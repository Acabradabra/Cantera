#!/usr/bin/env python3
#-*- coding: utf-8 -*-

#%%=================================================================================
from IPython import get_ipython

ip = get_ipython()
if ip is not None:
    ip.run_line_magic("load_ext", "autoreload")
    ip.run_line_magic("autoreload", "2")
#%%=================================================================================
#                     Modules
#===================================================================================
import Utilities as util
(Sysa,NSysa,Arg)=util.Parseur([],0,'Arg : case ')
(                              )=Arg

from numpy import *

# t0=time.time()
(plt,mtp)=util.Plot0()

#%%=================================================================================
#                     Inputs
#===================================================================================

d0='H2-CO2-Reduction/'
dp=d0+'Plots/'
data=d0+'Data/STe.csv'

#%%=================================================================================
#                     Process
#===================================================================================

#=====> Reading
Data=util.ReadCSV(data)
Hyb=set(Data['hyb'])

#=====> Ploting
Symb=['o','s','d','x','+']
fig,ax=plt.subplots(ncols=2,nrows=2,figsize=(14,10))
fig.suptitle(      r'CO mass fraction'      ,fontsize=30)
ax[0,0].set_title( r'Equivalence ratio'     ,fontsize=20) #=> Phi
ax[0,0].set_xlabel(r'$\phi$ [-]'            ,fontsize=30)
ax[0,1].set_title( r'Thermal power'         ,fontsize=20) #=> Power
ax[0,1].set_xlabel(r'P [GW/m2]'             ,fontsize=30) ; ax[0,1].set_xlim((0,40))
ax[1,0].set_title( r'Hydrogen'              ,fontsize=20) #=> Hydrogen
ax[1,0].set_xlabel(r'$Y_{H_2}^u$ [-]'       ,fontsize=30)
ax[1,1].set_title( r'Burned gas temperature',fontsize=20) #=> Temperature
ax[1,1].set_xlabel(r'$T_b$ [K]'             ,fontsize=30)
for n,h in enumerate(Hyb) :
    Sel_h=Data['hyb']==h
    Phi=set(Data['phi'])
    for p in Phi :
        Sel_p=Data['phi'  ]==p
        Sel=Sel_h*Sel_p
        ax[0,0].plot(Data['phi'  ][Sel]     ,Data['YCO_b'][Sel],'b'+Symb[n])
        ax[0,0].plot(Data['phi'  ][Sel]     ,Data['YCO_m'][Sel],'r'+Symb[n])
        ax[0,1].plot(Data['IQ'   ][Sel]*1e-9,Data['YCO_b'][Sel],'b'+Symb[n])
        ax[0,1].plot(Data['IQ'   ][Sel]*1e-9,Data['YCO_m'][Sel],'r'+Symb[n])
        ax[1,0].plot(Data['YH2_u'][Sel]     ,Data['YCO_b'][Sel],'b'+Symb[n])
        ax[1,0].plot(Data['YH2_u'][Sel]     ,Data['YCO_m'][Sel],'r'+Symb[n])
        ax[1,1].plot(Data['Ta'   ][Sel]     ,Data['YCO_b'][Sel],'b'+Symb[n])
        ax[1,1].plot(Data['Ta'   ][Sel]     ,Data['YCO_m'][Sel],'r'+Symb[n])

fig.tight_layout()
fig.savefig(dp+'/YCO.pdf')

Imax=argmax(Data['IQ'])

print('=> max IQ : %.3f [GW/m3]  ,  phi : %.3f  ,  hyb : %.3f  ,  rm : %.3f'%(Data['IQ'][Imax]*1e-9,Data['phi'][Imax],Data['hyb'][Imax],Data['rm'][Imax]))

# %%