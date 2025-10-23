#!/usr/bin/env python3
#-*- coding: utf-8 -*-

#%%=================================================================================
# from IPython import get_ipython

# ip = get_ipython()
# if ip is not None:
#     ip.run_line_magic("load_ext", "autoreload")
#     ip.run_line_magic("autoreload", "2")
#%%=================================================================================
#                     Modules
#===================================================================================
import Utilities as util
(Sysa,NSysa,Arg)=util.Parseur(['Plot','Data','Clear'],1,'Arg : case ')
(                               PLOT , DATA , CLEAR )=Arg

import Flamme1D    as f1D
# import Manip       as man
from numpy import *

import os
import sys
import time

import cantera as ct
ct.add_directory('/mnt/d/Cantera/Scheme')

#os.system('clear')
t0=time.time()
(plt,mtp)=util.Plot0()

#%%=================================================================================
#                     Inputs
#===================================================================================
dir=os.getcwd()+'/'+Sysa[0]+'/'
df=dir+'Flammes/'
dp=dir+'Plots/'
dd=dir+'Data/'
util.MKDIR(df)
util.MKDIR(dp)
util.MKDIR(dd)

#=========================> Parameters import
sys.path.append(dir)
import Params as pm

#=========================> Flow parameters
Tu=pm.Tu
Pu=pm.Pu
X0=pm.X0
gas=ct.Solution( pm.schem + '.yaml' )
# (gas,Spe_name,Nspe,NOx_name,INOx,NNOx,Reac,Nreac)=f1D.ExtractSubmech(pm.schem,0)

#=========================> Numerical parameters
grid0=arange(0,pm.L+0.1*pm.dx0,pm.dx0)
Tol=pm.Tol
Tstep=pm.Tstep
Rafcrit=pm.Rafcrit

#=========================> Options
Ray=pm.Ray
verb=pm.verb

#=========================> Loops
Vhyb=pm.Vhyb
Vphi=pm.Vphi
Vrm0=pm.Vrm0

#=========================> Names
N_In_a=df+'FreeFlame.yaml'
N_Ou_a=N_In_a
N_In_b=df+'BurnerFlame.yaml'
N_Ou_b=N_In_b
STe_data=dd+'STe.csv'

#%%=================================================================================
util.Entete1(104,[],'Burner')
#===================================================================================
def Clear(name) : print('\n===> Clearing') ; os.system('rm '+name)
#===================================================================================
if CLEAR : Clear(df+'*')
#===================================================================================
if DATA : 
	if os.path.exists(STe_data) : 
		util.Section('Warning : Data file already exists',1,5,'y')
		erase=input(' Do you want to erase it ? (y/n) ')
		if 'y' in erase : os.system('rm {0} '.format(STe_data))
		else 	        : sys.exit('\n\n====> Stop to avoid overwriting data \n\n')
	tit='hyb,phi,rm,Tu,Ta,Sl,rhou,IQ,MQ'
	for s in pm.SpeOu : tit+=',Y'+s+'_u'+',Y'+s+'_m'+',Y'+s+'_b'
	os.system('echo {0} > {1}'.format(tit,STe_data))
else   : util.Section('Warning : No Data',5,5,'y')
#===================================================================================

Spe_names=gas.species_names
If=Spe_names.index(pm.SpeIn[0])
Is_ou=[ Spe_names.index(s) for s in pm.SpeOu ]
for hyb in Vhyb :
	for phi in Vphi :
		Xu= f1D.Xu(phi,hyb,f1D.r_N2(X0),f1D.r_O2(hyb)) # Unburnt mixture
		Xu['CO2']=pm.r_CO2*Xu['O2']
		#=========================> Adiabatic Flame
		(f_a,conv_a)=f1D.Adia1D_0(  Xu,Tu,Pu,grid0,N_In_a,N_Ou_a,Tol,Tstep,Rafcrit,gas,pm.Ray,pm.verb )
		#==========> Properties
		if not conv_a : 
			print('=> no burner conv')
			Clear(N_In_a)
			break
		Grid=f_a.grid*1e3               # [mm]
		T   =f_a.T                      # [K]
		Sl0 =f_a.velocity[0]            # [m/s]
		rho0=f_a.density_mass[0]        # [kg/m3]
		Qx  =f_a.heat_release_rate      # [W/m3]
		MQ_a=max(Qx)                    # [W/m3]
		IQ_a=sum( 0.5*(Qx[1:]+Qx[:-1])*(Grid[1:]-Grid[:-1]) ) # [W/m2]
		md_a=Sl0*rho0
		Tad=T[-1]
		util.Section('hyb : %.3f  ,  phi : %.3f  ,  Tad : %.0f [K]  ,  Sl0 : %.3f [m/s]'%(hyb,phi,Tad,Sl0),0,3,'b')
		if DATA :
			STe='%.12f,%.12f,%.12f,%.12f,%.12f,%.12e,%.12e,%.12e,%.12e'%(hyb,phi,1,T[0],T[-1],Sl0,rho0,IQ_a,MQ_a)
			for k in Is_ou : Yk=f_a.Y[k,:] ; STe+=',%.12e,%.12e,%.12e'%(Yk[0],max(Yk),Yk[-1])
			os.system('echo {0} >> {1}'.format(STe,STe_data))
		for r_m0 in Vrm0 :
			mdot=r_m0*md_a
			carac='hyb%03.0f-phi%03.0f-rm%03.0f'%(hyb*1e2,phi*1e2,r_m0*1e2)
			#=========================> Burner Flame
			(f_b,conv_b)=f1D.Burner1D_0(Xu,mdot,Tu,Pu,grid0,N_In_b,N_Ou_b,Tol,Tstep,Rafcrit,gas,pm.Ray,pm.verb)
			if not conv_a : 
				print('=> no burner conv')
				Clear(N_In_b)
				break
			#==========> Properties
			Grid=f_b.grid*1e3         # [mm]
			Yf=f_b.Y[If,:]            # [-]
			T =f_b.T                  # [K]
			Sl=f_b.velocity[0]        # [m/s]
			rho0=f_b.density_mass[0]  # [kg/m3]
			Qx=f_b.heat_release_rate  # [W/m3]
			MQ=max(Qx)                # [W/m3]
			IQ=sum( 0.5*(Qx[1:]+Qx[:-1])*(Grid[1:]-Grid[:-1]) ) # [W/m2]
			print( '=> r : %03.0f [p]   ,   mdot : %.0f [g/s-m2]  =>  Tb : %.0f [K]  ,  IQ : %.0f [GW/m3]'%(r_m0*1e2,mdot*1e3,T[-1],IQ*1e-9) )
			#=========================> Plotting
			if PLOT :
				f1D.PlotFlame(           Grid,Yf,T,Tad,Qx,MQ_a,5,     dp+'/BurnerFlame-%s.pdf'%(carac) , 'Burner Flame : phi=%.2f  ,  rm=%.2f '%(phi,r_m0) )
				f1D.PlotSpecies(pm.SpeOu,Grid,f_b,Spe_names,5,pm.ColS,dp+'/BurnerSpecies-%s.pdf'%(carac))
			if DATA :
				STe='%.12f,%.12f,%.12f,%.12f,%.12f,%.12e,%.12e,%.12e,%.12e'%(hyb,phi,r_m0,T[0],T[-1],Sl,rho0,IQ,MQ)
				for k in Is_ou : Yk=f_b.Y[k,:] ; STe+=',%.12e,%.12e,%.12e'%(Yk[0],max(Yk),Yk[-1])
				os.system('echo {0} >> {1}'.format(STe,STe_data))