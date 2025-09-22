#!/usr/bin/env python3
#-*- coding: utf-8 -*-
from __future__ import unicode_literals
# from multiprocessing import Process,Value,Array,Manager

import Utilities as util
(Sysa,NSysa,Arg)=util.Parseur(['NOx','Data','Clear','Diff','Strain','Plot','Prof'],2,'Arg : hyb Raf ')
(                               NOX , DATA , CLEAR , DIFF , STRAIN , PLOT , PROF )=Arg

import Flamme1D    as f1D
# import PostProcess as pp
import Manip       as man
from numpy import *

import os
import sys
import time

import cantera as ct
ct.add_directory('/mnt/d/Cantera/Scheme')

#os.system('clear')
t0=time.time()
(plt,mtp)=util.Plot0()

#---------------------------------------------------------------------
######################################             Input             #
#---------------------------------------------------------------------

########## --------------------> Initial Gas State
Ti=300
VM0 =[10]                   #float(Sysa[0])
VTi =[300]                #float(Sysa[0])
#VTi =[300,500,700]                #float(Sysa[0])
#VTi =[400,600,800]                #float(Sysa[0])
#VTi =[300,400,500,600,700,800]    #float(Sysa[0])
# VTi =[290,300,310,320,330,340,350]     #float(Sysa[0])
# VTi=linspace(290,310,21)
# VTi=linspace(300,800,51)
# VTi=arange(300,801,10)
# VTi=arange(300,601,10)
# VTi=arange(600,801,10)
# VTi=arange(900,289.9,-1)
# Vphi=array(range(100,19,-1))/100  #float(Sysa[1])
# Vphi=arange(1,0,-0.01)
# Vphi=arange(1,0.199,-0.01)
# Vphi=arange(1,8.001, 0.01)
# Vphi=arange(1.0,0.0,-0.01)
Vphi=arange(1.0,0.49,-0.01)
# Vphi=[ 0.42 ]
# Vphi=[ 0.45 ]
#Vphi=[ 0.49 ]
# Vphi=[ 0.51 ]
#Vphi=[ 0.53 ]
# Vphi=[ 0.8 ]
# Vphi=[ 0.2 ]
# Vphi=[ 1 ]
hyb0=float(Sysa[0])
Raf =      Sysa[1]
Pi=ct.one_atm
hyb=man.Alpha(hyb0) # Conversion power volumic flow

########## --------------------> Reactants
if   hyb0==1 : Fuel='H2'
elif hyb0==2 : Fuel='GN'
else         : Fuel='CH4'

X0=0.21 #{float(sys.argv[2]) # 0.057, 0.125, 0.210 ( air ), 0.400, 1.0 ( O2 )
a=(1-X0)/X0

gas=0
if Fuel=='H2' :
	SpeIn=['H2']
	SpeOu=['H2','O2','N2','H2O']
	if NOX :
		schem='UCSD_SanDiego2_All2'
		# schem='UCSD_SanDiego0_All'
		# (gas,Spe_name,Nspe,NOx_name,INOx,NNOx,Reac,Nreac)=f1D.ExtractSubmech(schem,0)
	else : 
		# schem='Boivin'
		schem='UCSD_SanDiego0'
		# schem='Fluent'
	if 'UCSD' in schem : (gas,Spe_name,Nspe,NOx_name,INOx,NNOx,Reac,Nreac)=f1D.ExtractSubmech(schem,0)
elif Fuel=='CH4' :
	# schem='gri30'
	schem='Laera-light'
	# schem='Laera'
	# schem='2S_CH4_BFER'
	# schem='UCSD_SanDiego0'
	# schem='Fluent'
	SpeIn=['CH4']
	SpeOu=['CH4','CO2','CO','O2','H2O','N2']
elif Fuel=='GN' :
	# schem='UCSD_SanDiego0'
	schem='Fluent'
	SpeIn=['CH4','C2H6','C3H8','H2']
	SpeOu=['CH4','C2H6','C3H8','CO2','CO','O2','H2O','N2']
else :
	sys.exit('\n====> Fuel not build yet \n\n')

CompoGN={ 'CH4':0.925,'C2H6':0.041,'C3H8':0.009,'CO2':0.010,'N2':0.015 }
Xia=2*CompoGN['CH4']+2.5*CompoGN['C2H6']+10*CompoGN['C3H8']

if gas==0 : gas=ct.Solution( schem + '.yaml' )
########## --------------------> initial grid
# L=40e-3
L=20e-3
dx=1e-4 ; N0=int(round(L/dx,0))+1
grid0=linspace(0,L,N0)

########## --------------------> Sutherland
Set_sut0=[0.18662466e-4,300,0.6759]

########## --------------------> Calculation setting
Tol=[1e-3,1e-8]
#Tol=[1e-6,1e-10]
#Tol=[1e-8,1e-10]
#Tol=[1e-10,1e-12]

