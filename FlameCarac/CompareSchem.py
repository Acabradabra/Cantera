#!/usr/bin/env python3
#-*- coding: utf-8 -*-

# import Flamme1D as f1D
import Utilities as util
(Sysa,NSysa,Arg)=util.Parseur(['Save'],0,'Arg : ')
(                               SAVE )=Arg

import numpy as np

import sys
import os
import time

t0=time.time()

#---------------------------------------------------------------------
######################################             Input             #
#---------------------------------------------------------------------

dird='Data-Adia/'
dirp='Profile/'
tag='H2-UCSD-Boivin-F-L020'
# tag='H2-Gri30-Boivin-F-L020'
# tag='H2-Gri30-Laera-F-L020'
# tag='CH4-Gri30-Laera-F-L020'
# tag='CH4-Gri30-BFER-F-L020'
# tag='CH4-50p-Gri30-Laera-F-L020'

if tag=='CH4-Gri30-BFER-F-L020' :
	F_data=[
	'STe-CH4_hyb00_gri30_F_L020-0.dat',
	'STe-CH4_hyb00_2S_CH4_BFER_F_L020-0.dat']
	F_prof=[
	'F_phi100_Ti300_CH4_hyb00_gri30_F_L020.dat',
	'F_phi100_Ti300_CH4_hyb00_2S_CH4_BFER_F_L020.dat']
elif tag=='CH4-Gri30-Laera-F-L020' :
	F_data=[
	'STe-CH4_hyb50_gri30_F_L020-0.dat',
	'STe-CH4_hyb50_Laera-light_F_L020-0.dat']
	F_prof=[
	'F_phi050_Ti300_CH4_hyb50_gri30_F_L020.dat',
	'F_phi050_Ti300_CH4_hyb50_Laera-light_F_L020.dat']
elif tag=='H2-Gri30-Laera-F-L020' :
	F_data=[
	'STe-H2_hyb100_gri30_F_L020-0.dat',
	'STe-H2_hyb100_Laera-light_F_L020-0.dat']
	F_prof=[
	'F_phi050_Ti300_H2_hyb100_gri30_F_L020.dat',
	'F_phi050_Ti300_H2_hyb100_Laera-light_F_L020.dat']
elif tag=='H2-UCSD-Boivin-F-L020' :
	F_data=[
	'STe-H2_hyb100_UCSD_SanDiego0_F_L020-0.dat',
	'STe-H2_hyb100_Boivin_F_L020-0.dat']
	F_prof=[
	'F_phi050_Ti300_H2_hyb100_UCSD_SanDiego0_F_L020.dat',
	'F_phi050_Ti300_H2_hyb100_Boivin_F_L020.dat']
else : sys.exit('=> Error: tag not recognized')

DATA=[ np.loadtxt(dird+f,skiprows=1,delimiter=',') for f in F_data ]
PROF=[ np.loadtxt(dirp+f,skiprows=1,delimiter=',') for f in F_prof ]

#---------------------------------------------------------------------
######################################             Ploting           #
#---------------------------------------------------------------------
(plt,mtp)=util.Plot0()

#=====> Mono
prof=PROF[0]
pos=prof[:,0]*1e3
T=(prof[:,1]-prof[0,1])/(prof[-1,1]-prof[0,1])
Y=prof[:,3]/prof[0,3]
Q=prof[:,6]/max(prof[:,6])
figM,axM=plt.subplots(figsize=(10,6))
axM.plot( pos,Y , 'b' )
axM.plot( pos,T , 'r' )
axM.plot( pos,Q , 'k' )

#=====> Profiles
figP,axP=plt.subplots(figsize=(10,6)) ; bxP=axP.twinx()
Col=['g','r']
for n,p in enumerate(PROF) :
	axP.plot(p[:,0]*1e3,p[:,1],Col[n])
	bxP.plot(p[:,0]*1e3,p[:,-1],'k')
axP.set_xlim((5,10))

#=====> Compare
figC,axC=plt.subplots(ncols=2,nrows=2,figsize=(14,10)) ; bxC=np.array([ [ a.twinx() for a in al ] for al in axC ])
axC[0,0].set_ylabel('Tad [K]' ,fontsize=30)    ; axC[0,0].set_title('Adiabatique temperature',fontsize=20) ; VT=[]
axC[0,1].set_ylabel('Sl [m/s]',fontsize=30)    ; axC[0,1].set_title('Flame velocity'         ,fontsize=20) ; VS=[]
axC[1,0].set_ylabel('Dl [mm]' ,fontsize=30)    ; axC[1,0].set_title('Flame thickness'        ,fontsize=20) ; VD=[]
axC[1,1].set_ylabel('PCI [MJ/kg]',fontsize=30) ; axC[1,1].set_title('Thermal power'          ,fontsize=20) ; VQ=[]
bxC[0,1].set_ylabel('Relative error [%]' ,fontsize=30)
bxC[1,1].set_ylabel('Relative error [%]' ,fontsize=30)
Col=['g','r']
for n,d in enumerate(DATA) :
	VT.append(      d[:,3] )
	VS.append(      d[:,4] )
	VD.append(  1e3*d[:,5] )
	VQ.append( 1e-6*d[:,7]/(d[:,6]*d[:,4]*d[:,-1]) )
	axC[0,0].plot( d[:,1],VT[-1],Col[n])
	axC[0,1].plot( d[:,1],VS[-1],Col[n])
	axC[1,0].plot( d[:,1],VD[-1],Col[n])
	axC[1,1].plot( d[:,1],VQ[-1],Col[n])
axC[1,0].set_xlabel('$\phi$ [-]',fontsize=30)
axC[1,1].set_xlabel('$\phi$ [-]',fontsize=30)

N0=len(VT[0])
N1=len(VT[1])
Nt=min(N0,N1)
bxC[0,0].plot( DATA[0][:Nt,1] , 100*abs(VT[1][:Nt]-VT[0][:Nt])/VT[0][:Nt],'k' )
bxC[0,1].plot( DATA[0][:Nt,1] , 100*abs(VS[1][:Nt]-VS[0][:Nt])/VS[0][:Nt],'k' )
bxC[1,0].plot( DATA[0][:Nt,1] , 100*abs(VD[1][:Nt]-VD[0][:Nt])/VD[0][:Nt],'k' )
bxC[1,1].plot( DATA[0][:Nt,1] , 100*abs(VQ[1][:Nt]-VQ[0][:Nt])/VQ[0][:Nt],'k' )

util.NewPos(bxC[0,0],1,1,-0.04,0)
util.NewPos(bxC[0,1],1,1, 0.01,0)
util.NewPos(bxC[1,0],1,1,-0.04,0)
util.NewPos(bxC[1,1],1,1, 0.01,0)

if SAVE :
	util.SaveFig(figP,'Plot/Compare-{}-Profiles.pdf'.format(tag))
	util.SaveFig(figC,'Plot/Compare-{}-Carac.pdf'.format(tag))
	util.SaveFig(figM,'Plot/Compare-{}-Mono.pdf'.format(tag))
else :
	plt.show()