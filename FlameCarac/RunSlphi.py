#!/usr/bin/env python
#-*- coding: utf-8 -*-
# from __future__ import unicode_literals
# from multiprocessing import Process,Value,Array,Manager

import Flamme1D as f1D
import Utilities as util
import numpy as np

import sys
import os
import time

import cantera as ct
# --Data --Plot

os.system('clear')
t0=time.time()

#---------------------------------------------------------------------
######################################             Input             #
#---------------------------------------------------------------------

Fuel=sys.argv[1]
#Fuel='H2'
#Fuel='CH4'
#Fuel='C3H8'

########## --------------------> Initial Gas State
Pi=ct.one_atm

########## --------------------> Reactants
X0=0.21 #{float(sys.argv[2]) # 0.057, 0.125, 0.210 ( air ), 0.400, 1.0 ( O2 )
a=(1-X0)/X0

if   Fuel=='H2'   : Phi=list(np.linspace(0.1,1,60)) ; Phi.extend([1.25,1.5,1.75,2  ]) ; Phi.reverse()
elif Fuel=='CH4'  : Phi=list(np.linspace(0.3,1,60)) ; Phi.extend([1.05,1.1,1.2 ,1.3]) ; Phi.reverse()
elif Fuel=='C3H8' : Phi=list(np.linspace(0.3,1,60)) ; Phi.extend([1.1 ,1.2,1.3 ])     ; Phi.reverse()
else : print('wrong Fuel')
# Phi=[1,0.9,0.8,0.7,0.6,0.5,0.4] #float(sys.argv[1])
#Phi=[0.5,0.49,0.48,0.47,0.46,0.45,0.44] #float(sys.argv[1])
N=len(Phi)

########## --------------------> initial grid
L=20e-3
grid0=np.linspace(0,L,50)

########## --------------------> Calculation setting
Rafcrit=2
Tol=[1e-8,1e-11]
Tstep=1e-5
view=0

Ti=300

########## --------------------> Rayonnement
Ray=False

########## --------------------> Gas
schem='UCSD_SanDiego0' #UCSD_SanDiego2_All2

if Fuel=='H2' : (gas,Spe_name,Nspe,NOx,INOx,NNOx,Reac,Nreac)=f1D.ExtractSubmech(schem,view)
else : gas=ct.Solution( schem + '.cti' )

Set1='{2}_Pi={0:1.3e}_{1}'.format(Pi,schem,Fuel)
Set2='_Raf{0:.0f}_Tol={1:.0e}_Tstep={2:.0e}_L{5:1.2e}_X0={3:.2f}_Ti={4:.0f}'.format(Rafcrit,Tol[0]*Tol[1],Tstep,X0,Ti,L)
Set0= Set1 + Set2

#---------------------------------------------------------------------
######################################       Calculation             #
#---------------------------------------------------------------------
util.Entete1(105,[Set1,Set2,'',Fuel],'Init AVBP')
#---------------------------------------------------------------------
if '--Clear' in sys.argv : os.system('rm Flame/*') ; print('\n===> Clearing')

NameIn='Flame/Adia-1-{0}.xml'.format(Fuel)
NameOut=NameIn

Sl,Tb,Ngrid,Phi2,Thick=[],[],[],[],[]

print('\n=====> Start calculation \n')
print('phi     Sl    Tb       Ngrid')
conv_a,n=True,0
while conv_a and n<N:
	phi=Phi[n]

	if   Fuel=='H2'  : Xi={  'H2':2,'O2': 1/phi ,'N2':   a/phi}
	elif Fuel=='CH4' : Xi={ 'CH4':1,'O2': 2/phi ,'N2': 2*a/phi}
	elif Fuel=='C3H8': Xi={'C3H8':1,'O2': 5/phi ,'N2': 5*a/phi}
	
	(f_a,conv_a)=f1D.Adia1D_0(Xi,Ti,Pi,grid0,NameIn,NameOut,Tol,Tstep,Rafcrit,gas,Ray,view)
	
	if conv_a:
		Grid=f_a.grid ; Ngrid=len(Grid)
		T=f_a.T
		Phi2.append(phi)
		Sl.append(f_a.u[0])
		Tb.append(T[-1])
		Thick.append(f1D.Thick(X,T,Ngrid))
		n+=1
		
		print('{0:5.7f} {1:4.7f} {2:5.2f} {3:5.0f} {4:.3e}'.format(phi,Sl[-1],Tb[-1],Ngrid[-1],Thick[-1]))
	else : print('No convergence , phi= ',phi)

os.system('rm '+NameIn)

#---------------------------------------------------------------------
######################################       Output                  #
#---------------------------------------------------------------------
if '--Data' in sys.argv:
	with open('Data/{0}.dat'.format(Set0,Fuel),'w') as file:
		file.write(' Phi  Sl             Tb         Ngrid\n')
		for i in range(n):
			file.write( '{0:2.8f} {1:4.12f} {2:5.3f} {3:5.0f} {4:.12e}\n'.format( Phi[i],Sl[i],Tb[i],Ngrid[i],Thick[i] ) )
	file.closed

import matplotlib.pyplot as plt
import matplotlib

matplotlib.rcParams['text.usetex'] = True
matplotlib.rcParams['text.latex.unicode'] = True

labsize=15

if N==1:
	fig,ax=plt.subplots()
	ax.plot(f_a.grid,f_a.T)
	plt.show()

if '--Plot' in sys.argv:
	fig,ax=plt.subplots()
	ax.plot(Phi2,Sl,'ok')
	ax.set_xlabel(r'$\phi$',fontsize=labsize)
	ax.set_ylabel(r'S$_L^0$' ,fontsize=labsize)
	ax.set_title('Fuel= '+Fuel)

	fig.savefig('Plot/'+Set0+'.pdf')

	plt.show()
