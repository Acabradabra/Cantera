#!/usr/bin/env python3
#-*- coding: utf-8 -*-
from numpy import *

#=====> Flow parameters
Tu=300 # [K]
Pu=101325   # [Pa]

#=====> inlet mixture
# X0=0.21 # Air concentration (molar)
X0=1 # Air concentration (molar)
Vhyb=arange(0  , 1.1 , 0.25)
Vphi=arange(1.0, 0.39,-0.10)
Vrm0=arange(0.9, 0.39,-0.10)
# Vphi=[0.8]
# Vrm0=[0.8]

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
SpeIn=['H2']
SpeOu=['CO2','CO','H2','O2','H2O']
ColS =['k'  ,'m' ,'b' ,'r' ,'g'  ]

#=====> CO2 Dilution
r_CO2=0.1