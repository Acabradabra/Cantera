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
(Sysa,NSysa,Arg)=util.Parseur(['CO','NOx','Compa','Carac'],0,'Arg : ')
(                               CO , NOX , COMPA , CARAC )=Arg

import os
import Flamme1D   as f1D
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
    data=d0+'Data/STe.csv'
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
    data=d0+'Data/STe.csv'
    titre='NOx mass fraction'
    fname='YNOx.pdf'
    var1='YNO_b'
    var2='YNO2_b'
    c1,c2=1e6,1e9
    # Spe=[r'Oxygen',r'$Y_{O_2}^u$ [-]','YO2_u']
    Spe=[r'Max heat release rate',r'max Q [GW/m3]','MQ',1e-9]
elif COMPA :
    rm=0.9
    d0='CO-Comparison/'
    titre_m='CO maximal mass fractions'
    titre_b='CO burned mass fractions'
    # data1=d0+'Data/STe-grimech211.csv'
    data1=d0+'Data/STe-gri30.csv'
    data2=d0+'Data/STe-Laera-light.csv'
    Col=['g','r']
elif CARAC :
    d0='Carac-O2-CO2_20p/'
    # d0='Carac-Air-CO2_10p/'
    rm=1
    hyb=0
    Schems=[
        'gri30',
        'Laera-light',
        '2S_CH4_BFER']
    Labels=[
        'grimech',
        'Laera' ,
        'BFER']
    if hyb==1 or 'Carac-O2' in d0 : Schems=Schems[:-1]
    Col=['.k','-g','-r']
    ERR=False

#%%=================================================================================
#                     Process
#===================================================================================
dp=d0+'Post/'
if CARAC and ERR : dp=dp[:-1]+'-Err/'
util.MKDIR(dp)
#===================================================================================

#=====> Carbon monoxide
if CO or NOX :
    Data=util.ReadCSV(data)
    Hyb=sort([ h for h in set(Data['hyb'])]) ; print(Hyb)
    fig,ax=plt.subplots(ncols=2,nrows=2,figsize=(14,10))
    fig.suptitle(titre,fontsize=30)
    if CO : ax[0,1].set_xlim((0,40))
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
    # ax[0,0].legend(fontsize=12)
    fig.tight_layout()
    fig.savefig(dp+fname)
    # Imax=argmax(Data['IQ'])
    # print('=> max IQ : %.3f [GW/m3]  ,  phi : %.3f  ,  hyb : %.3f  ,  rm : %.3f'%(Data['IQ'][Imax]*1e-9,Data['phi'][Imax],Data['hyb'][Imax],Data['rm'][Imax]))