if Raf=='G' :
	Rafcrit=2
	Tstep=1e-5
	# Ncase=4 # H2
	Ncase=0 # CH4
elif Raf=='F' :
	Rafcrit=3
	Tstep=1e-7
	Ncase=0
else : sys.extit('\n\n =====> Wrong Refinement \n\n')

view=0

########## --------------------> Rayonnement
Ray=False

########## --------------------> Gas
Spe=gas.species_names ; Nspe=len(Spe)
if NOX : (NOx_name,NNOx,INOx)=f1D.LocateNOx(Spe,Nspe)
ISin=[ Spe.index(s) for s in SpeIn ]
ISou=[ Spe.index(s) for s in SpeOu ]

Set1='{2}_Pi={0:1.3e}_{1}_X0{3:.2f}_hyb{4:.3f}'.format(Pi,schem,Fuel,X0,hyb0)
Set2='Raf{0:.0f}_Tol={1:.0e}_Tstep={2:.0e}_L{3:1.2e}'.format(Rafcrit,Tol[0]*Tol[1],Tstep,L)
Set0='{}_hyb{:02.0f}_{}_{}_L{:03.0f}'.format(Fuel,hyb0*100,schem,Raf,L*1e3)

if DIFF : sdif='-Diff-'
else    : sdif='-'
NOx_data='Data-Adia/NOx{}{}-{:.0f}.dat'.format(sdif,Set0,Ncase)
STe_data='Data-Adia/STe{}{}-{:.0f}.dat'.format(sdif,Set0,Ncase)
# Dif_data='Data-Adia/Dif-hyb{0:03.0f}-{1}-{2:02.0f}.dat'.format(hyb0*100,Set0,Ncase)

NameIn='Flame/Flame-{}.yaml'.format(Set0)
NameOut=NameIn

#---------------------------------------------------------------------
######################################       Function                #
#---------------------------------------------------------------------
def Clear(name) : print('\n===> Clearing') ; os.system('rm '+name)
#---------------------------------------------------------------------
######################################       Calculation             #
#---------------------------------------------------------------------
util.Entete1(105,[Set1,Set2,NameIn,'',NOx_data,STe_data],'Init AVBP')
#---------------------------------------------------------------------
# if CLEAR : Clear(NameIn)
#---------------------------------------------------------------------
util.Section('Start Loop Adia Calculations',2,5,'r')

if DATA : 
	if os.path.exists(STe_data) : os.system('rm {0} '.format(STe_data))
	# tit='hyb,phi,Tu,Ta,Sl,Thick,rhou,IHrr,MHrr'
	tit='hyb,phi,Tu,Ta,Sl,Thick,rhou,IHrr,MHrr,la,cp'
	os.system('echo {0} >> {1}'.format(tit,STe_data))
else   : print(5*'\n'+'\033[33m'+5*'='+'>'+'  Warning DATA :',DATA,'\033[0m'+7*'\n')
if NOX :
	if os.path.exists(NOx_data) : os.system('rm {0} '.format(NOx_data))
	tit='hyb,phi,Tu,NO,N2O,NO2'
	os.system('echo {0} >> {1}'.format(tit,NOx_data))
if PLOT :
	fig,ax=plt.subplots() ; ax2=ax.twinx()

