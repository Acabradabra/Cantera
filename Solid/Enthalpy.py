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
(Sysa,NSysa,Arg)=util.Parseur(['Base','Nasa','Only','Save'],0,'Arg : ')
(                             [ BASE , NASA , ONLY , SAVE ])=Arg

import Flamme1D as f1D
from numpy import *
import cantera as ct
import Klinker as kk

import sys
import os
import time

t0=time.time()
(plt,mtp)=util.Plot0()
#%%=================================================================================
#                     Parameters
#===================================================================================
dirp='/mnt/scratch/ZEUS/Cantera/Solid/PLOT/'

mdot=6 # [T/j] Production of klinker
# mdot=5.6 # [T/j] Production of klinker

#====================> Temperature discretisation
dT=10                           # [K] Temperature step for enthalpy calculation
Temp=arange(300,1900+0.1*dT,dT) # [K] Temperature range for enthalpy calculation
Tvap=100 +273.15 # [K] Vaporization temperature of water
Tdhy=500 +273.15 # [K] Dehydration temperature of aluminum hydroxide
Tdc1=500 +273.15 # [K] First decarbonization temperature of calcium carbonate
Tdc2=900 +273.15 # [K] Second decarbonization temperature of calcium carbonate
Tfus=1500+273.15 # [K] Fusion temperature of CAC


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
    Species=list(kk.Compo_feed)+list(kk.Compo_AlOOH)+list(kk.Compo_CACO3)
    # print(Species)
    Tref=1e3

    print(util.Col('b','=> Gas :'))
    for s in gas :
        if any([sp in s.name for sp in Species]) :
            print(f' {s.name:<10} => cp : {s.thermo.cp(Tref):.5e} [J/K-kmol]   ,   h : {s.thermo.h(Tref):.5e} [J/kmol]')
    print(util.Col('b','=> Condensed :'))
    for s in sol :
        if any([sp in s.name for sp in Species]) :
            print(f' {s.name:<10} => cp : {s.thermo.cp(Tref):.5e} [J/K-kmol]   ,   h : {s.thermo.h(Tref):.5e} [J/kmol]')
#===================================================================================
if ONLY : sys.exit('=> Output !')
#===================================================================================
def cp(Compo,Species,T,Yt) : return(sum([ Species[s].thermo.cp(T)*Compo[s]/Species[s].molecular_weight for s in Compo])/Yt) # Heat capacity of phase 1 at T=300 K [J/K-kg]
#-----------------------------------------------------------------------------------
def Cp(Compo,Species,VT) : Yt=sum([ Compo[s] for s in Compo]) ; return(Yt, array([ cp(Compo,Species,T,Yt) for T in VT ]) )
#===================================================================================
def print_Spec(Compo,Species,T) :
    for s in Compo : 
        spe=Species[s]
        print(f' {s:<10} => cp : {spe.thermo.cp(T):.2e} [J/K-kmol]   ,   h : {spe.thermo.h(T):.2e} [J/kmol]   ,   y : {Compo[s]*1e2:.2f} [%] ,  W : {spe.molecular_weight:.2f} [g/mol]')
#===================================================================================

#====================> Species
sol=ct.Species.list_from_file('nasa_condensed.yaml') ; Snames=[s.name for s in sol]
gas=ct.Species.list_from_file('nasa_gas.yaml')       ; Gnames=[s.name for s in gas]
Spe_names=['H2O','H2O(s)','H2O(L)','CO2','CaO(s)','CaO(L)','AL2O3(a)','AL2O3(L)','Fe2O3(s)','SiO2(Lqz)','SiO2(L)','TiO2(ru)','TiO2(L)','CaCO3(caL)'] ; Nspe0=len(Spe_names)
Species       ={s:gas[Gnames.index(s)] for s in Spe_names if s in Gnames}
Species.update({s:sol[Snames.index(s)] for s in Spe_names if s in Snames})
Nspe1=len(Species)
print( util.Col((Nspe0==Nspe1)*'g'+(Nspe0!=Nspe1)*'r',f'=> Nspe0 : {Nspe0}  ,  Nspe1 : {Nspe1} \n') )

