#!/usr/bin/env python3
#-*- coding: utf-8 -*-

#%%=================================================================================
from unittest import case
from IPython import get_ipython

ip = get_ipython()
if ip is not None:
    ip.run_line_magic("load_ext", "autoreload")
    ip.run_line_magic("autoreload", "2")
#%%=================================================================================
#                     Modules
#===================================================================================
import Flamme1D as f1D
import Utilities as util
import numpy as np
import cantera as ct

import sys
import os
import time

t0=time.time()
#%%=================================================================================
#                     Parameters
#===================================================================================
d_schem='/mnt/d/Cantera/Scheme'
ct.add_directory(d_schem)

gas=ct.Solution( 'Laera.yaml' )
