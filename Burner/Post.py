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
(Sysa,NSysa,Arg)=util.Parseur(['CO','NOx'],0,'Arg : ')
(                               CO , NOX )=Arg

from numpy import *

# t0=time.time()
(plt,mtp)=util.Plot0()

#%%=================================================================================
#                     Inputs
#===================================================================================
if   CO :
    Symb=['o','s','d','x','+']
    Col1=['r','m','violet','c','b']
    d0='H2-CO2-Reduction/'
    titre='CO mass fraction'
    fname='YCO.pdf'
    var1='YCO_b'
    # var2='YCO_m'
    var2=''
    c1,c2=1,1
    Spe=[r'Hydrogen',r'$Y_{H_2}^u$ [-]','YH2_u',1]
elif NOX :
    Col1=['g']
    Col2=['b']
    d0='NOx-Formation/'
    titre='NOx mass fraction'
    fname='YNOx.pdf'
    var1='YNO_b'
    var2='YNO2_b'
    c1,c2=1e6,1e9
    # Spe=[r'Oxygen',r'$Y_{O_2}^u$ [-]','YO2_u']
    Spe=[r'Max heat release rate',r'max Q [GW/m3]','MQ',1e-9]

#%%=================================================================================
#                     Process
#===================================================================================
dp=d0+'Post/'
data=d0+'Data/STe.csv'
util.MKDIR(dp)
#===================================================================================

#=====> Reading
Data=util.ReadCSV(data)

#=====> Carbon monoxide
if CO or NOX :
    Hyb=set(Data['hyb']) ; print(Hyb)
    fig,ax=plt.subplots(ncols=2,nrows=2,figsize=(14,10))
    fig.suptitle(titre,fontsize=30)
    if CO : ax[0,1].set_xlim((0,30))
    ax[0,0].set_title( r'Equivalence ratio'     ,fontsize=20) #=> Phi
    ax[0,0].set_xlabel(r'$\phi$ [-]'            ,fontsize=30)
    ax[0,1].set_title( r'Thermal power'         ,fontsize=20) #=> Power
    ax[0,1].set_xlabel(r'P [GW/m2]'             ,fontsize=30)
    ax[1,0].set_title( Spe[0]                   ,fontsize=20) #=> Hydrogen
    ax[1,0].set_xlabel(Spe[1]                   ,fontsize=30)
    ax[1,1].set_title( r'Burned gas temperature',fontsize=20) #=> Temperature
    ax[1,1].set_xlabel(r'$T_b$ [K]'             ,fontsize=30)
    for n,h in enumerate(Hyb) :
        Sel_h=Data['hyb']==h
        Phi=set(Data['phi'])
        for p in Phi :
            Sel_p=Data['phi']==p
            Sel=Sel_h*Sel_p
            if var1 :
                col1=Col1[n]
                ax[0,0].plot(Data['phi' ][Sel]       ,Data[var1][Sel]*c1,col1)
                ax[0,1].plot(Data['IQ'  ][Sel]*1e-9  ,Data[var1][Sel]*c1,col1)
                ax[1,0].plot(Data[Spe[2]][Sel]*Spe[3],Data[var1][Sel]*c1,col1)
                ax[1,1].plot(Data['Ta'  ][Sel]       ,Data[var1][Sel]*c1,col1)
            if var2 :
                col2=Col2[n]
                ax[0,0].plot(Data['phi' ][Sel]       ,Data[var2][Sel]*c2,col2)
                ax[0,1].plot(Data['IQ'  ][Sel]*1e-9  ,Data[var2][Sel]*c2,col2)
                ax[1,0].plot(Data[Spe[2]][Sel]*Spe[3],Data[var2][Sel]*c2,col2)
                ax[1,1].plot(Data['Ta'  ][Sel]       ,Data[var2][Sel]*c2,col2)
    fig.tight_layout()
    fig.savefig(dp+fname)
    # Imax=argmax(Data['IQ'])
    # print('=> max IQ : %.3f [GW/m3]  ,  phi : %.3f  ,  hyb : %.3f  ,  rm : %.3f'%(Data['IQ'][Imax]*1e-9,Data['phi'][Imax],Data['hyb'][Imax],Data['rm'][Imax]))

# %%