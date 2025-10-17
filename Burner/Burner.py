#!/usr/bin/env python3
#-*- coding: utf-8 -*-

#%%=================================================================================
# from IPython import get_ipython

# ip = get_ipython()
# if ip is not None:
#     ip.run_line_magic("load_ext", "autoreload")
#     ip.run_line_magic("autoreload", "2")
#%%=================================================================================
#                     Modules
#===================================================================================
import Utilities as util
(Sysa,NSysa,Arg)=util.Parseur(['Plot','Clear'],1,'Arg : case ')
(                               PLOT , CLEAR )=Arg

import Flamme1D    as f1D
import Manip       as man
from numpy import *

import os
import sys
import time

import cantera as ct
ct.add_directory('/mnt/d/Cantera/Scheme')

#os.system('clear')
t0=time.time()
(plt,mtp)=util.Plot0()

#%%=================================================================================
#                     Inputs
#===================================================================================
dir=os.getcwd()+'/'+Sysa[0]+'/'
df=dir+'Flammes/'
dp=dir+'Plots/'
dd=dir+'Data/'
util.MKDIR(df)
util.MKDIR(dp)
util.MKDIR(dd)

#=========================> Parameters import
sys.path.append(dir)
import Params as pm

#=========================> Flow parameters
Tu=pm.Tu
Pu=pm.Pu
X0=pm.X0
hyb=pm.hyb
gas=ct.Solution( pm.schem + '.yaml' )
# (gas,Spe_name,Nspe,NOx_name,INOx,NNOx,Reac,Nreac)=f1D.ExtractSubmech(pm.schem,0)

#=========================> Numerical parameters
grid0=arange(0,pm.L+0.1*pm.dx0,pm.dx0)
Tol=pm.Tol
Tstep=pm.Tstep
Rafcrit=pm.Rafcrit

#=========================> Option
Ray=pm.Ray
verb=pm.verb

N_In_a=df+'FreeFlame.yaml'
N_Ou_a=N_In_a
N_In_b=df+'BurnerFlame.yaml'
N_Ou_b=N_In_b

#%%=================================================================================
#                     Processing
#===================================================================================
def Clear(name) : print('\n===> Clearing') ; os.system('rm '+name)
#===================================================================================
if CLEAR : Clear(df+'*')

Spe_names=gas.species_names
If=Spe_names.index(pm.SpeIn[0])

for phi in pm.Vphi :
    Xu= f1D.Xu(phi,hyb,f1D.r_N2(X0),f1D.r_O2(hyb)) # Unburnt mixture
    Xu['CO2']=0.1
    #=========================> Adiabatic Flame
    (f_a,conv_a)=f1D.Adia1D_0(  Xu,     Tu,Pu,grid0,N_In_a,N_Ou_a,Tol,Tstep,Rafcrit,gas,pm.Ray,pm.verb) ; 
    #==========> Properties
    Tad=f_a.T[-1]             # [K]
    Sl0=f_a.velocity[0]       # [m/s]
    Rho0=f_a.density_mass[0]  # [kg/m3]
    MQ_a=max(f_a.heat_release_rate) # [W/m3]
    md_a=Sl0*Rho0

    for r_m0 in pm.Vrm0 :
        mdot=r_m0*md_a
        #=========================> Burner Flame
        (f_b,conv_b)=f1D.Burner1D_0(Xu,mdot,Tu,Pu,grid0,N_In_b,N_Ou_b,Tol,Tstep,Rafcrit,gas,pm.Ray,pm.verb)
        #==========> Properties
        Grid=f_b.grid*1e3         # [mm]
        Yf=f_b.Y[If,:]            # [-]
        T =f_b.T                  # [K]
        Qx=f_b.heat_release_rate  # [W/m3]
        #=========================> Plotting
        if PLOT :
            f1D.PlotFlame(Grid,Yf,T,Tad,Qx,MQ_a,5, dp+'/BurnerFlame-phi%03.0f-rm0%3.0f.pdf'%(phi,r_m0) , 'Burner Flame : phi=%.2f  ,  rm=%.2f '%(phi,r_m0) )
            f1D.PlotSpecies(pm.SpeOu,Grid,f_b,Spe_names,5,pm.ColS,dp+'/BurnerSpecies-phi%03.0f-rm0%3.0f.pdf'%(phi,r_m0))