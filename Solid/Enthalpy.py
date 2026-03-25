#!/usr/bin/env python3
#-*- coding: utf-8 -*-

#%%=================================================================================
# from unittest import case
# from IPython import get_ipython

# ip = get_ipython()
# if ip is not None:
#     ip.run_line_magic("load_ext", "autoreload")
#     ip.run_line_magic("autoreload", "2")
#%%=================================================================================
#                     Modules
#===================================================================================
import Utilities as util
(Sysa,NSysa,Arg)=util.Parseur(['Base','Nasa'],0,'Arg : ')
(                             [ BASE , NASA ])=Arg

import Flamme1D as f1D
import numpy as np
import cantera as ct

import sys
import os
import time

t0=time.time()
#%%=================================================================================
#                     Parameters
#===================================================================================


#%%=================================================================================
if BASE :
    fp1=-145.547400
    fp2=-73.607790 
    fp3=-74.239620 
    fp4=-73.382280 
    fp5=-44.285280 
    fpt=fp1+fp2+fp3+fp4+fp5
    md1=13.18700
    md2=6
    fp2=fpt*md2/md1 ; 
    print(f'=> prod : {md2:.0f} T/j  ,  Heat Sink : {fp2:.6f} [kW]')
#===================================================================================
if NASA :
    gas=ct.Species.list_from_file('nasa_gas.yaml')
    sol=ct.Species.list_from_file('nasa_condensed.yaml')

    for s in sol :
        if 'AL2O3' in s.name :
            print(f'=> {s.name} : {s.thermo}')
#===================================================================================