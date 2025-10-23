#!/usr/bin/env python3
#-*- coding: utf-8 -*-
from numpy import *

#=====> Flow parameters
Tu=300    # [K]
Pu=101325 # [Pa]

#=====> inlet mixture
X0=0.21 # O2 air concentration (molar)
Vhyb=[0]
Vphi=arange(1.0, 0.39,-0.10)
Vrm0=arange(0.9, 0.39,-0.10)

#=====> initial grid
L=2e-2      # Domain length [m]
dx0=1e-4    # Initial grid spacing [m]

#=====> Numerics
Tol=[1e-3,1e-8]
Rafcrit=2
Tstep=1e-5
#Rafcrit=3
#Tstep=1e-7

#=====> Options
verb=0
Ray=False

#=====> Kinetic
# schem='Boivin'
# schem='UCSD_SanDiego0'
schem='gri30'
SpeIn=['CH4']
SpeOu=['O2','CH4','CO2','CO','NO','NO2']
ColS =['b' ,'r'  ,'k'  ,'c' ,'g' ,'y'  ]
Cspe =[1   ,1    ,1   ,1e6 ,1e6  ]

#=====> CO2 Dilution
r_CO2=0