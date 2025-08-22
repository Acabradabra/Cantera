#!/usr/bin/env python
#-*- coding: utf-8 -*-

import Flamme1D as f1D
import Utilities as util
import numpy as np

import sys
import os
import time

import cantera as ct

t0=time.time()

#---------------------------------------------------------------------
######################################             Input             #
#---------------------------------------------------------------------

Mech=[
# 'UCSD_SanDiego0.yaml',
# 'Boivin.yaml',
# '2S_CH4_BFER.yaml',
# 'gri30'
]

#=====> Atmosphère
Pi=ct.one_atm         # Pressure
X0=0.21 ; a=(1-X0)/X0 # Oxygen concentration
hyb0=0                # Hybridation in power