#!/usr/bin/env python3
#-*- coding: utf-8 -*-

import Flamme1D as f1D
import Utilities as util
import numpy as np
import cantera as ct

import sys
import os
import time


t0=time.time()

#---------------------------------------------------------------------
######################################             Input             #
#---------------------------------------------------------------------
d_schem='/mnt/d/Cantera/Scheme'
ct.add_directory(d_schem)
# f_thermo='UCSD_SanDiego0'
f_thermo='gri30'
f_chemst='/mnt/d/Cantera/Scheme/Laera-Reac.csv'

input_file=f_thermo+'.yaml'
all_spe=ct.Species.list_from_file(input_file,section='species')
gas = ct.Solution(thermo='ideal-gas',kinetics='gas',transport_model='mixture-averaged',species=all_spe)

#---------------------------------------------------------------------
######################################             Building          #
#---------------------------------------------------------------------
def s_rate(vp) :
	p=[float(x) for x in vp.split(' ') if x ]
	rate='{'+'A: {:.8e}, b: {:.8f}, Ea: {:.8e}'. format(p[0],p[1],p[2])+'}'# ; print(rate)
	return(rate)
#---------------------------------------------------------------------
def s_tri(vp) :
	p=[]
	for s in vp.split(' ')[1:] :
		m,i=s.split(':')
		p.append(m+': {:.3f}'.format(float(i)))
	tri='{'+p[1]
	for s in p[2:] : tri+=', '+s
	tri+='}'
	return(tri)
#---------------------------------------------------------------------
def s_tro(vp) :
	# print(vp)
	p=[float(x) for x in vp.split(' ') if x ] #; print(p)
	if   len(p)==3 : tro='{'+'A: {:.3f}, T3: {:.3f}, T1: {:.3f}'.            format(p[0],p[1],p[2]     )+'}' #; print(tro)
	elif len(p)==4 : tro='{'+'A: {:.3f}, T3: {:.3f}, T1: {:.3f}, T2: {:.3f}'.format(p[0],p[1],p[2],p[3])+'}' #; print(tro)
	else               : tro='' ; util.Error('Wrong size of troe falloff parameters : {}'.format(len(tro)))
	return(tro)
#---------------------------------------------------------------------

freac=open(f_chemst) ; Np=[]
for l in freac.readlines() :
	Vl=l[:-1].split(';') ; Np.append(len([ v for v in Vl if v]))
	n=int(Vl[0]) #; print(n)
	eq0=Vl[1]
	if   '<=>' in eq0 : (r,p)=eq0.split('<=>') ; eq=r.strip()+'  <=>  '+p.strip()
	elif  '=>' in eq0 : (r,p)=eq0.split('=>')  ; eq=r.strip()+ '  =>  '+p.strip()
	else : util.Error('Wrong equation symbol (<=>,=>) : '+eq0)
	# print(eq)
	if   Vl[3] : #=======================================> Troe Fallof
		low=s_rate(Vl[2])
		hig=s_rate(Vl[3])
		tro=s_tro(Vl[4])
		tri=s_tri(Vl[5])
		reac='''
equation: {}  # Reaction {}
type: falloff
low-P-rate-constant: {}
high-P-rate-constant: {}
Troe: {}
efficiencies: {}
		'''.format(eq,n,low,hig,tro,tri)
	elif Vl[5] : #=======================================> Troe Fallof
		low=s_rate(Vl[2])
		tri=s_tri(Vl[5])
		reac='''
equation: {}  # Reaction {}
type: three-body
rate-constant: {}
efficiencies: {}
		'''.format(eq,n,low,tri)
	else      : #=======================================> Arhenius
		low=s_rate(Vl[2])
		reac='''
equation: {}  # Reaction {}
rate-constant: {}
		'''.format(eq,n,low)
	# print(reac)
	gas.add_reaction( ct.Reaction.from_yaml(reac,kinetics=gas) )

#---------------------------------------------------------------------
######################################             Writing           #
#---------------------------------------------------------------------

gas.write_yaml(filename=d_schem+'/Laera.yaml',units={'length':'m', 'quantity': 'kmol', 'activation-energy': 'J/kmol'},precision=8)