for phi in Vphi :
	for Ti in VTi :
	# for m0 in VM0 :

		if CLEAR : Clear(NameIn)
		###########################################################################################################################
		###########################################################################################################################
		if Fuel=='H2' :
			Xi={ 'H2':2,'O2': 1/phi ,'N2': a/phi}
		elif Fuel=='CH4' and schem=='2S_CH4_BFER' :
			Xi={'CH4':1,'O2': 2/phi ,'N2': 2*a/phi}
		elif Fuel=='CH4' :
			oxy=(2-3*hyb/2)
			# Xi={'CH4':phi*(1-hyb),'H2':phi*hyb,'O2': oxy ,'N2': 2*a*oxy}
			Xi={ 'CH4':phi*(1-hyb) , 'H2':phi*hyb , 'O2':oxy , 'N2': a*oxy }
		elif Fuel=='GN' :
			Xi={ 'CH4':CompoGN['CH4'],'C2H6':CompoGN['C2H6'],'C3H8':CompoGN['C3H8'],'O2':Xia/phi,'N2':a*Xia/phi }
		###########################################################################################################################
		###########################################################################################################################			
		util.Section('Start adia => Ti : {0:.0f} , phi : {1:.3f}'.format(Ti,phi),0,3,'b')
		if DIFF     : (f_a,conv_a)=f1D.ColdFlow(   Xi,       Ti,Pi,grid0,NameIn,NameOut,Tol,Tstep,Rafcrit,gas,Ray,view)
		elif STRAIN : (f_a,conv_a)=f1D.CounterFlow(Xi,[m0,0],Ti,Pi,grid0,NameIn,NameOut,Tol,Tstep,Rafcrit,gas,Ray,view)
		else        : (f_a,conv_a)=f1D.Adia1D_0(   Xi,       Ti,Pi,grid0,NameIn,NameOut,Tol,Tstep,Rafcrit,gas,Ray,view)
		if not conv_a : 
			print('=> no conv')
			Clear(NameIn)
			break
		###########################################################################################################################
		###########################################################################################################################
		
		#=========================> Output field
		grid =f_a.grid                  #[m]
		U    =f_a.velocity              #[m/s]
		T    =f_a.T                     #[K]
		Y    =f_a.Y                     #[-]
		X    =f_a.X                     #[-]
		C    =f_a.concentrations        #[kmol/m^3]
		rho  =f_a.density_mass          #[kg/m^3]
		Qx   =f_a.heat_release_rate     #[W/m^3]
		Hs   =f_a.heat_production_rates #[W/m^3]
		Ngrid=len(grid)
		
		Cp   =f_a.cp_mass                 #[J/kg-K]
		Cv   =f_a.cv_mass                 #[J/kg-K]
		lamb =f_a.thermal_conductivity    #[W/m-K]
		Diff0=f_a.mix_diff_coeffs         #[m^2/s]
		Diffm=f_a.mix_diff_coeffs_mass    #[m^2/s]
		mu   =f_a.viscosity               #[Pa-s]
		
		R0=ct.gas_constant                #[J/kmol-K]
		
		Sl   =U[0]
		rho0 =rho[0]
		Ta   =T[-1]
		Thick=f1D.Thick(grid,T,Ngrid)
		Y0f  =sum([Y[k,0] for k in ISin])

		Q=sum( [ 0.5*( Qx[n+1]+Qx[n] )*( grid[n+1]-grid[n] ) for n in range(Ngrid-1) ] ) ; MH=max(Qx)

		#=========================> Plot
		if PLOT :
			ax.cla() ; ax2.cla()
			ax. plot( grid,T ,'r' )
			ax2.plot( grid,Qx,'k' )
			util.SaveFig( fig , 'Plot/LoopAdia/Plot-Tu{0:.0f}-phi{1:.2f}.pdf'.format(Ti,phi) )

		#---------------------------------------------------------------------
		######################################       output                  #
		#---------------------------------------------------------------------
		
		print('Ngrid      : {:.0f}'.                                    format(Ngrid))
		print('Sl         : {:.3f} [m/s]'.                              format(Sl) )
		print('Tadia      : {:.0f} [K]  '.                              format(Ta) )
		print('Thicknes   : {:.2f} [mm] '.                              format(Thick*1e3) )
		print('rho in     : {:.3f} [kg/m3]  ,  rho ou : {:.3f} [kg/m3]'.format(rho[0],rho[-1]) )
		print('Total Heat : {:.2e} [W]  ,  Max Heat : {:.2e} [W/m3]'.   format(Q,MH))
		
		######################################## --------------------> Profile
		if PROF :
			fout=open('Profile/F_phi{:03.0f}_Ti{:.0f}_'.format(phi*100,Ti)+Set0+'.dat','w')
			fout.write('Pos,T,U,')
			for s in SpeOu : fout.write(s+',')
			fout.write('Q\n')
			for i in range(Ngrid) :
				fout.write( '{:.12e},{:.12e},'.format(grid[i],T[i],U[i]) )
				for k in ISou :fout.write('{:.12e},'.format(Y[k,i]))
				fout.write( '{:.12e}\n'.format(Qx[i]) )
			fout.closed

		######################################## --------------------> NOx
		if NOX :
			print('\n===> NOx : ',NOx_name)
			NOx_OUT='{0:.12f} , {1:.12f} , {2:.12f}'.format(hyb,phi,Ti)
			for i in INOx : NOx_OUT+=' , {0:.12e}'.format(Y[i][-1])
			print(NOx_OUT,'\n')
			os.system('echo {0} >> {1}'.format(NOx_OUT,NOx_data))
		######################################## --------------------> Sl Tad Thickness
		if DATA :
			STe='{0:.12f},{1:.12f},{2:.12f},{3:.12f},{4:.12e},{5:.12e},{6:.12e},{7:.12e},{8:.12e},{9:.12e},{10:.12e},{11:.12e}'.format(hyb,phi,Ti,Ta,Sl,Thick,rho0,Q,MH,lamb[0],Cp[0],Y0f)
			os.system('echo {0} >> {1}'.format(STe,STe_data))
	if not conv_a : 
		print('=> Stop')
		break

print('\n\n=====> Programme completed Dt=',time.time()-t0,'\n')