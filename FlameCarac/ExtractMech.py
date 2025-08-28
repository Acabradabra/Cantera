#!/usr/bin/env python3
#-*- coding: utf-8 -*-

# import Flamme1D as f1D
import Utilities as util
import numpy as np

import sys
import os
import time

import camelot

t0=time.time()

#---------------------------------------------------------------------
######################################             Input             #
#---------------------------------------------------------------------

file='/mnt/d/Cantera/Scheme/ARC-CERFACS.pdf'

table=camelot.read_pdf(file,pages='5,6,7,8,9')
table.export('Extract.csv',f='csv',compress=True)