elif COMPA :
    #=====> Reading
    Data1=util.ReadCSV(data1)
    Data2=util.ReadCSV(data2)
    #=====> Hybridation
    Hyb1=sort([ h for h in set(Data1['hyb'])]) ; Nh1=len(Hyb1) ; print('=> Hyb1 : ',Hyb1)
    Hyb2=sort([ h for h in set(Data2['hyb'])]) ; Nh2=len(Hyb2) ; print('=> Hyb2 : ',Hyb2)
    if Nh1==Nh2 : Hyb=Hyb1 ; Nh=Nh1
    else        : Hyb=[ h for h in unique(concatenate((Hyb1,Hyb2))) if h in Hyb1 and h in Hyb2 ] ; Nh=len(Hyb)
    nc=2 ; nr=Nh//nc+int(Nh%nc>0)
    #=====> Flow rate
    Rm1=sort([ r for r in set(Data1['rm'])]) ; Nr1=len(Rm1) ; print('=> Rm1 : ',Rm1)
    Rm2=sort([ r for r in set(Data2['rm'])]) ; Nr2=len(Rm2) ; print('=> Rm2 : ',Rm2)
    if Nr1==Nr2 : Rm=Rm1 ; Nr=Nr1
    else        : Rm=[ r for r in unique(concatenate((Rm1,Rm2))) if r in Rm1 and r in Rm2 ] ; Nr=len(Rm)
    #=====> Ploting
    for rm in Rm :
        fname_m='YCO-r%03.0f_m.pdf'%(rm*100)
        fname_b='YCO-r%03.0f_b.pdf'%(rm*100)
        fig_m,ax_m=plt.subplots(ncols=nc,nrows=nr,figsize=(14,8*nr/nc)) ; bx_m=[ [a.twinx() for a in A] for A in ax_m]
        fig_b,ax_b=plt.subplots(ncols=nc,nrows=nr,figsize=(14,8*nr/nc)) ; bx_b=[ [a.twinx() for a in A] for A in ax_b]
        if Nh%nc>0 : 
            ax_m[-1,-1].axis('off') ; bx_m[-1][-1].axis('off')
            ax_b[-1,-1].axis('off') ; bx_b[-1][-1].axis('off')
        fig_m.suptitle(titre_m,fontsize=30)
        fig_b.suptitle(titre_b,fontsize=30)
        for n,h in enumerate(Hyb) :
            i=n//nc ; j=n%nc
            ax_m[i,j].set_title( r'Hybridation : %.0f'%(h*1e2)+'%' ,fontsize=20)
            ax_b[i,j].set_title( r'Hybridation : %.0f'%(h*1e2)+'%' ,fontsize=20)
            for d,D in enumerate([Data1,Data2]) :
                Sel_h=(D['hyb']==h)
                Sel_r=(D['rm' ]==rm)
                Sel=Sel_h*Sel_r
                Phi  = D['phi'  ][Sel]
                YCO_m= D['YCO_m'][Sel]
                YCO_b= D['YCO_b'][Sel]
                ax_m[i,j].plot(Phi,YCO_m*1e2,Col[d])
                ax_b[i,j].plot(Phi,YCO_b*1e2,Col[d])
            bx_m[i][j].plot(Data1['phi'][Sel],100*abs(Data1['YCO_m'][Sel]-Data2['YCO_m'][Sel])/Data1['YCO_m'][Sel],'k')
            bx_b[i][j].plot(Data1['phi'][Sel],100*abs(Data1['YCO_b'][Sel]-Data2['YCO_b'][Sel])/Data1['YCO_b'][Sel],'k')
            if j==0 :
                ax_m[i,j].set_ylabel(r'$Y_{CO}^{m}$ [%]'   ,fontsize=25)
                ax_b[i,j].set_ylabel(r'$Y_{CO}^{b}$ [%]'   ,fontsize=25)
            if j==nc-1 :
                bx_m[i][j].set_ylabel(r'Relative error [%]',fontsize=25)
                bx_b[i][j].set_ylabel(r'Relative error [%]',fontsize=25)
            if i==nr-1 :
                ax_m[i,j].set_xlabel(r'$\phi$ [-]'         ,fontsize=25)
                ax_b[i,j].set_xlabel(r'$\phi$ [-]'         ,fontsize=25)
        util.SaveFig(fig_m,dp+fname_m)
        util.SaveFig(fig_b,dp+fname_b)