#====================> 
util.Section( 'Phase 1 [T0 Tvap]',0,3,'r' )
#====================>
Compo_1={
    'CO2'      :                                             kk.Compo_feed['CaCO3']*kk.Compo_CACO3['CO2'] ,
    'CaO(s)'   :                                             kk.Compo_feed['CaCO3']*kk.Compo_CACO3['CaO'] ,
    'H2O(L)'   :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['Vap']+kk.Compo_feed['CaCO3']*kk.Compo_CACO3['Vap'] ,
    'H2O(s)'   :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['H2O']                                              ,
    'AL2O3(a)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['AL2O3']                                            ,
    'Fe2O3(s)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['Fe2O3']                                            ,
    'SiO2(Lqz)':kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['SiO2']                                             ,
    'TiO2(ru)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['TiO2']                                             ,
}
# print_Spec(Compo_1,Species,Temp[0])
Temp1=append(Temp[Temp<Tvap],Tvap)
(Yt1,Cp1)=Cp(Compo_1,Species,Temp1)
DH1=trapezoid(Cp1,Temp1)
print(f'=> Yt1 : {(1-Yt1)*1e2:.2f} %')
print(f'=> cp({Temp1[ 0]:.2f} [K] ) : {Cp1[ 0]:.2e} [J/K-kg] , {Cp1[ 0]/4.184e3:.2f} [kcal/K-kg]') 
print(f'=> cp({Temp1[-1]:.2f} [K] ) : {Cp1[-1]:.2e} [J/K-kg] , {Cp1[-1]/4.184e3:.2f} [kcal/K-kg]') 
print(util.Col('b',f'=> DH1 : {DH1/1e3:.2f} [kJ/kg(rm)] '))
#====================> 
util.Section( 'Phase 2 [Tvap]',0,3,'r' )
#====================>
y_vap=kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['Vap']+kk.Compo_feed['CaCO3']*kk.Compo_CACO3['Vap']
H_vap=(Species['H2O'].thermo.h(Tvap)-Species['H2O(L)'].thermo.h(Tvap))/Species['H2O'].molecular_weight # [J/kg] Enthalpy of vaporization of water at Tvap
DH2=y_vap*H_vap
print(f'=> y_vap : {y_vap*1e2:.2f} %')
print(f'=> H_vap : {H_vap/1e3:.2f} [kJ/kg] , {H_vap/4.184e3:.2f} [kcal/kg]')
print(util.Col('b',f'=> DH2 : {DH2/1e3:.2f} [kJ/kg(rm)] '))
#====================> 
util.Section( 'Phase 3 [Tvap Tdc1]',0,3,'r' )
#====================>
Compo_3={
    'CO2'      :                                             kk.Compo_feed['CaCO3']*kk.Compo_CACO3['CO2'] ,
    'CaO(s)'   :                                             kk.Compo_feed['CaCO3']*kk.Compo_CACO3['CaO'] ,
    'H2O'      :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['H2O']                                              ,
    'AL2O3(a)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['AL2O3']                                            ,
    'Fe2O3(s)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['Fe2O3']                                            ,
    'SiO2(Lqz)':kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['SiO2']                                             ,
    'TiO2(ru)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['TiO2']                                             ,
}
Temp3=append(Tvap,append(Temp[(Tvap<Temp) & (Temp<Tdc1)],Tdc1))
(Yt3,Cp3)=Cp(Compo_3,Species,Temp3)
DH3=trapezoid(Cp3,Temp3)*(1-y_vap)
# print_Spec(Compo_3,Species,Temp3[-1])
print(f'=> Yt3 : {(1-Yt3)*1e2:.2f} %')
print(f'=> cp({Temp3[ 0]:.2f} [K] ) : {Cp3[ 0]:.2e} [J/K-kg] , {Cp3[ 0]/4.184e3:.2f} [kcal/K-kg]') 
print(f'=> cp({Temp3[-1]:.2f} [K] ) : {Cp3[-1]:.2e} [J/K-kg] , {Cp3[-1]/4.184e3:.2f} [kcal/K-kg]') 
print(util.Col('b',f'=> DH3 : {DH3/1e3:.2f} [kJ/kg(rm)] '))
#====================> 
util.Section( 'Phase 4 [Tdhy]',0,3,'r' )
#====================>
y_h2o=kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['H2O']
H_hyd=kk.DH_dhyd*4.184e3 # [J/kg] Enthalpy of dehydration of aluminum hydroxide at Tdc1
DH4=y_h2o*H_hyd
print(f'=> y_h2o : {y_h2o*1e2:.2f} %')
print(f'=> H_hyd : {H_hyd/1e3:.2f} [kJ/kg] , {H_hyd/4.184e3:.2f} [kcal/kg]')
print(util.Col('b',f'=> DH4 : {DH4/1e3:.2f} [kJ/kg(rm)] '))
#====================> 
util.Section( 'Phase 5 [Tdc1-Tdc2] CO2',0,3,'r' )
#====================>
y_co2=kk.Compo_feed['CaCO3']*kk.Compo_CACO3['CO2']
H_decb=kk.DH_decb*4.184e3 # [J/kg] Enthalpy of decarbonation of calcium carbonate at Tdc1
DH5=kk.Compo_feed['CaCO3']*H_decb
print(f'=> y_co2 : {y_co2*1e2:.2f} %')
print(f'=> H_decb : {H_decb/1e3:.2f} [kJ/kg] , {H_decb/4.184e3:.2f} [kcal/kg]')
print(util.Col('b',f'=> DH5 : {DH5/1e3:.2f} [kJ/kg(rm)] '))
#====================> 
util.Section( 'Phase 6 [Tdc1-Tdc2] T',0,3,'r' )
#====================>
Compo_6={
    'CO2'      :                                             kk.Compo_feed['CaCO3']*kk.Compo_CACO3['CO2']*0.5 ,
    'CaO(s)'   :                                             kk.Compo_feed['CaCO3']*kk.Compo_CACO3['CaO'] ,
    'AL2O3(a)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['AL2O3']                                            ,
    'Fe2O3(s)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['Fe2O3']                                            ,
    'SiO2(Lqz)':kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['SiO2']                                             ,
    'TiO2(ru)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['TiO2']                                             ,
} # Phase 3 composition
Temp6=append(Tdc1,append(Temp[(Tdc1<Temp) & (Temp<Tdc2)],Tdc2))
# print_Spec(Compo_6,Species,Temp6[-1])
(Yt6,Cp6)=Cp(Compo_6,Species,Temp6) ; y_kk=1-(y_vap+y_h2o+y_co2)
DH6=trapezoid(Cp6,Temp6)*(1-(y_vap+y_h2o+0.5*kk.Compo_feed['CaCO3']*kk.Compo_CACO3['CO2']))
print(f'=> Yt6 : {(1-Yt6)*1e2:.2f} %  ,  y_kk : {y_kk*1e2:.2f} %')
print(f'=> cp({Temp6[ 0]:.2f} [K] ) : {Cp6[ 0]:.2e} [J/K-kg] , {Cp6[ 0]/4.184e3:.2f} [kcal/K-kg]') 
print(f'=> cp({Temp6[-1]:.2f} [K] ) : {Cp6[-1]:.2e} [J/K-kg] , {Cp6[-1]/4.184e3:.2f} [kcal/K-kg]') 
print(util.Col('b',f'=> DH6 : {DH6/1e3:.2f} [kJ/kg(rm)] '))
#====================> 
util.Section( 'Phase 7 [Tdc2-Tfus]',0,3,'r' )
#====================>
Compo_7={
    'CaO(s)'   :                                             kk.Compo_feed['CaCO3']*kk.Compo_CACO3['CaO'] ,
    'AL2O3(a)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['AL2O3']                                            ,
    'Fe2O3(s)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['Fe2O3']                                            ,
    'SiO2(Lqz)':kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['SiO2']                                             ,
    'TiO2(ru)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['TiO2']                                             ,
}
Temp7=append(Tdc2,append(Temp[(Tdc2<Temp) & (Temp<Tfus)],Tfus))
# print_Spec(Compo_7,Species,Temp7[-1])
(Yt7,Cp7)=Cp(Compo_7,Species,Temp7)
DH7=trapezoid(Cp7,Temp7)*y_kk
print(f'=> Yt7 : {(1-Yt7)*1e2:.2f} %  ,  y_kk : {y_kk*1e2:.2f} %')
print(f'=> cp({Temp7[ 0]:.2f} [K] ) : {Cp7[ 0]:.2e} [J/K-kg] , {Cp7[ 0]/4.184e3:.2f} [kcal/K-kg]') 
print(f'=> cp({Temp7[-1]:.2f} [K] ) : {Cp7[-1]:.2e} [J/K-kg] , {Cp7[-1]/4.184e3:.2f} [kcal/K-kg]') 
print(util.Col('b',f'=> DH7 : {DH7/1e3:.2f} [kJ/kg(rm)] '))
#====================> 
util.Section( 'Phase 8 [Tfus]',0,3,'r' )
#====================>
H_fus=(kk.DH_rcac+kk.DH_fcac)*4.184e3 # [J/kg] Enthalpy of reaction and fusion of CAC at Tfus
DH8=y_kk*H_fus
print(f'=> y_kk : {y_kk*1e2:.2f} %')
print(f'=> H_fus : {H_fus/1e3:.2f} [kJ/kg] , {H_fus/4.184e3:.2f} [kcal/kg]')
print(util.Col('b',f'=> DH8 : {DH8/1e3:.2f} [kJ/kg(rm)] '))
#====================> 
util.Section( 'Phase 9 [Tfus-Tmax]',0,3,'r' )
#====================>
Compo_9={
    'CaO(s)'   :                                             kk.Compo_feed['CaCO3']*kk.Compo_CACO3['CaO'] ,
    'AL2O3(a)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['AL2O3']                                            ,
    'Fe2O3(s)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['Fe2O3']                                            ,
    'SiO2(Lqz)':kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['SiO2']                                             ,
    'TiO2(ru)' :kk.Compo_feed['AlOOH']*kk.Compo_AlOOH['TiO2']                                             ,
}
Temp9=append(Tfus,Temp[(Tfus<Temp)])
# print_Spec(Compo_9,Species,Temp9[-1])
(Yt9,Cp9)=Cp(Compo_9,Species,Temp9)
DH9=trapezoid(Cp9,Temp9)*y_kk
print(f'=> Yt9 : {(1-Yt9)*1e2:.2f} %  ,  y_kk : {y_kk*1e2:.2f} %')
print(f'=> cp({Temp9[ 0]:.2f} [K] ) : {Cp9[ 0]:.2e} [J/K-kg] , {Cp9[ 0]/4.184e3:.2f} [kcal/K-kg]') 
print(f'=> cp({Temp9[-1]:.2f} [K] ) : {Cp9[-1]:.2e} [J/K-kg] , {Cp9[-1]/4.184e3:.2f} [kcal/K-kg]') 
print(util.Col('b',f'=> DH9 : {DH9/1e3:.2f} [kJ/kg(rm)] '))

