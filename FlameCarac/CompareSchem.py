#!/usr/bin/env python3
#-*- coding: utf-8 -*-

# import Flamme1D as f1D
import Utilities as util
import numpy as np

import sys
import os
import time

# import cantera as ct

t0=time.time()

#---------------------------------------------------------------------
######################################             Input             #
#---------------------------------------------------------------------

dird='Data-Adia/'
dirp='Profile/'

F_data=[
'STe-CH4_hyb00_UCSD_SanDiego0_2_L040-0.dat',
'STe-hyb200-GN_hyb200_UCSD_SanDiego0_2_L040-00.dat'
]

F_prof=[
'F_phi100_Ti300_CH4_hyb00_UCSD_SanDiego0_2_L040.dat',
'F_phi100_Ti300_GN_hyb200_UCSD_SanDiego0_2_L040.dat'
]

DATA=[ np.loadtxt(dird+f,skiprows=1,delimiter=',') for f in F_data ]
PROF=[ np.loadtxt(dirp+f,skiprows=1,delimiter=',') for f in F_prof ]

#---------------------------------------------------------------------
######################################             Ploting           #
#---------------------------------------------------------------------
(plt,mtp)=util.Plot0()

#=====> Profiles
figP,axP=plt.subplots() ; bxP=axP.twinx()
for p in PROF :
	axP.plot(p[:,0],p[:,1])
	bxP.plot(p[:,0],p[:,-1],'k')

#=====> Compare
figC,axC=plt.subplots(ncols=2,nrows=2)
axC[0,0].set_ylabel('Tad')
axC[0,1].set_ylabel('Sl')
axC[1,0].set_ylabel('Dl')
axC[1,1].set_ylabel('PCI')
for d in DATA :
	axC[0,0].plot( d[:,1],d[:,3] )
	axC[0,1].plot( d[:,1],d[:,4] )
	axC[1,0].plot( d[:,1],d[:,5]*1e3 )
	axC[1,1].plot( d[:,1],d[:,7]/(d[:,6]*d[:,4]*) )

plt.show()