elif CARAC :
    fig,ax=plt.subplots(ncols=2,nrows=2,figsize=(14,10))
    if ERR : bx=array([ [ a.twinx() for a in al ] for al in ax ])
    fig.suptitle('Flame characteristics',fontsize=30)
    ax[0,0].set_ylabel(r'$T_{ad}$ [K]'      ,fontsize=30) ; ax[0,0].set_title('Adiabatique temperature',fontsize=30)
    ax[0,1].set_ylabel(r'$S_l^0$ [cm/s]'    ,fontsize=30) ; ax[0,1].set_title('Flame velocity'         ,fontsize=30)
    ax[1,0].set_ylabel(r'$\delta_l^0$ [mm]' ,fontsize=30) ; ax[1,0].set_title('Flame thickness'        ,fontsize=30)
    ax[1,1].set_ylabel(r'$Y_{CO}^{b}$ [ppm]',fontsize=30) ; ax[1,1].set_title('Carbon monoxide'        ,fontsize=30)
    ax[1,0].set_xlabel(r'$\phi$ [-]',fontsize=30)
    ax[1,1].set_xlabel(r'$\phi$ [-]',fontsize=30)
    #; ax[0,0].set_ylim(Tlim)
    #; ax[0,1].set_ylim(Slim)
    #; ax[1,0].set_ylim(Dlim)
    #; ax[1,1].set_ylim(Ylim)
    for n,s in enumerate(Schems) :
        for mix in ['lean','rich'] :
            data=d0+'Data/STe-{}-{}.csv'.format(s,mix) ; print('=> Reading : '+data)
            if os.path.exists(data) :
                D=util.ReadCSV(data)
                Sel=f1D.SelHybRm(D,hyb,rm)
                if   n==0 and mix=='lean' : D0_l=D ; N0_l=len(D0_l['phi'][Sel]) ; Sel0_l=Sel
                elif n==0 and mix=='rich' : D0_r=D ; N0_r=len(D0_r['phi'][Sel]) ; Sel0_r=Sel
                elif True : # mix=='lean' : 
                    if   mix=='lean' : D0=D0_l ; N0=N0_l ; Sel0=Sel0_l
                    elif mix=='rich' : D0=D0_r ; N0=N0_r ; Sel0=Sel0_r
                    N1=len(D['phi']) ; Nt=min([N0,N1])-1
                    ET=abs(D['Ta'   ][Sel][:Nt]-D0['Ta'   ][Sel0][:Nt])/D0['Ta'   ][Sel0][:Nt] ; print(f'=> ET : {100*max(ET):.2f} [%]')
                    ES=abs(D['Sl'   ][Sel][:Nt]-D0['Sl'   ][Sel0][:Nt])/D0['Sl'   ][Sel0][:Nt] ; print(f'=> ES : {100*max(ES):.2f} [%]')
                    ED=abs(D['Dl'   ][Sel][:Nt]-D0['Dl'   ][Sel0][:Nt])/D0['Dl'   ][Sel0][:Nt] ; print(f'=> ED : {100*max(ED):.2f} [%]')
                    EY=abs(D['YCO_b'][Sel][:Nt]-D0['YCO_b'][Sel0][:Nt])/D0['YCO_b'][Sel0][:Nt] ; print(f'=> EY : {100*max(EY):.2f} [%]')
                if n==1 and ERR : 
                    bx[0,0].plot(D['phi'][Sel][:Nt],100*ET,'k')
                    bx[0,1].plot(D['phi'][Sel][:Nt],100*ES,'k')
                    bx[1,0].plot(D['phi'][Sel][:Nt],100*ED,'k')
                    bx[1,1].plot(D['phi'][Sel][:Nt],100*EY,'k')
                Phi=D['phi'  ][Sel]
                Tad=D['Ta'   ][Sel]
                Sl =D['Sl'   ][Sel]*1e2
                Dl =D['Dl'   ][Sel]
                YCO=D['YCO_b'][Sel]*1e6
                ax[0,0].plot(    Phi,Tad,Col[n],label=Labels[n]+'-')
                ax[0,1].plot(    Phi,Sl ,Col[n],label=Labels[n]+'-')
                ax[1,0].plot(    Phi,Dl ,Col[n],label=Labels[n]+'-')
                ax[1,1].semilogy(Phi,YCO,Col[n],label=Labels[n]+'-')
            else : print('=> No file ')
    ax[0,0].plot(2*[1],ax[0,0].get_ylim(),':k')
    ax[0,1].plot(2*[1],ax[0,1].get_ylim(),':k')
    ax[1,0].plot(2*[1],ax[1,0].get_ylim(),':k')
    ax[1,1].plot(2*[1],ax[1,1].get_ylim(),':k')
    util.SaveFig(fig,dp+f'Carac-hyb{hyb*100:03.0f}.svg')