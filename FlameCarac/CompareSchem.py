#!/usr/bin/env python3
#-*- coding: utf-8 -*-

# import Flamme1D as f1D
import Utilities as util
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

F_data=[
'STe-CH4_hyb00_gri30_F_L020-0.dat',
# 'STe-CH4_hyb00_UCSD_SanDiego0_F_L020-0.dat',
# 'STe-CH4_hyb00_UCSD_SanDiego0_2_L040-0.dat',
# 'STe-GN_hyb200_UCSD_SanDiego0_2_L040-0.dat'
# 'STe-CH4_hyb00_2S_CH4_BFER_2_L040-0.dat'
'STe-CH4_hyb00_Laera_G_L040-0.dat'
]

F_prof=[
# 'F_phi050_Ti300_CH4_hyb00_UCSD_SanDiego0_2_L040.dat',
# 'F_phi050_Ti300_CH4_hyb00_Laera_2_L040.dat'
# 'F_phi100_Ti300_GN_hyb200_UCSD_SanDiego0_2_L040.dat'
]

DATA=[ np.loadtxt(dird+f,skiprows=1,delimiter=',') for f in F_data ]
PROF=[ np.loadtxt(dirp+f,skiprows=1,delimiter=',') for f in F_prof ]

#---------------------------------------------------------------------
######################################             Ploting           #
#---------------------------------------------------------------------
(plt,mtp)=util.Plot0()

#=====> Profiles
figP,axP=plt.subplots(figsize=(10,8)) ; bxP=axP.twinx()
for p in PROF :
	axP.plot(p[:,0]*1e3,p[:,1])
	bxP.plot(p[:,0]*1e3,p[:,-1],'k')
axP.set_xlim((10,20))
figP.savefig('Plot/Compare-Profiles.pdf')

#=====> Compare
figC,axC=plt.subplots(ncols=2,nrows=2,figsize=(14,10)) ; bxC=np.array([ [ a.twinx() for a in al ] for al in axC ])
axC[0,0].set_ylabel('Tad',fontsize=30) ; VT=[]
axC[0,1].set_ylabel('Sl' ,fontsize=30) ; VS=[]
axC[1,0].set_ylabel('Dl' ,fontsize=30) ; VD=[]
axC[1,1].set_ylabel('PCI',fontsize=30) ; VQ=[]
Col=['g','r']
for n,d in enumerate(DATA) :
	VT.append( d[:,3] )
	VS.append( d[:,4] )
	VD.append( d[:,5]*1e3 )
	VQ.append( d[:,7]/(d[:,6]*d[:,4]*d[:,-1]) )
	axC[0,0].plot( d[:,1],VT[-1],Col[n])
	axC[0,1].plot( d[:,1],VS[-1],Col[n])
	axC[1,0].plot( d[:,1],VD[-1],Col[n])
	axC[1,1].plot( d[:,1],VQ[-1],Col[n])

N0=len(VT[0])
N1=len(VT[1])
Nt=min(N0,N1)
# print(DATA[0][:Nt,1])
# print()
bxC[0,0].plot( DATA[0][:Nt,1] , 100*abs(VT[1][:Nt]-VT[0][:Nt])/VT[0][:Nt],'k' )
bxC[0,1].plot( DATA[0][:Nt,1] , 100*abs(VS[1][:Nt]-VS[0][:Nt])/VS[0][:Nt],'k' )
bxC[1,0].plot( DATA[0][:Nt,1] , 100*abs(VD[1][:Nt]-VD[0][:Nt])/VD[0][:Nt],'k' )
bxC[1,1].plot( DATA[0][:Nt,1] , 100*abs(VQ[1][:Nt]-VQ[0][:Nt])/VQ[0][:Nt],'k' )

util.NewPos(bxC[0,0],1,1,-0.03,0)
util.NewPos(bxC[0,1],1,1, 0.03,0)
util.NewPos(bxC[1,0],1,1,-0.03,0)
util.NewPos(bxC[1,1],1,1, 0.03,0)

figC.savefig('Plot/Compare-Carac.pdf')


# plt.show()