#====================> 
util.Section( 'Bilan ',1,3,'r' )
#====================>
DH_tot=DH1+DH2+DH3+DH4+DH5+DH6+DH7+DH8+DH9
Pow=DH_tot*mdot*1e3/(24*3600*y_kk) # [W] Power for production of klinker
Eff_j =DH_tot/(    1e6*y_kk)       # Efficiency of the process in joule
Eff_th=DH_tot/(4.184e3*y_kk)       # Efficiency of the process in thermie
print(util.Col('g',f'=> DH_tot : {DH_tot/1e3:.2f} [kJ/kg(rm)]  ,  Eff : {Eff_j:.2f} [GJ/t KK] , {Eff_th:.2f} [th/t KK] '))
print(util.Col('g',f'=> m : {mdot:.2f} [T/j]  ==>  Power : {Pow/1e3:.2f} [kW] \n'))

#====================> Figure
fig,ax=plt.subplots(figsize=(10,15),nrows=3)
Ybd=[ [0.7,1.05] , [0.2,0.32] , [0,3.5] ]
for i in range(3) :
    ax[i].set_ylim(Ybd[i])
    ax[i].plot(2*[Tvap],Ybd[i],':k')
    ax[i].plot(2*[Tdc1],Ybd[i],':k')
    ax[i].plot(2*[Tdc2],Ybd[i],':k')
    ax[i].plot(2*[Tfus],Ybd[i],':k')
    # ax[i].set_xticks([Temp[0],Tvap,Tdc1,Tdc2,Tfus,Temp[-1]])
ax[0].set_ylabel( 'Mass fraction [-]'         , fontsize=25 )
ax[1].set_ylabel( 'Heat capacity [kcal/K-kg]' , fontsize=25 )
ax[2].set_ylabel( 'Enthalpy [MJ/kg]'          , fontsize=25 )
ax[2].set_xlabel( 'Temperature [°C]'          , fontsize=25 )
ax[0].set_xticklabels([])
ax[1].set_xticklabels([])
#=====> Mass fraction
y_dry=1-y_vap
y_hyd=1-(y_vap+y_h2o)
ax[0].plot([Temp1[0],Temp1[-1]],2*[1         ],'k')
ax[0].plot([Temp3[0],Temp3[-1]],2*[y_dry     ],'k')
ax[0].plot([Temp6[0],Temp6[-1]],  [y_hyd,y_kk],'k')
ax[0].plot([Temp7[0],Temp9[-1]],2*[y_kk      ],'k')
#=====> Heat Capacity
ax[1].plot(Temp1,Cp1/4.184e3,'k')
ax[1].plot(Temp3,Cp3/4.184e3,'k')
ax[1].plot(Temp6,Cp6/4.184e3,'k')
ax[1].plot(Temp7,Cp7/4.184e3,'k')
ax[1].plot(Temp9,Cp9/4.184e3,'k')
#=====> Enthalpy
H=0
ax[2].plot(  [Temp1[0],Temp1[-1]],  [     H*1e-6,(H+DH1    )*1e-6],'k') ; H+=DH1
ax[2].plot(2*[Tvap              ],  [     H*1e-6,(H+DH2    )*1e-6],'k') ; H+=DH2
ax[2].plot(  [Temp3[0],Temp3[-1]],  [     H*1e-6,(H+DH3    )*1e-6],'k') ; H+=DH3
ax[2].plot(2*[Tdhy              ],  [     H*1e-6,(H+DH4    )*1e-6],'k') ; H+=DH4
ax[2].plot(  [Tdc1    ,Tdc2     ],  [     H*1e-6,(H+DH6    )*1e-6],'k') ; Href=H+DH6
ax[2].plot(  [Tdc1    ,Tdc2     ],  [     H*1e-6,(H+DH5+DH6)*1e-6],'k') ; H+=DH5+DH6
ax[2].plot(  [Temp7[0],Temp7[-1]],  [     H*1e-6,(H+DH7    )*1e-6],'k') ; H+=DH7
ax[2].plot(2*[Tfus              ],  [     H*1e-6,(H+DH8    )*1e-6],'k') ; H+=DH8
ax[2].plot(  [Temp9[0],Temp9[-1]],  [     H*1e-6,(H+DH9    )*1e-6],'k')
ax[2].plot(  [ Temp[0], Temp[-1]],2*[DH_tot*1e-6],'--k')
ax[2].text(Tvap-10,DH_tot*1e-6+0.1,'Drying'       ,fontsize=16)
ax[2].text(Tdc1-10,DH_tot*1e-6+0.1,'Dehydration'  ,fontsize=16)
ax[2].text(Tdc1+10,DH_tot*1e-6-0.2,'Decarbonation',fontsize=16)
ax[2].text(Tdc2+10,  Href*1e-6    ,'Heating only' ,fontsize=16)
ax[2].text(Tfus-10,DH_tot*1e-6+0.1,'Melting'      ,fontsize=16)

if SAVE : util.SaveFig(fig,dirp+'Enthalpy.pdf')