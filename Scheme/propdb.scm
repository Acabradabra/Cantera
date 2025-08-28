;;;
;;; Copyright 1987-2024 ANSYS, Inc. All Rights Reserved.
;;;



;;; (name type[fluid/solid] (chemical-formula . formula)
;;;                         (prop1 (method1a . data1a) (method1b . data1b))
;;;                         (prop2 (method2a . data2a) (method2b . data2b)))
;;;
;;; The default method should be listed _first_ for each property. 
;;; Constant methods are dotted pairs where the cdr is a number.
;;; Coefficient methods are lists where the cdr is the coefficients.
;;; Methods which take no user data are dotted pairs where the cdr is #f.
;;;
;;; All properties are in SI units.
;;;
;;; Developers:  Please keep this list in alpabetical order, and use only valid
;;;              Scheme symbol names.  Every entry should include a reference
;;;              number on its first line.  References are listed at the end of
;;;              this file. 
;;; 
;;; Main Data Source for critical properties:
;;;   B. E. Poling, J. M. Prausnitz, J. P. O'Connel,
;;;     The Properties of Gases and Liquids, 5th Ed., McGraw-Hill.
;;; Other data source
;;;   Robert H Perry, Cecil H Chilton
;;;   Chemical Engineers' Handbook, 5th Edition, McGraw-Hill.
(
 ;; mixture-template must be at the top to serve as the default choice
 ;; for mixture.  This is the only exception to the alpabetical order rule.
 
 (mixture-template
  mixture
  (chemical-formula . #f)
  (species (names h2o o2 n2))
  (reactions (finite-rate ("reaction-1" () () ((o2 0 1) (h2o 0 1) (n2 0 1)) (stoichiometry "  ") (arrhenius 1e+15 1e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" () () ((o2 0 1) (h2o 0 1) (n2 0 1)) (stoichiometry "  ") (arrhenius 1e+15 100 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" () () ((o2 0 1) (h2o 0 1) (n2 0 1)) (stoichiometry "  ") (arrhenius 1e+15 100 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (air-2species-nitrogen
  mixture
  (chemical-formula . #f)
  (species (names n2 n))
  (reactions (finite-rate ("reaction-1" ((n2 1 1 1) (n2 1 1 1)) ((n 2 0 1) (n2 1 0 1)) ((n2 0 1)) (stoichiometry "1n2 + 1n2 --> 2n + 1n2") (arrhenius 7e+18 9.41197e+08 -1.6) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 0.7)) ("reaction-2" ((n2 1 1 1) (n 1 1 1)) ((n 2 0 1) (n 1 0 1)) ((n2 0 1)) (stoichiometry "1n2 + 1n --> 2n + 1n") (arrhenius 3e+19 9.41197e+08 -1.6) (mixing-rate 2 0.9) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 0.7))))
  (collision-cross-section (cross-section-multicomponent (n2 n2   (neutral-involved-interaction -6.0614558E-03 1.2689102E-01 -1.0616948E+00 8.0955466E+02 -7.6303990E-03 1.6878089E-01 -1.4004234E+00 2.1427708E+03))
                                                         (n2 n    (neutral-involved-interaction -1.0796249E-02 2.2656509E-01 -1.7910602E+00 4.0455218E+03 -8.3493693E-03 1.7808911E-01 -1.4466155E+00 1.9324210E+03))
                                                         (n  n    (neutral-involved-interaction -9.6083779E-03 2.0938971E-01 -1.7386904E+00 3.3587983E+03 -7.7439615E-03 1.7129007E-01 -1.4809088E+00 2.1284951E+03))
                                                         )
                           )
  (mass-diffusivity (constant-lewis-number 1.4) (unity-lewis-number . #f))
  (thermal-conductivity (ideal-gas-mixing-law . #f))
  (viscosity (ideal-gas-mixing-law . #f))
  (specific-heat (mixing-law . #f))
  )
 
 (air-5species-park93
  mixture
  (chemical-formula . #f)
  (species (names n o2 o no n2))
  (mass-diffusivity (constant-lewis-number 1.4) (unity-lewis-number . #f))
  (thermal-conductivity (ideal-gas-mixing-law . #f))
  (viscosity (ideal-gas-mixing-law . #f))
  (specific-heat (mixing-law . #f))
  (collision-cross-section (cross-section-multicomponent (n2 n2   (neutral-involved-interaction -6.0614558E-03 1.2689102E-01 -1.0616948E+00 8.0955466E+02 -7.6303990E-03 1.6878089E-01 -1.4004234E+00 2.1427708E+03))
                                                         (n2 o2   (neutral-involved-interaction -3.7959091E-03 9.5708295E-02 -1.0070611E+00 8.9392313E+02 -8.0457321E-03 1.9228905E-01 -1.7102854E+00 5.2213857E+03))
                                                         (o2 o2   (neutral-involved-interaction -8.0682650E-04 1.6602480E-02 -3.1472774E-01 1.4116458E+02 -6.2931612E-03 1.4624645E-01 -1.3006927E+00 1.8066892E+03))
                                                         (n2 n    (neutral-involved-interaction -1.0796249E-02 2.2656509E-01 -1.7910602E+00 4.0455218E+03 -8.3493693E-03 1.7808911E-01 -1.4466155E+00 1.9324210E+03))
                                                         (o2 n    (neutral-involved-interaction -1.1453028E-03 1.2654140E-02 -2.2435218E-01 7.7201588E+01 -1.0608832E-03 1.1782595E-02 -2.1246301E-01 8.4561598E+01))
                                                         (n  n    (neutral-involved-interaction -9.6083779E-03 2.0938971E-01 -1.7386904E+00 3.3587983E+03 -7.7439615E-03 1.7129007E-01 -1.4809088E+00 2.1284951E+03))
                                                         (n2 o    (neutral-involved-interaction -2.7244269E-03 6.9587171E-02 -7.9538667E-01 4.0673730E+02 -8.3110691E-03 1.9617877E-01 -1.7205427E+00 4.0812829E+03))
                                                         (o2 o    (neutral-involved-interaction -4.8405803E-03 1.0297688E-01 -9.6876576E-01 6.1629812E+02 -3.7969686E-03 7.6789981E-02 -7.3056809E-01 3.3958171E+02))
                                                         (n  o    (neutral-involved-interaction -7.8147689E-03 1.6792705E-01 -1.4308628E+00 1.6628859E+03 -5.0478143E-03 1.0236186E-01 -9.0058935E-01 4.4472565E+02))
                                                         (o  o    (neutral-involved-interaction -6.4040535E-03 1.4629949E-01 -1.3892121E+00 2.0903441E+03 -4.2451096E-03 9.6820337E-02 -9.9770795E-01 8.3320644E+02))
                                                         (n2 no   (neutral-involved-interaction -1.9295666E-03 2.7995735E-02 -3.1588514E-01 1.2880734E+02 -6.8237776E-03 1.4360616E-01 -1.1922240E+00 1.2433086E+03))
                                                         (o2 no   (neutral-involved-interaction -6.4433840E-04 8.5378580E-03 -2.3225102E-01 1.1371608E+02 -6.8508672E-03 1.5524564E-01 -1.3479583E+00 2.0037890E+03))
                                                         (no n    (neutral-involved-interaction -1.5770918E-03 1.9578381E-02 -2.7873624E-01 9.9547944E+01 -1.4719259E-03 1.8446968E-02 -2.6460411E-01 1.0911124E+02))
                                                         (no o    (neutral-involved-interaction -1.0885815E-03 1.1883688E-02 -2.1844909E-01 7.5512560E+01 -1.0066279E-03 1.1029264E-02 -2.0671266E-01 8.2644384E+01))
                                                         (no no   (neutral-involved-interaction 0.0000000E+00 -1.1056066E-02 -5.9216250E-02 7.2542367E+01 -7.4942466E-03 1.6626193E-01 -1.4107027E+00 2.3097604E+03))
                                                         )
                           )
  (reactions (finite-rate ("reaction-1" ((n2 1 1 1) ) ((n 2 0 4.2857)) ((o 0 4.2857)) (stoichiometry "1n2 + 1M --> 2n + 1M") (arrhenius 7e+18 9.41197e+08 -1.6) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #t) (control-temperature 0.7) (backward-reaction? . #t) ) 
                          ("reaction-2" ((o2 1 1 1) ) ((o 2 0 5)) ((n 0 5)) (stoichiometry "1o2 + 1M --> 2o + 1M") (arrhenius 2e+18 4.94710e+08 -1.5) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #t) (control-temperature 0.7) (backward-reaction? . #t) )
                          ("reaction-3" ((no 1 1 1) ) ((n 1 0 22) (o 1 0 22)) () (stoichiometry "1no + 1M --> 1n + 1o + 1M") (arrhenius 5e+12 6.27742e+08 0.0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #t) (control-temperature 0.7) (backward-reaction? . #t) )
                          ("reaction-4" ((no 1 1 1) (o 1 1 1)) ((n 1 0 1) (o2 1 0 1) ) ((n2 0 1)) (stoichiometry "1no + 1o --> 1n + 1o2") (arrhenius 8.4e+9 1.61716e+08 0.0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t))
                          ("reaction-5" ((o 1 1 1) (n2 1 1 1)) ((n 1 0 1) (no 1 0 1) ) ((n2 0 1)) (stoichiometry "1o + 1n2 --> 1n + 1no") (arrhenius 6.4e+14 3.19275e+08 -1.0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) ))))

 (air-11species-park93
  mixture
  (chemical-formula . #f)
  (species (names n o2 o no n+ o2+ o+ no+ n2+ e n2))
  (mass-diffusivity (constant-lewis-number 1.4) (unity-lewis-number . #f))
  (thermal-conductivity (ideal-gas-mixing-law . #f))
  (specific-heat (mixing-law . #f))
  (viscosity (ideal-gas-mixing-law . #f))
  (reactions (finite-rate ("reaction-1" ((n2 1 1 1) ) ((n 2 0 4.2857)) ((o 0 4.2857) (n+ 0 4.2857) (o+ 0 4.2857) (e 0 1714.29)) (stoichiometry "1n2 + 1M --> 2n + 1M") (arrhenius 7e+18 9.41197e+08 -1.6) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #t) (control-temperature 0.7) (backward-reaction? . #t) ) 
                          ("reaction-2" ((o2 1 1 1) ) ((o 2 0 5)) ((n 0 5) (n+ 0 5) (o+ 0 5) (e 0 0)) (stoichiometry "1o2 + 1M --> 2o + 1M") (arrhenius 2e+18 4.94710e+08 -1.5) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #t) (control-temperature 0.7) (backward-reaction? . #t) )
                          ("reaction-3" ((no 1 1 1) ) ((n 1 0 22) (o 1 0 22)) ((n+ 0 22) (o+ 0 22) (e 0 0)) (stoichiometry "1no + 1M --> 1n + 1o + 1M") (arrhenius 5e+12 6.27742e+08 0.0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #t) (control-temperature 0.7) (backward-reaction? . #t) )
                          ("reaction-4" ((no 1 1 1) (o 1 1 1)) ((n 1 0 1) (o2 1 0 1) ) ((n2 0 1)) (stoichiometry "1no + 1o --> 1n + 1o2") (arrhenius 8.4e+9 1.61716e+08 0.0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t))
                          ("reaction-5" ((o 1 1 1) (n2 1 1 1)) ((n 1 0 1) (no 1 0 1) ) ((n2 0 1)) (stoichiometry "1o + 1n2 --> 1n + 1no") (arrhenius 6.4e+14 3.19275e+08 -1.0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-6" ((n 1 1 1) (o 1 1 1)) ((no+ 1 0 1) (e 1 0 1) ) ((n2 0 1)) (stoichiometry "1n + 1o --> 1no+ + 1e") (arrhenius 8.8e+5 265231357.519 1.0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-7" ((o 1 1 1) (o 1 1 1)) ((o2+ 1 0 1) (e 1 0 1) ) ((n2 0 1)) (stoichiometry "1o + 1o --> 1o2+ + 1e") (arrhenius 7.1e-1 670145687.023 2.7) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-8" ((n 1 1 1) (n 1 1 1)) ((n2+ 1 0 1) (e 1 0 1) ) ((n2 0 1)) (stoichiometry "1n + 1n --> 1n2+ + 1e") (arrhenius 4.4e+4 561226226.725 1.5) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-9" ((no+ 1 1 1) (o 1 1 1)) ((n+ 1 0 1) (o2 1 0 1) ) ((n2 0 1)) (stoichiometry "1no+ + 1o --> 1n+ + 1o2") (arrhenius 1.0e+9 641876514.121 0.5) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-10" ((n+ 1 1 1) (n2 1 1 1)) ((n2+ 1 0 1) (n 1 0 1) ) ((n2 0 1)) (stoichiometry "1n+ + 1n2 --> 1n2+ + 1n") (arrhenius 1.0e+9 101436443.941 0.5) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-11" ((o2+ 1 1 1) (n 1 1 1)) ((n+ 1 0 1) (o2 1 0 1) ) ((n2 0 1)) (stoichiometry "1o2+ + 1n --> 1n+ + 1o2") (arrhenius 8.7e+10 237793630.879 0.14) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-12" ((o+ 1 1 1) (no 1 1 1)) ((n+ 1 0 1) (o2 1 0 1) ) ((n2 0 1)) (stoichiometry "1o+ + 1no --> 1n+ + 1o2") (arrhenius 1.4e+2 221164705.643 1.9) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-13" ((o2+ 1 1 1) (n2 1 1 1)) ((n2+ 1 0 1) (o2 1 0 1) ) ((n2 0 1)) (stoichiometry "1o2+ + 1n2 --> 1n2+ + 1o2") (arrhenius 9.9e+9 338398628.559 0.0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-14" ((o2+ 1 1 1) (o 1 1 1)) ((o+ 1 0 1) (o2 1 0 1) ) ((n2 0 1)) (stoichiometry "1o2+ + 1o --> 1o+ + 1o2") (arrhenius 4.0e+9 149660327.127 -0.09) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-15" ((no+ 1 1 1) (n 1 1 1)) ((o+ 1 0 1) (n2 1 0 1) ) ((n2 0 1)) (stoichiometry "1no+ + 1n --> 1o+ + 1n2") (arrhenius 3.4e+10 106425121.512 -1.08) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-16" ((no+ 1 1 1) (o2 1 1 1)) ((o2+ 1 0 1) (no 1 0 1) ) ((n2 0 1)) (stoichiometry "1no+ + 1o2 --> 1o2+ + 1no") (arrhenius 2.4e+10 271051481.352 0.41) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-17" ((no+ 1 1 1) (o 1 1 1)) ((o2+ 1 0 1) (n 1 0 1) ) ((n2 0 1)) (stoichiometry "1no+ + 1o --> 1o2+ + 1n") (arrhenius 7.2e+9 404082883.242 0.29) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-18" ((o+ 1 1 1) (n2 1 1 1)) ((n2+ 1 0 1) (o 1 0 1) ) ((n2 0 1)) (stoichiometry "1o+ + 1n2 --> 1n2+ + 1o") (arrhenius 9.1e+8 189569747.694 0.36) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-19" ((no+ 1 1 1) (n 1 1 1)) ((n2+ 1 0 1) (o 1 0 1) ) ((n2 0 1)) (stoichiometry "1no+ + 1n --> 1n2+ + 1o") (arrhenius 7.2e+10 295163422.944 0.0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-20" ((o 1 1 1) (e 1 1 1)) ((o+ 1 0 1) (e 1 0 1) (e 1 0 1)) ((n2 0 1)) (stoichiometry "1o + 1e --> 1o+ + 1e + 1e") (arrhenius 3.9e+30 1317842324.98 -3.78) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 0.0) (backward-reaction? . #t) )
                          ("reaction-21" ((n 1 1 1) (e 1 1 1)) ((n+ 1 0 1) (e 1 0 1) (e 1 0 1)) ((n2 0 1)) (stoichiometry "1n + 1e --> 1n+ + 1e + 1e") (arrhenius 2.5e+31 1401818397.42 -3.82) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 0.0) (backward-reaction? . #t) )
                          ))
  (collision-cross-section (cross-section-multicomponent (n2 n2   (neutral-involved-interaction -6.0614558E-03 1.2689102E-01 -1.0616948E+00 8.0955466E+02 -7.6303990E-03 1.6878089E-01 -1.4004234E+00 2.1427708E+03))
                                                         (n2 o2   (neutral-involved-interaction -3.7959091E-03 9.5708295E-02 -1.0070611E+00 8.9392313E+02 -8.0457321E-03 1.9228905E-01 -1.7102854E+00 5.2213857E+03))
                                                         (o2 o2   (neutral-involved-interaction -8.0682650E-04 1.6602480E-02 -3.1472774E-01 1.4116458E+02 -6.2931612E-03 1.4624645E-01 -1.3006927E+00 1.8066892E+03))
                                                         (n2 n    (neutral-involved-interaction -1.0796249E-02 2.2656509E-01 -1.7910602E+00 4.0455218E+03 -8.3493693E-03 1.7808911E-01 -1.4466155E+00 1.9324210E+03))
                                                         (o2 n    (neutral-involved-interaction -1.1453028E-03 1.2654140E-02 -2.2435218E-01 7.7201588E+01 -1.0608832E-03 1.1782595E-02 -2.1246301E-01 8.4561598E+01))
                                                         (n  n    (neutral-involved-interaction -9.6083779E-03 2.0938971E-01 -1.7386904E+00 3.3587983E+03 -7.7439615E-03 1.7129007E-01 -1.4809088E+00 2.1284951E+03))
                                                         (n2 o    (neutral-involved-interaction -2.7244269E-03 6.9587171E-02 -7.9538667E-01 4.0673730E+02 -8.3110691E-03 1.9617877E-01 -1.7205427E+00 4.0812829E+03))
                                                         (o2 o    (neutral-involved-interaction -4.8405803E-03 1.0297688E-01 -9.6876576E-01 6.1629812E+02 -3.7969686E-03 7.6789981E-02 -7.3056809E-01 3.3958171E+02))
                                                         (n  o    (neutral-involved-interaction -7.8147689E-03 1.6792705E-01 -1.4308628E+00 1.6628859E+03 -5.0478143E-03 1.0236186E-01 -9.0058935E-01 4.4472565E+02))
                                                         (o  o    (neutral-involved-interaction -6.4040535E-03 1.4629949E-01 -1.3892121E+00 2.0903441E+03 -4.2451096E-03 9.6820337E-02 -9.9770795E-01 8.3320644E+02))
                                                         (n2 no   (neutral-involved-interaction -1.9295666E-03 2.7995735E-02 -3.1588514E-01 1.2880734E+02 -6.8237776E-03 1.4360616E-01 -1.1922240E+00 1.2433086E+03))
                                                         (o2 no   (neutral-involved-interaction -6.4433840E-04 8.5378580E-03 -2.3225102E-01 1.1371608E+02 -6.8508672E-03 1.5524564E-01 -1.3479583E+00 2.0037890E+03))
                                                         (no n    (neutral-involved-interaction -1.5770918E-03 1.9578381E-02 -2.7873624E-01 9.9547944E+01 -1.4719259E-03 1.8446968E-02 -2.6460411E-01 1.0911124E+02))
                                                         (no o    (neutral-involved-interaction -1.0885815E-03 1.1883688E-02 -2.1844909E-01 7.5512560E+01 -1.0066279E-03 1.1029264E-02 -2.0671266E-01 8.2644384E+01))
                                                         (no no   (neutral-involved-interaction 0.0000000E+00 -1.1056066E-02 -5.9216250E-02 7.2542367E+01 -7.4942466E-03 1.6626193E-01 -1.4107027E+00 2.3097604E+03))
                                                         (n2 no+  (neutral-involved-interaction  0.0000000E+00 9.1205839E-02 -1.8728231E+00 2.4432020E+05  0.0000000E+00 8.5112236E-02 -1.7460044E+00 1.4498969E+05))
                                                         (o2 no+  (neutral-involved-interaction -3.7822765E-03 1.7967016E-01 -2.5409098E+00 1.1840435E+06  0.0000000E+00 8.4737359E-02 -1.7290488E+00 1.2485194E+05))
                                                         (n  no+  (neutral-involved-interaction -1.9605234E-02 5.5570872E-01 -5.4285702E+00 1.3574446E+09 -2.1009546E-02 5.8910426E-01 -5.6681361E+00 2.4486594E+09))
                                                         (o  no+  (neutral-involved-interaction -1.6409054E-02 4.6352852E-01 -4.5479735E+00 7.4250671E+07 -1.5315132E-02 4.3541627E-01 -4.2864279E+00 3.5125207E+07))
                                                         (no no+  (neutral-involved-interaction -8.1158474E-03 2.1474280E-01 -2.0148450E+00 6.2986385E+04  1.1055777E-02 -1.6621846E-01 1.4372166E-01 1.3182061E+03))
                                                         (e  n2   (neutral-involved-interaction -1.0525124E-02 1.3498950E-01 1.2524805E-01 1.5066506E-01  -4.2254948E-03 -5.2965163E-02 1.9157708E+00 6.3263309E-04))
                                                         (e  o2   (neutral-involved-interaction 2.3527001E-02 -6.9632323E-01 6.8035475E+00 1.8335509E-09   9.6744867E-03 -3.3759583E-01 3.7952121E+00 6.8468036E-06))
                                                         (e  n    (neutral-involved-interaction 0.0000000E+00 1.6554247E-01 -3.4986344E+00 5.9268038E+08  -1.0903638E-01 2.8678381E+00 -2.5297550E+01 3.4838798E+33))
                                                         (e  o    (neutral-involved-interaction 9.9865506E-03 -2.7407431E-01 2.6561032E+00 4.3080676E-04  -1.7924100E-02 4.0402656E-01 -2.6712374E+00 4.1447669E+02))
                                                         (e  no   (neutral-involved-interaction 1.0414818E-01 -2.8369126E+00 2.5323135E+01 7.7138358E-32   0.0000000E+00 5.4444485E-02 -1.2854128E+00 1.3857556E+04))
                                                         (n2 n+   (neutral-involved-interaction -1.0687805E-02 2.4479697E-01 -2.3192863E+00 1.0689229E+05 -7.0776069E-03 1.7917938E-01 -1.9102410E+00 4.6736263E+04))
                                                         (o2 n+   (neutral-involved-interaction 0.0000000E+00 8.7745537E-02 -1.8347158E+00 1.9830120E+05   9.8019578E-03 -1.4699425E-01 3.9382460E-02 1.5112165E+03))
                                                         (n  n+   (neutral-involved-interaction -4.0078980E-03 1.0327487E-01 -9.9473323E-01 2.8178290E+03 -1.4271306E-02 3.0401993E-01 -2.4573879E+00 5.3694705E+04))
                                                         (o  n+   (neutral-involved-interaction -1.5767256E-02 3.5405830E-01 -3.0686783E+00 4.6336779E+05 -1.7907392E-02 4.1207892E-01 -3.5343610E+00 1.4987678E+06))
                                                         (no n+   (neutral-involved-interaction 0.0000000E+00 8.6531037E-02 -1.8117931E+00 1.8621272E+05   1.1716366E-02 -1.9289789E-01 4.0269474E-01 6.0891590E+02))
                                                         (n2 o+   (neutral-involved-interaction 1.0352091E-02 -1.5733723E-01 2.9326150E-02 2.1003616E+03   1.8733000E-02 -3.6163781E-01 1.6947101E+00 2.5244859E+01))
                                                         (o2 o+   (neutral-involved-interaction 0.0000000E+00 9.3559978E-02 -1.9842999E+00 4.3097490E+05   1.4207970E-02 -2.4736726E-01 7.4561859E-01 3.2519188E+02))
                                                         (n  o+   (neutral-involved-interaction -2.4288224E-02 5.6305072E-01 -4.6849679E+00 2.7303024E+07 -2.1681211E-02 5.2300453E-01 -4.5118623E+00 2.3467766E+07))
                                                         (o  o+   (neutral-involved-interaction -3.8347988E-03 9.9930498E-02 -9.6288891E-01 1.9669897E+03 -1.6032919E-02 3.7114396E-01 -3.2050078E+00 5.8099314E+05))
                                                         (no o+   (neutral-involved-interaction 8.3856973E-03 -1.0972656E-01 -3.3896281E-01 5.2004690E+03  1.8015337E-02 -3.4415293E-01 1.5658151E+00 3.3303758E+01))
                                                         (n2 n2+  (neutral-involved-interaction -2.9123716E-03 9.6850678E-02 -1.1416540E+00 7.9252169E+03 -1.6447237E-02 4.7759522E-01 -4.7641986E+00 2.9127542E+08))
                                                         (o2 n2+  (neutral-involved-interaction -4.0893007E-03 1.7795266E-01 -2.3800543E+00 5.1949298E+05 -4.9176811E-03 1.9694738E-01 -2.5025540E+00 6.8213629E+05))
                                                         (n  n2+  (neutral-involved-interaction -1.4501284E-02 4.1085338E-01 -4.0115094E+00 1.5735451E+07 -1.2882395E-02 3.7306469E-01 -3.7106760E+00 7.5444981E+06))
                                                         (o  n2+  (neutral-involved-interaction -1.6923472E-02 4.6067692E-01 -4.3294966E+00 2.5538927E+07 -1.7420606E-02 4.7126950E-01 -4.3841087E+00 2.8275095E+07))
                                                         (no n2+  (neutral-involved-interaction -9.2292933E-03 2.9813226E-01 -3.2899475E+00 4.9147046E+06 -4.0133981E-03 1.7290664E-01 -2.2855449E+00 3.6429320E+05))
                                                         (n2 o2+  (neutral-involved-interaction 1.2405624E-02 -2.0452111E-01 3.5478475E-01 1.0778357E+03   2.2455421E-02 -4.5106797E-01 2.3763420E+00 4.7754696E+00))
                                                         (o2 o2+  (neutral-involved-interaction -8.9520932E-03 2.2749642E-01 -2.0758341E+00 6.7674419E+04  2.8664463E-02 -5.8087240E-01 3.2564558E+00 6.6890428E-01))
                                                         (n  o2+  (neutral-involved-interaction 0.0000000E+00 8.3065769E-02 -1.7501512E+00 1.0846799E+05   1.1205000E-02 -1.8182149E-01 3.2624972E-01 5.5186183E+02))
                                                         (o  o2+  (neutral-involved-interaction -2.9417970E-03 1.5129273E-01 -2.2497964E+00 2.9325215E+05  0.0000000E+00 8.3446262E-02 -1.7191179E+00 8.0539928E+04))
                                                         (no o2+  (neutral-involved-interaction 1.3731123E-02 -2.3920299E-01 6.7093226E-01 4.0068731E+02   2.2679271E-02 -4.5710920E-01 2.4427275E+00 3.6733514E+00))
                                                         (n+ n+   (charged-particle-interaction #f)) (n+ o+   (charged-particle-interaction #f)) (n+ no+  (charged-particle-interaction #f))
                                                         (n+ n2+  (charged-particle-interaction #f)) (n+ o2+  (charged-particle-interaction #f)) (n+ e    (charged-particle-interaction #t))
                                                         (o+ o+   (charged-particle-interaction #f)) (o+ no+  (charged-particle-interaction #f)) (o+ n2+  (charged-particle-interaction #f))
                                                         (o+ o2+  (charged-particle-interaction #f)) (o+ e    (charged-particle-interaction #t)) (no+ no+ (charged-particle-interaction #f))
                                                         (no+ n2+ (charged-particle-interaction #f)) (no+ o2+ (charged-particle-interaction #f)) (no+ e   (charged-particle-interaction #t))
                                                         (n2+ n2+ (charged-particle-interaction #f)) (n2+ o2+ (charged-particle-interaction #f)) (n2+ e   (charged-particle-interaction #t))
                                                         (o2+ o2+ (charged-particle-interaction #f)) (o2+ e   (charged-particle-interaction #t)) (e   e   (charged-particle-interaction #f))
                                                         )
                           )
  )

 (mars-5species-mckenzie
  mixture
  (chemical-formula . #f)
  (species (names co o2 c o co2))
  (mass-diffusivity (constant-lewis-number 1.4) (unity-lewis-number . #f))
  (thermal-conductivity (ideal-gas-mixing-law . #f))
  (viscosity (ideal-gas-mixing-law . #f))
  (specific-heat (mixing-law . #f))
  (reactions (finite-rate ("reaction-1" ((co2 1 1 1)) ((co 1 0 1) (o 1 0 1)) () (stoichiometry "1co2 + 1M --> 1co + 1o + 1M") (arrhenius 1.2e+8 2.85518e+08 0.5) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #t) (control-temperature 0.7) (backward-reaction? . #t) ) 
                          ("reaction-2" ((co 1 1 1)) ((c 1 0 14.8) (o 1 0 14.8)) ((co 0 1.95)) (stoichiometry "1co + 1M --> 1c + 1o + 1M") (arrhenius 4.48e+16 1.071734e9 -1.0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #t) (control-temperature 0.7) (backward-reaction? . #t) )
                          ("reaction-3" ((o2 1 1 1)) ((o 2 0 5)) ((c 0 5)) (stoichiometry "1o2 + 1M --> 2o + 1M") (arrhenius 9.05e+15 4.93629e+08 -1.0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #t) (control-temperature 0.7) (backward-reaction? . #t) )
                          ("reaction-4" ((co2 1 1 1) (o 1 1 1)) ((o2 1 0 1) (co 1 0 1) ) ((o2 0 1)) (stoichiometry "1co2 + 1o --> 1o2 + 1co") (arrhenius 2.54e+8 2.30227e+08 0.5) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t))
                          ("reaction-5" ((co 1 1 1) (o 1 1 1)) ((o2 1 0 1) (c 1 0 1) ) ((o2 0 1)) (stoichiometry "1co + 1o --> 1o2 + 1c") (arrhenius 2.73e+9 5.781876e+08 0.5) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t))
                          ("reaction-6" ((co 1 1 1) (co 1 1 1)) ((co2 1 0 1) (c 1 0 1) ) ((o2 0 1)) (stoichiometry "1co + 1co --> 1co2 + 1c") (arrhenius 2.33e+6 5.46343e+08 0.5) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (control-temperature 1.0) (backward-reaction? . #t) ))))

(mars-8species-park
  mixture 
  (chemical-formula . #f) 
  (species (names (co o2 c o co2 no n n2) () ())) 
  (mass-diffusivity (constant-lewis-number 1.4) (unity-lewis-number . #f))
  (reactions (finite-rate ("reaction-1" ((co2 1. 1. 1.)) ((co 1. 0. 1.) (o 1. 0. 2.029)) ((o2 0 1.) (c 0 2.029) (no 0 1.) (n 0 2.029) (n2 0 1.)) (stoichiometry 1co2 --> 1co + 1o) (arrhenius 6.9e+18 526097583.05 -1.5) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) ) 
                          ("reaction-2" ((co 1. 1. 1.)) ((c 1. 0. 1.478) (o 1. 0. 1.478)) ((o2 0 1.) (co2 0 1.) (no 0 1.) (n 0 1.478) (n2 0 1.)) (stoichiometry 1co --> 1c + 1o) (arrhenius 2.3e+17 1072565598. -1.) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-3" ((o2 1. 1. 1)) ((o 2. 0. 5)) ((co 0 1) (c 0 5) (co2 0 1) (no 0 1) (n 0 5) (n2 0 1)) (stoichiometry 1o2 --> 2o) (arrhenius 2.0e18 496789110.475 -1.5) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-4" ((co2 1. 1. 1) (o 1. 1. 1)) ((o2 1. 0. 1) (co 1. 0. 1)) ((c 0 1) (no 0 1) (n 0 1) (n2 0 1)) (stoichiometry 1co2 + 1o --> 1o2 + 1co) (arrhenius 21000000000. 231142043.6 0.) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-5" ((co 1. 1. 1) (o 1. 1. 1)) ((o2 1. 0. 1) (c 1. 0. 1)) ((co2 0 1) (no 0 1) (n 0 1) (n2 0 1)) (stoichiometry 1co + 1o --> 1o2 + 1c) (arrhenius 39000000000. 575360770.4 -0.18) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-6" ((no 1. 1. 1) (o 1. 1. 1)) ((o2 1. 0. 1) (n 1. 0. 1)) ((co 1. 1) (c 0. 1) (co2 0. 1) (n2 0 1)) (stoichiometry 1no + 1o --> 1o2 + 1n) (arrhenius 8400000000. 161716285.9 0.) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-7" ((n2 1. 1. 1.)) ((n 2. 0. 4.286)) ((co 0 1.) (o2 0 1.) (c 0 4.286) (o 0 4.286) (co2 0 1.) (no 0 1.)) (stoichiometry 1n2 --> 2n) (arrhenius 7e+18 941197098.4 -1.6) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-8" ((n2 1. 1. 1.) (o 1. 1. 5.)) ((no 1. 0. 1.) (n 1. 0. 5.)) ((co 0 1.) (o2 1. 1.) (c 0 5.) (co2 0 1.)) (stoichiometry 1n2 + 1o --> 1no + 1n) (arrhenius 640000000000000. 319025900. -1.) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-9" ((no 1. 1. 1.)) ((n 1. 0. 1.) (o 1. 0. 1.)) ((co 0 0.0455) (o2 0 0.0455) (c 0 1.) (co2 0 1.) (n2 0 0.0455)) (stoichiometry 1no --> 1n + 1o) (arrhenius 110000000000000. 627741881. 0.) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )))
  (density (ideal-gas . #f))
  (specific-heat (mixing-law . #f))
  (thermal-conductivity (ideal-gas-mixing-law . #f))
  (viscosity (ideal-gas-mixing-law . #f))
  (speed-of-sound (none . #f))
  )

(mars-venus-16species-johnston
  mixture
  (chemical-formula . #f)
  (species (names (co n2 o2 no c n o cn c2 c+ o+ no+ o2+ co+ e co2) () ())) 
  (mass-diffusivity (constant-lewis-number 1.4) (unity-lewis-number . #f))
  (reactions (finite-rate 
                          ("reaction-1" ((co2 1. 1. 1.)) ((co 1. 0. 1.) (o 1. 0. 2.029)) ((o2 0 1.) (c 0 2.029) (no 0 1.) (n 0 2.029) ) (stoichiometry 1co2 --> 1co + 1o) (arrhenius 6.9e+18 526097583.05 -1.5) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-2" ((co 1. 1. 1.)) ((c 1. 0. 1.5) (o 1. 0. 1.5)) ((o2 0 1.) (no 0 1.) (n 0 1.5) (n2 0 1.)) (stoichiometry 1co --> 1c + 1o) (arrhenius 1.2e+18 1072565677.74 -1.) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )

                          ("reaction-3" ((c2 1. 1. 1.)) ((c 2. 0. 1.)) ((n2 0 1.)) (stoichiometry 1c2 --> 2c) (arrhenius 4.5e+15 594484077.198 -1) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-4" ((cn 1. 1. 1)) ((c 1. 0. 1) (n 1. 0. 1)) ((n2 0 1)) (stoichiometry 1cn --> 1c + 1n) (arrhenius 6.0e12 590326845.889 -0.4) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-5" ((n2 1. 1. 1.)) ((n 2. 0. 4.286)) ((co 0 1.) (o2 0 1.) (c 0 4.286) (o 0 4.286) (co2 0 1.) (e 0 0)) (stoichiometry 1n2 --> 2n) (arrhenius 7e+18 941197098.4 -1.6) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-5-e" ((n2 1. 1. 1.) (e 1. 1. 1.)) ((n 2. 0. 1.) (e 1. 1. 1.)) ((co2 0 1.)) (stoichiometry 1n2 + 1e --> 2n + 1e) (arrhenius 6e+0 941197098.4 2.6) (control-temperature 0.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-6" ((no 1. 1. 22.)) ((n 1. 0. 22.) (o 1. 0. 22.)) ((c 0 22) (co2 0 22)) (stoichiometry 1no --> 1n + 1o) (arrhenius 2.0e12 627741881. 0.) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-7" ((o2 1. 1. 1)) ((o 2. 0. 5)) ((co 0 1) (c 0 5) (co2 0 1) (no 0 1) (n 0 5) (n2 0 1)) (stoichiometry 1o2 --> 2o) (arrhenius 2.0e18 493546499.936 -1.5) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-8" ((co2 1. 1. 1) (o 1. 1. 1)) ((o2 1. 0. 1) (co 1. 0. 1)) ((n2 0 1)) (stoichiometry 1co2 + 1o --> 1o2 + 1co) (arrhenius 2.71e11 281028835.88 0.) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-9" ((co 1. 1. 1) (c 1. 1. 1)) ((c2 1. 0. 1) (o 1. 0. 1)) ((n2 0 1)) (stoichiometry 1co + 1c --> 1c2 + 1o) (arrhenius 2.4e14 482238830.8 -1.) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-10" ((co 1. 1. 1) (n 1. 1. 1)) ((cn 1. 0. 1) (o 1. 0. 1)) ((n2 0 1)) (stoichiometry 1co + 1n --> 1cn + 1o) (arrhenius 1.0e12 320938256.36 0.) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-11" ((co 1. 1. 1) (no 1. 1. 1)) ((co2 1. 0. 1) (n 1. 0. 1)) ((n2 0 1)) (stoichiometry 1co + 1no --> 1co2 + 1n) (arrhenius 3.0e3 110582352.58 0.88) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-12" ((co 1. 1. 1) (o 1. 1. 1)) ((o2 1. 0. 1) (c 1. 0. 1)) ((n2 0 1)) (stoichiometry 1co + 1o --> 1o2 + 1c) (arrhenius 3.9e10 575360770.4 -0.18) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-13" ((c2 1. 1. 1) (n2 1. 1. 1)) ((cn 1. 0. 1) (cn 1. 0. 1)) ((n2 0 1)) (stoichiometry 1c2 + 1n2 --> 1cn + 1cn) (arrhenius 1.5e10 174603714.6 -0.) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-14" ((cn 1. 1. 1) (c 1. 1. 1)) ((c2 1. 0. 1) (n 1. 0. 1)) ((n2 0 1)) (stoichiometry 1cn + 1c --> 1c2 + 1n) (arrhenius 3.0e11 150491773.06 0.0) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-15" ((cn 1. 1. 1) (o 1. 1. 1)) ((no 1. 0. 1) (c 1. 0. 1)) ((n2 0 1)) (stoichiometry 1cn + 1o --> 1no + 1c) (arrhenius 1.6e9 121391153.96 0.1) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-16" ((n 1. 1. 1) (co 1. 1. 1)) ((no 1. 0. 1) (c 1. 0. 1)) ((n2 0 1)) (stoichiometry 1n + 1co --> 1no + 1c) (arrhenius 1.1e11 444823749.1 0.07) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-17" ((n2 1. 1. 1) (c 1. 1. 1)) ((cn 1. 0. 1) (n 1. 0. 1)) ((n2 0 1)) (stoichiometry 1n2 + 1c --> 1cn + 1n) (arrhenius 1.1e11 192895532.32 -0.11) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-18" ((n2 1. 1. 1) (co 1. 1. 1)) ((cn 1. 0. 1) (no 1. 0. 1)) ((n2 0 1)) (stoichiometry 1n2 + 1co --> 1cn + 1no) (arrhenius 1.2e13 640213620.2 -1.23) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-19" ((n2 1. 1. 1) (o 1. 1. 1)) ((no 1. 0. 1) (n 1. 0. 1)) ((n2 0 1)) (stoichiometry 1n2 + 1o --> 1no + 1n) (arrhenius 6.0e10 315949578.8 0.1) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-20" ((o2 1. 1. 1) (n 1. 1. 1)) ((no 1. 0. 1) (o 1. 0. 1)) ((n2 0 1)) (stoichiometry 1o2 + 1n --> 1no + 1o) (arrhenius 2.49e6 33340995.026 1.18) (control-temperature 1.) (backward-reaction? . #t) )
                          ("reaction-21" ((c 1 1 1) (o 1 1 1)) ((co+ 1 0 1) (e 1 0 1) ) ((n2 0 1)) (stoichiometry "1c + 1o --> 1co+ + 1e") (arrhenius 8.8e+5 275208712.06 1.) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-22" ((c 1 1 1) (e 1 1 1)) ((c+ 1 0 1) (e 1 0 1) (e 1 0 1)) ((n2 0 1)) (stoichiometry "1c + 1e --> 1c+ + 1e + 1e") (arrhenius 3.9e+30 1086700261.82 -3.78) (control-temperature 0.0) (backward-reaction? . #t) )
                          ("reaction-23" ((c+ 1 1 1) (co 1 1 1)) ((co+ 1 0 1) (c 1 0 1) ) ((n2 0 1)) (stoichiometry "1c+ + 1co --> 1co+ + 1c") (arrhenius 1.0e+10 261074125.64 0.0) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-24" ((co 1 1 1) (e 1 1 1)) ((co+ 1 0 1) (e 1 0 1) (e 1 0 1)) ((n2 0 1)) (stoichiometry "1co + 1e --> 1co+ + 1e + 1e") (arrhenius 4.5e+11 1355257403.8 0.275) (control-temperature 0.0) (backward-reaction? . #t) )
                          ("reaction-25" ((n 1 1 1) (o 1 1 1)) ((no+ 1 0 1) (e 1 0 1) ) ((n2 0 1)) (stoichiometry "1n + 1o --> 1no+ + 1e") (arrhenius 5.3e+9 265231357.519 0.0) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-26" ((no+ 1 1 1) (c 1 1 1)) ((c+ 1 0 1) (no 1 0 1) ) ((n2 0 1)) (stoichiometry "1no+ + 1c --> 1c+ + 1no") (arrhenius 1.0e+10 192895532.32 0.) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-27" ((no+ 1 1 1) (n 1 1 1)) ((o+ 1 0 1) (n2 1 0 1) ) ((n2 0 1)) (stoichiometry "1no+ + 1n --> 1o+ + 1n2") (arrhenius 3.4e+10 106425121.28 -1.08) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-28" ((no+ 1 1 1) (o 1 1 1)) ((o2+ 1 0 1) (n 1 0 1) ) ((n2 0 1)) (stoichiometry "1no+ + 1o --> 1o2+ + 1n") (arrhenius 7.2e+9 404082882.36 0.29) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-29" ((no+ 1 1 1) (o2 1 1 1)) ((no 1 0 1) (o2+ 1 0 1) ) ((n2 0 1)) (stoichiometry "1no+ + 1o2 --> 1no + 1o2+") (arrhenius 2.4e+10 271051480.76 0.41) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-30" ((o 1 1 1) (o 1 1 1)) ((o2+ 1 0 1) (e 1 0 1) ) ((n2 0 1)) (stoichiometry "1o + 1o --> 1o2+ + 1e") (arrhenius 7.1e-1 670145687.023 2.7) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-31" ((o 1 1 1) (e 1 1 1)) ((o+ 1 0 1) (e 1 0 1) (e 1 0 1)) ((n2 0 1)) (stoichiometry "1o + 1e --> 1o+ + 1e + 1e") (arrhenius 3.9e+30 1317842324.98 -3.78) (control-temperature 0.0) (backward-reaction? . #t) )
                          ("reaction-32" ((o2 1 1 1) (c+ 1 1 1)) ((o2+ 1 0 1) (c 1 0 1) ) ((n2 0 1)) (stoichiometry "1o2 + 1c+ --> 1o2+ + 1c") (arrhenius 1.0e+10 78155948.44 0.0) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-33" ((o2+ 1 1 1) (o 1 1 1)) ((o+ 1 0 1) (o2 1 0 1) ) ((n2 0 1)) (stoichiometry "1o2+ + 1o --> 1o+ + 1o2") (arrhenius 4.0e+9 149660326.8 -0.09) (control-temperature 1.0) (backward-reaction? . #t) )
                          ("reaction-34" ((o2 1 1 1) (e 1 1 1)) ((o2+ 1 0 1) (e 1 0 1) (e 1 0 1)) ((n2 0 1)) (stoichiometry "1o2 + 1e --> 1o2+ + 1e + 1e") (arrhenius 2.19e+7 1080880138 1.16) (control-temperature 0.0) (backward-reaction? . #t) )))
  (density (ideal-gas . #f))
  (specific-heat (mixing-law . #f))
  (thermal-conductivity (ideal-gas-mixing-law . #f))
  (viscosity (ideal-gas-mixing-law . #f))
  (speed-of-sound (none . #f))
  )



(air-11species-gupta mixture
		(chemical-formula . #f)
		(species (names (o2 o n no no+ o+ n+ o2+ n2+ e n2) () ()))
		(reactions (finite-rate ("reaction-1" ((o2 1. 1. 9)) ((o 2. 2. 25)) ((n 0 1) (no 0 1) (no+ 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (e 0 0) (n2 0 2)) (stoichiometry 1o2 --> 2o) (arrhenius 3610000000000000. 493852000. -1.) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0) (control-temperature 0.7)) ("reaction-2" ((n2 1. 1. 2.5)) ((n 2. 2. 0)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (e 0 0)) (stoichiometry 1n2 --> 2n) (arrhenius 1.92e14 940367000. -0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0) (control-temperature 0.7)) ("reaction-3" ((n2 1. 1. 1) (n 1. 1. 1)) ((n 2. 2. 1) (n 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1n --> 2n + 1n) (arrhenius 4.15e+19 1.0892e9 -1.5) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-4" ((no 1. 1. 20)) ((n 1. 0. 20) (o 1. 0. 20)) ((o2 0 1) (no+ 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (e 0 0) (n2 0 1)) (stoichiometry 1no --> 1n + 1o) (arrhenius 3.97e+17 628574000. -1.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0) (control-temperature 0.7)) ("reaction-5" ((no 1. 1. 1) (o 1. 1. 1)) ((o2 1. 0. 1) (n 1. 0. 1)) ((no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1no + 1o --> 1o2 + 1n) (arrhenius 3180000. 163795000. 1.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-6" ((n2 1. 1. 1) (o 1. 1. 1)) ((no 1. 0. 1) (n 1. 0. 1)) ((o2 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1o --> 1no + 1n) (arrhenius 67500000000. 311793000. 0.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-7" ((n 1. 1. 1) (o 1. 1. 1)) ((no+ 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (no 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1n + 1o --> 1no+ + 1e) (arrhenius 9030000. 269389000. 0.5) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-8" ((o 1. 1. 1) (e 1. 1. 1)) ((o+ 1. 0. 1) (e 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (n 0 1) (no 0 1) (no+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1o + 1e --> 1o+ + 1e + 1e) (arrhenius 3.6e+28 1313690000. -2.91) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0) (control-temperature 0.0)) ("reaction-9" ((n 1. 1. 1) (e 1. 1. 1)) ((n+ 1. 0. 1) (e 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (o2+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1n + 1e --> 1n+ + 1e + 1e) (arrhenius 1.1e+29 1405140000. -3.14) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0) (control-temperature 0.0)) ("reaction-10" ((o 1. 1. 1) (o 1. 1. 1)) ((o2+ 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (n 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1o + 1o --> 1o2+ + 1e) (arrhenius 160000000000000. 671809000. -0.98) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-11" ((o 1. 1. 1) (o2+ 1. 1. 1)) ((o+ 1. 0. 1) (o2 1. 0. 1)) ((n 0 1) (no 0 1) (no+ 0 1) (n+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o + 1o2+ --> 1o+ + 1o2) (arrhenius 2920000000000000. 232805000. -1.11) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-12" ((n2 1. 1. 1) (n+ 1. 1. 1)) ((n2+ 1. 0. 1) (n 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (o2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1n+ --> 1n2+ + 1n) (arrhenius 202000000. 108088000. 0.8100000000000001) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-13" ((n 1. 1. 1) (n 1. 1. 1)) ((n2+ 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2 0 1)) (stoichiometry 1n + 1n --> 1n2+ + 1e) (arrhenius 14000000000. 563721000. 0.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-14" ((o2 1. 1. 1) (n2 1. 1. 1)) ((no 1. 0. 1) (no+ 1. 0. 1) (e 1. 0. 1)) ((o 0 1) (n 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1)) (stoichiometry 1o2 + 1n2 --> 1no + 1no+ + 1e) (arrhenius 1.38e+17 1172340000. -1.84) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-15" ((no 1. 1. 0)) ((no+ 1. 0. 0) (e 1. 0. 0)) ((o2 0 4) (o 0 0) (n 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (n2 0 1)) (stoichiometry 1no --> 1no+ + 1e) (arrhenius 2200000000000. 897963000. -0.35) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-16" ((o 1. 1. 1) (no+ 1. 1. 1)) ((o+ 1. 0. 1) (no 1. 0. 1)) ((o2 0 1) (n 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o + 1no+ --> 1o+ + 1no) (arrhenius 3630000000000. 422375000. -0.6) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-17" ((n2 1. 1. 1) (o+ 1. 1. 1)) ((n2+ 1. 0. 1) (o 1. 0. 1)) ((o2 0 1) (n 0 1) (no 0 1) (no+ 0 1) (n+ 0 1) (o2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1o+ --> 1n2+ + 1o) (arrhenius 3.4e+16 1.9123e8 -2.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-18" ((n 1. 1. 1) (no+ 1. 1. 1)) ((n+ 1. 0. 1) (no 1. 0. 1)) ((o2 0 1) (o 0 1) (o+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1n + 1no+ --> 1n+ + 1no) (arrhenius 1e+16 507183000. -0.93) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-19" ((o2 1. 1. 1) (no+ 1. 1. 1)) ((o2+ 1. 0. 1) (no 1. 0. 1)) ((o 0 1) (n 0 1) (o+ 0 1) (n+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o2 + 1no+ --> 1o2+ + 1no) (arrhenius 1800000000000. 274378000. 0.17) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-20" ((o 1. 1. 1) (no+ 1. 1. 1)) ((n+ 1. 0. 1) (o2 1. 0. 1)) ((n 0 1) (no 1 1) (o+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o + 1no+ --> 1n+ + 1o2) (arrhenius 13400000000. 642459000. 0.31) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0))) (eddy-dissipation ("reaction-1" ((o2 1. 1. 9)) ((o 2. 2. 25)) ((n 0 1) (no 0 1) (no+ 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (e 0 0) (n2 0 2)) (stoichiometry 1o2 --> 2o) (arrhenius 3610000000000000. 493852000. -1.) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-2" ((n2 1. 1. 2.5)) ((n 2. 2. 0)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (e 0 0)) (stoichiometry 1n2 --> 2n) (arrhenius 192000000000. 940367000. -0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-3" ((n2 1. 1. 1) (n 1. 1. 1)) ((n 2. 2. 1) (n 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1n --> 2n + 1n) (arrhenius 4.15e+19 940367000. -1.5) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-4" ((no 1. 1. 20)) ((n 1. 0. 20) (o 1. 0. 20)) ((o2 0 1) (no+ 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (e 0 0) (n2 0 1)) (stoichiometry 1no --> 1n + 1o) (arrhenius 3.97e+17 628574000. -1.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-5" ((no 1. 1. 1) (o 1. 1. 1)) ((o2 1. 0. 1) (n 1. 0. 1)) ((no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1no + 1o --> 1o2 + 1n) (arrhenius 3180000. 163795000. 1.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-6" ((n2 1. 1. 1) (o 1. 1. 1)) ((no 1. 0. 1) (n 1. 0. 1)) ((o2 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1o --> 1no + 1n) (arrhenius 67500000000. 311793000. 0.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-7" ((n 1. 1. 1) (o 1. 1. 1)) ((no+ 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (no 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1n + 1o --> 1no+ + 1e) (arrhenius 9030000. 269389000. 0.5) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-8" ((o 1. 1. 1) (e 1. 1. 1)) ((o+ 1. 0. 1) (e 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (n 0 1) (no 0 1) (no+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1o + 1e --> 1o+ + 1e + 1e) (arrhenius 3.6e+28 1313690000. -2.91) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-9" ((n 1. 1. 1) (e 1. 1. 1)) ((n+ 1. 0. 1) (e 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (o2+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1n + 1e --> 1n+ + 1e + 1e) (arrhenius 1.1e+29 1405140000. -3.14) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-10" ((o 1. 1. 1) (o 1. 1. 1)) ((o2+ 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (n 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1o + 1o --> 1o2+ + 1e) (arrhenius 160000000000000. 671809000. -0.98) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-11" ((o 1. 1. 1) (o2+ 1. 1. 1)) ((o+ 1. 0. 1) (o2 1. 0. 1)) ((n 0 1) (no 0 1) (no+ 0 1) (n+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o + 1o2+ --> 1o+ + 1o2) (arrhenius 2920000000000000. 232805000. -1.11) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-12" ((n2 1. 1. 1) (n+ 1. 1. 1)) ((n2+ 1. 0. 1) (n 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (o2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1n+ --> 1n2+ + 1n) (arrhenius 202000000. 108088000. 0.8100000000000001) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-13" ((n 1. 1. 1) (n 1. 1. 1)) ((n2+ 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2 0 1)) (stoichiometry 1n + 1n --> 1n2+ + 1e) (arrhenius 14000000000. 563721000. 0.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-14" ((o2 1. 1. 1) (n2 1. 1. 1)) ((no 1. 0. 1) (no+ 1. 0. 1) (e 1. 0. 1)) ((o 0 1) (n 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1)) (stoichiometry 1o2 + 1n2 --> 1no + 1no+ + 1e) (arrhenius 1.38e+17 1172340000. -1.84) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-15" ((no 1. 1. 0)) ((no+ 1. 0. 0) (e 1. 0. 0)) ((o2 0 4) (o 0 0) (n 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (n2 0 1)) (stoichiometry 1no --> 1no+ + 1e) (arrhenius 2200000000000. 897963000. -0.35) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-16" ((o 1. 1. 1) (no+ 1. 1. 1)) ((o+ 1. 0. 1) (no 1. 0. 1)) ((o2 0 1) (n 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o + 1no+ --> 1o+ + 1no) (arrhenius 3630000000000. 422375000. -0.6) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-17" ((n2 1. 1. 1) (o+ 1. 1. 1)) ((n2+ 1. 0. 1) (o 1. 0. 1)) ((o2 0 1) (n 0 1) (no 0 1) (no+ 0 1) (n+ 0 1) (o2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1o+ --> 1n2+ + 1o) (arrhenius 3.4e+16 199547000. -2.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-18" ((n 1. 1. 1) (no+ 1. 1. 1)) ((n+ 1. 0. 1) (no 1. 0. 1)) ((o2 0 1) (o 0 1) (o+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1n + 1no+ --> 1n+ + 1no) (arrhenius 1e+16 507183000. -0.93) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-19" ((o2 1. 1. 1) (no+ 1. 1. 1)) ((o2+ 1. 0. 1) (no 1. 0. 1)) ((o 0 1) (n 0 1) (o+ 0 1) (n+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o2 + 1no+ --> 1o2+ + 1no) (arrhenius 1800000000000. 274378000. 0.17) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-20" ((o 1. 1. 1) (no+ 1. 1. 1)) ((n+ 1. 0. 1) (o2 1. 0. 1)) ((n 0 1) (no 1 1) (o+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o + 1no+ --> 1n+ + 1o2) (arrhenius 13400000000. 642459000. 0.31) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0))) (finite-rate/eddy-dissipation ("reaction-1" ((o2 1. 1. 9)) ((o 2. 2. 25)) ((n 0 1) (no 0 1) (no+ 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (e 0 0) (n2 0 2)) (stoichiometry 1o2 --> 2o) (arrhenius 3610000000000000. 493852000. -1.) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-2" ((n2 1. 1. 2.5)) ((n 2. 2. 0)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (e 0 0)) (stoichiometry 1n2 --> 2n) (arrhenius 192000000000. 940367000. -0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-3" ((n2 1. 1. 1) (n 1. 1. 1)) ((n 2. 2. 1) (n 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1n --> 2n + 1n) (arrhenius 4.15e+19 940367000. -1.5) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-4" ((no 1. 1. 20)) ((n 1. 0. 20) (o 1. 0. 20)) ((o2 0 1) (no+ 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (e 0 0) (n2 0 1)) (stoichiometry 1no --> 1n + 1o) (arrhenius 3.97e+17 628574000. -1.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-5" ((no 1. 1. 1) (o 1. 1. 1)) ((o2 1. 0. 1) (n 1. 0. 1)) ((no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1no + 1o --> 1o2 + 1n) (arrhenius 3180000. 163795000. 1.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-6" ((n2 1. 1. 1) (o 1. 1. 1)) ((no 1. 0. 1) (n 1. 0. 1)) ((o2 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1o --> 1no + 1n) (arrhenius 67500000000. 311793000. 0.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-7" ((n 1. 1. 1) (o 1. 1. 1)) ((no+ 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (no 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1n + 1o --> 1no+ + 1e) (arrhenius 9030000. 269389000. 0.5) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-8" ((o 1. 1. 1) (e 1. 1. 1)) ((o+ 1. 0. 1) (e 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (n 0 1) (no 0 1) (no+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1o + 1e --> 1o+ + 1e + 1e) (arrhenius 3.6e+28 1313690000. -2.91) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-9" ((n 1. 1. 1) (e 1. 1. 1)) ((n+ 1. 0. 1) (e 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (o2+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1n + 1e --> 1n+ + 1e + 1e) (arrhenius 1.1e+29 1405140000. -3.14) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-10" ((o 1. 1. 1) (o 1. 1. 1)) ((o2+ 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (n 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (n2+ 0 1) (n2 0 1)) (stoichiometry 1o + 1o --> 1o2+ + 1e) (arrhenius 160000000000000. 671809000. -0.98) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-11" ((o 1. 1. 1) (o2+ 1. 1. 1)) ((o+ 1. 0. 1) (o2 1. 0. 1)) ((n 0 1) (no 0 1) (no+ 0 1) (n+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o + 1o2+ --> 1o+ + 1o2) (arrhenius 2920000000000000. 232805000. -1.11) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-12" ((n2 1. 1. 1) (n+ 1. 1. 1)) ((n2+ 1. 0. 1) (n 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (o2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1n+ --> 1n2+ + 1n) (arrhenius 202000000. 108088000. 0.8100000000000001) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-13" ((n 1. 1. 1) (n 1. 1. 1)) ((n2+ 1. 0. 1) (e 1. 0. 1)) ((o2 0 1) (o 0 1) (no 0 1) (no+ 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2 0 1)) (stoichiometry 1n + 1n --> 1n2+ + 1e) (arrhenius 14000000000. 563721000. 0.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-14" ((o2 1. 1. 1) (n2 1. 1. 1)) ((no 1. 0. 1) (no+ 1. 0. 1) (e 1. 0. 1)) ((o 0 1) (n 0 1) (o+ 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1)) (stoichiometry 1o2 + 1n2 --> 1no + 1no+ + 1e) (arrhenius 1.38e+17 1172340000. -1.84) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-15" ((no 1. 1. 0)) ((no+ 1. 0. 0) (e 1. 0. 0)) ((o2 0 4) (o 0 0) (n 0 0) (o+ 0 0) (n+ 0 0) (o2+ 0 0) (n2+ 0 0) (n2 0 1)) (stoichiometry 1no --> 1no+ + 1e) (arrhenius 2200000000000. 897963000. -0.35) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-16" ((o 1. 1. 1) (no+ 1. 1. 1)) ((o+ 1. 0. 1) (no 1. 0. 1)) ((o2 0 1) (n 0 1) (n+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o + 1no+ --> 1o+ + 1no) (arrhenius 3630000000000. 422375000. -0.6) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-17" ((n2 1. 1. 1) (o+ 1. 1. 1)) ((n2+ 1. 0. 1) (o 1. 0. 1)) ((o2 0 1) (n 0 1) (no 0 1) (no+ 0 1) (n+ 0 1) (o2+ 0 1) (e 0 1)) (stoichiometry 1n2 + 1o+ --> 1n2+ + 1o) (arrhenius 3.4e+16 199547000. -2.) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-18" ((n 1. 1. 1) (no+ 1. 1. 1)) ((n+ 1. 0. 1) (no 1. 0. 1)) ((o2 0 1) (o 0 1) (o+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1n + 1no+ --> 1n+ + 1no) (arrhenius 1e+16 507183000. -0.93) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-19" ((o2 1. 1. 1) (no+ 1. 1. 1)) ((o2+ 1. 0. 1) (no 1. 0. 1)) ((o 0 1) (n 0 1) (o+ 0 1) (n+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o2 + 1no+ --> 1o2+ + 1no) (arrhenius 1800000000000. 274378000. 0.17) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0)) ("reaction-20" ((o 1. 1. 1) (no+ 1. 1. 1)) ((n+ 1. 0. 1) (o2 1. 0. 1)) ((n 0 1) (no 1 1) (o+ 0 1) (o2+ 0 1) (n2+ 0 1) (e 0 1) (n2 0 1)) (stoichiometry 1o + 1no+ --> 1n+ + 1o2) (arrhenius 13400000000. 642459000. 0.31) (backward-reaction? . #t) (rev-params #f 1000000000000000. 100000000. 0))))
		(reaction-mechs (reaction-mechs ("mechanism-1" (reaction-type . volumetric) (reaction-list "reaction-20" "reaction-19" "reaction-18" "reaction-17" "reaction-16" "reaction-15" "reaction-14" "reaction-13" "reaction-12" "reaction-11" "reaction-10" "reaction-9" "reaction-8" "reaction-7" "reaction-6" "reaction-5" "reaction-4" "reaction-3" "reaction-2" "reaction-1") (site-info))))
  (collision-cross-section (cross-section-multicomponent (n2 n2   (neutral-involved-interaction -6.0614558E-03 1.2689102E-01 -1.0616948E+00 8.0955466E+02 -7.6303990E-03 1.6878089E-01 -1.4004234E+00 2.1427708E+03))
                                                         (n2 o2   (neutral-involved-interaction -3.7959091E-03 9.5708295E-02 -1.0070611E+00 8.9392313E+02 -8.0457321E-03 1.9228905E-01 -1.7102854E+00 5.2213857E+03))
                                                         (o2 o2   (neutral-involved-interaction -8.0682650E-04 1.6602480E-02 -3.1472774E-01 1.4116458E+02 -6.2931612E-03 1.4624645E-01 -1.3006927E+00 1.8066892E+03))
                                                         (n2 n    (neutral-involved-interaction -1.0796249E-02 2.2656509E-01 -1.7910602E+00 4.0455218E+03 -8.3493693E-03 1.7808911E-01 -1.4466155E+00 1.9324210E+03))
                                                         (o2 n    (neutral-involved-interaction -1.1453028E-03 1.2654140E-02 -2.2435218E-01 7.7201588E+01 -1.0608832E-03 1.1782595E-02 -2.1246301E-01 8.4561598E+01))
                                                         (n  n    (neutral-involved-interaction -9.6083779E-03 2.0938971E-01 -1.7386904E+00 3.3587983E+03 -7.7439615E-03 1.7129007E-01 -1.4809088E+00 2.1284951E+03))
                                                         (n2 o    (neutral-involved-interaction -2.7244269E-03 6.9587171E-02 -7.9538667E-01 4.0673730E+02 -8.3110691E-03 1.9617877E-01 -1.7205427E+00 4.0812829E+03))
                                                         (o2 o    (neutral-involved-interaction -4.8405803E-03 1.0297688E-01 -9.6876576E-01 6.1629812E+02 -3.7969686E-03 7.6789981E-02 -7.3056809E-01 3.3958171E+02))
                                                         (n  o    (neutral-involved-interaction -7.8147689E-03 1.6792705E-01 -1.4308628E+00 1.6628859E+03 -5.0478143E-03 1.0236186E-01 -9.0058935E-01 4.4472565E+02))
                                                         (o  o    (neutral-involved-interaction -6.4040535E-03 1.4629949E-01 -1.3892121E+00 2.0903441E+03 -4.2451096E-03 9.6820337E-02 -9.9770795E-01 8.3320644E+02))
                                                         (n2 no   (neutral-involved-interaction -1.9295666E-03 2.7995735E-02 -3.1588514E-01 1.2880734E+02 -6.8237776E-03 1.4360616E-01 -1.1922240E+00 1.2433086E+03))
                                                         (o2 no   (neutral-involved-interaction -6.4433840E-04 8.5378580E-03 -2.3225102E-01 1.1371608E+02 -6.8508672E-03 1.5524564E-01 -1.3479583E+00 2.0037890E+03))
                                                         (no n    (neutral-involved-interaction -1.5770918E-03 1.9578381E-02 -2.7873624E-01 9.9547944E+01 -1.4719259E-03 1.8446968E-02 -2.6460411E-01 1.0911124E+02))
                                                         (no o    (neutral-involved-interaction -1.0885815E-03 1.1883688E-02 -2.1844909E-01 7.5512560E+01 -1.0066279E-03 1.1029264E-02 -2.0671266E-01 8.2644384E+01))
                                                         (no no   (neutral-involved-interaction 0.0000000E+00 -1.1056066E-02 -5.9216250E-02 7.2542367E+01 -7.4942466E-03 1.6626193E-01 -1.4107027E+00 2.3097604E+03))
                                                         (n2 no+  (neutral-involved-interaction  0.0000000E+00 9.1205839E-02 -1.8728231E+00 2.4432020E+05  0.0000000E+00 8.5112236E-02 -1.7460044E+00 1.4498969E+05))
                                                         (o2 no+  (neutral-involved-interaction -3.7822765E-03 1.7967016E-01 -2.5409098E+00 1.1840435E+06  0.0000000E+00 8.4737359E-02 -1.7290488E+00 1.2485194E+05))
                                                         (n  no+  (neutral-involved-interaction -1.9605234E-02 5.5570872E-01 -5.4285702E+00 1.3574446E+09 -2.1009546E-02 5.8910426E-01 -5.6681361E+00 2.4486594E+09))
                                                         (o  no+  (neutral-involved-interaction -1.6409054E-02 4.6352852E-01 -4.5479735E+00 7.4250671E+07 -1.5315132E-02 4.3541627E-01 -4.2864279E+00 3.5125207E+07))
                                                         (no no+  (neutral-involved-interaction -8.1158474E-03 2.1474280E-01 -2.0148450E+00 6.2986385E+04  1.1055777E-02 -1.6621846E-01 1.4372166E-01 1.3182061E+03))
                                                         (e  n2   (neutral-involved-interaction -1.0525124E-02 1.3498950E-01 1.2524805E-01 1.5066506E-01  -4.2254948E-03 -5.2965163E-02 1.9157708E+00 6.3263309E-04))
                                                         (e  o2   (neutral-involved-interaction 2.3527001E-02 -6.9632323E-01 6.8035475E+00 1.8335509E-09   9.6744867E-03 -3.3759583E-01 3.7952121E+00 6.8468036E-06))
                                                         (e  n    (neutral-involved-interaction 0.0000000E+00 1.6554247E-01 -3.4986344E+00 5.9268038E+08  -1.0903638E-01 2.8678381E+00 -2.5297550E+01 3.4838798E+33))
                                                         (e  o    (neutral-involved-interaction 9.9865506E-03 -2.7407431E-01 2.6561032E+00 4.3080676E-04  -1.7924100E-02 4.0402656E-01 -2.6712374E+00 4.1447669E+02))
                                                         (e  no   (neutral-involved-interaction 1.0414818E-01 -2.8369126E+00 2.5323135E+01 7.7138358E-32   0.0000000E+00 5.4444485E-02 -1.2854128E+00 1.3857556E+04))
                                                         (n2 n+   (neutral-involved-interaction -1.0687805E-02 2.4479697E-01 -2.3192863E+00 1.0689229E+05 -7.0776069E-03 1.7917938E-01 -1.9102410E+00 4.6736263E+04))
                                                         (o2 n+   (neutral-involved-interaction 0.0000000E+00 8.7745537E-02 -1.8347158E+00 1.9830120E+05   9.8019578E-03 -1.4699425E-01 3.9382460E-02 1.5112165E+03))
                                                         (n  n+   (neutral-involved-interaction -4.0078980E-03 1.0327487E-01 -9.9473323E-01 2.8178290E+03 -1.4271306E-02 3.0401993E-01 -2.4573879E+00 5.3694705E+04))
                                                         (o  n+   (neutral-involved-interaction -1.5767256E-02 3.5405830E-01 -3.0686783E+00 4.6336779E+05 -1.7907392E-02 4.1207892E-01 -3.5343610E+00 1.4987678E+06))
                                                         (no n+   (neutral-involved-interaction 0.0000000E+00 8.6531037E-02 -1.8117931E+00 1.8621272E+05   1.1716366E-02 -1.9289789E-01 4.0269474E-01 6.0891590E+02))
                                                         (n2 o+   (neutral-involved-interaction 1.0352091E-02 -1.5733723E-01 2.9326150E-02 2.1003616E+03   1.8733000E-02 -3.6163781E-01 1.6947101E+00 2.5244859E+01))
                                                         (o2 o+   (neutral-involved-interaction 0.0000000E+00 9.3559978E-02 -1.9842999E+00 4.3097490E+05   1.4207970E-02 -2.4736726E-01 7.4561859E-01 3.2519188E+02))
                                                         (n  o+   (neutral-involved-interaction -2.4288224E-02 5.6305072E-01 -4.6849679E+00 2.7303024E+07 -2.1681211E-02 5.2300453E-01 -4.5118623E+00 2.3467766E+07))
                                                         (o  o+   (neutral-involved-interaction -3.8347988E-03 9.9930498E-02 -9.6288891E-01 1.9669897E+03 -1.6032919E-02 3.7114396E-01 -3.2050078E+00 5.8099314E+05))
                                                         (no o+   (neutral-involved-interaction 8.3856973E-03 -1.0972656E-01 -3.3896281E-01 5.2004690E+03  1.8015337E-02 -3.4415293E-01 1.5658151E+00 3.3303758E+01))
                                                         (n2 n2+  (neutral-involved-interaction -2.9123716E-03 9.6850678E-02 -1.1416540E+00 7.9252169E+03 -1.6447237E-02 4.7759522E-01 -4.7641986E+00 2.9127542E+08))
                                                         (o2 n2+  (neutral-involved-interaction -4.0893007E-03 1.7795266E-01 -2.3800543E+00 5.1949298E+05 -4.9176811E-03 1.9694738E-01 -2.5025540E+00 6.8213629E+05))
                                                         (n  n2+  (neutral-involved-interaction -1.4501284E-02 4.1085338E-01 -4.0115094E+00 1.5735451E+07 -1.2882395E-02 3.7306469E-01 -3.7106760E+00 7.5444981E+06))
                                                         (o  n2+  (neutral-involved-interaction -1.6923472E-02 4.6067692E-01 -4.3294966E+00 2.5538927E+07 -1.7420606E-02 4.7126950E-01 -4.3841087E+00 2.8275095E+07))
                                                         (no n2+  (neutral-involved-interaction -9.2292933E-03 2.9813226E-01 -3.2899475E+00 4.9147046E+06 -4.0133981E-03 1.7290664E-01 -2.2855449E+00 3.6429320E+05))
                                                         (n2 o2+  (neutral-involved-interaction 1.2405624E-02 -2.0452111E-01 3.5478475E-01 1.0778357E+03   2.2455421E-02 -4.5106797E-01 2.3763420E+00 4.7754696E+00))
                                                         (o2 o2+  (neutral-involved-interaction -8.9520932E-03 2.2749642E-01 -2.0758341E+00 6.7674419E+04  2.8664463E-02 -5.8087240E-01 3.2564558E+00 6.6890428E-01))
                                                         (n  o2+  (neutral-involved-interaction 0.0000000E+00 8.3065769E-02 -1.7501512E+00 1.0846799E+05   1.1205000E-02 -1.8182149E-01 3.2624972E-01 5.5186183E+02))
                                                         (o  o2+  (neutral-involved-interaction -2.9417970E-03 1.5129273E-01 -2.2497964E+00 2.9325215E+05  0.0000000E+00 8.3446262E-02 -1.7191179E+00 8.0539928E+04))
                                                         (no o2+  (neutral-involved-interaction 1.3731123E-02 -2.3920299E-01 6.7093226E-01 4.0068731E+02   2.2679271E-02 -4.5710920E-01 2.4427275E+00 3.6733514E+00))
                                                         (n+ n+   (charged-particle-interaction #f)) (n+ o+   (charged-particle-interaction #f)) (n+ no+  (charged-particle-interaction #f))
                                                         (n+ n2+  (charged-particle-interaction #f)) (n+ o2+  (charged-particle-interaction #f)) (n+ e    (charged-particle-interaction #t))
                                                         (o+ o+   (charged-particle-interaction #f)) (o+ no+  (charged-particle-interaction #f)) (o+ n2+  (charged-particle-interaction #f))
                                                         (o+ o2+  (charged-particle-interaction #f)) (o+ e    (charged-particle-interaction #t)) (no+ no+ (charged-particle-interaction #f))
                                                         (no+ n2+ (charged-particle-interaction #f)) (no+ o2+ (charged-particle-interaction #f)) (no+ e   (charged-particle-interaction #t))
                                                         (n2+ n2+ (charged-particle-interaction #f)) (n2+ o2+ (charged-particle-interaction #f)) (n2+ e   (charged-particle-interaction #t))
                                                         (o2+ o2+ (charged-particle-interaction #f)) (o2+ e   (charged-particle-interaction #t)) (e   e   (charged-particle-interaction #f))
                                                         )
                           )
		(density (ideal-gas . #f))
		(specific-heat (mixing-law . #f))
		(thermal-conductivity (ideal-gas-mixing-law . #f) )
		(viscosity (ideal-gas-mixing-law . #f))
    (mass-diffusivity (constant-lewis-number 1.4) (unity-lewis-number . #f))
		(speed-of-sound (none . #f))
	)

 (particle-mixture-template
 (particle-mixture)
 (species (names h2o<l>))
 )

 (acetone
  fluid
  (chemical-formula . c3h6o)
  (density (constant . 791) (compressible-liquid 101325 791 9.2e+08 7 1.1 0.9))
  (specific-heat (constant . 2160) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -3.282372e+07 6.436055e+05 -4.210460e+03 1.736672e+01 -2.061565e-02 1.317350e-05 -3.459102e-09) (1000.000000 6000.000000 6.856813e+08 -3.016170e+06 5.661367e+03 -5.598731e-01 1.048690e-04 -1.053204e-08 4.381425e-13) ))
  (thermal-conductivity (constant . 0.18))
  (viscosity (constant . 0.000331))
  (molecular-weight (constant . 58.0498))
; Critical Properties from Polling et al.
  (critical-pressure (constant . 4.7000e6))
  (critical-temperature (constant . 508.10))
  (acentric-factor (constant . 0.307))
  (critical-volume (constant . 0.00360))
  )
 
 (acetylene
  fluid
  (chemical-formula . c2h2)
  (density (constant . 1.07))
  (specific-heat (polynomial piecewise-polynomial (300 1000 642.95584 4.8505018 -0.0051611109 2.8990371e-06 -6.1076403e-10) (1000 5000 1416.7169 1.7166374 -0.0006107864 1.0493824e-07 -6.8866451e-12)) (constant . 2167))
  (thermal-conductivity (constant . 0.0213))
  (viscosity (constant . 1e-05))
  (molecular-weight (constant . 26.04))
  (formation-enthalpy (constant . 2.2675098e+08))
  (reference-temperature (constant . 298.15))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 200892.91))
; Critical Properties from Polling et al.
  (critical-pressure (constant . 6.1140e6))
  (critical-temperature (constant . 308.30))
  (acentric-factor (constant . 0.189))
  (critical-volume (constant . 0.00431))
  )
 
 (acetylene-air
  mixture
  (chemical-formula . #f)
  (species (names c2h2 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c2h2 1 0.5 1) (o2 2.5 1.25 1)) ((co2 2 0 1) (h2o 1 0 1)) ((n2 0 1)) (stoichiometry "1c2h2 + 2.5o2 --> 2co2 + 1h2o") (arrhenius 3.655e+10 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c2h2 1 0.5 1) (o2 2.5 1.25 1)) ((co2 2 0 1) (h2o 1 0 1)) ((n2 0 1)) (stoichiometry "1c2h2 + 2.5o2 --> 2co2 + 1h2o") (arrhenius 3.655e+10 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c2h2 1 0.5 1) (o2 2.5 1.25 1)) ((co2 2 0 1) (h2o 1 0 1)) ((n2 0 1)) (stoichiometry "1c2h2 + 2.5o2 --> 2co2 + 1h2o") (arrhenius 3.655e+10 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (air
  fluid
  (chemical-formula . #f)
  (density (constant . 1.225) (compressible-liquid 101325 1.225 1.42e+05 1 1.1 0.9))
  ;; Cp piecewise-polynomal 2nd range coeffs corrected as proposed by Didier Bessette <Didier.Bessette@ansys.com>
  (specific-heat (constant . 1006.43)(polynomial piecewise-polynomial (100 1000 1161.48214452351 -2.36881890191577 1.48551108358867E-02 -5.03490927522584E-05 9.9285695564579E-08 -1.11109658897742E-10 6.54019600406048E-14 -1.57358768447275E-17)(1000 5000 7.85024454E+02 6.03014607E-01 -3.39650998E-04 1.11252948E-07 -2.08714889E-11 2.07846313E-15 -8.48686346E-20)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.898903e+06 -5.649626e+04 1.437799e+03 -1.653609e+00 3.062254e-03 -2.279138e-06 6.272365e-10) (1000.000000 6000.000000 6.932494e+07 -3.610532e+05 1.476665e+03 -6.138349e-02 2.027963e-05 -3.075525e-09 1.888054e-13 )) )
  (thermal-conductivity (constant . 0.0242))
  (viscosity (constant . 1.7894e-05) (sutherland 1.716e-5 273.11 110.56) (power-law 1.716e-05 273.11 0.666) (blottner-curve-fit 3.07e-2 2.30e-1 -1.08e1)) 
      ; viscosity of air at 273 K obtained from Kays & Crawford 
      ; (Convective Heat & Mass Transfer) & also from White's book on 
      ; turbulent flow
      ; 1.7894e-5 Pa.s is the value at 293 K
  (molecular-weight (constant . 28.966))
  (characteristic-vibrational-temperature (constant . 2686))
  (lennard-jones-length (constant . 3.711))
  (lennard-jones-energy (constant . 78.6))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 194336))
  (reference-temperature (constant . 298.15))
  ; Critical Properties Perry's Chemical Enginners Handbook.  
  (critical-pressure (constant . 3.758e6))
  (critical-temperature (constant . 132.3))
  (acentric-factor (constant . 0.033))
  (critical-volume (constant . 0.002857)) 
  (electric-conductivity (constant . 1.0e-09))
  (dual-electric-conductivity (constant . 1.0e-09))
  )

 (aluminum-trihydride-dimer 
  fluid
  (chemical-formula . al2h6)
  (specific-heat (polynomial piecewise-polynomial (300 600 -942.2163 7.0392357 0.0014405419 -1.5511509e-05 1.1719934e-08) (600 1500 365.0562 2.9593048 4.3699923e-05 -1.0646912e-06 3.2362317e-10)))
  (molecular-weight (constant . 60.01082))
  (formation-enthalpy (constant . 89337816))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2625938E+06))
   )

 (trimethyl-aluminum-dimer 
  fluid
  (chemical-formula . al2me6)
  (specific-heat (polynomial piecewise-polynomial (300 600 -41.289591 6.1539137 0.0012212019 -1.2648037e-05 9.4816199e-09) (600 1500 1022.5569 2.846398 6.9021395e-05 -9.4567206e-07 2.820516e-10)))
  (molecular-weight (constant . 144.17337))
  (formation-enthalpy (constant . -2.5606264e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.5484102E+06))
  )

 (aluminum-arsenide 
  fluid
  (chemical-formula . alas)
  (specific-heat (polynomial piecewise-polynomial (300 600 411.85033 -0.052380765 -0.00011684363 3.8791378e-07 -2.6905504e-10) (600 1500 390.82135 -0.0015569332 -1.6182607e-05 1.8271067e-08 -5.6335947e-12)))
  (molecular-weight (constant . 101.9031))
  (formation-enthalpy (constant . 4.4906877e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2537865E+06))
  )

 (aluminum-hydride
  fluid
  (chemical-formula . alh)
  (specific-heat (polynomial piecewise-polynomial (300 1000 912.39735 0.64328155 -0.00097303615 1.2289008e-06 -5.5760302e-10) (1000 5000 1007.7931 0.36103721 -0.00013891938 2.5818678e-08 -1.7890481e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.116671e+07 1.511724e+05 3.351062e+02 1.184860e+00 -6.389075e-05 -6.466311e-07 3.032376e-10) (1000.000000 6000.000000 2.020588e+09 -6.471142e+06 9.008889e+03 -4.465789e+00 1.334423e-03 -1.835352e-07 9.253938e-12) ))
  (molecular-weight (constant . 27.98947))
  (formation-enthalpy (constant . 2.5941387e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1877431E+06))
  )

 (aluminum-dihydride
  fluid
  (chemical-formula . alh2)
  (specific-heat (polynomial piecewise-polynomial (300 600 700.22558 2.843157 7.0852517e-05 -6.0774104e-06 4.9036944e-09) (600 1500 1286.4117 0.89711936 -5.6469044e-05 -2.9132302e-07 1.0028174e-10)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 4.172468e+06 -6.175534e+04 1.475053e+03 -1.136954e+00 3.844783e-03 -3.488790e-06 1.073267e-09) (1000.000000 6000.000000 4.108606e+07 -6.783802e+05 2.605147e+03 -3.751986e-01 1.369771e-04 -2.100228e-08 1.146324e-12) ))
  (molecular-weight (constant . 28.99744))
  (formation-enthalpy (constant . 1.7552802e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2276383E+06))
  )

 (aluminum-trihydride 
  fluid
  (chemical-formula . alh3)
  (specific-heat (polynomial piecewise-polynomial (300 600 279.40097 4.545252 0.00054774582 -9.7774469e-06 7.6294615e-09) (600 1500 1160.1503 1.7066952 -1.0744604e-05 -5.7134928e-07 1.8289014e-10)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 4.104421e+06 -7.859917e+03 6.948541e+02 2.027239e+00 6.461316e-04 -1.770447e-06 6.808019e-10) (1000.000000 6000.000000 1.630858e+08 -1.273490e+06 3.660190e+03 -3.399594e-01 7.278245e-05 -8.157052e-09 3.716398e-13) ))
  (molecular-weight (constant . 30.00541))
  (formation-enthalpy (constant . 78769208))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2188533E+06))
  )

 (methyl-aluminum 
  fluid
  (chemical-formula . alme)
  (specific-heat (polynomial piecewise-polynomial (300 600 527.19364 2.6217724 0.00049982078 -4.7380891e-06 3.4863997e-09) (600 1500 922.67374 1.4045575 4.9866634e-05 -4.1849424e-07 1.206586e-10)))
  (molecular-weight (constant . 42.01656))
  (formation-enthalpy (constant . 82639008))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2538958E+06))
  )

 (dimethyl-aluminum 
  fluid
  (chemical-formula . alme2)
  (specific-heat (polynomial piecewise-polynomial (300 600 138.36786 4.6727346 0.00089393305 -9.4727476e-06 7.1576858e-09) (600 1500 944.54081 2.1489954 8.4766391e-05 -6.7348567e-07 2.0345006e-10)))
  (molecular-weight (constant . 57.05162))
  (formation-enthalpy (constant . 53351560))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3238879E+06))
  )

 (trimethyl-aluminum 
  fluid
  (chemical-formula . alme3)
  (specific-heat (polynomial piecewise-polynomial (300 600 -81.05461 5.4010102 0.0013262758 -1.0565477e-05 7.7129956e-09) (600 1500 767.56897 2.831716 0.00013570385 -9.013698e-07 2.601591e-10)))
  (molecular-weight (constant . 72.08669))
  (formation-enthalpy (constant . -84935040))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3501493E+06))
  )

 (aluminum
  (solid)
  (chemical-formula . al)
  (density (constant . 2719))
  (specific-heat (constant . 871) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.542807e+06 5.735686e+03 7.434314e+02 6.124886e-02 -7.495425e-05 4.740278e-08 -1.215476e-11) (1000.000000 6000.000000 -9.000630e+06 3.598476e+04 7.262905e+02 2.384260e-02 -4.713080e-06 -3.072811e-10 1.557189e-13) (6000.000000 20000.000000 -1.553307e+11 1.171701e+08 -3.335298e+04 4.774677e+00 -3.297569e-04 1.106924e-08 -1.447104e-13) ))
  (atomic-number (constant . 13))
  (thermal-conductivity (constant . 202.4))
  (formation-entropy (constant . 164448.08))
  (electric-conductivity (constant . 3.541e+07))
  (dual-electric-conductivity (constant . 2.3677))
  (magnetic-permeability (constant . 1.257e-06))
  (struct-youngs-modulus (constant . 7.e+10))
  (struct-poisson-ratio (constant . 0.32))
  )

 (ammelide-vapor
 fluid
 (chemical-formula . ammd_c3h4n4o2)
 (density (constant . 2)); not known
 (molecular-weight (constant .  128.0895));nist
 (specific-heat (constant . 537)) ; not known yet
 (thermal-conductivity (constant . 0.0104)) ;not known yet
 (viscosity (constant . 1.2e-05)) ; not known yet
 (formation-enthalpy (constant . -389.0e+06)) ;computed as the difference of the ammelide<s> formation enthalpy and ammelide<s> latent-heat
 (formation-entropy (constant . 149.2E+03)); same a ammelide<s>
 (reference-temperature (constant . 298.15))
 )

 (ammonia-liquid
  fluid
  (chemical-formula . nh3<l>)
  (density (constant . 610) (compressible-liquid 101325 610 2.1e+09 7 1.1 0.9))
  (specific-heat (constant . 4758))
  (thermal-conductivity (constant . 0.493))
  (viscosity (constant . 0.000152))
; Critical Properties from Polling et al.
  (critical-pressure (constant . 11.3530e6))
  (critical-temperature (constant . 405.40))
  (acentric-factor (constant . 0.257))
  (critical-volume (constant . 0.00426))
  )
 
 (ammonia-vapor
  fluid
  (chemical-formula . nh3)
  (density (constant . 0.6894))
  (specific-heat (polynomial piecewise-polynomial (300 1000 1076.164 4.9380262 -0.0071534199 7.0653986e-06 -2.601377e-09) (1000 5000 1201.9011 2.9580837 -0.00097882914 1.5309961e-07 -9.4628597e-12)) (constant . 2158) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -3.750044e+07 6.204900e+05 -1.900709e+03 1.047691e+01 -1.066135e-02 6.431595e-06 -1.626870e-09) (1000.000000 6000.000000 1.197279e+09 -3.925637e+06 6.206826e+03 -1.943163e-01 1.734364e-05 1.235620e-09 -1.622172e-13) ))
  (thermal-conductivity (constant . 0.0247))
  (viscosity (constant . 1.015e-05))
  (molecular-weight (constant . 17.03061))
  (absorption-coefficient (constant . 0.5) (polynomial piecewise-linear (550 . 3.14) (890 . 1.93) (1220 . 0.95) (1550 . 0.5)))
  (formation-enthalpy (constant . -45915740))
  (reference-temperature (constant . 298.15))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 192612.34))
  ; Critical Properties from Polling et al.
  (critical-pressure (constant . 11.3530e6))
  (critical-temperature (constant . 405.40))
  (acentric-factor (constant . 0.257))
  (critical-volume (constant . 0.00426))
  )
 
 (anthracite
  (combusting-particle inert-particle)
  (chemical-formula . #f)
  (density (constant . 1550))
  (specific-heat (constant . 1680))
  (latent-heat (constant . 11000000))
  (vaporization-temperature (constant . 400))
  (thermal-conductivity (constant . 0.33))
  (boiling-point (constant . 400))
  (binary-diffusivity (constant . 4e-05))
  (volatile-fraction (constant . 0.069))
  (combustible-fraction (constant . 0.851))
  (swelling-coefficient (constant . 1))
  (emissivity (constant . 0.9))
  (scattering-factor (constant . 0.9))
  (burn-stoichiometry (constant . 2.67))
  (burn-hreact (constant . 32789000))
  (burn-hreact-fraction (constant . 0.3))
  (devolatilization-model (constant . 50) (single-rate 18000000 1.17e+08) (two-competing-rates 200000 1.046e+08 0.3 13000000 1.674e+08 1)(cpd-model 1 0 5 400 50))
  (combustion-model (diffusion-limited . #f) (kinetics/diffusion-limited 5e-12 0.002 79000000) (intrinsic-model 5e-12 0.030198 1.794e+08 0.5 6e-08 300000 1.4142136 0) (cbk -1.0 10.0))
  )
 
 (anthracite-volatiles
  fluid
  (chemical-formula . an_vol)
  (specific-heat (constant . 1500))
  (molecular-weight (constant . 13.21))
  (formation-enthalpy (constant . -57700000))
  (reference-temperature (constant . 298.15))
  ; Critical Properties estimated by assuming that anthracite volatiles comprise a mixture of CO2, H2 and CH4.
  (critical-pressure (constant . 1.427E+06))
  (critical-temperature (constant . 38.94))
  (acentric-factor (constant . -0.207))
  (critical-volume (constant . 0.031188))
  )
 
 (anthracite-volatiles-air
  mixture
  (chemical-formula . #f)
  (species (names an_vol o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((an_vol 1 0.2 1) (o2 2.207 1.3 1)) ((co2 0.1 0 1) (h2o 4.408 0 1)) ((n2 0 1)) (stoichiometry "1an_vol + 2.207o2 --> 0.1co2 + 4.408h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((an_vol 1 0.2 1) (o2 2.207 1.3 1)) ((co2 0.1 0 1) (h2o 4.408 0 1)) ((n2 0 1)) (stoichiometry "1an_vol + 2.207o2 --> 0.1co2 + 4.408h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((an_vol 1 0.2 1) (o2 2.207 1.3 1)) ((co2 0.1 0 1) (h2o 4.408 0 1)) ((n2 0 1)) (stoichiometry "1an_vol + 2.207o2 --> 0.1co2 + 4.408h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )

 (argon+ 
  fluid
  (chemical-formula . ar+)
  (specific-heat (polynomial piecewise-polynomial (300 1000 478.98249 0.16724497 -3.6606343e-05 -3.7070228e-08 -1.8601306e-12) (1000 5000 596.26961 -0.025050198 -2.2170194e-06 1.8887635e-09 -2.0030356e-13)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 -1.192867e+07 1.650677e+05 -3.573934e+02 2.173315e+00 -2.456428e-03 1.358735e-06 -3.012879e-10) (1000.000000 6000.000000 -7.983996e+07 1.698804e+05 4.789905e+02 -1.030890e-03 2.508255e-06 -4.547860e-10 2.633939e-14) (6000.000000 20000.000000 2.117511e+09 -1.391406e+06 9.284817e+02 -6.315167e-02 5.460386e-06 -2.508271e-10 4.795034e-15) ))
  (viscosity (constant . 2.125e-05) (blottner-curve-fit 1.18e-2 4.96e-1 -1.15e1))
  (molecular-weight (constant . 39.94746))
  (formation-enthalpy (constant . 1.5268467e+09))
  (reference-temperature (constant . 298))
  (characteristic-vibrational-temperature (constant . 0))
  (lennard-jones-length (constant . 3.408)) ; Svehla 1963
  (lennard-jones-energy (constant . 119.9))
  (formation-entropy (constant .  0.1662933E+06))
  ;; critical properties assumed the same as argon
  (critical-pressure (constant . 4.8980e6))
  (critical-temperature (constant . 150.86))
  (acentric-factor (constant . -0.002))
  (critical-volume (constant . 0.00187))
  )

 (argon
  (fluid inert-particle)
  (chemical-formula . ar)
  (density (constant . 1.6228))
  (specific-heat (constant . 520.64) (polynomial piecewise-polynomial (300 1000 520.32264 0 0 0 0) (1000 5000 520.32264 0 0 0 0)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 0.000000e+00 0.000000e+00 5.203310e+02 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (1000.000000 6000.000000 4.184582e+03 -1.247267e+01 5.203454e+02 -8.308939e-06 2.508562e-09 -3.785960e-13 2.244867e-17) (6000.000000 20000.000000 -2.071181e+11 1.344304e+08 -3.488080e+04 4.828533e+00 -3.582127e-04 1.359508e-08 -2.027240e-13) ))
  (thermal-conductivity (constant . 0.0158))
  (viscosity (constant . 2.125e-05) (sutherland 2.125e-05 273.11 144.4) (power-law 2.125e-05 273.11 0.72) (blottner-curve-fit 1.18e-2 4.96e-1 -1.15e1))
  (molecular-weight (constant . 39.948))
  (formation-enthalpy (constant . -3117.7105))
  (reference-temperature (constant . 298.15))
  (characteristic-vibrational-temperature (constant . 0))
  (lennard-jones-length (constant . 3.408))  ; Svehla 1963
  (lennard-jones-energy (constant . 119.9))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 154719.34))
  ; Critical Properties from Polling et al.
  (critical-pressure (constant . 4.8980e6))
  (critical-temperature (constant . 150.86))
  (acentric-factor (constant . -0.002))
  (critical-volume (constant . 0.00187))
  )
  
  (argon-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . ar<l>)
    ;; all properties from http://webbook.nist.gov constant properties at NBP
  (density (constant . 1395))
  (specific-heat (constant . 1117.2)(polynomial piecewise-linear (87 . 1117) (90 . 1121) (100 . 1154) (110 . 1218) (120 . 1332) (130 . 1564) ))
  (thermal-conductivity (constant . 0.12565))
  (viscosity (constant . 0.00027073))
  (molecular-weight (constant . 39.948))
  (formation-enthalpy (constant . 0))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 154719.34))
  (latent-heat (constant . 161138))	
  (vaporization-temperature (constant . 83))
  (boiling-point (constant . 87.3))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (constant . 3.0e-05)) ; rough guess
  (vapor-pressure (polynomial piecewise-linear (85	. 78897) (90 . 133510) (95 . 213050) (100 . 323770) (110 . 665260) (120 . 1213000) (130 . 2025500) (140 . 3168200) (150.86 . 4.8980e6)) (constant . 78897) )
  )

  (aluminum-solid
  (fluid inert-particle droplet-particle)
  (chemical-formula . al<s>)
  (density (constant . 2719)) 
  (specific-heat (polynomial piecewise-polynomial (300 600 843.35167 -0.1821896 -0.00012430563 7.1562918e-07 -5.2557973e-10) (600 5000 788.73643 -0.032763207 2.2195489e-05 -6.5361777e-09 7.0548676e-13)))
  (molecular-weight (constant . 26.9815))
  (formation-enthalpy (constant . 3.2971232e+08))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  0.1644514E+06))
  (species-phase (constant . 1))
  (boiling-point (constant . 2792))
; Critical Properties Bhatt et al. (2006) - acentric factor missing   
  (critical-pressure (constant . 9.123E+07))
  (critical-temperature (constant . 6299.00))
  (critical-volume (constant . 0.001410)) 
  )
  
 (arsenic 
  fluid
  (chemical-formula . as)
  (specific-heat (polynomial piecewise-polynomial (300 600 290.41974 0 0 0 0) (600 1500 290.41974 0 0 0 0)))
  (molecular-weight (constant . 74.9216))
  (formation-enthalpy (constant . 3.1580237e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1821283E+06))
   ; Critical Properties from Somayajulu (1989)  acentric factor missing
  (critical-pressure (constant . 22.2950e6))
  (critical-temperature (constant . 1673.02))
  (critical-volume (constant . 0.000467))
  )
 
 (battery-venting-gas-mixture
  mixture
  (chemical-formula . #f)
  (density (ideal-gas . #f))
  (species (names h2 co2 co ch4 c2h4 c2h6 h2o o2 n2))
  (reactions (finite-rate/eddy-dissipation (reaction-1 ((ch4 1 0.7 1) (o2 1.5 0.8 1)) ((co 1 0 1) (h2o 2 0 1)) ((h2 0 1) (co2 0 1) (c2h4 0 1) (c2h6 0 1) (n2 0 1)) (stoichiometry 1ch4 + 1.5o2 --> 1co + 2h2o) (arrhenius 5.012e+11 2e+08 0) (mixing-rate 4 0.5)) (reaction-2 ((co 1 1 1) (o2 0.5 0.25 1)) ((co2 1 0 1)) ((h2 0 1) (ch4 0 1) (c2h4 0 1) (c2h6 0 1) (h2o 0 1) (n2 0 1)) (stoichiometry 1co + 0.5o2 --> 1co2) (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5)) (reaction-3 ((h2 1 1 1) (o2 0.5 0.5 1)) ((h2o 1 0 1)) ((co2 0 1) (co 0 1) (ch4 0 1) (c2h4 0 1) (c2h6 0 1) (n2 0 1)) (stoichiometry 1h2 + 0.5o2 --> 1h2o) (arrhenius 1e+11 83144600 0) (mixing-rate 4 0.5)) (reaction-4 ((c2h4 1 0.1 1) (o2 2 1.65 1)) ((co 2 0 1) (h2o 2 0 1)) ((h2 0 1) (co2 0 1) (ch4 0 1) (c2h6 0 1) (n2 0 1)) (stoichiometry 1c2h4 + 2o2 --> 2co + 2h2o) (arrhenius 1.125e+10 1.247e+08 0) (mixing-rate 4 0.5)) (reaction-5 ((c2h6 1 0.1 1) (o2 2.5 1.65 1)) ((co 2 0 1) (h2o 3 0 1)) ((h2 0 1) (co2 0 1) (ch4 0 1) (c2h4 0 1) (n2 0 1)) (stoichiometry 1c2h6 + 2.5o2 --> 2co + 3h2o) (arrhenius 6.18e+09 1.247e+08 0) (mixing-rate 4 0.5))) (eddy-dissipation (reaction-1 ((ch4 1 0.7 1) (o2 1.5 0.8 1)) ((co 1 0 1) (h2o 2 0 1)) ((h2 0 1) (co2 0 1) (c2h4 0 1) (c2h6 0 1) (n2 0 1)) (stoichiometry 1ch4 + 1.5o2 --> 1co + 2h2o) (arrhenius 5.012e+11 2e+08 0) (mixing-rate 4 0.5)) (reaction-2 ((co 1 1 1) (o2 0.5 0.25 1)) ((co2 1 0 1)) ((h2 0 1) (ch4 0 1) (c2h4 0 1) (c2h6 0 1) (h2o 0 1) (n2 0 1)) (stoichiometry 1co + 0.5o2 --> 1co2) (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5)) (reaction-3 ((h2 1 1 1) (o2 0.5 0.5 1)) ((h2o 1 0 1)) ((co2 0 1) (co 0 1) (ch4 0 1) (c2h4 0 1) (c2h6 0 1) (n2 0 1)) (stoichiometry 1h2 + 0.5o2 --> 1h2o) (arrhenius 1e+11 83144600 0) (mixing-rate 4 0.5)) (reaction-4 ((c2h4 1 0.1 1) (o2 2 1.65 1)) ((co 2 0 1) (h2o 2 0 1)) ((h2 0 1) (co2 0 1) (ch4 0 1) (c2h6 0 1) (n2 0 1)) (stoichiometry 1c2h4 + 2o2 --> 2co + 2h2o) (arrhenius 1.125e+10 1.247e+08 0) (mixing-rate 4 0.5)) (reaction-5 ((c2h6 1 0.1 1) (o2 2.5 1.65 1)) ((co 2 0 1) (h2o 3 0 1)) ((h2 0 1) (co2 0 1) (ch4 0 1) (c2h4 0 1) (n2 0 1)) (stoichiometry 1c2h6 + 2.5o2 --> 2co + 3h2o) (arrhenius 6.18e+09 1.247e+08 0) (mixing-rate 4 0.5))) (finite-rate (reaction-1 ((ch4 1 0.7 1) (o2 1.5 0.8 1)) ((co 1 0 1) (h2o 2 0 1)) ((h2 0 1) (co2 0 1) (c2h4 0 1) (c2h6 0 1) (n2 0 1)) (stoichiometry 1ch4 + 1.5o2 --> 1co + 2h2o) (arrhenius 5.012e+11 2e+08 0) (mixing-rate 4 0.5)) (reaction-2 ((co 1 1 1) (o2 0.5 0.25 1)) ((co2 1 0 1)) ((h2 0 1) (ch4 0 1) (c2h4 0 1) (c2h6 0 1) (h2o 0 1) (n2 0 1)) (stoichiometry 1co + 0.5o2 --> 1co2) (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5)) (reaction-3 ((h2 1 1 1) (o2 0.5 0.5 1)) ((h2o 1 0 1)) ((co2 0 1) (co 0 1) (ch4 0 1) (c2h4 0 1) (c2h6 0 1) (n2 0 1)) (stoichiometry 1h2 + 0.5o2 --> 1h2o) (arrhenius 1e+11 83144600 0) (mixing-rate 4 0.5)) (reaction-4 ((c2h4 1 0.1 1) (o2 2 1.65 1)) ((co 2 0 1) (h2o 2 0 1)) ((h2 0 1) (co2 0 1) (ch4 0 1) (c2h6 0 1) (n2 0 1)) (stoichiometry 1c2h4 + 2o2 --> 2co + 2h2o) (arrhenius 1.125e+10 1.247e+08 0) (mixing-rate 4 0.5)) (reaction-5 ((c2h6 1 0.1 1) (o2 2.5 1.65 1)) ((co 2 0 1) (h2o 3 0 1)) ((h2 0 1) (co2 0 1) (ch4 0 1) (c2h4 0 1) (n2 0 1)) (stoichiometry 1c2h6 + 2.5o2 --> 2co + 3h2o) (arrhenius 6.18e+09 1.247e+08 0) (mixing-rate 4 0.5))))
  )

 (diarsenic 
  fluid
  (chemical-formula . as2)
  (specific-heat (polynomial piecewise-polynomial (300 600 204.35233 0.17321972 -5.9595846e-05 -3.1236215e-07 2.8735635e-10) (600 1500 243.82074 0.029907282 -1.3202567e-05 -3.6299131e-09 2.8765459e-12)))
  (molecular-weight (constant . 149.8432))
  (formation-enthalpy (constant . 1.9697136e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2503362E+06))
  )
 
 (triarsenic 
  fluid
  (chemical-formula . as3)
  (specific-heat (polynomial piecewise-polynomial (300 600 236.86048 0.16561364 -6.9049498e-05 -2.7354135e-07 2.5941074e-10) (600 1500 273.88485 0.028921363 -1.4494286e-05 -1.9248895e-09 2.3274576e-12)))
  (molecular-weight (constant . 224.7648))
  (formation-enthalpy (constant . 2.7343773e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3244016E+06))
  )
 
 (tetraarsenic
  fluid
  (chemical-formula . as4)
  (specific-heat (polynomial piecewise-polynomial (300 600 217.89053 0.21963142 -6.4637288e-05 -4.2345184e-07 3.8214818e-10) (600 1500 268.99418 0.03624014 -1.5313185e-05 -5.9672674e-09 4.0448171e-12)))
  (molecular-weight (constant . 299.6864))
  (formation-enthalpy (constant . 1.553392e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3282738E+06))
  )

 (arsenic-methyl-aluminum 
  fluid
  (chemical-formula . asalme)
  (specific-heat (polynomial piecewise-polynomial (300 600 288.19964 1.2272803 0.00013036228 -2.4081334e-06 1.867791e-09) (600 1500 506.73955 0.52314634 1.6358732e-06 -1.5829759e-07 4.9252799e-11)))
  (molecular-weight (constant . 116.93816))
  (formation-enthalpy (constant . 2.9289552e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3414575E+06))
  )
 
 (arsenic-dimethyl-aluminum 
  fluid
  (chemical-formula . asalme2)
  (specific-heat (polynomial piecewise-polynomial (300 600 302.93837 1.9326491 0.00031802503 -3.7221144e-06 2.8112518e-09) (600 1500 624.32812 0.92222846 2.5948084e-05 -2.8001431e-07 8.3758834e-11)))
  (molecular-weight (constant . 131.97322))
  (formation-enthalpy (constant . 2.6465325e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3807956E+06))
  )

 (arsenic-hydride
  fluid
  (chemical-formula . ash)
  (specific-heat (polynomial piecewise-polynomial (300 600 423.31245 -0.12675481 -3.8263601e-05 7.7523046e-07 -6.5854005e-10) (600 1500 352.57554 0.10963753 -5.338155e-08 -1.2128879e-08 -1.0133545e-12)))
  (molecular-weight (constant . 75.92957))
  (formation-enthalpy (constant . 2.5837387e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2100583E+06))
  )

  (ash-solid
  (solid inert-particle)
  (chemical-formula . #f)
  (density (constant . 600))
  (specific-heat (constant . 795) (polynomial 852.2 0.343 -0.0018))
  (thermal-conductivity (constant . 0.071))
  (molecular-weight (constant . 76.94))
  (struct-youngs-modulus (constant . 1.e+08))
  (struct-poisson-ratio (constant . 0.2))
  )

 (arsenic-dihydride
  fluid
  (chemical-formula . ash2)
  (specific-heat (polynomial piecewise-polynomial (300 600 408.37586 0.19011345 8.7218056e-05 2.5490232e-07 -3.2890145e-10) (600 1500 370.48379 0.3437734 1.5782885e-05 -8.5773632e-08 1.8310861e-11)))
  (molecular-weight (constant . 76.93754))
  (formation-enthalpy (constant . 1.7678214e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1943672E+06))
  )
 
 (arsenic-trihydride 
  fluid
  (chemical-formula . ash3)
  (specific-heat (polynomial piecewise-polynomial (300 600 100.76298 1.6090626 0.00012818326 -3.6240291e-06 2.9522205e-09) (600 1500 445.02381 0.46628291 2.3227882e-05 -1.2621715e-07 4.8388863e-11)))
  (molecular-weight (constant . 77.94551))
  (formation-enthalpy (constant . 69563960))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2328712E+06))
   ; Critical Properties from Somayajulu (1989)  acentric factor missing
  (critical-pressure (constant . 16.9570e6))
  (critical-temperature (constant . 373.10))
  (critical-volume (constant . 0.001501))
  )
 
 (methyl-gallium-arsenide 
  fluid
  (chemical-formula . asgame)
  (specific-heat (polynomial piecewise-polynomial (300 600 253.9585 0.77196619 8.6025846e-05 -1.4121645e-06 1.0831544e-09) (600 1500 381.26497 0.3642535 5.5680941e-06 -1.0389409e-07 3.1452511e-11)))
  (molecular-weight (constant . 159.67667))
  (formation-enthalpy (constant . 3.4938176e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3588218E+06))
  )

 (dimethyl-gallium-arsenide 
  fluid
  (chemical-formula . asgame2)
  (specific-heat (polynomial piecewise-polynomial (300 600 208.53819 1.4544807 0.00026064763 -2.7763881e-06 2.081305e-09) (600 1500 445.07219 0.7161272 2.454624e-05 -2.1669694e-07 6.4186155e-11)))
  (molecular-weight (constant . 174.71173))
  (formation-enthalpy (constant . 3.399688e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3807953E+06))
  )
 
 (methyl-gallium-arsenide-hydride 
  fluid
  (chemical-formula . asgameh)
  (specific-heat (polynomial piecewise-polynomial (300 600 185.5056 1.2088856 0.00014867668 -2.4515388e-06 1.9012844e-09) (600 1500 405.8114 0.50098284 5.4863651e-06 -1.5478477e-07 4.8548968e-11)))
  (molecular-weight (constant . 160.68463))
  (formation-enthalpy (constant . 3.9227085e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3545363E+06))
  )

 (methyl-arsenic 
  fluid
  (chemical-formula . asme)
  (specific-heat (polynomial piecewise-polynomial (300 600 242.64335 1.2248692 0.00022567006 -2.2363095e-06 1.651601e-09) (600 1500 430.45218 0.64479165 1.9849014e-05 -1.9420185e-07 5.6214908e-11)))
  (molecular-weight (constant . 89.95667))
  (formation-enthalpy (constant . 2.4770566e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2669723E+06))
  )

 (dimethyl-arsenic 
  fluid
  (chemical-formula . asme2)
  (specific-heat (polynomial piecewise-polynomial (300 600 110.10636 2.3149985 0.00052256739 -4.450945e-06 3.2708554e-09) (600 1500 473.66924 1.2047111 5.538068e-05 -3.7390706e-07 1.0848388e-10)))
  (molecular-weight (constant . 104.99172))
  (formation-enthalpy (constant . 1.4310216e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3326735E+06))
  )

 (trimethyl-arsenic 
  fluid
  (chemical-formula . asme3)
  (specific-heat (polynomial piecewise-polynomial (300 600 18.477186 2.9462017 0.00080707743 -5.4825727e-06 3.881325e-09) (600 1500 439.71411 1.7085301 7.9981944e-05 -5.4567548e-07 1.5254968e-10)))
  (molecular-weight (constant . 120.02678))
  (formation-enthalpy (constant . 12242346))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3589342E+06))
  )

 (atomic-hydrogen
  fluid
  (chemical-formula . h)
  (density (constant . 0.040948))
  (specific-heat (constant . 20621) (polynomial piecewise-polynomial (300 1000 20621.497 0 0 0 0) (1000 5000 20621.497 0 0 0 0)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 0.000000e+00 0.000000e+00 2.062244e+04 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (1000.000000 6000.000000 5.014366e+05 -1.500781e+03 2.062419e+04 -1.011747e-03 3.079241e-07 -4.691807e-11 2.813074e-15) (6000.000000 20000.000000 1.793127e+12 -1.082295e+09 2.803971e+05 -3.146159e+01 2.006856e-03 -6.346989e-08 7.955399e-13) ))
  (viscosity (constant . 7.49e-06) (blottner-curve-fit 0.0603 -0.1425 -10.6827)) ; CEA table 1995
  (thermal-conductivity (constant . 0.2316))
  (molecular-weight (constant . 1.00797))
  (formation-enthalpy (constant . 2.1796499e+08))
  (characteristic-vibrational-temperature (constant . 0))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 2.05))
  (lennard-jones-energy (constant . 145))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 114593.36))
 ; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.), acentric factor missing 
  (critical-pressure (constant . 1.36e+06))
  (critical-temperature (constant . 33.20))
  (critical-volume (constant . 0.0185))
  )
 
 (atomic-oxygen
  fluid
  (chemical-formula . o)
  (density (constant . 0.649961))
  (specific-heat (polynomial piecewise-linear (300 . 1363.95) (400 . 1343.77) (500 . 1329.37) (600 . 1319.84) (700 . 1314.14) (800 . 1311.15) (900 . 1309.67) (1000 . 1308.38) (1200 . 1305.1) (1400 . 1303.4) (1600 . 1302.15) (1800 . 1301.4) (2000 . 1301.19) (2500 . 1303.21) (3000 . 1308.99) (3500 . 1318.46) (4000 . 1331.17) (4500 . 1346.34) (5000 . 1362.85) (5500 . 1379.24) (6000 . 1393.7) (7000 . 1412.58) (8000 . 1429.08) (9000 . 1441.39) (10000 . 1450.74) (11000 . 1459.51) (12000 . 1471.27) (13000 . 1490.73) (14000 . 1523.8) (15000 . 1577.55) (16000 . 1666.17) (17000 . 1775.71) (18000 . 1915.77) (19000 . 2083.87) (20000 . 2275.95) (21000 . 2486.35) (22000 . 2707.87) (23000 . 2931.72) (24000 . 3147.53) (25000 . 3343.37) (26000 . 3515.2) (27000 . 3657.17) (28000 . 3763.27) (29000 . 3833.76) (30000 . 3869.87)) (polynomial piecewise-polynomial (300 1000 1531.1577 -0.85129899 0.0012581269 -8.3294262e-07 2.0218614e-10) (1000 5000 1321.0209 -0.014317108 -1.6124203e-06 2.3650336e-09 -2.2699264e-13)) (constant . 1368.75) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -4.133285e+06 8.352085e+04 1.021797e+03 5.267781e-01 -5.770540e-04 3.386979e-07 -8.235686e-11) (1000.000000 6000.000000 1.361037e+08 -3.792956e+05 1.723851e+03 -2.224898e-01 5.384366e-05 -4.904842e-09 1.416132e-13) (6000.000000 20000.000000 9.245023e+10 -5.624579e+07 1.460688e+04 -1.546151e+00 9.639940e-05 -3.012151e-09 3.737350e-14) ))
  (viscosity (constant . 1.886e-05) (blottner-curve-fit 2.03e-2 4.29e-1 -1.16e1) (gupta-curve-fit-viscosity 0.0205 0.4257 -11.5803))
  (thermal-conductivity (constant . 0.03674) (gupta-curve-fit-conductivity 0 0 0.03310 0.22834 -11.58116))
  (molecular-weight (constant . 15.9994))
  (characteristic-vibrational-temperature (constant . 0))
  (formation-enthalpy (constant . 2.491815e+08))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 2.75))
  (lennard-jones-energy (constant . 80))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 160932.56))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.), acentric factor missing    
  (critical-pressure (constant . 2.69e+06))
  (critical-temperature (constant . 44.50))
  (critical-volume (constant . 0.0022))  
  )
 
 (benzene-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . c6h6<l>)
  (density (constant . 875)(compressible-liquid 101325 875 1.12e+09 7 1.1 0.9)) ;compressible liquid data from Perry's handbook
  (specific-heat (constant . 1759)(polynomial piecewise-linear (280 . 1699) (300 . 1705) (320 . 1766) (340 . 1840) (353 .  1890) (360 . 1915) (380 . 1990) (400 . 2064) (420 . 2143) (440 . 2231) (460 . 2333) (480 . 2461) (500 . 2637) ))
  (latent-heat (constant . 394164))
  (vaporization-temperature (constant . 262))
  (boiling-point (constant . 353))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (film-averaged (averaging-coefficient 0.3333) (film-diffusivity  (polynomial piecewise-linear (273 . 7.7e-06 ) (300 . 9.08E-6) (313 . 9.78E-6) (350 . 1.19E-5) (373 . 1.33E-5) (400 . 1.5E-5) (450 . 1.85E-5) (473 . 2.01E-5)) (constant . 8.8e-06)))(constant . 8.8e-06));; Binary diffusivity from Perry's book extended according to the (T/T0)^1.75 analogy
  (thermal-conductivity (constant . 0.159))
  (viscosity (constant . 0.000589))
  (dpm-surften (constant . 0.02814) (polynomial piecewise-polynomial (50 562  7.08744e-02 -1.43402e-04 -3.50637e-08 1.17757e-10)))
  (vapor-pressure (polynomial piecewise-linear (262 . 1329) (270 . 2658) (281 . 5316) (288 . 7974) (299 . 13289) (315 . 26579) (334 . 53158) (353 . 101000) (377 . 202000) (416 . 505000) (452 . 1000000) (495 . 2000000) (524 . 3000000) (562.05 . 4895000)) (constant . 13289) ) 
  ;; http://webbook.nist.gov
  (molecular-weight (constant . 78.11472))
  (formation-enthalpy (constant . 49.0E+06))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 173.26E+03))
  )
 
 (benzene-vapor
  fluid
  (chemical-formula . c6h6)
  (density (constant . 3.31))
  (specific-heat (polynomial piecewise-polynomial (300 1000 -334.00231 5.0271552 -0.00031529006 -3.4728647e-06 1.8293326e-09) (1000 5000 1374.1876 1.8342341 -0.00053476464 6.2728938e-08 -2.0728937e-12)) (constant . 1663) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.791254e+07 4.696821e+05 -3.961883e+03 1.747710e+01 -2.153580e-02 1.394047e-05 -3.671106e-09) (1000.000000 6000.000000 4.842920e+08 -2.407249e+06 4.994534e+03 -4.467216e-01 8.377395e-05 -8.429466e-09 3.516276e-13) ))
  (thermal-conductivity (constant . 0.0112))
  (viscosity (constant . 8e-06))
  (molecular-weight (constant . 78.11472))
  (formation-enthalpy (constant . 82887888))
  (reference-temperature (constant . 298))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 269281.25))
  ; Critical Properties from Polling et al.
  (critical-pressure (constant . 4.8950e6))
  (critical-temperature (constant . 562.05))
  (acentric-factor (constant . 0.210))
  (critical-volume (constant . 0.00328))
  )
 
 (benzene-air
  mixture
  (chemical-formula . #f)
  (species (names c6h6 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c6h6 1 -0.1 1) (o2 7.5 1.85 1)) ((co2 6 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c6h6 + 7.5o2 --> 6co2 + 3h2o") (arrhenius 1.125e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c6h6 1 -0.1 1) (o2 7.5 1.85 1)) ((co2 6 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c6h6 + 7.5o2 --> 6co2 + 3h2o") (arrhenius 1.125e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c6h6 1 -0.1 1) (o2 7.5 1.85 1)) ((co2 6 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c6h6 + 7.5o2 --> 6co2 + 3h2o") (arrhenius 1.125e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (calcium-carbonate
  (solid inert-particle fluid droplet-particle)
  (chemical-formula . caco3)
  (density (constant . 2800))
  (specific-heat (constant . 856) (polynomial 823.3 0.497 -0.0013)(polynomial piecewise-polynomial ( 298.00 1000.00 -0.1470097E+03  0.5141129E+01 -0.7330009E-02  0.3837119E-05 -0.2481574E-09) (1000.00 1200.00  0.1199445E+04 -0.1161147E+00  0.1697413E-03  0.0000000E+00  0.0000000E+00)))
  (thermal-conductivity (constant . 2.25))
  (boiling-point (constant . 2850))
  (molecular-weight (constant . 100.09))
  (formation-enthalpy (constant . -0.1206934E+10))
  (reference-temperature (constant . 298.00))
  (formation-entropy (constant .  0.9286001E+05))
  (struct-youngs-modulus (constant . 2.e+09))
  (struct-poisson-ratio (constant . 0.2))
  )

 (calcium-oxide
  (solid inert-particle fluid droplet-particle)
  (chemical-formula . cao)
  (density (constant . 3320))
  (specific-heat (constant . 783) (polynomial 747.1 0.361 -0.0008)(polynomial piecewise-polynomial ( 300.00 1000.00  0.2511235E+03  0.2690927E+01 -0.4206613E-02  0.3041402E-05 -0.8180535E-09) (1000.00 3200.00  0.8385397E+03  0.1507160E+00 -0.3792112E-04  0.8082477E-08 -0.6313039E-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 5.767221e+06 -7.169752e+04 7.528613e+02 4.561066e-02 -1.719550e-04 1.259303e-07 -2.217098e-11) (1000.000000 6000.000000 -7.284554e+09 2.217887e+07 -2.493352e+04 1.391041e+01 -3.640759e-03 4.559206e-07 -2.203132e-11) (6000.000000 20000.000000 -5.195385e+10 3.088733e+07 -5.898403e+03 7.471613e-01 -4.775272e-05 1.567753e-09 -2.069884e-14) ))
  (thermal-conductivity (constant . 2.25))
  (boiling-point (constant . 2850))
  (molecular-weight (constant . 56.08))
  (formation-enthalpy (constant . -0.6351003E+09))
  (reference-temperature (constant . 298.00))
  (formation-entropy (constant .  0.3822535E+05))
  (struct-youngs-modulus (constant . 1.e+09))
  (struct-poisson-ratio (constant . 0.2))
  )

 (calcium-carbonate-calcium-oxide
  particle-mixture 
  (species (names cao caco3))
  (reaction-model (multicomponent-reactions) (none . #f))
  )

 (calcium-carbonate-decomposition 
  mixture 
  (species (names (co2 n2) (cao caco3))) 
  (reactions (finite-rate ("reaction-1" ((caco3 1. 0. 1)) ((cao 1. 0. 1) (co2 1. 0. 1)) ((n2 0 1)) (stoichiometry 1caco3 --> 1cao + 1co2) (arrhenius 5000000. 203693000. 0.) (particle-reaction? . #t)(catalyst-species cao) (diffusion-species co2) (particle-rate 5e-12 1.))) (finite-rate/eddy-dissipation ("reaction-1" ((caco3 1. 0. 1)) ((cao 1. 0. 1) (co2 1. 0. 1)) ((n2 0 1)) (stoichiometry 1caco3 --> 1cao + 1co2) (arrhenius 5000000. 203693000. 0.) (particle-reaction? . #t)(catalyst-species cao) (diffusion-species co2) (particle-rate 5e-12 1.))) (eddy-dissipation ("reaction-1" ((caco3 1. 0. 1)) ((cao 1. 0. 1) (co2 1. 0. 1)) ((n2 0 1)) (stoichiometry 1caco3 --> 1cao + 1co2) (arrhenius 5000000. 203693000. 0.) (particle-reaction? . #t)(catalyst-species cao) (diffusion-species co2) (particle-rate 5e-12 1.)))) 
  )

 (calcium-sulfide 
    fluid               
   (chemical-formula . cas)
   (density (constant . 2800))
   (specific-heat (polynomial piecewise-polynomial ( 300.00 1000.00  0.5356253E+03  0.5683555E+00 -0.6374285E-03  0.3533985E-06 -0.7005469E-10) (1000.00 3200.00  0.6515075E+03  0.1570366E+00 -0.8387944E-04  0.2880040E-07 -0.3569040E-11)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.674902e+06 -5.207432e+04 7.113509e+02 -4.147615e-01 5.559268e-04 -4.185511e-07 1.397789e-10) (1000.000000 6000.000000 -1.807500e+09 6.101078e+06 -7.286535e+03 4.641886e+00 -1.284851e-03 1.687684e-07 -8.500805e-12) ))
   (molecular-weight (constant .  0.7214400E+02))
   (formation-enthalpy (constant . -0.4732298E+09))
   (reference-temperature (constant . 298.00))
   (formation-entropy (constant .  0.5657792E+05))
  )
 
 (calcium-sulfate
  (solid inert-particle fluid droplet-particle)
  (chemical-formula . caso4)
  (density (constant . 2960))
  (specific-heat (constant . 856) (polynomial 569.3 0.676 -0.00048)(polynomial piecewise-polynomial ( 300.00 1000.00  0.5157080E+03  0.7253103E+00  0.0000000E+00  0.0000000E+00  0.0000000E+00) (1000.00 3200.00  0.5157080E+03  0.7253103E+00  0.0000000E+00  0.0000000E+00  0.0000000E+00)))
  (thermal-conductivity (constant . 0.5))
  (boiling-point (constant . 5000))
  (molecular-weight (constant . 136.142))
  (formation-enthalpy (constant . -0.1434159E+10))
  (reference-temperature (constant . 298.00))
  (formation-entropy (constant .  0.1066446E+06))
  (struct-youngs-modulus (constant . 1.e+09))
  (struct-poisson-ratio (constant . 0.2))
  )

 (carbon+ 
  fluid
  (chemical-formula . c+)
  (specific-heat (polynomial piecewise-polynomial (300 1000 1796.6541 -0.2816532 0.00047712391 -3.6457254e-07 1.0441467e-10) (1000 5000 1738.8118 -0.012017305 6.5793272e-06 -1.5359992e-09 1.2891e-13)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 1.563555e+06 -1.090058e+03 1.733236e+03 -3.601885e-03 3.126997e-06 -1.510177e-09 3.111863e-13) (1000.000000 6000.000000 8.688982e+06 -2.361997e+04 1.760751e+03 -1.941949e-02 6.750936e-06 -1.202403e-09 8.627226e-14) (6000.000000 20000.000000 3.889362e+08 -4.186301e+06 4.073792e+03 -4.992701e-01 4.723810e-05 -1.799862e-09 2.515680e-14) ))
  (viscosity (blottner-curve-fit -0.007140 0.768602 -12.956246))
  (lennard-jones-length (constant . 3.385)) ; Svehla 1963
  (lennard-jones-energy (constant . 30.6))
  (molecular-weight (constant . 12.01061))
  (characteristic-vibrational-temperature (constant . 0))
  (formation-enthalpy (constant . 1.8076571e+09))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1545408E+06))
  )

 (carbon- 
  fluid
  (chemical-formula . c-)
  (specific-heat (polynomial piecewise-polynomial (300 1000 1926.9809 -1.2281385 0.0025588494 -2.1227252e-06 5.9788502e-10) (1000 5000 2069.7924 -0.63574588 0.00034993932 -5.332201e-08 2.1895753e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 3.233579e+03 -1.374874e+00 1.730566e+03 -1.368354e-05 1.715987e-08 -1.114940e-11 2.932611e-15) (1000.000000 6000.000000 2.944150e+03 3.999798e-01 1.730559e+03 1.963241e-07 -5.072099e-11 6.561249e-15 -3.343778e-19) (6000.000000 20000.000000 8.467898e+03 -3.596924e+00 1.730560e+03 -1.206890e-07 8.352435e-12 -2.943626e-16 4.148036e-21) ))
  (molecular-weight (constant . 12.01169))
  (formation-enthalpy (constant . 5.8832275e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1512949E+06))
  )

 (dicarbon 
  fluid
  (chemical-formula . c2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 2421.3958 -2.5614164 0.0011195605 1.6622016e-06 -1.1407473e-09) (1000 5000 1431.5002 0.022606532 6.3583692e-05 -1.8326777e-08 1.6309141e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.924320e+08 -3.454357e+06 2.312666e+04 -6.034431e+01 8.474915e-02 -5.896103e-05 1.621425e-08) (1000.000000 6000.000000 -3.353600e+08 1.232557e+06 -1.752622e+02 1.019378e+00 -2.471106e-04 3.001090e-08 -1.411099e-12) (6000.000000 20000.000000 2.186201e+09 4.725835e+06 -1.383377e+03 6.706304e-01 -5.484111e-05 1.910890e-09 -2.510675e-14) ))
  (molecular-weight (constant . 24.0223))
  (characteristic-vibrational-temperature (constant . 2668)) ; NIST webbook
  (viscosity (blottner-curve-fit -0.008875 0.78595 -12.9908))  ; ref Svehla 1963
  (lennard-jones-length (constant . 3.913))  ; Svehla 1963
  (lennard-jones-energy (constant . 78.8))
  (formation-enthalpy (constant . 8.3778138e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1992902E+06))
  )

 (dicarbon+
  fluid
  (chemical-formula . c2+)
  (specific-heat (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 -34313549.38598808 466298.85193775396 -1203.4180362538248 5.802656458180663 -0.006458504464871385 3.776767245536687e-06 -8.428023051365298e-10) (1000.000000 6000.000000 1327834041.7607486 -2160502.3408833197 961.9098968406682 2.0996246569171215 -0.000849001846132967 1.3440236996690582e-07 -7.582577759127376e-12) (6000.000000 20000.000000 17283713034.288082 -6983911.584543243 2195.550944193545 0.2204471624085269 -3.588328111119685e-05 1.7109482757462383e-09 -2.7650793835001812e-14)))
  (molecular-weight (constant . 24.0223))
  (characteristic-vibrational-temperature (constant . 2668)) ; NIST webbook
  (viscosity (blottner-curve-fit -0.008875 0.78595 -12.9908))  ; ref Svehla 1963
  (lennard-jones-length (constant . 3.913))  ; Svehla 1963
  (lennard-jones-energy (constant . 78.8))
  (formation-enthalpy (constant . 2004775428.0))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 204719.0))
  )
 
 (dicarbon-
  fluid
  (chemical-formula . c2-)
  (specific-heat (polynomial piecewise-polynomial (300 1000 1200.2833 -0.081433292 0.00043051974 1.6287392e-07 -2.8256664e-10) (1000 5000 1314.1092 0.087565341 3.3603391e-05 -5.588858e-09 -1.1119866e-14)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 -4.090836e+07 4.977796e+05 -1.106229e+03 5.072487e+00 -5.349341e-03 3.136232e-06 -7.392890e-10) (1000.000000 6000.000000 1.550016e+09 -3.994849e+06 4.534792e+03 -6.448068e-01 1.389615e-05 1.283776e-08 -1.154870e-12) ))
  (molecular-weight (constant . 24.02285))
  (formation-enthalpy (constant . 4.4352435e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1964880E+06))
  )
 
 (dicarbon-trichloride 
  fluid
  (chemical-formula . c2cl3)
  (specific-heat (polynomial piecewise-polynomial (300 1500 306.64461 1.4111843 -0.0016253852 8.7496946e-07 -1.7936184e-10) (1500 4000 754.93613 0.060331304 -1.8626221e-05 2.4532252e-09 -9.8176859e-14)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.980958e+06 -5.643872e+04 5.759683e+02 7.922095e-01 -9.915379e-04 6.068208e-07 -1.493516e-10) (1000.000000 6000.000000 -1.405246e+07 -6.843208e+04 8.790164e+02 -1.973490e-02 4.324789e-06 -4.931922e-10 2.276962e-14) ))
  (molecular-weight (constant . 130.38129))
  (formation-enthalpy (constant . 2.2747085e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3342954E+06))
  )

 (pentachloro-ethyl 
  fluid
  (chemical-formula . c2cl5)
  (specific-heat (polynomial piecewise-polynomial (300 1500 264.94988 1.5974483 -0.0020066107 1.1295135e-06 -2.3680181e-10) (1500 4000 733.2224 0.038087286 -2.0044455e-05 4.916935e-09 -4.5454845e-13)))
  (molecular-weight (constant . 201.28729))
  (formation-enthalpy (constant . 30936866))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3964592E+06))
  )

 (hexachloro-ethane 
  fluid
  (chemical-formula . c2cl6)
  (specific-heat (polynomial piecewise-polynomial (300 1500 263.14464 1.5166495 -0.0018526012 1.0350392e-06 -2.1692112e-10) (1500 4000 709.92519 0.061728718 -2.0654264e-05 2.8200513e-09 -1.3901366e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 5.596637e+06 -9.155367e+04 7.122793e+02 6.213635e-01 -1.100296e-03 8.391162e-07 -2.420706e-10) (1000.000000 6000.000000 -1.958268e+07 -1.748987e+04 7.856812e+02 -5.192495e-03 1.144251e-06 -1.308636e-10 6.049631e-15) ))
  (molecular-weight (constant . 236.7403))
  (formation-enthalpy (constant . -1.3572894e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3893327E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 3.340E+06))
  (critical-temperature (constant . 703.62))
  (acentric-factor (constant . 0.225))
  (critical-volume (constant . 0.001757))
  )

 (hexafluoro-ethane 
  fluid
  (chemical-formula . c2f6)
  (specific-heat (polynomial piecewise-polynomial (300 1000 215.51726 2.3577239 -0.0016355225 2.6196552e-08 2.4140302e-10) (1000 5000 965.13214 0.37790663 -0.00016854738 3.3239523e-08 -2.4125339e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -2.287027e+06 4.819283e+04 -2.814788e+02 4.519341e+00 -5.911450e-03 3.807477e-06 -9.775671e-10) (1000.000000 6000.000000 -6.093514e+07 -5.677889e+04 1.326938e+03 -7.928790e-03 1.126925e-06 -2.092633e-10 1.501208e-14) ))
  (molecular-weight (constant . 138.0127))
  (formation-enthalpy (constant . -1.3439608e+09))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3321519E+06))
; Critical Properties from Polling et al.
  (critical-pressure (constant . 3.0390e6))
  (critical-temperature (constant . 293.04))
  (acentric-factor (constant . 0.257))
  (critical-volume (constant . 0.00161))
  )

 (ethynyl-radical 
  fluid
  (chemical-formula . c2h)
  (specific-heat (polynomial piecewise-polynomial (300 1000 1013.3443 2.0101929 -0.0016464519 9.3146135e-07 -2.7215905e-10) (1000 5000 1470.7513 0.73618085 -0.00020092888 3.2826894e-08 -2.4418512e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.542472e+06 -1.391009e+05 2.409790e+03 -1.673243e+00 2.735642e-03 -1.533640e-06 3.158873e-10) (1000.000000 6000.000000 1.327382e+09 -3.976002e+06 5.693166e+03 -1.108501e+00 1.994224e-04 -1.826123e-08 6.719294e-13) ))
  (molecular-weight (constant . 25.03027))
  (formation-enthalpy (constant . 5.6069062e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2073700E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)   
  (critical-pressure (constant . 2.81E+06))
  (critical-temperature (constant . 366.00))
  (acentric-factor (constant . 0.130))  
  (critical-volume (constant . 0.0040))  
  )

 (vinyl-radical 
  fluid
  (chemical-formula . c2h3)
  (specific-heat (polynomial piecewise-polynomial (300 1000 756.01186 2.2660829 0.00064860075 -4.0628914e-07 -3.6421721e-10) (1000 5000 1824.0214 1.2351046 -0.00012194246 -4.4306317e-08 7.3122429e-12)))
  (molecular-weight (constant . 27.04621))
  (formation-enthalpy (constant . 2.8623331e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2315035E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 6.52E+06))
  (critical-temperature (constant . 292.02))
  (acentric-factor (constant . 0.080))  
  (critical-volume (constant . 0.0044))  
  )

 (ethyl-radical 
  fluid
  (chemical-formula . c2h5)
  (specific-heat (polynomial piecewise-polynomial (300 1000 769.77795 2.4944416 0.0012644638 2.6716933e-07 -1.1236897e-09) (1000 5000 2057.1119 1.8550182 -0.00018389936 -6.7170063e-08 1.1102733e-11)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -4.037855e+07 7.765732e+05 -4.391657e+03 1.845854e+01 -2.076878e-02 1.315832e-05 -3.485817e-09) (1000.000000 6000.000000 1.192824e+09 -4.757837e+06 7.997843e+03 -8.731041e-01 1.626542e-04 -1.625890e-08 6.739634e-13) ))
  (molecular-weight (constant . 29.06215))
  (formation-enthalpy (constant . 1.1721378e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2516172E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 5.99E+06))
  (critical-temperature (constant . 297.57))
  (acentric-factor (constant . 0.110))  
  (critical-volume (constant . 0.0048))  
  )

 (chloro-acetylene 
  fluid
  (chemical-formula . c2hcl)
  (specific-heat (polynomial piecewise-polynomial (300 1000 497.40972 1.8310068 -0.0018170445 8.3744068e-07 -1.2205564e-10) (1000 5000 865.39409 0.5337926 -0.00020702927 3.7115625e-08 -2.5159046e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.828000e+07 -2.989265e+05 2.059232e+03 -1.773718e+00 2.202921e-03 -1.258010e-06 2.778224e-10) (1000.000000 6000.000000 1.583947e+08 -6.133079e+05 1.761528e+03 -9.346094e-02 1.583332e-05 -1.439590e-09 5.434280e-14) ))
  (molecular-weight (constant . 60.48327))
  (formation-enthalpy (constant . 2.1382413e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2419491E+06))
  ; Critical Properties from Cranium ver. 1.0.3
  (critical-pressure (constant . 6.567E+06))
  (critical-temperature (constant . 459.87))
  (acentric-factor (constant . 0.155))
  (critical-volume (constant . 0.002662))
  )

 (pentachloro-ethane 
  fluid
  (chemical-formula . c2hcl5)
  (specific-heat (polynomial piecewise-polynomial (300 1500 220.13351 1.7164972 -0.0019361345 1.0483621e-06 -2.1883615e-10) (1500 4000 779.99662 0.092239705 -2.4104291e-05 1.1236536e-09 2.0279302e-13)))
  (molecular-weight (constant . 202.29527))
  (formation-enthalpy (constant . -1.472455e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3829049E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 3.680E+06))
  (critical-temperature (constant . 655.00))
  (acentric-factor (constant . 0.254))
  (critical-volume (constant . 0.001864))
  )

 (cyano-methylidene 
  fluid
  (chemical-formula . c2n)
  (specific-heat (polynomial piecewise-polynomial (300 1000 764.89218 1.8702691 -0.0013749077 1.8886441e-07 1.0747919e-10) (1000 5000 1344.9254 0.33049438 -0.00014493879 2.8119268e-08 -2.0028467e-12)))
  (molecular-weight (constant . 38.029))
  (formation-enthalpy (constant . 5.5649734e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2307982E+06))
  )

 (cyanogen 
  fluid
  (chemical-formula . c2n2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 681.54129 1.9050055 -0.0021442899 1.4687586e-06 -4.4402325e-10) (1000 5000 1046.2493 0.63668231 -0.00026111748 4.8551132e-08 -3.373097e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.729515e+07 -3.080867e+05 2.482880e+03 -2.909931e+00 4.440159e-03 -3.035003e-06 7.908821e-10) (1000.000000 6000.000000 1.270404e+08 -6.394498e+05 2.101154e+03 -1.401980e-01 3.302041e-05 -3.532379e-09 1.602523e-13) ))
  (molecular-weight (constant . 52.0357))
  (formation-enthalpy (constant . 3.0909622e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2415081E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 4.693E+06))
  (critical-temperature (constant . 668.21))
  (acentric-factor (constant . 0.454))
  (critical-volume (constant . 0.003844))
  )

 (dicarbon-monoxide 
  fluid
  (chemical-formula . c2o)
  (specific-heat (polynomial piecewise-polynomial (300 1000 699.8644 1.7121999 -0.001820922 1.1569907e-06 -3.199303e-10) (1000 5000 1007.5274 0.61234836 -0.00022659427 3.7239719e-08 -2.3179412e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -5.070777e+05 -2.803921e+04 9.833540e+02 6.855464e-01 -1.834316e-05 -3.699021e-07 1.626008e-10) (1000.000000 6000.000000 6.762152e+07 -4.860474e+05 2.023853e+03 -2.587851e-01 7.808707e-05 -1.054776e-08 5.279543e-13) ))
  (molecular-weight (constant . 40.0217))
  (formation-enthalpy (constant . 2.8661363e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2329636E+06))
  )

 (carbon-trimer 
  fluid
  (chemical-formula . c3)
  (specific-heat (polynomial piecewise-polynomial (300 1000 1002.6847 0.29176226 -0.0010735286 2.0064771e-06 -9.7915114e-10) (1000 5000 877.66587 0.51998665 -0.00017777403 3.0372097e-08 -2.00611e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.004823e+07 1.536831e+05 3.348244e+02 1.715507e+00 -8.791897e-04 -5.392107e-09 1.016922e-10) (1000.000000 6000.000000 1.040239e+09 -3.371321e+06 5.265634e+03 -1.971598e+00 4.952034e-04 -4.854654e-08 1.465623e-12) (6000.000000 20000.000000 1.297277e+11 -1.107643e+08 3.432978e+04 -4.300770e+00 2.892920e-04 -9.764310e-09 1.314480e-13) ))
  (molecular-weight (constant . 36.03345))
  (formation-enthalpy (constant . 8.2008678e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2370873E+06))
  )

 (cyclopropenylidene 
  fluid
  (chemical-formula . c3h2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 588.03906 3.2348136 -0.00071029216 -1.8889176e-06 1.1548217e-09) (1000 5000 1427.0853 1.2827486 -0.00037601433 4.6488895e-08 -1.8119016e-12)))
  (molecular-weight (constant . 38.04939))
  (formation-enthalpy (constant . 4.4568646e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2352178E+06))
  )

 (propargyl-radical 
  fluid
  (chemical-formula . c3h3)
  (specific-heat (polynomial piecewise-polynomial (300 1000 3.89236E+02 5.06317E+00 -4.66698E-03 2.13026E-06 -2.95874E-10) (1000 5000 1.41391E+03 1.72134E+00 -6.06263E-04 9.65477E-08 -5.72398E-12)))
  (molecular-weight (constant . 39.0568))
  (formation-enthalpy (constant . 3.46000E+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2532693E+06))
  )

 (allene 
  fluid
  (chemical-formula . c3h4)
  (specific-heat (polynomial piecewise-polynomial (300 1000 -44.242507 6.969987 -0.0078958497 5.6981512e-06 -1.8033542e-09) (1000 5000 1188.9095 2.5666113 -0.00099726139 1.7849513e-07 -1.2062702e-11)))
  (molecular-weight (constant . 40.06533))
  (formation-enthalpy (constant . 1.8924907e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2296794E+06))
  ; Critical Properties from Polling et al. (1,2 propadiene)
  (critical-pressure (constant . 5.2500e6))
  (critical-temperature (constant . 394.0))
  (acentric-factor (constant . 0.122))
  (critical-volume (constant . 0.00434))
  )

 (cyclopropene
  fluid
  (chemical-formula . c3h4c)
  (specific-heat (polynomial piecewise-polynomial (300 1000 -5.1093475 4.8138748 -0.00038337891 -3.3052873e-06 1.8022275e-09) (1000 5000 1390.3797 2.1493574 -0.00071700418 1.0511478e-07 -5.537093e-12)))
  (molecular-weight (constant . 40.06533))
  (formation-enthalpy (constant . 2.7696576e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2434795E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.865E+06))
  (critical-temperature (constant . 463.95))
  (acentric-factor (constant . 0.174))
  (critical-volume (constant . 0.003956))
  )

 (propyne 
  fluid
  (chemical-formula . c3h4p)
  (specific-heat (polynomial piecewise-polynomial (300 1000 130.14479 6.4666813 -0.0077771343 6.1511226e-06 -2.0725769e-09) (1000 5000 1143.6474 2.5876781 -0.00099903326 1.779225e-07 -1.1977119e-11)))
  (molecular-weight (constant . 40.06533))
  (formation-enthalpy (constant . 1.8397728e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2070783E+06))
  ; Critical Properties from Somayajulu (1989), acentric factor from Assael et al. (1996)
  (critical-pressure (constant . 5.6280e6))
  (critical-temperature (constant . 402.38))
  (acentric-factor (constant . 0.215))
  (critical-volume (constant . 0.004093))
  )


 (carbon-suboxide 
  fluid
  (chemical-formula . c3o2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 491.06231 2.2446142 -0.0023307589 1.4489267e-06 -4.1781105e-10) (1000 5000 989.78034 0.67950208 -0.00028258583 5.3048561e-08 -3.7108217e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.930773e+07 -3.091311e+05 2.201958e+03 -2.182553e+00 3.639979e-03 -2.667496e-06 7.348670e-10) (1000.000000 6000.000000 8.514965e+07 -5.651659e+05 2.033508e+03 -1.436364e-01 3.027930e-05 -3.354109e-09 1.514490e-13) ))
  (molecular-weight (constant . 68.03225))
  (formation-enthalpy (constant . -93630488))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2760252E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.001E+06))
  (critical-temperature (constant . 422.15))
  (acentric-factor (constant . 0.175))
  (critical-volume (constant . 0.002499))
  )

 (tetracarbon 
  fluid
  (chemical-formula . c4)
  (specific-heat (polynomial piecewise-polynomial (300 1000 405.47182 2.8432547 -0.00264425 1.270883e-06 -2.7381988e-10) (1000 5000 1124.8861 0.73178428 -0.00030989183 5.8921843e-08 -4.1601948e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 6.755010e+06 -1.548471e+05 1.818731e+03 -1.133812e+00 2.152420e-03 -1.495897e-06 3.916641e-10) (1000.000000 6000.000000 1.592354e+08 -2.648574e+05 1.047068e+03 9.090476e-01 -3.079034e-04 4.482073e-08 -2.397855e-12) ))
  (molecular-weight (constant . 48.0446))
  (formation-enthalpy (constant . 9.7074714e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2282661E+06))
; Critical Properties from Cranium Ver. 1.0.3, software unable to calculate critical-temperature and acentric factor 
  (critical-pressure (constant . 5.327E+06))
  (critical-volume (constant . 0.003830))
  )

 (butadiynyl-radical 
  fluid
  (chemical-formula . c4h)
  (specific-heat (polynomial piecewise-polynomial (300 1000 851.43309 1.2021473 -1.0294939e-06 -3.8573669e-07 1.3707338e-10) (1000 5000 1058.1595 1.0498202 -0.00035356232 5.2242899e-08 -2.7738144e-12)))
  (molecular-weight (constant . 49.05257))
  (formation-enthalpy (constant . 6.4887277e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2547837E+06))
  )

 (diacetylene 
  fluid
  (chemical-formula . c4h2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 665.2049 3.2901577 -0.001638581 -1.1020049e-06 1.0093713e-09) (1000 5000 1499.9876 1.0043621 -0.0003236658 4.5754333e-08 -2.3012967e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 4.098409e+07 -6.474061e+05 3.929894e+03 -3.667397e+00 4.619112e-03 -2.619769e-06 5.685379e-10) (1000.000000 6000.000000 3.866962e+08 -1.482421e+06 3.511779e+03 -2.273624e-01 3.865921e-05 -3.528878e-09 1.337744e-13) ))
  (molecular-weight (constant . 50.06054))
  (formation-enthalpy (constant . 4.6738435e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2501208E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.597E+06))
  (critical-temperature (constant . 462.46))
  (acentric-factor (constant . 0.093))
  (critical-volume (constant . 0.003676))
  )
 
 (c4h6-2-butyne 
  fluid
  (chemical-formula . c4h6)
  (specific-heat (polynomial piecewise-polynomial (300 1000 491.41528 3.1134587 0.0010006568 -2.5491284e-06 9.8376297e-10) (1000 5000 1236.8096 2.5338852 -0.00084880048 1.2486465e-07 -6.6018008e-12)))
  (molecular-weight (constant . 54.09242))
  (formation-enthalpy (constant . 1.4628554e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2852004E+06))
; Critical Properties from Polling et al. (c4h6-1butyne)
  (critical-pressure (constant . 4.6000e6))
  (critical-temperature (constant . 440.0))
  (acentric-factor (constant . 0.245))
  (critical-volume (constant . 0.00385))
  )
 
 (c4h8-1-butene 
  fluid
  (chemical-formula . c4h8)
  (specific-heat (polynomial piecewise-polynomial (300 1000 175.02531 4.5719655 0.00075373957 -3.6534495e-06 1.6463484e-09) (1000 5000 304.30753 5.0901814 -0.0023536294 4.9033456e-07 -3.7580906e-11)))
  (molecular-weight (constant . 56.10836))
  (formation-enthalpy (constant . -556920.69))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3077707E+06))
; Critical Properties from Polling et al. 
  (critical-pressure (constant . 4.0200e6))
  (critical-temperature (constant . 419.50))
  (acentric-factor (constant . 0.194))
  (critical-volume (constant . 0.00429))
   )
 
 (carbon-pentamer 
  fluid
  (chemical-formula . c5)
  (specific-heat (polynomial piecewise-polynomial (300 1000 292.8462 3.2206584 -0.0029204682 1.2560627e-06 -2.1321611e-10) (1000 5000 1118.3594 0.79514636 -0.00033730492 6.4222865e-08 -4.5394426e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.662985e+06 -7.688491e+04 1.555915e+03 -6.018637e-01 2.407492e-03 -2.364556e-06 7.717688e-10) (1000.000000 6000.000000 3.007808e+07 -4.096294e+05 2.161359e+03 -1.135495e-01 2.460537e-05 -2.783187e-09 1.277145e-13) ))
  (molecular-weight (constant . 60.05575))
  (formation-enthalpy (constant . 9.7912454e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2419501E+06))
  )
 
 (c5h
  fluid
  (chemical-formula . c5h)
  (specific-heat (polynomial piecewise-polynomial (300 1000 222.59516 3.4169475 -0.0016429372 -1.4249128e-06 1.1995541e-09) (1000 5000 1183.9995 0.82434406 -0.00027449675 3.9389162e-08 -2.0016644e-12)))
  (molecular-weight (constant . 61.06372))
  (formation-enthalpy (constant . 7.7821882e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2602724E+06))
  )
 
 (c5h2 
  fluid
  (chemical-formula . c5h2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 410.18983 3.629971 -0.0013517562 -1.7048086e-06 1.2279249e-09) (1000 5000 1517.5132 0.99443277 -0.00035203887 5.4684562e-08 -3.0825736e-12)))
  (molecular-weight (constant . 62.07169))
  (formation-enthalpy (constant . 6.9135693e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2664876E+06))
  )
 
 (c5h3
  fluid
  (chemical-formula . c5h3)
  (specific-heat (polynomial piecewise-polynomial (300 1000 570.55554 3.100733 -0.00077195699 -1.6020472e-06 1.0184038e-09) (1000 5000 1421.884 1.2573884 -0.00042267125 6.2388505e-08 -3.3111694e-12)))
  (molecular-weight (constant . 63.07966))
  (formation-enthalpy (constant . 5.6658099e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2951047E+06))
  )
 
 (cyclopentadiene 
  fluid
  (chemical-formula . c5h6)
  (specific-heat (polynomial piecewise-polynomial (300 1000 -402.07775 5.1334328 8.5736276e-05 -3.9462167e-06 1.9837914e-09) (1000 5000 1218.7604 2.3121195 -0.00078798131 1.1814753e-07 -6.3991908e-12)))
  (molecular-weight (constant . 66.10357))
  (formation-enthalpy (constant . 1.3387056e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2696754E+06))
; Critical Properties from Owczarek&Blazej (2004), critical pressure, acentric factor and critical volume missing
  (critical-temperature (constant . 505.03))
  )
 
 (hexatriynyl-radical 
  fluid
  (chemical-formula . c6h)
  (specific-heat (polynomial piecewise-polynomial (300 1000 542.70551 2.7958519 -0.00086030691 -1.6847058e-06 1.1113931e-09) (1000 5000 1318.39 0.8300544 -0.00028057837 3.8764801e-08 -1.704611e-12)))
  (molecular-weight (constant . 73.07487))
  (formation-enthalpy (constant . 8.91872e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3100597E+06))
  )
 
 (cyclohexene
  fluid
  (chemical-formula . c6h10)
  (specific-heat (polynomial piecewise-polynomial (300 1000 -141.11461 4.777976 0.0012105552 -4.2134094e-06 1.7614529e-09) (1000 5000 1612.1045 2.403224 -0.00069925045 8.2081842e-08 -2.7156802e-12)))
  (molecular-weight (constant . 82.1466))
  (formation-enthalpy (constant . -4203357.5))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3127820E+06))
; Critical Properties from Polling et al. Only critical temperature and volume available 
  (critical-temperature (constant . 560.40))
  (critical-volume (constant . 0.00361))

  )
  
 (c6h2-1,3,5-hexatriyne 
  fluid
  (chemical-formula . c6h2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 645.44602 2.9591978 -0.0013094579 -1.2024914e-06 9.865377e-10) (1000 5000 1431.6681 0.90170107 -0.00029384307 4.1806463e-08 -2.1086392e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 3.259136e+07 -5.533117e+05 3.579658e+03 -3.501368e+00 4.855388e-03 -3.067105e-06 7.491822e-10) (1000.000000 6000.000000 2.910064e+08 -1.215914e+06 3.195874e+03 -2.106347e-01 3.829657e-05 -3.745859e-09 1.522977e-13) ))
  (molecular-weight (constant . 74.08284))
  (formation-enthalpy (constant . 7.0988909e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2967541E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 4.743E+06))
  (critical-temperature (constant . 546.96))
  (acentric-factor (constant . 0.068))
  (critical-volume (constant . 0.003456))
  )

 (c6h3
  fluid
  (chemical-formula . c6h3)
  (specific-heat (polynomial piecewise-polynomial (300 1000 554.40393 2.981627 -0.00065546995 -1.6910109e-06 1.0417238e-09) (1000 5000 1412.9664 1.1499301 -0.00038522935 5.6576907e-08 -2.9795387e-12)))
  (molecular-weight (constant . 75.09081))
  (formation-enthalpy (constant . 6.6297402e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3192535E+06))
  )
 
 (c6h4-1,5-hexadiyne-3-ene
  fluid
  (chemical-formula . c6h4)
  (specific-heat (polynomial piecewise-polynomial (300 1000 -142.08731 4.2244031 -0.0003981271 -2.9156157e-06 1.5852517e-09) (1000 5000 1099.4269 1.8467789 -0.00070722673 1.228139e-07 -7.9840418e-12)))
  (molecular-weight (constant . 76.09879))
  (formation-enthalpy (constant . 5.0948512e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2909572E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 4.243E+06))
  (critical-temperature (constant . 518.18))
  (acentric-factor (constant . 0.124))
  (critical-volume (constant . 0.003601))
  )
 
 (phenyl-radical 
  fluid
  (chemical-formula . c6h5)
  (specific-heat (polynomial piecewise-polynomial (300 1000 12.330852 3.9113055 0.00012489672 -2.3689633e-06 9.1261639e-10) (1000 4000 1701.0973 1.0406689 -0.0001016764 -5.8972853e-08 1.1068875e-11)))
  (molecular-weight (constant . 77.10675))
  (formation-enthalpy (constant . 3.3236131e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2921420E+06))
  )
 
 (c6h5<l>-1,5-hexadiynyl-radical 
  fluid
  (chemical-formula . c6h5<l>)
  (specific-heat (polynomial piecewise-polynomial (300 1000 523.43063 3.269006 1.8793421e-05 -1.9527931e-06 7.9712671e-10) (1000 4000 1856.3186 0.92960069 -8.8649845e-05 -5.1242088e-08 9.5364849e-12)))
  (molecular-weight (constant . 77.10675))
  (formation-enthalpy (constant . 5.8820992e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3525939E+06))
  )
 
 (phenoxy-radical 
  fluid
  (chemical-formula . c6h5o)
  (specific-heat (polynomial piecewise-polynomial (300 1000 98.898974 3.5335352 7.5880486e-05 -2.1756156e-06 8.6179978e-10) (1000 4000 1627.6081 0.8965545 -8.8546502e-05 -5.0657901e-08 9.5405136e-12)))
  (molecular-weight (constant . 93.10615))
  (formation-enthalpy (constant . 43321496))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3132742E+06))
  )

 (phenol 
  fluid
  (chemical-formula . c6h5oh)
  (specific-heat (polynomial piecewise-polynomial (300 1000 122.92561 3.4736157 0.0001569943 -2.0121686e-06 7.3410167e-10) (1000 4000 1609.2875 1.0092561 -9.6884569e-05 -5.6782061e-08 1.0591401e-11)))
  (molecular-weight (constant . 94.11412))
  (formation-enthalpy (constant . -1.0464509e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3219128E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.854E+06))
  (critical-temperature (constant . 695.08))
  (acentric-factor (constant . 0.368))
  (critical-volume (constant . 0.002420))
  )
 
 (cyclohexadienyl-radical 
  fluid
  (chemical-formula . c6h7)
  (specific-heat (polynomial piecewise-polynomial (300 1000 48.749102 4.1779688 0.00026576135 -2.3367963e-06 7.9410728e-10) (1000 4000 1844.4144 1.2894349 -0.00012459971 -7.3133238e-08 1.3674541e-11)))
  (molecular-weight (constant . 79.1227))
  (formation-enthalpy (constant . 2.0067789e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3057756E+06))
  )
 
 (n-heptyl-radical
  fluid
  (chemical-formula . c7h15)
  (specific-heat (polynomial piecewise-polynomial (300 1000 8.61693E+02 5.88035E-02 1.33734E-02 -1.75679E-05 6.98585E-09) (1000 4000 1.37561E+03 3.38296E+00 -1.23904E-03 2.04866E-07 -1.25025E-11)))
  (molecular-weight (constant . 99.1961))
  (formation-enthalpy (constant . 4.39000E+06))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.4479467E+06))
  )

 
 (octatetraynyl-radical
  fluid
  (chemical-formula . c8h)
  (specific-heat (polynomial piecewise-polynomial (300 1000 384.43229 3.0154454 -0.00087289389 -1.8812911e-06 1.2171455e-09) (1000 5000 1263.0206 0.85042511 -0.00028898447 4.013941e-08 -1.7755494e-12)))
  (molecular-weight (constant . 97.09718))
  (formation-enthalpy (constant . 1.2086404e+09))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3279998E+06))
  )

 (octatetrayne 
  fluid
  (chemical-formula . c8h2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 392.42534 3.336647 -0.00097295121 -2.1714571e-06 1.4159836e-09) (1000 5000 1328.8867 0.94534553 -0.00031563784 4.4051752e-08 -2.0132615e-12)))
  (molecular-weight (constant . 98.10514))
  (formation-enthalpy (constant . 9.4623782e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3177589E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 4.064E+06))
  (critical-temperature (constant . 629.01))
  (acentric-factor (constant . 0.044))
  (critical-volume (constant . 0.003343))
  )

 (carbon
  (fluid combusting-particle inert-particle)
  (chemical-formula . c)
  (density (constant . 2000))
  (molecular-weight (constant . 12.01115))
  (characteristic-vibrational-temperature (constant . 0))
  (specific-heat (polynomial piecewise-polynomial (300 1000 1729.566 0.055971235 -0.00018673958 2.1048488e-07 -7.660448e-11) (1000 5000 1801.2127 -0.12370504 6.2902174e-05 -7.9600504e-09 2.2918273e-13)) (constant . 1220) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 4.496221e+05 -6.679580e+02 1.733875e+03 -8.870894e-03 1.370758e-05 -1.111862e-08 3.678980e-12) (1000.000000 6000.000000 -8.924117e+07 1.190353e+05 1.831739e+03 -2.321180e-01 1.205973e-04 -2.009491e-08 1.136810e-12) (6000.000000 20000.000000 3.068442e+11 -1.997862e+08 5.356055e+04 -6.725457e+00 4.603219e-04 -1.543784e-08 2.007118e-13) ))
  (thermal-conductivity (constant . 0.33))
  (viscosity (blottner-curve-fit -0.007140 0.768602 -12.956246)) ; ref: Bouyahiaoui et al. 2019
  (lennard-jones-length (constant . 3.385))  ; Svehla 1963
  (lennard-jones-energy (constant . 30.6))
  (vaporization-temperature (constant . 400))
  (boiling-point (constant . 400))
  (binary-diffusivity (constant . 4e-05))
  (volatile-fraction (constant . 0))
  (combustible-fraction (constant . 1))
  (swelling-coefficient (constant . 1))
  (emissivity (constant . 0.9))
  (scattering-factor (constant . 0.9))
  (burn-stoichiometry (constant . 2.67))
  (burn-hreact (constant . 32789000))
  (burn-hreact-fraction (constant . 0.3))
  (formation-enthalpy (constant . 7.1670938e+08))
  (reference-temperature (constant . 298))
  (combustion-model (diffusion-limited . #f) (kinetics/diffusion-limited 5e-12 0.002 79000000) (intrinsic-model 5e-12 0.030198 1.794e+08 0.5 6e-08 300000 1.4142136 0) (cbk -1.0 10.0))
  (formation-entropy (constant . 157994.97))
  )

 (carbon-solid 
  (fluid inert-particle droplet-particle)
  (chemical-formula . c<s>)
  (density (constant . 2000))
  (specific-heat (polynomial piecewise-polynomial (273 1000 -464.17822 4.9711663 -0.0038992118 1.4829381e-06 -2.8855555e-10) (1000 5000 1031.5207 1.150554 -0.00046290062 8.9357071e-08 -6.372102e-12)) (constant . 1220))
  (boiling-point (constant . 4827))
  (molecular-weight (constant . 12.01115))
  (formation-enthalpy (constant . -101.268))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.5731747e+04))
  (species-phase (constant . 1))
  )
 
 (carbon-dioxide
  (fluid inert-particle)
  (chemical-formula . co2)
  (density (constant . 1.7878))
  (specific-heat (polynomial piecewise-polynomial (300 1000 429.92889 1.8744735 -0.001966485 1.2972514e-06 -3.9999562e-10) (1000 5000 841.37645 0.59323928 -0.00024151675 4.5227279e-08 -3.1531301e-12)) (constant . 840.37) (polynomial piecewise-linear (300 . 846) (600 . 1075) (1000 . 1234) (1500 . 1326) (2000 . 1371) (2500 . 1397)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 9.340018e+06 -1.183478e+05 1.001642e+03 4.729915e-01 -4.014079e-05 -1.453110e-07 5.384310e-11) (1000.000000 6000.000000 2.223584e+07 -3.379484e+05 1.566476e+03 -1.742787e-02 9.199934e-07 -3.574572e-10 1.196020e-13) (6000.000000 20000.000000 -2.917762e+11 1.921053e+08 -4.839069e+04 6.365554e+00 -4.120742e-04 1.320833e-08 -1.670510e-13) ))
  (thermal-conductivity (constant . 0.0145))
  (viscosity (constant . 1.37e-05) (sutherland 1.37e-05 273.11 222.22) (power-law 1.37e-05 273.11 0.79) (blottner-curve-fit -0.026654 1.107305 -14.291274))
  (molecular-weight (constant . 44.00995))
  (characteristic-vibrational-temperature (vibrational-modes 945 2  1903 1 3329 1))
  (absorption-coefficient (constant . 0.43) (polynomial piecewise-linear (550 . 0.46) (890 . 0.54) (1220 . 0.54) (1550 . 0.43)))
  (formation-enthalpy (constant . -3.9353235e+08))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 3.941))
  (lennard-jones-energy (constant . 195.2))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 0.2137202E+06))
  ; Critical Properties from Polling et al. 
  (critical-pressure (constant . 7.3740e6))
  (critical-temperature (constant . 304.12))
  (acentric-factor (constant . 0.225))
  (critical-volume (constant . 0.002137))
  )
    
 (carbon-disulfide-vapor
  fluid
  (chemical-formula . cs2)
  (density (constant . 3.222))
  (specific-heat (polynomial piecewise-polynomial (300 1000 389.41982 0.91453598 -0.00074645397 2.2835908e-07 -7.3569664e-12) (1000 5000 647.60796 0.19804873 -8.1813978e-05 1.5789037e-08 -1.1276333e-12)) (constant . 690.1) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.761644e+06 -5.076616e+04 6.876853e+02 2.063266e-01 3.300868e-05 -1.896700e-07 8.508530e-11) (1000.000000 6000.000000 -1.518283e+08 3.663491e+05 3.296913e+02 3.140937e-01 -9.911448e-05 1.500440e-08 -7.643177e-13) ))
  (thermal-conductivity (constant . 0.00992))
  (viscosity (constant . 1e-05))
  (molecular-weight (constant . 76.13914))
  (formation-enthalpy (constant . 1.1695176e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant . 237899.19))
 ; Critical Properties from Somayajulu (1989)
  (critical-pressure (constant . 7.3000e6))
  (critical-temperature (constant . 552.00))
  (critical-volume (constant . 0.002272))
  (acentric-factor (constant . 1.09000E-01))
  )
 
 (carbon-monoxide
  fluid
  (chemical-formula . co)
  (density (constant . 1.1233))
  (specific-heat (polynomial piecewise-polynomial (300 1000 968.38986 0.44878771 -0.0011522171 1.6568822e-06 -7.34637e-10) (1000 5000 897.93053 0.42823161 -0.00016713923 3.0234435e-08 -2.05137e-12)) (constant . 1043) (polynomial piecewise-linear (300 . 1040) (600 . 1087) (1000 . 1185) (1500 . 1257) (2000 . 1294) (2500 . 1315)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 4.420005e+06 -8.674362e+04 1.699239e+03 -2.426991e+00 4.324597e-03 -3.228810e-06 8.987985e-10) (1000.000000 6000.000000 1.371144e+08 -5.772574e+05 1.756288e+03 -1.681362e-01 4.152183e-05 -5.306476e-09 2.855838e-13) (6000.000000 20000.000000 2.632527e+11 -2.226373e+08 7.407437e+04 -1.174383e+01 9.788934e-04 -3.913499e-08 5.933543e-13) ))
  (thermal-conductivity (constant . 0.025))
  (viscosity (constant . 1.75e-05) (sutherland 1.657e-05 273.11 136.11) (power-law 1.657e-05 273.11 0.71) (blottner-curve-fit -0.014044 0.887198 -13.269815))
  (molecular-weight (constant . 28.01055))
  (characteristic-vibrational-temperature (constant . 3074))
  (absorption-coefficient (constant . 0.17) (polynomial piecewise-linear (550 . 0.21) (890 . 0.35) (1220 . 0.28) (1550 . 0.17)))
  (formation-enthalpy (constant . -1.1053956e+08))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 197531.64))
  ; Critical Properties from Polling et al. 
  (critical-pressure (constant . 3.4940e6))
  (critical-temperature (constant . 132.85))
  (acentric-factor (constant . 0.045))
  (critical-volume (constant . 0.003324))
   ) 

 (carbon-monoxide+
  fluid
  (chemical-formula . co+)
  (density (constant . 1.1233))
  (specific-heat (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -7541386.39795697 44610.53642066543 1304.5915568949772 -1.1878370398183093 0.0028361901259570566 -2.2373342450443987e-06 6.243280477007041e-10) (1000.000000 6000.000000 80193181.71968246 -366083.9001682554 1576.3698060261984 0.15560402566948156 -8.616959460942181e-05 1.8232686103154125e-08 -1.1386017938750255e-12) (6000.000000 20000.000000 -105071326131.67824 82833062.25750025 -24350.273183403053 3.944336378555426 -0.00028781364876474103 9.912163938046934e-09 -1.3164283256129193e-13)))
  (viscosity (blottner-curve-fit -0.014044 0.887198 -13.269815))
  (molecular-weight (constant . 28.01055))
  (characteristic-vibrational-temperature (constant . 3074))
  (formation-enthalpy (constant . 1247790876.0))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 178348.0))
   )
 
 (carbon-monoxide-air
  mixture
  (chemical-formula . #f)
  (species (names o2 co2 co h2o n2))
  (reactions (finite-rate ("reaction-1" ((co 1 1 1) (o2 0.5 0.25 1)) ((co2 1 0 1) (h2o 0 0.5 1)) ((n2 0 1)) (stoichiometry "1co + 0.5o2 --> 1co2") (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f)) ("reaction-2" ((co2 1 1 1)) ((co 1 0 1) (o2 0.5 0 1)) ((n2 0 1) (h2o 0 1)) (stoichiometry "1co2 --> 1co + 0.5o2") (arrhenius 5e+08 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((co 1 1 1) (o2 0.5 0.25 1)) ((co2 1 0 1) (h2o 0 0.5 1)) ((n2 0 1)) (stoichiometry "1co + 0.5o2 --> 1co2") (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f)) ("reaction-2" ((co2 1 1 1)) ((co 1 0 1) (o2 0.5 0 1)) ((n2 0 1) (h2o 0 1)) (stoichiometry "1co2 --> 1co + 0.5o2") (arrhenius 5e+08 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((co 1 1 1) (o2 0.5 0.25 1)) ((co2 1 0 1) (h2o 0 0.5 1)) ((n2 0 1)) (stoichiometry "1co + 0.5o2 --> 1co2") (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f)) ("reaction-2" ((co2 1 1 1)) ((co 1 0 1) (o2 0.5 0 1)) ((n2 0 1) (h2o 0 1)) (stoichiometry "1co2 --> 1co + 0.5o2") (arrhenius 5e+08 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (carbonyl-sulfide
  fluid
  (chemical-formula . cos)
  (density (constant . 2.548))
  (specific-heat (polynomial piecewise-polynomial (300 1000 395.62161 1.3169429 -0.0012296755 5.8418716e-07 -1.184339e-10) (1000 5000 718.56421 0.34684834 -0.00014177682 2.6903842e-08 -1.8971921e-12)) (constant . 755) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.183027e+07 -1.826138e+05 1.347356e+03 -9.509312e-01 1.497956e-03 -1.066462e-06 2.876762e-10) (1000.000000 6000.000000 2.710816e+07 -2.430371e+05 1.205500e+03 -5.728166e-02 1.404888e-05 -1.604627e-09 7.875025e-14) ))
  (thermal-conductivity (constant . 0.0104))
  (viscosity (constant . 1.2e-05))
  (molecular-weight (constant . 60.07455))
  (formation-enthalpy (constant . -1.3840773e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2315088E+06))
; Critical Properties from Somayajulu (1989)
  (critical-pressure (constant . 6.3490e6))
  (critical-temperature (constant . 375.00))
  (critical-volume (constant . 0.002247))
  (acentric-factor (constant . 1.05000E-01))
  )


 (trioxy-methylene 
  fluid
  (chemical-formula . <ch2o>3)
  (specific-heat (polynomial piecewise-polynomial (300 1500 -430.32925 5.6225014 -0.0043478275 1.8172432e-06 -3.2889011e-10) (1500 4000 1766.3259 0.79175398 -8.1981463e-05 -3.29956e-08 6.0965497e-12)))
  (molecular-weight (constant . 90.07947))
  (formation-enthalpy (constant . -4.632312e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2903348E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.823E+06))
  (critical-temperature (constant . 581.86))
  (acentric-factor (constant . 0.324))
  (critical-volume (constant . 0.002193))
  )

 (dimethyl-silene
  fluid
  (chemical-formula . <ch3>2sich2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 233.53779 5.0780789 -0.0038817222 1.7098653e-06 -3.2607373e-10) (1500 2500 1782.8752 1.2275145 -1.4217656e-05 -1.489732e-07 2.91267e-11)))
  (molecular-weight (constant . 72.18321))
  (formation-enthalpy (constant . 51745116))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3448529E+06))
  )

  (chloro-methylidene
   fluid
   (chemical-formula . ccl)
   (specific-heat (polynomial piecewise-polynomial (300 1500 502.99302 0.82492693 -0.00098604635 5.4068421e-07 -1.1175479e-10) (1500 4000 754.28781 0.031826127 -1.2584852e-05 2.3726536e-09 -1.7560513e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.625947e+06 2.690925e+03 3.799865e+02 1.338181e+00 -1.918923e-03 1.342002e-06 -3.692139e-10) (1000.000000 6000.000000 -2.970602e+07 3.855632e+04 7.358545e+02 4.079625e-02 -9.398934e-06 1.295296e-09 -4.733226e-14) ))
   (molecular-weight (constant . 47.46415))
   (formation-enthalpy (constant . 4.4394458e+08))
   (reference-temperature (constant . 298))
   (formation-entropy (constant .  0.2194834E+06))
   )

 (dichloro-methylene 
  fluid
  (chemical-formula . ccl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 333.86645 1.1158893 -0.0013796451 7.7474117e-07 -1.6285012e-10) (1500 4000 665.05327 0.035685419 -1.5117062e-05 3.1247463e-09 -2.5534445e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 7.482443e+06 -1.030273e+05 8.032771e+02 1.708603e-01 -5.061847e-04 4.502893e-07 -1.405144e-10) (1000.000000 6000.000000 1.957911e+08 -7.217666e+05 1.647201e+03 -6.051075e-01 1.907766e-04 -2.599784e-08 1.286165e-12) ))
  (molecular-weight (constant . 82.91714))
  (formation-enthalpy (constant . 2.2184682e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2648089E+06))
  )

 (trichloro-acetyl-radical
  fluid
  (chemical-formula . ccl2cclo)
  (specific-heat (polynomial piecewise-polynomial (300 1500 287.75239 1.6168935 -0.0017681669 9.1190533e-07 -1.8224109e-10) (1500 4000 850.50357 0.051143229 -2.1096933e-05 3.1823103e-09 -1.3587389e-13)))
  (molecular-weight (constant . 146.38069))
  (formation-enthalpy (constant . -1.0154989e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3555398E+06))
  )

 (trichloro-acetic-acid 
  fluid
  (chemical-formula . ccl2ccloh)
  (specific-heat (polynomial piecewise-polynomial (300 1500 259.60995 1.9229608 -0.0021644375 1.1960658e-06 -2.5538059e-10) (1500 5000 884.10624 0.12516277 -2.4963209e-05 3.5323007e-10 2.0722609e-13)))
  (molecular-weight (constant . 147.38867))
  (formation-enthalpy (constant . -1.8700856e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3468087E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 4.609E+06))
  (critical-temperature (constant . 623.30))
  (acentric-factor (constant . 0.379))
  (critical-volume (constant . 0.002022))
  )

 (ccl2ch-1,1-dichlorinated-vinyl-radical
  fluid
  (chemical-formula . ccl2ch)
  (specific-heat (polynomial piecewise-polynomial (300 1500 256.67956 2.1054644 -0.002367177 1.2940719e-06 -2.7411911e-10) (1500 4000 954.37771 0.1182527 -3.0306842e-05 9.5978839e-10 3.3316701e-13)))
  (molecular-weight (constant . 95.93627))
  (formation-enthalpy (constant . 2.6064923e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3009895E+06))
  )

 (ccl2hoo-1,1-dichloro-peroxymethyl-radical 
  fluid
  (chemical-formula . ccl2hoo)
  (specific-heat (polynomial piecewise-polynomial (300 1500 245.67907 1.9691696 -0.0021329032 1.1392317e-06 -2.3735999e-10) (1500 5000 913.71978 0.11990473 -2.3525466e-05 6.6264475e-10 1.5663725e-13)))
  (molecular-weight (constant . 115.92392))
  (formation-enthalpy (constant . -5555787))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3312878E+06))
  )

 (ccl2ohch2-1,1-dichloro-dimethylether-radical 
  fluid
  (chemical-formula . ccl2ohch2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 209.47595 3.2558431 -0.0039239521 2.2569048e-06 -4.9026101e-10) (1500 5000 1172.0571 0.20841455 -4.0598784e-05 1.5004388e-09 2.0950565e-13)))
  (molecular-weight (constant . 113.95161))
  (formation-enthalpy (constant . -94580496))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3374032E+06))
  )

 (ccl2ohchcl-1,1,2-trichloro-dimethylether-radical 
  fluid
  (chemical-formula . ccl2ohchcl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 307.43945 2.0839771 -0.0024603972 1.4015163e-06 -3.0355082e-10) (1500 5000 942.09317 0.13633921 -2.6430066e-05 8.9382683e-10 1.4831662e-13)))
  (molecular-weight (constant . 148.39664))
  (formation-enthalpy (constant . -1.319863e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3728504E+06))
 )

 (trichloro-methyl-radical 
  fluid
  (chemical-formula . ccl3)
  (specific-heat (polynomial piecewise-polynomial (300 1500 301.52856 1.1817059 -0.0014360042 7.9779128e-07 -1.6657401e-10) (1500 4000 658.562 0.040200116 -1.5750643e-05 2.9772457e-09 -2.230009e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.398397e+06 -3.897011e+04 4.808454e+02 8.724113e-01 -1.430759e-03 1.092250e-06 -3.209319e-10) (1000.000000 6000.000000 1.689342e+08 -5.629802e+05 1.321398e+03 -3.597315e-01 1.030452e-04 -1.416674e-08 7.460420e-13) ))
  (molecular-weight (constant . 118.37015))
  (formation-enthalpy (constant . 69380016))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3021137E+06))
  )

 (ccl3cclh2-1,1,1,2-tetrachloro-ethane
  fluid
  (chemical-formula . ccl3cclh2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 171.56236 2.0530991 -0.0021899361 1.1494548e-06 -2.3640352e-10) (1500 5000 885.97951 0.11299933 -2.3511926e-05 9.7219239e-10 1.2144655e-13)))
  (molecular-weight (constant . 167.85023))
  (formation-enthalpy (constant . -1.4761859e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3581497E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 4.194E+06))
  (critical-temperature (constant . 605.28))
  (acentric-factor (constant . 0.247))
  (critical-volume (constant . 0.001978))
  )

 (tetrachloro-athanal
  fluid
  (chemical-formula . ccl3cclo)
  (specific-heat (polynomial piecewise-polynomial (300 1500 289.62955 1.5826193 -0.0019084646 1.062962e-06 -2.2324987e-10) (1500 4000 771.56315 0.061357243 -2.0827751e-05 3.2822905e-09 -1.9884147e-13)))
  (molecular-weight (constant . 181.83369))
  (formation-enthalpy (constant . -2.3629574e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3784148E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 4.099E+06))
  (critical-temperature (constant . 671.82))
  (acentric-factor (constant . 0.342))
  (critical-volume (constant . 0.001853))
  )

 (ccl3ch2-1,1,2-trichloroethyl-radical 
  fluid
  (chemical-formula . ccl3ch2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 314.50289 1.9034849 -0.002168819 1.2252283e-06 -2.6663207e-10) (1500 5000 922.03388 0.13832286 -2.4872516e-05 1.4564712e-10 2.2956103e-13)))
  (molecular-weight (constant . 132.39723))
  (formation-enthalpy (constant . 79038704))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3464605E+06))
  )

 (ccl3chcl-1,1,2,2-tetrachloroethyl-radical 
  fluid
  (chemical-formula . ccl3chcl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 287.13729 1.7110254 -0.0020750584 1.1772381e-06 -2.5186775e-10) (1500 5000 802.41849 0.07959529 -2.0281705e-05 2.0721192e-09 -5.5097693e-14)))
  (molecular-weight (constant . 166.84227))
  (formation-enthalpy (constant . 46412032))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3725494E+06))
  )

 (trichloro-ethanal
  fluid
  (chemical-formula . ccl3cho)
  (specific-heat (polynomial piecewise-polynomial (300 1500 283.00636 1.670838 -0.0017714854 9.4016992e-07 -1.9640392e-10) (1500 5000 864.29227 0.10798348 -2.0436441e-05 3.1175886e-10 1.7014692e-13)))
  (molecular-weight (constant . 147.38867))
  (formation-enthalpy (constant . -1.9026451e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3558463E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 4.411E+06))
  (critical-temperature (constant . 614.14))
  (acentric-factor (constant . 0.316))
  (critical-volume (constant . 0.002042))
  )

 (ccl3oo-1,1,1-trichloro-peroxymethyl-radical 
  fluid
  (chemical-formula . ccl3oo)
  (specific-heat (polynomial piecewise-polynomial (300 1500 238.72282 1.9277405 -0.00237046 1.3115207e-06 -2.7114942e-10) (1500 5000 814.60263 0.046142517 -2.0059967e-05 3.9264385e-09 -2.8563759e-13)))
  (molecular-weight (constant . 150.36894))
  (formation-enthalpy (constant . -2951438))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3492341E+06))
  )
 
 (carbon-tetrachloride 
  fluid
  (chemical-formula . ccl4)
  (specific-heat (polynomial piecewise-polynomial (300 1500 276.04595 1.298565 -0.001611049 9.0715905e-07 -1.9108494e-10) (1500 4000 660.8148 0.040215647 -1.6981067e-05 3.5130005e-09 -2.8811063e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 5.910048e+06 -1.006317e+05 7.835660e+02 2.134805e-01 -5.463679e-04 4.673137e-07 -1.428273e-10) (1000.000000 6000.000000 -1.644867e+07 -1.171955e+04 7.114055e+02 -3.476199e-03 7.656475e-07 -8.752993e-11 4.045293e-15) ))
  (molecular-weight (constant . 153.82315)) 
  (formation-enthalpy (constant . -84593416))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3301985E+06))
  ; Critical Properties from Somayajulu (1989)
  (critical-pressure (constant . 4.5600e6))
  (critical-temperature (constant . 556.40))
  (critical-volume (constant . 1.794270E-003))
  (acentric-factor (constant . 1.93000E-01))
  )

 (cclh2oo-1-chloro-peroxymethyl-radical 
  fluid
  (chemical-formula . cclh2oo)
  (specific-heat (polynomial piecewise-polynomial (300 1500 161.58903 2.8014799 -0.00286042 1.52207e-06 -3.2375337e-10) (1500 5000 1154.4629 0.23782571 -3.6188239e-05 -2.1062536e-09 6.279802e-13)))
  (molecular-weight (constant . 81.47889))
  (formation-enthalpy (constant . 5299922.5))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2999355E+06))
  )

 (methylidene-radical
  fluid
  (chemical-formula . ch)
  (specific-heat (polynomial piecewise-polynomial (300 1000 2043.7301 1.3237904 -0.0032789777 3.6618073e-06 -1.2488529e-09) (1000 5000 1402.5637 1.4946266 -0.00045075462 5.7524702e-08 -2.4619263e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.418183e+07 -2.174872e+05 3.532670e+03 -3.700963e+00 5.089769e-03 -2.852162e-06 6.128719e-10) (1000.000000 6000.000000 1.316106e+09 -3.446287e+06 5.017426e+03 -5.087404e-01 1.126769e-04 -1.262211e-08 3.212638e-13) (6000.000000 20000.000000 -5.152872e+11 2.922116e+08 -6.286865e+04 7.888899e+00 -5.419343e-04 1.941762e-08 -2.810266e-13) ))
  (molecular-weight (constant . 13.01912))
  (characteristic-vibrational-temperature (constant . 4112)) ; NIST webbook
  (viscosity (blottner-curve-fit -0.007273 0.7602 -12.8753))  ; ref Svehla 1963
  (lennard-jones-length (constant . 3.370)) ; Svehla 1963
  (lennard-jones-energy (constant . 68.6))
  (formation-enthalpy (constant . 5.9414662e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1829184E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.), acentric factor missing     
  (critical-pressure (constant . 9.84e+06))
  (critical-temperature (constant . 252.59))
  (critical-volume (constant . 0.0045))  
  )

 (methylidene+ 
  fluid
  (chemical-formula . ch+)
  (specific-heat (polynomial piecewise-polynomial (300 1000 2124.9276 0.86029658 -0.0024880996 3.2758953e-06 -1.3121586e-09) (1000 5000 1758.4377 0.99176266 -0.00034285733 5.6979077e-08 -3.4594511e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 1.928555e+07 -2.949504e+05 3.976181e+03 -4.966175e+00 6.990263e-03 -4.263487e-06 9.996793e-10) (1000.000000 6000.000000 -4.535953e+09 1.167730e+07 -8.383874e+03 3.954515e+00 -1.858183e-04 -7.244169e-08 7.063541e-12) (6000.000000 20000.000000 -2.018269e+11 9.175891e+07 -7.079395e+03 9.978057e-02 3.147721e-05 -1.850168e-09 3.182057e-14) ))
  (molecular-weight (constant . 13.01858))
  (formation-enthalpy (constant . 1.6268113e+09))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1715576E+06))
  )

 (triplet-methylene-radical 
  fluid
  (chemical-formula . ch2)
  (specific-heat (polynomial piecewise-polynomial (250 1000 2230.0077 0.68746476 0.00014756628 5.2165591e-07 -4.346187e-10) (1000 4000 2155.4238 1.145789 -9.9995258e-05 -5.9860219e-08 1.0718151e-11)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.090040e+07 -1.996229e+05 2.672742e+03 1.494401e+00 -3.148480e-03 3.944388e-06 -1.547161e-09) (1000.000000 6000.000000 1.488088e+09 -4.714817e+06 7.343354e+03 -1.052698e+00 1.907164e-04 -1.819116e-08 7.142235e-13) ))
  (molecular-weight (constant . 14.02709))
  (formation-enthalpy (constant . 3.8696787e+08))
  (viscosity (blottner-curve-fit -0.01252 0.8606 -13.5495)) ; assume same as CH4
  (characteristic-vibrational-temperature (constant . 1385)) ; ref NIST webbook
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1954691E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 8.28E+06))
  (critical-temperature (constant . 226.50))
  (acentric-factor (constant . 0.030))  
  (critical-volume (constant . 0.0053))  
  )

 (singlet-methylene-radical 
  fluid
  (chemical-formula . ch2<s>)
  (specific-heat (polynomial piecewise-polynomial (300 1000 2353.9058 -0.10071081 0.00060777149 1.4774203e-06 -1.1743647e-09) (1000 4000 2105.9192 1.2250565 -0.00011345626 -6.5477796e-08 1.1981232e-11)))
  (molecular-weight (constant . 14.02709))
  (formation-enthalpy (constant . 4.2470074e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1886993E+06))
  )

 (vinyl-chloride-radical 
  fluid
  (chemical-formula . ch2ccl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 210.00784 3.0330138 -0.0032003951 1.7892169e-06 -3.9641687e-10) (1500 5000 1232.8346 0.31585674 -4.6869661e-05 -4.8470837e-09 1.1025611e-12)))
  (molecular-weight (constant . 61.49124))
  (formation-enthalpy (constant . 2.5688723e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2684440E+06))
  )

 (vinylidene-chloride 
  fluid
  (chemical-formula . ch2ccl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 130.97607 2.5590135 -0.0027196644 1.4823296e-06 -3.1815395e-10) (1500 5000 1002.9701 0.20891992 -3.2016142e-05 -1.2173467e-09 4.459167e-13)))
  (molecular-weight (constant . 96.94424))
  (formation-enthalpy (constant . 2981161.7))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2877202E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.19E+06))
  (critical-temperature (constant . 513.88))
  (acentric-factor (constant . 0.218))
  (critical-volume (constant . 0.002259))
  )

 (ch2ccloh-2-chloro-ethyl-alcohol 
  fluid
  (chemical-formula . ch2ccloh)
  (specific-heat (polynomial piecewise-polynomial (300 1500 70.411938 3.9434691 -0.0043587029 2.4436489e-06 -5.3187392e-10) (1500 5000 1342.6051 0.33908184 -5.0722373e-05 -2.2624979e-09 7.4468106e-13)))
  (molecular-weight (constant . 78.49861))
  (formation-enthalpy (constant . -1.5457221e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2901885E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.845E+06))
  (critical-temperature (constant . 554.15))
  (acentric-factor (constant . 0.582))
  (critical-volume (constant . 0.002395))
  )

 (vinyl-acetylene 
  fluid
  (chemical-formula . ch2chcch)
  (specific-heat (polynomial piecewise-polynomial (300 1000 516.31149 2.9786028 0.00020281471 -1.5023814e-06 4.7196168e-10) (1000 4000 1707.9672 1.1147228 -0.00010485824 -6.2018772e-08 1.1496767e-11)))
  (molecular-weight (constant . 52.07648))
  (formation-enthalpy (constant . 2.8930304e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2817395E+06))
  ; Critical Properties from http://www.cheric.org/research/kdb/hcprop/cmpsrch.php
  (critical-temperature (constant . 455.00))
  (critical-pressure (constant . 4.960000E+006))
  (critical-volume (constant . 3.878976E-003))
  (acentric-factor (constant . 9.20000E-02))
  )

 (ch2chcch2-1,3-butadien-2-yl-radical
  fluid
  (chemical-formula . ch2chcch2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 607.61688 3.1288353 0.00029332328 -1.4576995e-06 3.7372489e-10) (1000 4000 1879.1467 1.2515228 -0.00012683744 -7.1557676e-08 1.3527543e-11)))
  (molecular-weight (constant . 53.08445))
  (formation-enthalpy (constant . 3.102033e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3151407E+06))
  )

 (allyl-radical 
  fluid
  (chemical-formula . ch2chch2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 460.82195 4.0193155 0.00022749586 -2.053774e-06 6.9662015e-10) (1000 4000 1953.7309 1.6347177 -0.00016124159 -9.4142589e-08 1.7415354e-11)))
  (molecular-weight (constant . 41.0733))
  (formation-enthalpy (constant . 1.616783e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2708757E+06))
  )
 
 (ch2chchch-1,3-butadien-1-yl-radical 
  fluid
  (chemical-formula . ch2chchch)
  (specific-heat (polynomial piecewise-polynomial (300 1000 469.12879 3.5842892 0.00030940769 -1.7984368e-06 5.0085832e-10) (1000 4000 2015.1298 1.2441285 -0.00013511182 -7.2918779e-08 1.4019689e-11)))
  (molecular-weight (constant . 53.08445))
  (formation-enthalpy (constant . 3.6022214e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3057331E+06))
  )

 (ch2chchch2-1,3-butadiene 
fluid
	(chemical-formula . ch2chchch2)
	(specific-heat (polynomial piecewise-polynomial (300 1000 296.90257 3.8104225 0.0004638962 -1.7748232e-06 3.9757995e-10) (1000 4000 1928.1466 1.4750452 -0.00014121006 -8.3456927e-08 1.5453061e-11)))
	(molecular-weight (constant . 54.09242))
	(formation-enthalpy (constant . 1.1835909e+08))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2947443E+06))
; Critical Properties from Polling et al. 
    (critical-pressure (constant . 4.3200e6))
    (critical-temperature (constant . 425.00))
    (acentric-factor (constant . 0.195))
    (critical-volume (constant . 0.004086))
  )

 (chloro-ethylene
  fluid
  (chemical-formula . ch2chcl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 14.873229 3.7200265 -0.0036271706 1.9465877e-06 -4.2624155e-10) (1500 5000 1369.9809 0.40480371 -5.1634566e-05 -6.5525332e-09 1.3370579e-12)))
  (molecular-weight (constant . 62.49921))
  (formation-enthalpy (constant . 19534808))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2635565E+06))
; Critical Properties from Somayajulu (1989)
  (critical-pressure (constant . 5.6700e6))
  (critical-temperature (constant . 432.00))
  (critical-volume (constant . 0.002805))
  (acentric-factor (constant . 1.22000E-01))   
  )
 
 (chloro-methyl-radical 
  fluid
  (chemical-formula . ch2cl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 406.62966 2.1900167 -0.0022794818 1.3167329e-06 -3.0255104e-10) (1500 5000 1146.4147 0.27889358 -3.487572e-05 -4.6940618e-09 9.2571413e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -5.358396e+06 1.064264e+05 -1.956312e+02 3.630695e+00 -4.277458e-03 2.846451e-06 -7.830906e-10) (1000.000000 6000.000000 2.793492e+08 -1.082348e+06 2.284909e+03 -1.916490e-01 3.508130e-05 -3.448624e-09 1.407416e-13) ))
  (molecular-weight (constant . 49.48009))
  (formation-enthalpy (constant . 1.132857e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2480393E+06))
  )
 
 (methylene-chloride 
  fluid
  (chemical-formula . ch2cl2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 139.32933 2.0720563 -0.0021321918 1.3175127e-06 -3.7313307e-10) (1000 5000 579.26384 0.66198995 -0.00026197714 4.7543483e-08 -3.2470784e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -2.456928e+06 8.504708e+04 -4.987381e+02 4.062697e+00 -5.090320e-03 3.373407e-06 -9.075152e-10) (1000.000000 6000.000000 1.497102e+08 -6.830151e+05 1.658506e+03 -1.238442e-01 2.295444e-05 -2.284146e-09 9.430183e-14) ))
  (molecular-weight (constant . 84.93309))
  (formation-enthalpy (constant . -95528256))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2701781E+06))
; Critical Properties from Polling et al. dichloromethane only critical pressure and temperature available 
  (critical-pressure (constant . 6.100e6))
  (critical-temperature (constant . 510.00))
  )
 
 (ch2clccl2-1,2,2-trichloro-ethyl-radical 
  fluid
  (chemical-formula . ch2clccl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 210.44976 2.0708614 -0.0022633425 1.241809e-06 -2.6587749e-10) (1500 5000 903.13965 0.14943731 -2.617078e-05 -1.5354947e-10 2.8256625e-13)))
  (molecular-weight (constant . 132.39723))
  (formation-enthalpy (constant . 25307314))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3486473E+06))
  )
 
 (ch2clcclo-1,2-dichloro-acetaldehyde 
  fluid
  (chemical-formula . ch2clcclo)
  (specific-heat (polynomial piecewise-polynomial (300 1500 199.20162 2.3631344 -0.0024717893 1.3356034e-06 -2.8636284e-10) (1500 5000 1024.7404 0.19063344 -3.0490511e-05 -1.2096181e-09 4.5914929e-13)))
  (molecular-weight (constant . 112.94363))
  (formation-enthalpy (constant . -2.4392904e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3267942E+06))
; Critical Properties from Cranium Ver 1.0.3
  (critical-pressure (constant . 4.952E+06))
  (critical-temperature (constant . 573.49))
  (acentric-factor (constant . 0.364))
  (critical-volume (constant . 0.002240))
  )
 
 (chloro-ethyl-radical 
  fluid
  (chemical-formula . ch2clch2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 214.16684 3.5089109 -0.0032617606 1.7664147e-06 -3.9885612e-10) (1500 5000 1527.8474 0.46538295 -5.3994419e-05 -9.5258589e-09 1.7238924e-12)))
  (molecular-weight (constant . 63.50718))
  (formation-enthalpy (constant . 96657624))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2906413E+06))
  )
 
 (ch2clch2cl-1,2-dichloro-ethane 
  fluid
  (chemical-formula . ch2clch2cl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 -20.47075 3.3880488 -0.0033245482 1.7427183e-06 -3.7073388e-10) (1500 5000 1212.486 0.32235403 -4.4521649e-05 -4.3398257e-09 9.894148e-13)))
  (molecular-weight (constant . 98.96017))
  (formation-enthalpy (constant . -1.3527378e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3031464E+06))
  ; Critical Properties from Somayajulu (1989)
  (critical-pressure (constant . 5.3700e6))
  (critical-temperature (constant . 561.00))
  (critical-volume (constant . 0.002274))
  (acentric-factor (constant . 2.78000E-01))
  )
 
 (ch2clchcl-1,2-dichloro-ethyl-radical 
  fluid
  (chemical-formula . ch2clchcl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 193.20622 2.5561245 -0.0025869059 1.4046887e-06 -3.0669402e-10) (1500 5000 1099.7203 0.25478808 -3.5354551e-05 -3.3180683e-09 7.6742215e-13)))
  (molecular-weight (constant . 97.95221))
  (formation-enthalpy (constant . 54987572))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3213467E+06))
  )

 (ch2clchcl2-1,2,2-trichloro-ethane 
  fluid
  (chemical-formula . ch2clchcl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 77.22005 2.5854736 -0.0026105341 1.3482004e-06 -2.7842372e-10) (1500 5000 1008.8622 0.18994346 -3.1233623e-05 -9.951272e-10 4.4297039e-13)))
  (molecular-weight (constant . 133.40521))
  (formation-enthalpy (constant . -1.4736477e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3352563E+06))
  ; Critical Properties from Somayajulu (1989)
  (critical-pressure (constant . 4.5610e6))
  (critical-temperature (constant . 606.00))
  (critical-volume (constant . 0.002139))
  (acentric-factor (constant . 2.17000E-01)); same as 1,1,1-trichloro-ethane 
  )
 
 (chloro-acetaldehyde 
  fluid
  (chemical-formula . ch2clcho)
  (specific-heat (polynomial piecewise-polynomial (300 1500 69.407465 3.1341327 -0.0027909721 1.4060966e-06 -3.0062304e-10) (1500 5000 1300.6139 0.35174824 -4.3497044e-05 -6.5666718e-09 1.2610415e-12)))
  (molecular-weight (constant . 78.49861))
  (formation-enthalpy (constant . -1.7433203e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3098046E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.370E+06))
  (critical-temperature (constant . 513.93))
  (acentric-factor (constant . 0.338))
  (critical-volume (constant . 0.002764))
  )
 
 (ketene 
  fluid
  (chemical-formula . ch2co)
  (specific-heat (polynomial piecewise-polynomial (300 1000 588.39919 2.396878 -0.00046381057 -1.2790018e-06 7.7247182e-10) (1000 5000 1194.3767 1.1481 -0.0003799323 5.5270208e-08 -2.8853953e-12)))
  (molecular-weight (constant . 42.03764))
  (formation-enthalpy (constant . -51876036))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2417871E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.813E+06))
  (critical-temperature (constant . 384.31))
  (acentric-factor (constant . 0.180))
  (critical-volume (constant . 0.003140))
  )
 
 (difluoro-methane 
  fluid
  (chemical-formula . ch2f2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 58.644048 3.4663139 -0.0039026085 3.1041558e-06 -1.115263e-09) (1000 5000 755.94621 1.2781103 -0.0005091865 9.271281e-08 -6.3414482e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -2.908633e+07 5.073437e+05 -2.739760e+03 1.024675e+01 -1.168872e-02 7.074329e-06 -1.764236e-09) (1000.000000 6000.000000 2.471719e+08 -1.258869e+06 2.826849e+03 -2.527083e-01 4.904283e-05 -5.087030e-09 2.179274e-13) ))
  (molecular-weight (constant . 52.02389))
  (formation-enthalpy (constant . -4.5069382e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2465198E+06))
  ; Critical Properties from Polling et al. 
  (critical-pressure (constant . 5.8050e6))
  (critical-temperature (constant . 351.26))
  (acentric-factor (constant . 0.278))
  (critical-volume (constant . 0.002326))
  )

 (vinoxy-radical
  fluid
  (chemical-formula . ch2hco)
  (specific-heat (polynomial piecewise-polynomial (300 1000 658.4667 2.0741757 0.00036534524 -1.3826937e-06 5.5384078e-10) (1000 5000 1154.2118 1.570439 -0.00052993612 7.8618687e-08 -4.2030176e-12)))
  (molecular-weight (constant . 43.04561))
  (formation-enthalpy (constant . 25092572))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2677823E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 5.71E+06))
  (critical-temperature (constant . 502.68))
  (acentric-factor (constant . 0.330))  
  (critical-volume (constant . 0.0034))  
  )
 
 (formaldehyde
  fluid
  (chemical-formula . ch2o)
  (specific-heat (polynomial piecewise-polynomial (300 1000 457.64151 3.4976475 -0.0052283402 5.6765396e-06 -2.3296268e-09) (1000 5000 829.4838 1.850059 -0.00072795781 1.3117184e-07 -8.8954654e-12)))
  (molecular-weight (constant . 30.02649))
  (formation-enthalpy (constant . -1.1591482e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2185936E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 7.027E+06))
  (critical-temperature (constant . 340.98))
  (acentric-factor (constant . 0.218))
  (critical-volume (constant . 0.003197))
  )
 
 (hydroxymethyl-radical
  fluid
  (chemical-formula . ch2oh)
  (specific-heat (polynomial piecewise-polynomial (250 1000 766.91719 2.6831585 -0.00014160035 -1.376649e-06 6.0172942e-10) (1000 4000 1695.1849 0.9666797 -8.5771585e-05 -5.1940409e-08 9.402732e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -2.205796e+07 3.484340e+05 -1.116238e+03 8.128386e+00 -9.130388e-03 5.837745e-06 -1.552499e-09) (1000.000000 6000.000000 6.774494e+08 -2.474456e+06 4.589150e+03 -3.511719e-01 5.723935e-05 -5.012709e-09 1.835147e-13) ))
  (molecular-weight (constant . 31.03446))
  (formation-enthalpy (constant . -17173850))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2463322E+06))
 ; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)    
  (critical-pressure (constant . 7.58E+06))
  (critical-temperature (constant . 467.74))
  (acentric-factor (constant . 0.210))  
  (critical-volume (constant . 0.0033)) 
  )

 (ch2ohccl2
  fluid
  (chemical-formula . ch2ohccl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 140.30489 3.033985 -0.0032304742 1.7095523e-06 -3.5401057e-10) (1500 5000 1169.0121 0.20768052 -3.6293767e-05 -1.5814527e-10 3.8277135e-13)))
  (molecular-weight (constant . 113.95161))
  (formation-enthalpy (constant . -97127488))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3458574E+06))
  )

 (ch2ohchcl 
  fluid
  (chemical-formula . ch2ohchcl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 36.660551 4.4054492 -0.0046993982 2.5601731e-06 -5.4761232e-10) (1500 5000 1512.4548 0.37327922 -5.6670015e-05 -2.9930988e-09 9.3286077e-13)))
  (molecular-weight (constant . 79.50658))
  (formation-enthalpy (constant . -70242736))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3135742E+06))
  )

 (chloro-silenyl-radical
  fluid
  (chemical-formula . ch2sicl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 376.67532 2.1003895 -0.0023016705 1.3013097e-06 -2.8848389e-10) (1500 4000 1062.8964 0.2032671 -3.5418261e-05 -4.16151e-09 1.1674848e-12)))
  (molecular-weight (constant . 77.56609))
  (formation-enthalpy (constant . 1.910832e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2900975E+06))
  )
 
 (methylene-trichloro-silane
  fluid
  (chemical-formula . ch2sicl3)
  (specific-heat (polynomial piecewise-polynomial (300 1500 376.21317 1.5190731 -0.001774355 1.0133872e-06 -2.2057614e-10) (1500 4000 826.68475 0.1282104 -2.3230418e-05 -8.546519e-10 4.3257809e-13)))
  (molecular-weight (constant . 148.47208))
  (formation-enthalpy (constant . -3.6698838e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3847133E+06))
  )

 (methylene-chloro-silane 
  fluid
  (chemical-formula . ch2sih2cl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 253.4804 3.1635631 -0.0031752059 1.6847648e-06 -3.578929e-10) (1500 4000 1316.9725 0.36236935 -4.812575e-05 -1.0184385e-08 2.1706581e-12)))
  (molecular-weight (constant . 79.58203))
  (formation-enthalpy (constant . -3652073.3))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3176928E+06))
  )
 
 (methylene-dichloro-silane 
  fluid
  (chemical-formula . ch2sihcl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 304.85728 2.1916655 -0.0023980238 1.3285386e-06 -2.8624431e-10) (1500 4000 995.36391 0.21211329 -3.2966409e-05 -3.8461371e-09 1.0130293e-12)))
  (molecular-weight (constant . 114.02706))
  (formation-enthalpy (constant . -1.8688853e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3560080E+06))
  )
 
 (methyl-radical 
  fluid
  (chemical-formula . ch3)
  (specific-heat (polynomial piecewise-polynomial (300 1000 1344.0266 6.1515906 -0.0092915621 8.9686603e-06 -3.2432996e-09) (1000 5000 1572.7509 3.3942798 -0.0012333736 2.0931818e-07 -1.356036e-11)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.591212e+07 2.817696e+05 1.100925e+02 7.543075e+00 -7.933476e-03 5.607498e-06 -1.674804e-09) (1000.000000 6000.000000 1.526850e+09 -5.163351e+06 8.227352e+03 -7.959296e-01 1.351552e-04 -1.229843e-08 4.640762e-13) ))
  (molecular-weight (constant . 15.03506))
  (viscosity (blottner-curve-fit -0.01252 0.8606 -13.5495)) ; assume same as CH4
  (characteristic-vibrational-temperature (constant . 867)) ; ref NIST webbook
  (formation-enthalpy (constant . 1.4568613e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1940331E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)    
  (critical-pressure (constant . 7.07E+06))
  (critical-temperature (constant . 93.76))
  (acentric-factor (constant . 0.060))  
  (critical-volume (constant . 0.0055))  
  )
 
 (acetyl-chloride 
  fluid
  (chemical-formula . ch3c<o>cl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 240.97363 2.6675554 -0.0022797784 1.1481462e-06 -2.5093768e-10) (1500 5000 1313.9725 0.3400462 -3.9582848e-05 -7.1383746e-09 1.2912577e-12)))
  (molecular-weight (constant . 78.49861))
  (formation-enthalpy (constant . -2.3792258e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3007539E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.742E+06))
  (critical-temperature (constant . 527.50))
  (acentric-factor (constant . 0.335))
  (critical-volume (constant . 0.002599))
  )

 (ch3cc-1-propyn-1-yl-radical 
  fluid
  (chemical-formula . ch3cc)
  (specific-heat (polynomial piecewise-polynomial (300 1000 808.65955 1.8624575 0.00053708688 -3.2556543e-07 -3.0027351e-10) (1000 4000 1626.4129 1.1140938 -0.00010757931 -6.2154676e-08 1.1592539e-11)))
  (molecular-weight (constant . 39.05736))
  (formation-enthalpy (constant . 5.1807302e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2522127E+06))
  )
 
 (ch3ccch2-2-butyn-3-yl-radical 
  fluid
  (chemical-formula . ch3ccch2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 793.84484 2.461746 0.00046501504 -7.8164944e-07 -4.674034e-11) (1000 4000 1811.3747 1.2577435 -0.00011980934 -7.0113598e-08 1.3020624e-11)))
  (molecular-weight (constant . 53.08445))
  (formation-enthalpy (constant . 3.1105206e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3362251E+06))
  )
 
 (ch3ccch3-1,3-butadiyne 
  fluid
  (chemical-formula . ch3ccch3)
  (specific-heat (polynomial piecewise-polynomial (300 1000 626.67627 2.6178592 0.00072357034 -5.7904794e-07 -3.1770486e-10) (1000 4000 1742.5028 1.545921 -0.00014619492 -8.7005325e-08 1.613071e-11)))
  (molecular-weight (constant . 54.09242))
  (formation-enthalpy (constant . 1.7128421e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3069682E+06))
;; critical properties from http://www.cheric.org/research/kdb/hcprop/cmpsrch.php
  (critical-temperature (constant . 4.25000E+02)) 
  (critical-pressure (constant . 4.320000E+006))
  (critical-volume (constant . 4.085677E-003))
  (acentric-factor (constant . 1.95000E-01))
  )
 
 (ch3cch2-1-propen-2-yl-radical 
  fluid
  (chemical-formula . ch3cch2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 685.37919 2.8431538 0.00064860146 -7.7410472e-07 -1.8327208e-10) (1000 4000 1842.2907 1.6121615 -0.00015961248 -9.2347874e-08 1.7265418e-11)))
  (molecular-weight (constant . 41.0733))
  (formation-enthalpy (constant . 2.5560206e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2897443E+06))
  )

 (methyl-chloro-carbene
  fluid
  (chemical-formula . ch3ccl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 224.47631 2.8792537 -0.0025162371 1.2902708e-06 -2.8396558e-10) (1500 5000 1362.1883 0.36811255 -4.295378e-05 -7.6526792e-09 1.3880866e-12)))
  (molecular-weight (constant . 62.49921))
  (formation-enthalpy (constant . 2.5830765e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2837481E+06))
  )

 (ch3ccl2-1,1-dichloro-ethyl-radical 
fluid
	(chemical-formula . ch3ccl2)
	(specific-heat (polynomial piecewise-polynomial (300 1500 272.76463 2.1962078 -0.0020541287 1.0812363e-06 -2.3669072e-10) (1500 5000 1103.4902 0.24959299 -3.1800516e-05 -4.2785782e-09 8.5419044e-13)))
	(molecular-weight (constant . 97.95221))
	(formation-enthalpy (constant . 43585772))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.3191390E+06))
	)

 (ch3ccl3-1,1,1-trichloro-ethane 
fluid
	(chemical-formula . ch3ccl3)
	(specific-heat (polynomial piecewise-polynomial (300 1500 154.83532 2.4365386 -0.0025014571 1.315147e-06 -2.753605e-10) (1500 5000 1020.3431 0.1829221 -3.0140536e-05 -9.0664063e-10 4.1954553e-13)))
	(molecular-weight (constant . 133.40521))
	(formation-enthalpy (constant . -1.4020472e+08))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.3205676E+06))
    ; Critical Properties from Somayajulu (1989)
    (critical-pressure (constant . 4.3000e6))
    (critical-temperature (constant . 545.00))
    (critical-volume (constant . 0.002139))
    (acentric-factor (constant . 2.17000E-01))
	)

 (acetyl-chloride 
fluid
	(chemical-formula . ch3cclo)
	(specific-heat (polynomial piecewise-polynomial (300 1500 241.21565 2.6668977 -0.0022789438 1.147636e-06 -2.5081979e-10) (1500 5000 1314.0018 0.34002184 -3.9574799e-05 -7.1390581e-09 1.291214e-12)))
	(molecular-weight (constant . 78.49861))
	(formation-enthalpy (constant . -2.3791302e+08))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.3007280E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-pressure (constant . 5.742E+06))
    (critical-temperature (constant . 527.50))
    (acentric-factor (constant . 0.335))
    (critical-volume (constant . 0.002599))
	)

 (ch3ch2cch-1-butyne
fluid
	(chemical-formula . ch3ch2cch)
	(specific-heat (polynomial piecewise-polynomial (300 1000 572.71586 3.1563442 0.00046441386 -1.2499098e-06 1.683513e-10) (1000 4000 1845.5418 1.4719011 -0.00013825899 -8.253727e-08 1.526944e-11)))
	(molecular-weight (constant . 54.09242))
	(formation-enthalpy (constant . 1.8724376e+08))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2989102E+06))
	; Critical Properties from Polling et al. 
    (critical-pressure (constant . 4.6000e6))
    (critical-temperature (constant . 440.0))
    (acentric-factor (constant . 0.245))
    (critical-volume (constant . 0.003845))
	)

 (chloro-ethane
fluid
	(chemical-formula . ch3ch2cl)
	(specific-heat (polynomial piecewise-polynomial (300 1500 -89.978682 4.597852 -0.0041629724 2.177486e-06 -4.8038163e-10) (1500 5000 1676.8059 0.57335381 -6.7020692e-05 -1.1752955e-08 2.1378198e-12)))
	(molecular-weight (constant . 64.51515))
	(formation-enthalpy (constant . -1.1338516e+08))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2775690E+06))
	; Critical Properties from Polling et al. 
    (critical-pressure (constant . 5.3000e6))
    (critical-temperature (constant . 460.30))
    (critical-volume (constant . 0.003085))
    (acentric-factor (constant . 1.91000E-01))   
	)

 (ethyl-oxide-radical
fluid
	(chemical-formula . ch3ch2o)
	(specific-heat (polynomial piecewise-polynomial (300 1500 127.39673 5.4456445 -0.0041424803 1.8665112e-06 -3.7715839e-10) (1500 4000 2190.3542 0.99458946 -9.2073798e-05 -4.42749e-08 7.8517732e-12)))
	(molecular-weight (constant . 45.06155))
	(formation-enthalpy (constant . -1851907))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2753714E+06))
	)

 (ch3chch-1-propen-1-yl-radical 
fluid
	(chemical-formula . ch3chch)
	(specific-heat (polynomial piecewise-polynomial (300 1000 640.04609 3.0730418 0.00055113938 -1.0479867e-06 1.100248e-11) (1000 4000 1864.3037 1.5933853 -0.00015636509 -9.1038595e-08 1.695785e-11)))
	(molecular-weight (constant . 41.0733))
	(formation-enthalpy (constant . 2.7091674e+08))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2876191E+06))
	)

 (ethylidene-chloride-radical 
fluid
	(chemical-formula . ch3chcl)
	(specific-heat (polynomial piecewise-polynomial (300 1500 249.21531 3.1920734 -0.0027005825 1.3987225e-06 -3.1610033e-10) (1500 5000 1526.9046 0.46336195 -5.0514353e-05 -1.0718224e-08 1.8427586e-12)))
	(molecular-weight (constant . 63.50718))
	(formation-enthalpy (constant . 76577832))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2907230E+06))
	)

 (ethylidene-chloride 
fluid
	(chemical-formula . ch3chcl2)
	(specific-heat (polynomial piecewise-polynomial (300 1500 37.898091 3.2639776 -0.0032202988 1.7051274e-06 -3.6611186e-10) (1500 5000 1221.8688 0.31694399 -4.3598967e-05 -4.3193684e-09 9.7718193e-13)))
	(molecular-weight (constant . 98.96017))
	(formation-enthalpy (constant . -1.3396416e+08))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.3056482E+06))
; Critical Properties from Polling et al. 
    (critical-pressure (constant . 5.1000e6))
    (critical-temperature (constant . 523.00))
    (critical-volume (constant . 0.002385))
    (acentric-factor (constant . 2.40000E-01))  
	)

 (ch3choh-1-hydroxy-ethyl-radical 
fluid
	(chemical-formula . ch3choh)
	(specific-heat (polynomial piecewise-polynomial (300 1500 267.23378 5.4178441 -0.0044801683 2.1683216e-06 -4.5133853e-10) (1500 4000 2191.4633 0.97633499 -9.1661385e-05 -4.1575756e-08 7.3864615e-12)))
	(molecular-weight (constant . 44.05358))
	(formation-enthalpy (constant . -59278944))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2835783E+06))
	)

 (methyl-chloride
fluid
	(chemical-formula . ch3cl)
	(specific-heat (polynomial piecewise-polynomial (300 1000 76.113156 3.4059755 -0.0042044823 3.557584e-06 -1.2691533e-09) (1000 5000 598.42409 1.4268846 -0.00055066644 9.7986341e-08 -6.5894803e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.620825e+07 3.266854e+05 -1.786026e+03 7.868602e+00 -9.083209e-03 5.774134e-06 -1.521045e-09) (1000.000000 6000.000000 4.154123e+08 -1.696447e+06 3.100567e+03 -3.083415e-01 5.720233e-05 -5.696437e-09 2.353348e-13) ))
	(molecular-weight (constant . 50.48806))
	(formation-enthalpy (constant . -83695744))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2342032E+06))	
    ; Critical Properties from Somayajulu (1989)
    (critical-pressure (constant . 6.6790e6))
    (critical-temperature (constant . 416.25))
    (critical-volume (constant . 0.002753))
    (acentric-factor (constant . 1.53000E-01))
	)

 (vinoxy-radical 
fluid
	(chemical-formula . ch3co)
	(specific-heat (polynomial piecewise-polynomial (300 1000 603.65325 1.8886814 0.00087332606 -1.7401942e-06 6.1687237e-10) (1000 5000 1084.0221 1.6321112 -0.00055128378 8.1865021e-08 -4.3814626e-12)))
	(molecular-weight (constant . 43.04561))
	(formation-enthalpy (constant . -22608908))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2666908E+06))
	)

 (methyl-fluoride
fluid
	(chemical-formula . ch3f)
	(specific-heat (polynomial piecewise-polynomial (300 1000 63.539966 4.8879019 -0.0065046653 6.2569267e-06 -2.4271681e-09) (1000 5000 736.55602 2.2754977 -0.00088233385 1.5741961e-07 -1.0601584e-11)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -4.959000e+07 8.422074e+05 -4.321778e+03 1.452473e+01 -1.580552e-02 9.428842e-06 -2.351838e-09) (1000.000000 6000.000000 6.258877e+08 -2.653296e+06 4.713768e+03 -5.059544e-01 9.599216e-05 -9.759044e-09 4.108030e-13) ))
	(molecular-weight (constant . 34.03346))
	(formation-enthalpy (constant . -2.3433398e+08))
	(reference-temperature (constant . 298))
; Critical Properties from Polling et al. 
    (critical-pressure (constant . 5.54800e6))
    (critical-temperature (constant . 315.0))
    (acentric-factor (constant . 0.204))
    (critical-volume (constant . 0.003329))
	)

 (acetaldehyde
fluid
	(chemical-formula . ch3hco)
	(specific-heat (polynomial piecewise-polynomial (300 1000 472.90596 2.5233351 0.00088174908 -2.1291663e-06 8.0467324e-10) (1000 5000 1107.6046 2.0372235 -0.00068802976 1.0215921e-07 -5.4672842e-12)))
	(molecular-weight (constant . 44.05358))
	(formation-enthalpy (constant . -1.6532021e+08))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2637914E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-pressure (constant . 5.548E+06))
    (critical-temperature (constant . 466.29))
    (acentric-factor (constant . 0.274))
    (critical-volume (constant . 0.003814))
	)

 (nitroso-methyl
fluid
	(chemical-formula . ch3no)
	(specific-heat (polynomial piecewise-polynomial (300 1500 389.48561 2.8018116 -0.0013054117 2.7885008e-07 -2.9612678e-11) (1500 4000 1628.2224 0.68414938 -5.3435241e-05 -3.5034331e-08 5.9763204e-12)))
	(molecular-weight (constant . 45.04116))
	(formation-enthalpy (constant . 79289320))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2655634E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-pressure (constant . 7.798E+06))
    (critical-temperature (constant . 537.10))
    (acentric-factor (constant . 0.429))
    (critical-volume (constant . 0.003130))
	)

 (nitro-methane 
fluid
	(chemical-formula . ch3no2)
	(specific-heat (polynomial piecewise-polynomial (300 1500 43.923885 3.6301979 -0.0026296352 1.0573472e-06 -1.9052334e-10) (1500 4000 1484.9051 0.58929672 -5.7256552e-05 -2.5785524e-08 4.6549034e-12)))
	(molecular-weight (constant . 61.04056))
	(formation-enthalpy (constant . -70450376))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.3013956E+06))
; Critical Properties from Polling et al.
    (critical-pressure (constant . 5.8700e6))
    (critical-temperature (constant . 588.0))
    (critical-volume (constant . 0.002834))
    (acentric-factor (constant . 3.10000E-01))
	)

 (methoxy-radical 
fluid
	(chemical-formula . ch3o)
	(specific-heat (polynomial piecewise-polynomial (300 1000 564.26615 1.9333741 0.0014302124 -1.976518e-06 5.5606983e-10) (1000 3000 1010.2223 2.1088268 -0.00071166302 1.0567394e-07 -5.6598397e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -7.581013e+06 1.811636e+05 -6.106241e+02 6.492520e+00 -5.919199e-03 3.296592e-06 -8.317905e-10) (1000.000000 6000.000000 5.960123e+08 -2.604292e+06 5.043464e+03 -5.255226e-01 1.015606e-04 -1.062203e-08 4.802066e-13) ))
	(molecular-weight (constant . 31.03446))
	(formation-enthalpy (constant . 16297127))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2284662E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)    
  (critical-pressure (constant . 7.01E+06))
  (critical-temperature (constant . 338.30))
  (acentric-factor (constant . 0.090))  
  (critical-volume (constant . 0.0032))    
	)

 (dimethyl-ether 
fluid
	(chemical-formula . ch3och3)
	(specific-heat (polynomial piecewise-polynomial (300 1500 303.98992 5.8129874 -0.0020181301 7.4907138e-08 4.6608593e-11) (1500 4000 2998.0412 1.6382988 -0.00011539252 -8.8772103e-08 1.485361e-11)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -4.860498e+07 7.761927e+05 -3.885360e+03 1.467641e+01 -1.497213e-02 8.666568e-06 -2.145389e-09) (1000.000000 6000.000000 8.904164e+08 -3.759587e+06 6.549746e+03 -7.414815e-01 1.426389e-04 -1.467583e-08 6.241410e-13) ))
	(molecular-weight (constant . 34.05837))
	(formation-enthalpy (constant . -1.8293966e+08))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2692607E+06))
 ; Critical Properties from Polling et al.
    (critical-pressure (constant . 5.4000e6))
    (critical-temperature (constant . 400.10))
    (critical-volume (constant . 0.004991))
    (acentric-factor (constant . 2.00000E-01))
	)

 (chloro-methanol
fluid
	(chemical-formula . ch3ocl)
	(specific-heat (polynomial piecewise-polynomial (300 1500 197.00472 2.8207073 -0.0025668571 1.3446906e-06 -2.9651392e-10) (1500 5000 1278.6718 0.34764825 -4.1661851e-05 -6.8001086e-09 1.2665177e-12)))
	(molecular-weight (constant . 66.48746))
	(formation-enthalpy (constant . -58503952))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2737274E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-pressure (constant . 6.146E+06))
    (critical-temperature (constant . 454.00))
    (acentric-factor (constant . 0.254))
    (critical-volume (constant . 0.002467))
	)

 (methyl-nitrite
fluid
	(chemical-formula . ch3ono)
	(specific-heat (polynomial piecewise-polynomial (300 1500 203.00005 3.6033467 -0.0028772079 1.2823362e-06 -2.4670426e-10) (1500 4000 1547.5222 0.56654531 -5.6468211e-05 -2.3089518e-08 4.1254386e-12)))
	(molecular-weight (constant . 61.04056))
	(formation-enthalpy (constant . -63815412))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2798102E+06))
; Critical Properties from Cranium Ver. 1.0.3, the software was unable to compute the critical volume 
    (critical-pressure (constant . 5.495E+06))
    (critical-temperature (constant . 476.22))
    (acentric-factor (constant . 0.362))
	)

 (methyl-nitrate 
fluid
	(chemical-formula . ch3ono2)
	(specific-heat (polynomial piecewise-polynomial (300 1500 84.215695 3.72786 -0.0030459239 1.3299544e-06 -2.4845514e-10) (1500 4000 1549.9695 0.44380328 -5.5181298e-05 -1.6149906e-08 3.2507918e-12)))
	(molecular-weight (constant . 77.03996))
	(formation-enthalpy (constant . -1.0902098e+08))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2997188E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-pressure (constant . 5.933E+06))
    (critical-temperature (constant . 606.71))
    (acentric-factor (constant . 0.407))
    (critical-volume (constant . 0.002505))
	)

 (methyl-chloro-silylene
fluid
	(chemical-formula . ch3sicl)
	(specific-heat (polynomial piecewise-polynomial (300 1500 368.78112 1.9397876 -0.0016646109 8.3131807e-07 -1.7681165e-10) (1500 4000 1060.2497 0.3278398 -3.4109826e-05 -1.293755e-08 2.3860933e-12)))
	(molecular-weight (constant . 78.57406))
	(formation-enthalpy (constant . -10189357))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.3039371E+06))
	)

 (methyl-silylidene-silane 
fluid
	(chemical-formula . ch3sih2sih)
	(specific-heat (polynomial piecewise-polynomial (300 1500 229.60035 4.9701163 -0.0039434613 1.8121686e-06 -3.6671274e-10) (1500 4000 2120.3897 0.81224446 -8.1599359e-05 -3.4085606e-08 6.2133788e-12)))
	(molecular-weight (constant . 90.274))
	(formation-enthalpy (constant . -41694128))
	(reference-temperature (constant . 298))
     (formation-entropy (constant .  0.3835629E+06))
	)

 (ch3sih2sih2ch3-1,2-dimethyl-disilane 
fluid
	(chemical-formula . ch3sih2sih2ch3)
	(specific-heat (polynomial piecewise-polynomial (300 1500 288.22984 4.6206496 -0.0032438581 1.247321e-06 -2.0946924e-10) (1500 2500 1794.4354 1.1007589 -2.4435864e-05 -1.3718673e-07 2.8089942e-11)))
	(molecular-weight (constant . 90.274))
	(formation-enthalpy (constant . -45134892))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3791314E+06))
	)

 (methyl-dichloro-silane
fluid
	(chemical-formula . ch3sihcl2)
	(specific-heat (polynomial piecewise-polynomial (300 1500 300.45012 2.1640133 -0.0020221973 1.0348775e-06 -2.175644e-10) (1500 4000 1054.7808 0.28951387 -3.4811235e-05 -9.6587464e-09 1.9140122e-12)))
	(molecular-weight (constant . 115.03503))
	(formation-enthalpy (constant . -3.9221494e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3369609E+06))
   ; Critical Properties from Smith (1994) acentric factor & critical volume missing
    (critical-pressure (constant . 3.9300e6))
    (critical-temperature (constant . 490.00))
    )

 (chloro-methylene
  fluid
  (chemical-formula . chcl)
  (specific-heat (polynomial piecewise-polynomial (300 1200 477.06513 1.3388443 -0.0018245655 1.8275323e-06 -6.7184138e-10) (1200 5000 551.72385 1.0252193 -0.00050056038 1.0142127e-07 -7.3721921e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -2.318597e+06 8.654230e+04 -2.123888e+02 3.634165e+00 -5.387367e-03 4.198547e-06 -1.246100e-09) (1000.000000 6000.000000 1.621453e+09 -4.758048e+06 5.669737e+03 -1.799521e+00 3.753897e-04 -3.960338e-08 1.673836e-12) ))
  (molecular-weight (constant . 48.47212))
  (formation-enthalpy (constant . 3.3473962e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2348036E+06))
  )
 
 (dichloro-methyl-radical 
  fluid
  (chemical-formula . chcl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 278.3648 1.283865 -0.0013794226 7.46315e-07 -1.5736525e-10) (1500 4000 684.84845 0.12400734 -1.9547067e-05 -2.1336612e-09 5.7991116e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 5.586197e+06 -6.501516e+04 6.012463e+02 9.653640e-01 -1.263468e-03 8.472970e-07 -2.210860e-10) (1000.000000 6000.000000 8.767228e+07 -3.494221e+05 1.175356e+03 -4.955935e-02 6.076928e-06 -1.867959e-10 -1.222744e-14) ))
  (molecular-weight (constant . 83.92512))
  (formation-enthalpy (constant . 81637936))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2723230E+06))
  )
 
 (chcl2ccl2-1,1,2,2-tetrachloro-ethyl-radical
  fluid
  (chemical-formula . chcl2ccl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 209.6581 1.7130677 -0.0018948753 1.0099124e-06 -2.0751256e-10) (1500 4000 762.77222 0.10668218 -2.3022859e-05 4.1357634e-10 2.6097464e-13)))
  (molecular-weight (constant . 166.84227))
  (formation-enthalpy (constant . 35701080))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3880801E+06))
  )
 
 (dichloro-methyl-chloroformate-radical 
  fluid
  (chemical-formula . chcl2cclo)
  (specific-heat (polynomial piecewise-polynomial (300 1500 259.14562 1.7594327 -0.0018834359 9.9454933e-07 -2.0481294e-10) (1500 4000 839.83239 0.13108209 -2.4627586e-05 -9.4820599e-10 4.8588206e-13)))
  (molecular-weight (constant . 147.38867))
  (formation-enthalpy (constant . -2.4207262e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3565954E+06))
  )
 
 (chcl2ch2-1,1-dichloroethyl-radical
  fluid
  (chemical-formula . chcl2ch2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 189.70087 2.6762191 -0.0028078739 1.5492759e-06 -3.3903094e-10) (1500 5000 1109.0901 0.25161638 -3.6529653e-05 -2.6934036e-09 6.9984094e-13)))
  (molecular-weight (constant . 97.95221))
  (formation-enthalpy (constant . 84667920))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3347201E+06))
  )
 
 (chcl2chcl-1,1,2-trichloro-ethyl-radical 
  fluid
  (chemical-formula . chcl2chcl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 237.94946 2.0367657 -0.0022597002 1.2517627e-06 -2.6924718e-10) (1500 5000 907.46947 0.14673189 -2.5948989e-05 -3.2930153e-11 2.6405331e-13)))
  (molecular-weight (constant . 132.39723))
  (formation-enthalpy (constant . 43316232))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3495548E+06))
  )

 (chcl2chcl2-1,1,2,2-tetrachloro-ethane 
  fluid
  (chemical-formula . chcl2chcl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 134.32438 2.1999555 -0.0024301323 1.303976e-06 -2.7076882e-10) (1500 5000 864.79861 0.12305196 -2.5400197e-05 1.1228965e-09 1.1749193e-13)))
  (molecular-weight (constant . 167.85023))
  (formation-enthalpy (constant . -1.5071216e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3573223E+06))
  ; Critical Properties from Somayajulu (1989)  acentric factor missing
  (critical-pressure (constant . 4.0790e6))
  (critical-temperature (constant . 626.00))
  (critical-volume (constant . 0.001968)) 
  )
 
 (chclccl-1,2-dichloro-vinyl-radical 
  fluid
  (chemical-formula . chclccl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 227.50743 2.0512866 -0.0022387711 1.1989045e-06 -2.4873877e-10) (1500 4000 890.61234 0.15019415 -2.7396276e-05 -7.0662455e-10 4.717201e-13)))
  (molecular-weight (constant . 95.93627))
  (formation-enthalpy (constant . 2.3423395e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3029362E+06))
  )

 (chclccloh-1,2-dichloro-vinyl-alcohol 
  fluid
  (chemical-formula . chclccloh)
  (specific-heat (polynomial piecewise-polynomial (300 1500 148.7424 2.8054519 -0.0031508276 1.7253918e-06 -3.6327029e-10) (1500 5000 1039.5947 0.19020367 -3.3692828e-05 3.8395169e-10 2.5922026e-13)))
  (molecular-weight (constant . 112.94363))
  (formation-enthalpy (constant . -1.8206998e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3197616E+06))
; Critical Properties from Cranium Ver. 1.0.3.
  (critical-pressure (constant . 5.611E+06))
  (critical-temperature (constant . 609.57))
  (acentric-factor (constant . 0.636))
  (critical-volume (constant . 0.002100))
  )

 (chloro-vinyl-radical 
  fluid
  (chemical-formula . chclch)
  (specific-heat (polynomial piecewise-polynomial (300 1500 160.91853 3.2894307 -0.0034559644 1.8593762e-06 -3.9777249e-10) (1500 5000 1341.9608 0.21878728 -4.0506297e-05 -1.3140445e-10 4.4575185e-13)))
  (molecular-weight (constant . 61.49124))
  (formation-enthalpy (constant . 2.7117517e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2698262E+06))
  )

 (chclchcl-1,2-dichloro-ethylene
  fluid
  (chemical-formula . chclchcl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 90.424543 2.6386576 -0.0027895202 1.5124113e-06 -3.2371197e-10) (1500 5000 997.99267 0.21114963 -3.3452469e-05 -1.3050537e-09 5.0204325e-13)))
  (molecular-weight (constant . 96.94424))
  (formation-enthalpy (constant . -4826126))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2895037E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.188E+06))
  (critical-temperature (constant . 513.05))
  (acentric-factor (constant . 0.231))
  (critical-volume (constant . 0.002352))
  )

 (chclchoh-1-chloro-ethenol 
  fluid
  (chemical-formula . chclchoh)
  (specific-heat (polynomial piecewise-polynomial (300 1500 -21.960795 4.0968931 -0.0043474356 2.3420914e-06 -4.9575059e-10) (1500 5000 1361.5253 0.32915962 -5.1239845e-05 -2.2122424e-09 7.8305782e-13)))
  (molecular-weight (constant . 78.49861))
  (formation-enthalpy (constant . -1.6135474e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2892813E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.890E+06))
  (critical-temperature (constant . 554.35))
  (acentric-factor (constant . 0.636))
  (critical-volume (constant . 0.002510))
  )

 (chloro-hydroxy-methyl-radical 
  fluid
  (chemical-formula . chcloh)
  (specific-heat (polynomial piecewise-polynomial (300 1500 167.52885 3.0551983 -0.0032507252 1.7227346e-06 -3.5712449e-10) (1500 5000 1197.0528 0.21873461 -3.6984446e-05 -4.7817272e-10 4.2593685e-13)))
  (molecular-weight (constant . 65.47949))
  (formation-enthalpy (constant . -69665712))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2737187E+06))
  )

 (chclohch2 
  fluid
  (chemical-formula . chclohch2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 154.11703 3.9363702 -0.0040771144 2.208722e-06 -4.7516746e-10) (1500 5000 1504.233 0.37150427 -5.2633754e-05 -4.2365607e-09 1.0469676e-12)))
  (molecular-weight (constant . 79.50658))
  (formation-enthalpy (constant . -63094664))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3192594E+06))
  )

 (chclohchcl  
  fluid
  (chemical-formula . chclohchcl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 191.60471 2.8136102 -0.0029852941 1.5980827e-06 -3.3585806e-10) (1500 5000 1143.5178 0.21670535 -3.5223909e-05 -9.9712269e-10 4.7428617e-13)))
  (molecular-weight (constant . 113.95161))
  (formation-enthalpy (constant . -1.0398328e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3506909E+06))
  )

 (fluoro-methylene 
  fluid
  (chemical-formula . chf)
  (specific-heat (polynomial piecewise-polynomial (300 1000 786.58913 1.2596792 -0.0012910501 1.3705877e-06 -6.2405331e-10) (1000 5000 1101.7775 0.53658291 -0.00016951845 3.6061892e-08 -3.1508023e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.178652e+07 2.268301e+05 -5.125545e+02 4.459898e+00 -5.011027e-03 3.316854e-06 -8.818721e-10) (1000.000000 6000.000000 1.991900e+09 -5.936681e+06 7.190323e+03 -2.013155e+00 3.933684e-04 -4.120925e-08 1.795840e-12) ))
  (molecular-weight (constant . 32.01752))
  (formation-enthalpy (constant . 1.2552322e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2232244E+06))
  )

 (trifluoro-methane
  fluid
  (chemical-formula . chf3)
  (specific-heat (polynomial piecewise-polynomial (300 1000 103.6128 2.7413079 -0.0025219574 1.3234059e-06 -3.4547675e-10) (1000 5000 811.59065 0.74204911 -0.00030587543 5.7109163e-08 -3.9806546e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.300524e+07 2.425297e+05 -1.384931e+03 6.870906e+00 -8.143142e-03 5.002060e-06 -1.250710e-09) (1000.000000 6000.000000 6.752319e+07 -5.615398e+05 1.884342e+03 -8.768405e-02 2.340894e-05 -2.449452e-09 1.065620e-13) ))
  (molecular-weight (constant . 70.01432))
  (formation-enthalpy (constant . -6.9709267e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2595332E+06))
  ; Critical Properties from Polling et al. 
  (critical-pressure (constant . 4.8360e6))
  (critical-temperature (constant . 298.97))
  (acentric-factor (constant . 0.267))
  (critical-volume (constant . 0.001900))
  )

 (chohclccl2-2,2,2-trichloro-ethanol
  fluid
  (chemical-formula . chohclccl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 236.23811 2.1842743 -0.0024430745 1.3304797e-06 -2.7928545e-10) (1500 5000 942.28927 0.13727673 -2.6370188e-05 7.3579265e-10 1.706766e-13)))
  (molecular-weight (constant . 148.39664))
  (formation-enthalpy (constant . -1.332136e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3777105E+06))
  )

 (chloro-silyne 
  fluid
  (chemical-formula . chsicl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 496.93596 1.3750563 -0.0016373865 9.4532117e-07 -2.0663749e-10) (1500 4000 891.11597 0.11861172 -2.1957206e-05 -5.0080215e-10 3.5912977e-13)))
  (molecular-weight (constant . 76.55812))
  (formation-enthalpy (constant . 3.7294678e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2941524E+06))
  )

 (dichloro-methylidene-silene 
  fluid
  (chemical-formula . chsicl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 441.34495 1.2690587 -0.0015850309 9.2997237e-07 -2.0411608e-10) (1500 4000 795.59072 0.08523987 -1.9490612e-05 1.1638715e-09 8.0570962e-14)))
  (molecular-weight (constant . 112.01112))
  (formation-enthalpy (constant . 1.2387992e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3467098E+06))
  )

 (trichloro-methylidene-silane 
  fluid
  (chemical-formula . chsicl3)
  (specific-heat (polynomial piecewise-polynomial (300 1500 415.44982 1.2558458 -0.0015838963 9.2700494e-07 -2.0245287e-10) (1500 4000 766.62674 0.072376539 -1.8722941e-05 1.8564464e-09 -3.080513e-14)))
  (molecular-weight (constant . 147.46411))
  (formation-enthalpy (constant . -1.475707e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3773871E+06))
  )

 (chloro-methylidene-silane 
  fluid
  (chemical-formula . chsih2cl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 303.63801 2.7752205 -0.0029566684 1.6051027e-06 -3.4194422e-10) (1500 4000 1209.2733 0.26197028 -4.0895685e-05 -4.9389786e-09 1.2935889e-12)))
  (molecular-weight (constant . 78.57407))
  (formation-enthalpy (constant . 2.1152107e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3132145E+06))
  )
 
 (chloro-methylidene-silene 
  fluid
  (chemical-formula . chsihcl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 433.69022 1.9830995 -0.0022464246 1.2703211e-06 -2.7659422e-10) (1500 4000 1041.5102 0.1813534 -3.0509477e-05 -2.283251e-09 7.4484017e-13)))
  (molecular-weight (constant . 77.56609))
  (formation-enthalpy (constant . 2.8424214e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3023601E+06))
  )

 (dichloro-methylidene-silane 
  fluid
  (chemical-formula . chsihcl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 357.08224 1.8463464 -0.0021455363 1.2135772e-06 -2.6215887e-10) (1500 4000 917.10537 0.14062507 -2.7127757e-05 -4.0213407e-10 4.2298886e-13)))
  (molecular-weight (constant . 113.01909))
  (formation-enthalpy (constant . 30196334))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3457356E+06))
  )

 (chlorine
  (fluid inert-particle)
  (chemical-formula . cl2)
  (density (constant . 2.95))
  (specific-heat (polynomial piecewise-polynomial (300 1500 333.86645 1.1158893 -0.0013796451 7.7474117e-07 -1.6285012e-10) (1500 4000 665.05327 0.035685419 -1.5117062e-05 3.1247463e-09 -2.5534445e-13)) (constant . 650) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 4.060551e+06 -6.504646e+04 7.279113e+02 -3.505692e-01 3.720747e-04 -2.103243e-07 4.995408e-11) (1000.000000 6000.000000 7.144234e+08 -2.286161e+06 3.347270e+03 -1.700254e+00 5.234423e-04 -7.456100e-08 3.901711e-12) ))
  (thermal-conductivity (constant . 0.00882))
  (viscosity (constant . 1.33e-05))
  (molecular-weight (constant . 70.906))
  (formation-enthalpy (constant . 0))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 222988))
  ;; critical properties from http://www.cheric.org/research/kdb/hcprop/cmpsrch.php
  (critical-temperature (constant . 4.16900E+02))
  (critical-pressure (constant . 7.991000E+006))
  (critical-volume (constant . 1.734691E-003))
  (acentric-factor (constant . 9.00000E-02))
  )
 
 (chloroform
  fluid
  (chemical-formula . chcl3)
  (density (constant . 1489))
  (specific-heat (constant . 967) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.364858e+06 -2.122559e+04 2.036335e+02 1.971443e+00 -2.585663e-03 1.777002e-06 -4.866849e-10) (1000.000000 6000.000000 4.272423e+07 -2.587151e+05 1.052200e+03 1.647746e-02 9.028170e-06 -8.819138e-10 3.657979e-14) ))
  (thermal-conductivity (constant . 0.129))
  (viscosity (constant . 0.00058))
  (formation-enthalpy (constant . -97293144))
  (molecular-weight (constant . 119.3679))
  (formation-entropy (constant . 295564.12))
  (reference-temperature (constant . 298))
  ; Critical Properties from Polling et al. acentric factor from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.5000e6))
  (critical-temperature (constant . 536.50))
  (acentric-factor (constant . 0.218))
  (critical-volume (constant . 0.002011))
  )

 (atomic-chlorine 
  fluid
  (chemical-formula . cl)
  (specific-heat (polynomial piecewise-polynomial (300 1000 558.52068 0.20851114 9.5459664e-05 -5.0865456e-07 2.7223406e-10) (1000 5000 684.84575 -0.084378954 3.0353433e-05 -5.072083e-09 3.22817e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 5.338249e+06 -5.085427e+04 6.438090e+02 5.748396e-01 -1.280029e-03 1.036119e-06 -3.020970e-10) (1000.000000 6000.000000 -3.982043e+07 1.426305e+05 4.992206e+02 3.066076e-02 -6.202860e-06 6.666327e-10 -2.938366e-14) (6000.000000 20000.000000 -1.674421e+10 1.055338e+07 -2.172695e+03 3.887073e-01 -3.110289e-05 1.297850e-09 -1.967719e-14) ))
  (molecular-weight (constant . 35.453))
  (formation-enthalpy (constant . 1.2129325e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1650934E+06))
  )
 
 (chloro-methyl-silene
  fluid
  (chemical-formula . cl<ch3>sich2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 267.63159 3.2570169 -0.0030783911 1.6153916e-06 -3.4595027e-10) (1500 4000 1344.0363 0.50333035 -5.5589361e-05 -1.9165752e-08 3.5714164e-12)))
  (molecular-weight (constant . 92.60115))
  (formation-enthalpy (constant . -54741328))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3329884E+06))
  )

 (tetrachloro-ethylene 
  fluid
  (chemical-formula . cl2cccl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 278.64982 1.392918 -0.0015927181 8.5535463e-07 -1.7512356e-10) (1500 4000 721.96464 0.063643056 -1.7674522e-05 2.2529409e-09 -1.1772301e-13)))
  (molecular-weight (constant . 165.83429))
  (formation-enthalpy (constant . -23723522))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3406392E+06))
   ; Critical Properties from Somayajulu (1989)
  (critical-pressure (constant . 4.6280e6))
  (critical-temperature (constant . 620.20))
  (critical-volume (constant . 0.001827))
  (acentric-factor (constant . 0.213))
  )

 (cl2cchcl-1,1,2-trichloro-ethylene
  fluid
  (chemical-formula . cl2cchcl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 218.8029 1.802674 -0.0019427415 1.0282726e-06 -2.1144454e-10) (1500 4000 808.84993 0.13090333 -2.3821264e-05 -5.7444458e-10 3.8705807e-13)))
  (molecular-weight (constant . 131.38927))
  (formation-enthalpy (constant . -16563802))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3244764E+06))
  ; Critical Properties from Somayajulu (1989)  acentric factor from Cranium ver. 1.0.3
  (critical-pressure (constant . 4.9100e6))
  (critical-temperature (constant . 571.00))
  (acentric-factor (constant . 0.241))
  (critical-volume (constant . 0.001977))
  )

 (dichloro-acetyl-radical
  fluid
  (chemical-formula . cl2ccho)
  (specific-heat (polynomial piecewise-polynomial (300 1500 252.6153 2.0505846 -0.0021119003 1.0920799e-06 -2.2412797e-10) (1500 4000 961.62136 0.16104507 -3.1527877e-05 -2.6673068e-09 9.0641506e-13)))
  (molecular-weight (constant . 111.93567))
  (formation-enthalpy (constant . -52140992))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3245727E+06))
  )

 (cl2choh-1,1-dichloro-methanol 
  fluid
  (chemical-formula . cl2choh)
  (specific-heat (polynomial piecewise-polynomial (300 1500 215.74723 2.1428154 -0.0022935348 1.2592554e-06 -2.7134469e-10) (1500 5000 930.11034 0.18836784 -2.8514296e-05 -1.4946818e-09 4.6635453e-13)))
  (molecular-weight (constant . 100.93249))
  (formation-enthalpy (constant . -2.7786624e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3033938E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 6.028E+06))
  (critical-temperature (constant . 573.23))
  (acentric-factor (constant . 0.616))
  (critical-volume (constant . 0.002051))
  )

 (phosgene 
  fluid
  (chemical-formula . cl2co)
  (specific-heat (polynomial piecewise-polynomial (300 1500 290.84747 1.3720411 -0.0015367633 8.2420542e-07 -1.7015229e-10) (1500 4000 736.715 0.074975723 -1.880785e-05 1.2495657e-09 8.09514e-14)))
  (molecular-weight (constant . 98.91655))
  (formation-enthalpy (constant . -2.205137e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2830230E+06))
  ; Critical Properties from Somayajulu (1989)
  (critical-pressure (constant . 5.5670e6))
  (critical-temperature (constant . 455.00))
  (critical-volume (constant . 0.001921))
  (acentric-factor (constant . 2.05000E-01))
  )

 (dichloro-hydroxy-methyl-radical 
  fluid
  (chemical-formula . cl2coh)
  (specific-heat (polynomial piecewise-polynomial (300 1500 316.2434 1.8344289 -0.0022248148 1.2745979e-06 -2.7502329e-10) (1500 5000 853.87419 0.1095656 -2.2915054e-05 1.3569025e-09 5.3855739e-14)))
  (molecular-weight (constant . 99.92452))
  (formation-enthalpy (constant . -94914416))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3083040E+06))
  )

 (dichloro-methoxy-radical 
  fluid
  (chemical-formula . cl2hco)
  (specific-heat (polynomial piecewise-polynomial (300 1500 186.48193 2.0443683 -0.0022318993 1.200807e-06 -2.5153903e-10) (1500 5000 875.19413 0.12475243 -2.4360032e-05 6.5722506e-10 1.6544996e-13)))
  (molecular-weight (constant . 99.92451))
  (formation-enthalpy (constant . -17253874))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2997843E+06))
  )

 (dimethyl-dichloro-silane
  fluid
  (chemical-formula . cl2si<ch3>2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 383.87126 2.3398073 -0.0019958192 9.9574798e-07 -2.1211784e-10) (1500 4000 1218.1977 0.40233536 -4.1039744e-05 -1.6159337e-08 2.9567004e-12)))
  (molecular-weight (constant . 129.06212))
  (formation-enthalpy (constant . -4.7529696e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3784915E+06))
  ; Critical Properties from Sladkov (2001)  acentric factor missing
  (critical-pressure (constant . 3.4800e6))
  (critical-temperature (constant . 520.40))
  (critical-volume (constant . 0.002711))
  )

 (dichloro-methyl-methylidene-silane
  fluid
  (chemical-formula . cl2si<ch3>ch2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 389.16829 2.3515774 -0.0023025905 1.2376161e-06 -2.6864161e-10) (1500 4000 1165.5139 0.33475454 -3.927574e-05 -1.1153334e-08 2.1786884e-12)))
  (molecular-weight (constant . 128.05415))
  (formation-enthalpy (constant . -2.6855072e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3969497E+06))
  )

 (dichloro-silene 
  fluid
  (chemical-formula . cl2sich2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 302.49514 1.9402576 -0.0021960349 1.2353971e-06 -2.6671356e-10) (1500 4000 873.01202 0.19783617 -3.1126714e-05 -4.0866548e-09 1.0057728e-12)))
  (molecular-weight (constant . 113.01909))
  (formation-enthalpy (constant . -1.4332136e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3142566E+06))
  )

 (dichloro-methyl-silyl-radical 
  fluid
  (chemical-formula . cl2sich3)
  (specific-heat (polynomial piecewise-polynomial (300 1500 384.50427 1.6083678 -0.0014943484 7.7294897e-07 -1.6463066e-10) (1500 4000 937.0301 0.23619948 -2.7522021e-05 -8.1065773e-09 1.5776806e-12)))
  (molecular-weight (constant . 114.02706))
  (formation-enthalpy (constant . -2.2053416e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3420171E+06))
  )

 (dichloro-disilane
  fluid
  (chemical-formula . cl2sisi)
  (specific-heat (polynomial piecewise-polynomial (300 1500 430.28969 0.72334063 -0.00093090658 5.3644393e-07 -1.1468271e-10) (1500 4000 635.06139 0.021745671 -1.0990772e-05 2.6571714e-09 -2.4509585e-13)))
  (molecular-weight (constant . 127.078))
  (formation-enthalpy (constant . 1.3685344e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3342437E+06))
  )

 (trichloro-disilenyl-radical
  fluid
  (chemical-formula . cl2sisicl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 429.16613 0.83340961 -0.001093801 6.1766643e-07 -1.2831563e-10) (1500 4000 667.22938 -0.0009451766 -1.1190937e-05 4.5103788e-09 -5.1363233e-13)))
  (molecular-weight (constant . 162.53099))
  (formation-enthalpy (constant . -1.0214354e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3869093E+06))
  )

 (tetrachloro-disilene
  fluid
  (chemical-formula . cl2sisicl2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 452.53604 0.72131258 -0.00089507575 4.9240335e-07 -1.0151043e-10) (1500 4000 680.54517 0.00035278274 -1.0320522e-05 3.7762736e-09 -4.0479416e-13)))
  (molecular-weight (constant . 197.98399))
  (formation-enthalpy (constant . -4.0040032e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.4269170E+06))
  )

 (trichloro-methoxy-radical
  fluid
  (chemical-formula . cl3co)
  (specific-heat (polynomial piecewise-polynomial (300 1500 281.45508 1.5242099 -0.001840768 1.019204e-06 -2.1242392e-10) (1500 5000 747.79553 0.048010347 -1.6707165e-05 2.6893229e-09 -1.6531233e-13)))
  (molecular-weight (constant . 134.36954))
  (formation-enthalpy (constant . -18281076))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3278662E+06))
  )

 (trichloro-methanol 
  fluid
  (chemical-formula . cl3coh)
  (specific-heat (polynomial piecewise-polynomial (300 1500 262.1953 1.7145628 -0.0020099926 1.1228502e-06 -2.3847682e-10) (1500 5000 789.80018 0.097533667 -2.074324e-05 1.2475805e-09 4.9242835e-14)))
  (molecular-weight (constant . 135.37752))
  (formation-enthalpy (constant . -2.7711789e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3314392E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.792E+06))
  (critical-temperature (constant . 620.89))
  (acentric-factor (constant . 0.605))
  (critical-volume (constant . 0.001817))
  )

 (methyl-trichloro-silane 
  fluid
  (chemical-formula . cl3sich3)
  (specific-heat (polynomial piecewise-polynomial (300 1500 373.11275 1.5153947 -0.0015186347 8.1088932e-07 -1.7334291e-10) (1500 4000 874.92317 0.18765749 -2.4879435e-05 -5.205944e-09 1.1098995e-12)))
  (molecular-weight (constant . 149.48006))
  (formation-enthalpy (constant . -5.7632326e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3568313E+06))
  ; Critical Properties from Sladkov (2001)  acentric factor missing
  (critical-pressure (constant . 3.5100e6))
  (critical-temperature (constant . 517.80))
  (critical-volume (constant . 0.002273))
  )

 (disilicon-trichloride
  fluid
  (chemical-formula . cl3sisi)
  (specific-heat (polynomial piecewise-polynomial (300 1500 431.23717 0.76540944 -0.00099348261 5.7566538e-07 -1.2352043e-10) (1500 4000 646.10039 0.022049717 -1.1501624e-05 2.8509086e-09 -2.6754261e-13)))
  (molecular-weight (constant . 162.53099))
  (formation-enthalpy (constant . -1.0950981e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3741982E+06))
  )

 (trichloro-silylidene-silane
  fluid
  (chemical-formula . cl3sisicl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 408.24759 0.79358351 -0.0010293137 5.9615976e-07 -1.2788166e-10) (1500 4000 631.39434 0.022577088 -1.1710334e-05 2.8932991e-09 -2.7107222e-13)))
  (molecular-weight (constant . 197.98399))
  (formation-enthalpy (constant . -4.165512e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.4321243E+06))
  )

 (dichloro-acetylene 
  fluid
  (chemical-formula . clcccl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 448.32439 1.0892723 -0.0012144077 6.6646421e-07 -1.4153457e-10) (1500 4000 797.49844 0.081296803 -1.7064891e-05 1.3929395e-10 2.1659327e-13)))
  (molecular-weight (constant . 94.9283))
  (formation-enthalpy (constant . 2.3514902e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2689674E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.816E+06))
  (critical-temperature (constant . 540.40))
  (acentric-factor (constant . 0.166))
  (critical-volume (constant . 0.002212))
  )

 (chloro-ketyl-radical 
  fluid
  (chemical-formula . clcco)
  (specific-heat (polynomial piecewise-polynomial (300 1500 486.62825 1.244115 -0.0011164648 5.1349799e-07 -1.0023142e-10) (1500 5000 1032.0518 0.04113326 -1.4177466e-05 1.3290542e-09 1.015712e-14)))
  (molecular-weight (constant . 75.4747))
  (formation-enthalpy (constant . 1.767677e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2881864E+06))
  )

 (chloro-methanol 
  fluid
  (chemical-formula . clch2oh)
  (specific-heat (polynomial piecewise-polynomial (300 1500 104.17906 2.9499578 -0.0026727155 1.3828262e-06 -3.0042326e-10) (1500 5000 1219.274 0.37195057 -4.314871e-05 -7.5156396e-09 1.362788e-12)))
  (molecular-weight (constant . 66.48746))
  (formation-enthalpy (constant . -2.3217394e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2989671E+06))
  )

 (carbonyl-chloride
  fluid
  (chemical-formula . clco)
  (specific-heat (polynomial piecewise-polynomial (300 1500 627.59207 0.41467304 -0.00027488452 1.0092077e-07 -1.7638504e-11) (1500 4000 803.72167 0.070342939 -9.9354368e-06 -1.9842158e-09 4.4229905e-13)))
  (molecular-weight (constant . 63.46355))
  (formation-enthalpy (constant . -27119182))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2694365E+06))
  )

 (chloro-hydroxy-methylene
  fluid
  (chemical-formula . clcoh)
  (specific-heat (polynomial piecewise-polynomial (300 1500 262.77983 2.2353248 -0.0024972634 1.4177578e-06 -3.1303326e-10) (1500 5000 985.64031 0.1944499 -3.4195158e-05 -1.8915864e-09 6.1866877e-13)))
  (molecular-weight (constant . 64.47152))
  (formation-enthalpy (constant . 4713686.5))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2609979E+06))
  )

 (dichloro-methoxy-radical
  fluid
  (chemical-formula . clh2co)
  (specific-heat (polynomial piecewise-polynomial (300 1500 107.13627 2.868269 -0.002815631 1.4795324e-06 -3.158628e-10) (1500 5000 1156.0591 0.27053915 -3.8023837e-05 -3.4710887e-09 8.1742177e-13)))
  (molecular-weight (constant . 65.47949))
  (formation-enthalpy (constant . -9844389))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2695200E+06))
  )


 (formyl-chloride
  fluid
  (chemical-formula . clhco)
  (specific-heat (polynomial piecewise-polynomial (300 1500 306.74911 1.6492498 -0.0014110055 6.5637066e-07 -1.2877502e-10) (1500 4000 919.80563 0.21743247 -2.6234883e-05 -7.4855927e-09 1.4867993e-12)))
  (molecular-weight (constant . 64.47152))
  (formation-enthalpy (constant . -1.8534675e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2585547E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 6.665E+06))
  (critical-temperature (constant . 491.40))
  (acentric-factor (constant . 0.311))
  (critical-volume (constant . 0.002513))
  )

 (chlorine-oxide
  fluid
  (chemical-formula . clo)
  (specific-heat (polynomial piecewise-polynomial (300 1500 471.64039 0.75380753 -0.00091377931 5.0596467e-07 -1.0528547e-10) (1500 4000 698.18247 0.027971237 -1.1566614e-05 2.3021143e-09 -1.8026374e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -2.726564e+06 4.159187e+04 3.516088e+02 1.039398e+00 -1.384598e-03 9.315984e-07 -2.497910e-10) (1000.000000 6000.000000 6.615368e+07 -2.853768e+05 1.145379e+03 -2.954709e-01 1.147951e-04 -1.954238e-08 1.143527e-12) ))
  (molecular-weight (constant . 51.4524))
  (formation-enthalpy (constant . 1.2215573e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2217538E+06))
  )

 (dichlorine-monoxide
  fluid
  (chemical-formula . clocl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 325.07902 1.0333704 -0.0012673129 7.0729306e-07 -1.4796344e-10) (1500 5000 634.79582 0.03142256 -1.1722851e-05 2.0316929e-09 -1.3435839e-13)))
  (molecular-weight (constant . 86.9054))
  (formation-enthalpy (constant . 82449616))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2663357E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 6.776E+06))
  (critical-temperature (constant . 479.50))
  (acentric-factor (constant . 0.265))
  (critical-volume (constant . 0.001818))
  )

 (chlorine-dioxide 
  fluid
  (chemical-formula . cloo)
  (specific-heat (polynomial piecewise-polynomial (300 1500 381.76076 1.34176 -0.001571099 8.5170818e-07 -1.7499448e-10) (1500 4000 801.31804 0.052503196 -1.8138169e-05 2.8499011e-09 -1.672725e-13)))
  (molecular-weight (constant . 67.4518))
  (formation-enthalpy (constant . 1.405744e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2658492E+06))
  )

 (dimethyl-chloro-silyl-radical 
  fluid
  (chemical-formula . clsi<ch3>2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 387.81305 2.7947148 -0.0021692558 1.0265463e-06 -2.1689531e-10) (1500 4000 1422.9568 0.54373383 -5.0603801e-05 -2.3852681e-08 4.2317701e-12)))
  (molecular-weight (constant . 93.60912))
  (formation-enthalpy (constant . -1.0903061e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3548605E+06))
  )

 (dimethyl-methylidene-chloro-silane
  fluid
  (chemical-formula . clsi<ch3>2ch2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 408.09842 3.4841937 -0.002998595 1.5239815e-06 -3.2957387e-10) (1500 4000 1633.8042 0.61936935 -6.12107e-05 -2.5452544e-08 4.6001077e-12)))
  (molecular-weight (constant . 107.63622))
  (formation-enthalpy (constant . -1.549721e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.4035474E+06))
  )

 (trimethyl-chloro-silane
  fluid
  (chemical-formula . clsi<ch3>3)
  (specific-heat (polynomial piecewise-polynomial (300 1500 394.23097 3.471666 -0.0026325948 1.2328446e-06 -2.6105548e-10) (1500 4000 1690.7444 0.69793835 -6.3197673e-05 -3.1323659e-08 5.5127378e-12)))
  (molecular-weight (constant . 108.64418))
  (formation-enthalpy (constant . -3.6016352e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3918870E+06))
  ; Critical Properties from Sladkov (2001)  acentric factor missing
  (critical-pressure (constant . 3.2000e6))
  (critical-temperature (constant . 497.80))
  (critical-volume (constant . 0.003365))
  )

 (methyl-chloro-silylene
fluid
	(chemical-formula . clsich3)
	(specific-heat (polynomial piecewise-polynomial (300 1500 368.85634 1.9393832 -0.0016639212 8.3086941e-07 -1.7671131e-10) (1500 4000 1060.3352 0.32775608 -3.4090383e-05 -1.2931938e-08 2.3845027e-12)))
	(molecular-weight (constant . 78.57407))
	(formation-enthalpy (constant . -11816152))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3039436E+06))
	)

 (disilicon-chloride
 fluid
	(chemical-formula . clsisi)
	(specific-heat (polynomial piecewise-polynomial (300 1500 475.00014 0.52522448 -0.0006821158 3.9531358e-07 -8.481657e-11) (1500 4000 621.34575 0.016735303 -8.8873638e-06 2.2147305e-09 -2.0760415e-13)))
	(molecular-weight (constant . 91.625))
	(formation-enthalpy (constant . 4.1468618e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2989233E+06))
	)

 (dichloro-silyne
 fluid
	(chemical-formula . clsisicl)
	(specific-heat (polynomial piecewise-polynomial (300 1500 459.46726 0.74352595 -0.0010198623 5.8634958e-07 -1.2266055e-10) (1500 4000 659.72925 -0.0079612641 -1.0179573e-05 4.7415972e-09 -5.6483222e-13)))
	(molecular-weight (constant . 127.078))
	(formation-enthalpy (constant . 1.4010614e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3426222E+06))
	)
 
(cyanid-radical
 fluid
	(chemical-formula . cn)
	(specific-heat (polynomial piecewise-polynomial (300 1000 1170.6242 -0.36958378 0.00069134528 5.9253615e-08 -2.625112e-10) (1000 5000 1188.8121 0.048520857 6.3509331e-05 -1.2138186e-08 4.2445294e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.262026e+06 -4.447095e+04 1.575743e+03 -2.014779e+00 4.016462e-03 -3.156801e-06 9.085791e-10) (1000.000000 6000.000000 -7.120011e+08 1.610860e+06 -6.780683e+01 4.329835e-01 4.237292e-05 -2.216857e-08 1.756019e-12) (6000.000000 20000.000000 -5.735611e+10 3.369359e+07 -5.527332e+03 7.014193e-01 -2.719184e-05 2.977931e-10 2.031914e-15) ))
	(molecular-weight (constant . 26.01785))
  (characteristic-vibrational-temperature (constant . 2975)) ; NIST webbook
	(formation-enthalpy (constant . 4.3515917e+08))
  (viscosity (blottner-curve-fit -0.0025 0.681 -12.4914))  ; ref Maciel and Pimenta 2013
  (lennard-jones-length (constant . 3.856))  ; Svehla 1963
  (lennard-jones-energy (constant . 75))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2025420E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 5.96E+06))
  (critical-temperature (constant . 514.23))
  (acentric-factor (constant . 0.100))  
  (critical-volume (constant . 0.0042))       
	)

 (cyanide-radical+
 fluid
	(chemical-formula . cn+)
	(specific-heat (polynomial piecewise-polynomial (300 1000 996.62809 0.4963741 -0.00030320012 4.7280343e-07 -2.9070492e-10) (1000 5000 1182.8752 0.23913176 -5.7208494e-05 7.5621935e-09 -4.5923332e-13)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 -2.653407e+08 2.804495e+06 -9.515179e+03 1.590493e+01 -4.161558e-03 -6.577941e-06 3.601129e-09) (1000.000000 6000.000000 -2.286074e+09 5.935323e+06 -3.465908e+03 1.951548e+00 -3.806814e-04 3.786489e-08 -1.533912e-12) (6000.000000 20000.000000 -5.793810e+10 3.607431e+07 -7.309775e+03 1.113603e+00 -7.061954e-05 2.102760e-09 -2.414903e-14) ))
	(molecular-weight (constant . 26.0173))
  (characteristic-vibrational-temperature (constant . 2975))
  (viscosity (blottner-curve-fit -0.0025 0.681 -12.4914))  ; ref Maciel and Pimenta 2013
  (lennard-jones-length (constant . 3.856))  ; Svehla 1963
  (lennard-jones-energy (constant . 75))
	(formation-enthalpy (constant . 1.802838e+09))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2133132E+06))
	)

 (cyanide-radical-
 fluid
	(chemical-formula . cn-)
	(specific-heat (polynomial piecewise-polynomial (300 1000 1047.8233 0.46789154 -0.0012545455 1.7990613e-06 -7.9042106e-10) (1000 5000 952.68533 0.46807729 -0.00018127583 3.2518763e-08 -2.1956485e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 -1.468221e+07 1.363467e+05 7.502217e+02 -5.793818e-02 1.459220e-03 -1.427801e-06 4.368914e-10) (1000.000000 6000.000000 1.111715e+08 -5.181665e+05 1.790357e+03 -1.260524e-01 2.790339e-05 -3.094907e-09 1.398922e-13) ))
	(molecular-weight (constant . 26.01839))
	(formation-enthalpy (constant . 60666992))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.1958608E+06))
	)

 (methane-tetraylbis-amidogen
fluid
	(chemical-formula . cn2)
	(specific-heat (polynomial piecewise-polynomial (300 1000 631.49455 1.8305474 -0.0015798998 7.3835013e-07 -1.8168361e-10) (1000 5000 1156.4517 0.43633916 -0.00018717637 3.5700046e-08 -2.505766e-12)))
	(molecular-weight (constant . 40.02455))
	(formation-enthalpy (constant . 4.728119e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2260897E+06))
	)

 (cnn 
fluid
	(chemical-formula . cnn)
	(specific-heat (polynomial piecewise-polynomial (300 1000 732.13461 1.5106039 -0.0017184959 1.1692563e-06 -3.4100619e-10) (1000 5000 994.18605 0.53169848 -0.00020838174 3.7540067e-08 -2.5496543e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -2.798352e+05 -2.876765e+04 9.538750e+02 8.926469e-01 -8.861565e-04 6.108620e-07 -1.850958e-10) (1000.000000 6000.000000 1.264143e+08 -5.364653e+05 1.806251e+03 -3.795127e-02 -2.825940e-06 1.781687e-09 -1.206377e-13) ))
	(molecular-weight (constant . 40.02455))
	(formation-enthalpy (constant . 5.8453229e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2316224E+06))
	)

 (isocyanato-radical 
fluid
	(chemical-formula . cno)
	(specific-heat (polynomial piecewise-polynomial (300 1500 755.87147 1.2696433 -0.0010494151 4.5674695e-07 -8.422556e-11) (1500 4000 1252.2979 0.14624066 -2.197965e-05 -3.6538334e-09 8.7082997e-13)))
	(molecular-weight (constant . 42.01725))
	(formation-enthalpy (constant . 4.0855472e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2325195E+06))
	)

 (inert-mixture
  mixture
  (chemical-formula . #f)
  (species (names h2o co2 n2))
  )

 (carbon-dioxide-
  fluid
  (chemical-formula . co2-)
  (specific-heat (polynomial piecewise-polynomial (300 1000 498.18926 1.4741645 -0.0015484008 1.2351213e-06 -4.7611293e-10) (1000 5000 871.01676 0.47852013 -0.00020217266 3.8289174e-08 -2.6919912e-12)))
  (molecular-weight (constant . 44.01049))
  (formation-enthalpy (constant . -4.4144003e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2405168E+06))
  ;; critical properties assumed the same as carbon-dioxide
  (critical-pressure (constant . 7.3740e6))
  (critical-temperature (constant . 304.12))
  (acentric-factor (constant . 0.225))
  (critical-volume (constant . 0.002137))
  )

 (coal-hv
  (combusting-particle inert-particle)
  (chemical-formula . #f)
  (density (constant . 1400))
  (specific-heat (constant . 1680))
  (latent-heat (constant . 0))
  (vaporization-temperature (constant . 400))
  (boiling-point (constant . 400))
  (binary-diffusivity (constant . 4e-05))
  (volatile-fraction (constant . 0.345))
  (combustible-fraction (constant . 0.575))
  (swelling-coefficient (constant . 2))
  (emissivity (constant . 0.9))
  (scattering-factor (constant . 0.9))
  (burn-stoichiometry (constant . 2.67))
  (burn-hreact (constant . 32789000))
  (burn-hreact-fraction (constant . 0.3))
  (devolatilization-model (constant . 50) (single-rate 312000 74000000) (two-competing-rates 200000 1.046e+08 0.3 13000000 1.674e+08 1)(cpd-model 1 0 5 400 50))
  (combustion-model (diffusion-limited . #f) (kinetics/diffusion-limited 5e-12 0.002 79000000) (intrinsic-model 5e-12 0.030198 1.794e+08 0.5 6e-08 300000 1.4142136 0) (cbk -1.0 10.0))
  )
 
 (coal-hv-volatiles
  fluid
  (chemical-formula . hv_vol)
  (specific-heat (constant . 1500))
  (molecular-weight (constant . 18.412))
  (formation-enthalpy (constant . -59040000))
  (reference-temperature (constant . 298.15))
 ; Critical Properties estimated by assuming that coal-hv volatiles comprise a mixture of CO2, CH4 and C2H6.
  (critical-pressure (constant . 5.235E+06))
  (critical-temperature (constant . 275.17))
  (acentric-factor (constant . 0.098))
  (critical-volume (constant . 0.004711))
  )
 
 (coal-hv-volatiles-air
  mixture
  (chemical-formula . #f)
  (species (names hv_vol o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((hv_vol 1 0.2 1) (o2 1.598 1.3 1)) ((co2 1 0 1) (h2o 1.417 0 1)) ((n2 0 1)) (stoichiometry "1hv_vol + 1.598o2 --> 1co2 + 1.417h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((hv_vol 1 0.2 1) (o2 1.598 1.3 1)) ((co2 1 0 1) (h2o 1.417 0 1)) ((n2 0 1)) (stoichiometry "1hv_vol + 1.598o2 --> 1co2 + 1.417h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((hv_vol 1 0.2 1) (o2 1.598 1.3 1)) ((co2 1 0 1) (h2o 1.417 0 1)) ((n2 0 1)) (stoichiometry "1hv_vol + 1.598o2 --> 1co2 + 1.417h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (coal-lv
  (combusting-particle inert-particle)
  (chemical-formula . #f)
  (density (constant . 1400))
  (specific-heat (constant . 1680))
  (latent-heat (constant . 0))
  (vaporization-temperature (constant . 400))
  (boiling-point (constant . 400))
  (binary-diffusivity (constant . 4e-05))
  (thermal-conductivity (constant . 0.33))
  (volatile-fraction (constant . 0.129))
  (combustible-fraction (constant . 0.791))
  (swelling-coefficient (constant . 1.4))
  (emissivity (constant . 0.9))
  (scattering-factor (constant . 0.9))
  (burn-stoichiometry (constant . 2.67))
  (burn-hreact (constant . 32789000))
  (burn-hreact-fraction (constant . 0.3))
  (devolatilization-model (constant . 50) (single-rate 382000 74000000) (two-competing-rates 200000 1.046e+08 0.3 13000000 1.674e+08 1)(cpd-model 1 0 5 400 50))
  (combustion-model (diffusion-limited . #f) (kinetics/diffusion-limited 5e-12 0.002 79000000) (intrinsic-model 5e-12 0.030198 1.794e+08 0.5 6e-08 300000 1.4142136 0) (cbk -1.0 10.0))
  )
 
 (coal-lv-volatiles
  fluid
  (chemical-formula . lv_vol)
  (specific-heat (constant . 1500))
  (molecular-weight (constant . 23.82))
  (formation-enthalpy (constant . -1.18e+08))
  (reference-temperature (constant . 298.15))
   ; Critical Properties estimated by assuming that coal-lv volatiles comprise a mixture of CO2, H2 and CH4.
  (critical-pressure (constant . 2.358E+06))
  (critical-temperature (constant . 83.13))
  (acentric-factor (constant . -0.143))
  (critical-volume (constant . 0.024123))
  )
 
 (coal-lv-volatiles-air
  mixture
  (chemical-formula . #f)
  (species (names lv_vol o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((lv_vol 1 0.2 1) (o2 2.979 1.3 1)) ((co2 1 0 1) (h2o 4.17 0 1)) ((n2 0 1)) (stoichiometry "1lv_vol + 2.979o2 --> 1co2 + 4.17h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((lv_vol 1 0.2 1) (o2 2.979 1.3 1)) ((co2 1 0 1) (h2o 4.17 0 1)) ((n2 0 1)) (stoichiometry "1lv_vol + 2.979o2 --> 1co2 + 4.17h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((lv_vol 1 0.2 1) (o2 2.979 1.3 1)) ((co2 1 0 1) (h2o 4.17 0 1)) ((n2 0 1)) (stoichiometry "1lv_vol + 2.979o2 --> 1co2 + 4.17h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (coal-mv
  (combusting-particle inert-particle)
  (chemical-formula . #f)
  (density (constant . 1400))
  (specific-heat (constant . 1680))
  (latent-heat (constant . 0))
  (vaporization-temperature (constant . 400))
  (boiling-point (constant . 400))
  (binary-diffusivity (constant . 4e-05))
  (volatile-fraction (constant . 0.276))
  (thermal-conductivity (constant . 0.33))
  (combustible-fraction (constant . 0.644))
  (swelling-coefficient (constant . 2))
  (emissivity (constant . 0.9))
  (scattering-factor (constant . 0.9))
  (burn-stoichiometry (constant . 2.67))
  (burn-hreact (constant . 32789000))
  (burn-hreact-fraction (constant . 0.3))
  (devolatilization-model (constant . 50) (single-rate 492000 74000000) (two-competing-rates 200000 1.046e+08 0.3 13000000 1.674e+08 1)(cpd-model 1 0 5 400 50))
  (combustion-model (diffusion-limited . #f) (kinetics/diffusion-limited 5e-12 0.002 79000000) (intrinsic-model 5e-12 0.030198 1.794e+08 0.5 6e-08 300000 1.4142136 0) (cbk -1.0 10.0))
  )
 
 (coal-mv-volatiles
  fluid
  (chemical-formula . mv_vol)
  (specific-heat (constant . 1500))
  (molecular-weight (constant . 17.237))
  (formation-enthalpy (constant . -56010000))
  (reference-temperature (constant . 298.15))
 ; Critical Properties estimated by assuming that coal-mv volatiles comprise a mixture of CO, CH4 and C2H6.
  (critical-pressure (constant . 4.567E+06))
  (critical-temperature (constant . 256.83))
  (acentric-factor (constant . 0.077))
  (critical-volume (constant . 0.004710))
  )
 
 (coal-mv-volatiles-air
  mixture
  (chemical-formula . #f)
  (species (names mv_vol o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((mv_vol 1 0.2 1) (o2 1.706 1.3 1)) ((co2 1 0 1) (h2o 1.543 0 1)) ((n2 0 1)) (stoichiometry "1mv_vol + 1.706o2 --> 1co2 + 1.543h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((mv_vol 1 0.2 1) (o2 1.706 1.3 1)) ((co2 1 0 1) (h2o 1.543 0 1)) ((n2 0 1)) (stoichiometry "1mv_vol + 1.706o2 --> 1co2 + 1.543h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((mv_vol 1 0.2 1) (o2 1.706 1.3 1)) ((co2 1 0 1) (h2o 1.543 0 1)) ((n2 0 1)) (stoichiometry "1mv_vol + 1.706o2 --> 1co2 + 1.543h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 

 (copper
  (solid inert-particle)
  (chemical-formula . cu)
  (density (constant . 8978))
  (specific-heat (constant . 381) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.009200e+04 -1.529850e+02 3.280188e+02 -2.769181e-03 4.503201e-06 -3.745489e-09 1.250750e-12) (1000.000000 6000.000000 3.019947e+08 -1.112582e+06 1.920573e+03 -1.107855e+00 3.778477e-04 -5.587807e-08 3.014942e-12) (6000.000000 20000.000000 -8.492412e+10 5.548115e+07 -1.346317e+04 1.697358e+00 -1.016209e-04 2.905272e-09 -3.194544e-14) ))
  (thermal-conductivity (constant . 387.6))
  (atomic-number (constant . 29))
  (electric-conductivity (constant . 5.8e+07))
  (magnetic-permeability (constant . 1.257e-06))
  (struct-youngs-modulus (constant . 1.17e+11))
  (struct-poisson-ratio (constant . 0.33))
  )
 
 (carbon-sulfide
fluid
	(chemical-formula . cs)
	(specific-heat (polynomial piecewise-polynomial (300 1000 554.34209 0.51392179 -0.00045230349 3.1870742e-07 -1.2572956e-10) (1000 5000 705.02913 0.1543161 -5.9967135e-05 1.0105074e-08 -5.4445189e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -9.290182e+06 1.540606e+05 -2.910758e+02 2.603823e+00 -2.969947e-03 1.729772e-06 -4.092931e-10) (1000.000000 6000.000000 -1.833473e+08 4.412601e+05 3.224523e+02 2.975137e-01 -7.821497e-05 8.497594e-09 -1.121512e-13) ))
	(molecular-weight (constant . 44.07515))
	(formation-enthalpy (constant . 2.803353e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2104345E+06))
	)

 (chloro-silynyl-radical
fluid
	(chemical-formula . csicl)
	(specific-heat (polynomial piecewise-polynomial (300 1500 529.31651 0.78748392 -0.0010206208 5.907756e-07 -1.2666724e-10) (1500 4000 750.28693 0.023543598 -1.2301582e-05 3.046346e-09 -2.8536241e-13)))
	(molecular-weight (constant . 75.55016))
	(formation-enthalpy (constant . 6.1112346e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2848307E+06))
	)

 (dichloro-carbene-silene 
fluid
	(chemical-formula . csicl2)
	(specific-heat (polynomial piecewise-polynomial (300 1500 410.66908 1.0732717 -0.0013666065 7.8241552e-07 -1.6659509e-10) (1500 4000 719.32247 0.031548692 -1.5044911e-05 3.4856723e-09 -3.1269861e-13)))
	(molecular-weight (constant . 111.00315))
	(formation-enthalpy (constant . 3.7284528e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3209991E+06))
	)

 (trichloro-carbyne-silane
fluid
	(chemical-formula . csicl3)
	(specific-heat (polynomial piecewise-polynomial (300 1500 411.38946 1.0429514 -0.0013332939 7.6522497e-07 -1.6318851e-10) (1500 4000 709.93575 0.030310831 -1.4695599e-05 3.4489619e-09 -3.1210927e-13)))
	(molecular-weight (constant . 146.45615))
	(formation-enthalpy (constant . 37859468))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3631650E+06))
	)

 (chloro-carbene-silane
fluid
	(chemical-formula . csih2cl)
	(specific-heat (polynomial piecewise-polynomial (300 1500 233.71529 2.5781531 -0.002735141 1.4423448e-06 -2.9820778e-10) (1500 4000 1101.3658 0.19023714 -3.5460601e-05 -1.6660077e-09 7.5127773e-13)))
	(molecular-weight (constant . 77.56609))
	(formation-enthalpy (constant . 4.429048e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2923971E+06))
	)

 (chloro-carbene-silene
fluid
	(chemical-formula . csihcl)
	(specific-heat (polynomial piecewise-polynomial (300 1500 455.6699 1.4516331 -0.0015835317 8.495825e-07 -1.7725016e-10) (1500 4000 932.26406 0.10320741 -2.1617283e-05 7.9019543e-11 2.9289981e-13)))
	(molecular-weight (constant . 76.55812))
	(formation-enthalpy (constant . 4.9986518e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2832011E+06))
	)

 (dichloro-carbyne-silane
fluid
	(chemical-formula . csihcl2)
	(specific-heat (polynomial piecewise-polynomial (300 1500 312.17995 1.6915552 -0.0019696683 1.0875341e-06 -2.2890483e-10) (1500 4000 841.01704 0.089137749 -2.3105943e-05 1.904042e-09 3.8199365e-14)))
	(molecular-weight (constant . 112.01112))
	(formation-enthalpy (constant . 2.6425854e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3241859E+06))
	)

(dioxane
 fluid
	(chemical-formula . dioxane)
	(specific-heat (polynomial piecewise-polynomial (300 1500 -553.2597 6.682491 -0.0051511644 2.1847178e-06 -4.0478515e-10) (1500 4000 2046.0192 0.99050959 -9.9450443e-05 -4.2218919e-08 7.7081044e-12)))
	(molecular-weight (constant . 88.10716))
	(formation-enthalpy (constant . -3.1431491e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3000940E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-pressure (constant . 5.155E+06))
    (critical-temperature (constant . 579.27))
    (acentric-factor (constant . 0.288))
    (critical-volume (constant . 0.002656))
	)

 (disilane
  fluid
;  (chemical-formula . si2h6) merged in the THERMO.DB record
  (chemical-formula . h3sisih3)
  (density (constant . 2.53))
; (specific-heat (polynomial piecewise-polynomial (300 1000 70.848759 5.5910889 -0.0062608267 4.2487507e-06 -1.2674028e-09) (1000 2000 1186.9001 1.5385923 -0.00016252107 -2.545736e-07 7.4061968e-11)))
  (specific-heat (polynomial piecewise-polynomial (300 1000 520.92242 2.6423895 2.3933048e-05 -1.3806069e-06 5.2538679e-10) (1000 3000 1427.5168 1.0986153 -0.00010818608 -1.1141909e-07 2.5499053e-11)))
  (molecular-weight (constant . 62.21982))
;  (formation-enthalpy (constant . 79908608))
  (formation-enthalpy (constant . 80184208))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 4.828))
  (lennard-jones-energy (constant . 301.3))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
;  (formation-entropy (constant . 270008.16))
  (formation-entropy (constant .  0.2794497E+06))
  )
 
 (disilicon-dihydride
  fluid
  (chemical-formula . si2h2)
  (density (constant . 2.37))
  (specific-heat (polynomial piecewise-polynomial (300 1500 138.14938 2.7619603 -0.0026083017 1.2008297e-06 -2.1965088e-10) (1500 4000 1157.2563 0.18492807 -3.496743e-05 -2.0711733e-09 8.3835631e-13)))
  (molecular-weight (constant . 58.18794))
  (formation-enthalpy (constant . 4.0009978e+08))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 0))
  (lennard-jones-energy (constant . 0))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 246146.45))
  )
 
 (disilicon-trihydride
  fluid
  (chemical-formula . si2h3)
  (density (constant . 2.411))
  (specific-heat (polynomial piecewise-polynomial (300 1000 468.47293 3.0276599 -0.0041208504 3.2132986e-06 -1.0215022e-09) (1000 2000 1019.3673 0.71966971 -0.00010721556 -9.3577494e-08 2.8836067e-11)))
  (molecular-weight (constant . 59.19591))
  (formation-enthalpy (constant . 4.4226762e+08))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 0))
  (lennard-jones-energy (constant . 0))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 274102.47))
  )

  (diesel-1-fuel
   (fluid inert-particle droplet-particle)
   (description . "Diesel Category 1, Cetane 45 \n\nData compiled from MFL. Density: 852 kg/m3 @ 288 K, Viscosity: 2.15 mm2/s @ 313 K. All constant property data valid at 298.15 K and 1 bar. Binary diffusivity data computed from Fuller's method for C13H24 into air @ 1 bar. \n\nANSYS Inc. provides no warranty for this data." )
   (chemical-formula . c13h24<l>) ;; Dicyclohexylmethane
   (molecular-weight (constant . 180.33))
   (reference-temperature (constant . 298.15))
   (acentric-factor (constant . 0.5144))  ;; Poling, Prausnitz, "The Property of Gases and Liquids", Eqn. 2-3.3

   ;; critical pressure & temperature
   (critical-pressure (constant . 18.7e+5))
   (critical-temperature (constant . 736))

   (vaporization-temperature (constant . 325))
   (volatile-fraction (constant . 1))
   (averaging-coefficient-t (none . #f) (constant . 0.3333))
   (averaging-coefficient-y (none . #f) (constant . 0.3333))
   (vaporization-model (convection/diffusion-controlled 1 1) (diffusion-controlled . #f))

   (boiling-point (constant . 541.0))        ;; pvap = 1bar

   (density (constant . 846)                 ;; @ 298 K (= 852 @ 288K according to EU & US Diesel standards)
            (polynomial piecewise-linear
                         (243.0 . 882.825) (263.0 . 869.527) (283.0 . 856.038) (303.0 . 842.345) (323.0 . 828.431)
                         (343.0 . 814.280) (363.0 . 799.870) (383.0 . 785.178) (403.0 . 770.178) (423.0 . 754.838)
                         (443.0 . 739.123) (463.0 . 722.989) (483.0 . 706.386) (503.0 . 689.251) (523.0 . 671.508)
                         (543.0 . 653.061) (563.0 . 633.788) (583.0 . 613.528) (603.0 . 592.061) (623.0 . 569.080)
                         (643.0 . 544.120) (663.0 . 516.435) (683.0 . 484.673) (703.0 . 445.881) (723.0 . 390.287)
                         (735.0 . 312.684)))
   (dpm-surften (constant . 7.9E-1)          ;; @ 298 K
                (polynomial piecewise-polynomial (243. 735. 0.925808 0.000854661 -6.34292e-6 9.34709e-9 -1.15636e-11 7.16063e-15)))
   (binary-diffusivity (constant . 4.942e-06);; @ 298 K and 1 bar
                       (polynomial piecewise-polynomial (243. 2500. -8.20125e-7 8.8961e-9 3.93909e-11 -4.54284e-15 4.93983e-19)))

   (diffusivity-reference-pressure (constant . 101325)
                                   (none . #f))
   (specific-heat (constant . 2193.27)       ;; @ 298 K
                  (polynomial piecewise-polynomial (243. 735. 1774.52 0.0832 0.004436)))
   (thermal-conductivity (constant . 0.1157) ;; @ 298 K
                         (polynomial piecewise-polynomial (243. 735. 0.15 -1.15e-4)))

   (viscosity (constant . 0.0029)            ;; @ 298 K
              (polynomial piecewise-polynomial (279. 528. 0.883321 -0.0120799 6.93707e-5 -2.13249e-7 3.69214e-10 -3.40838e-13 1.30926e-16)))

   (latent-heat (constant . 234330.)         ;; @ normal boiling point (541 K)
                (polynomial piecewise-linear
                    (243.0 . 333348.375) (263.0 . 328143.438) (283.0 . 322800.188) (303.0 . 317308.656) (323.0 . 311657.438)
                    (343.0 . 305833.938) (363.0 . 299823.625) (383.0 . 293610.000) (403.0 . 287174.125) (423.0 . 280493.844)
                    (443.0 . 273543.344) (463.0 . 266292.125) (483.0 . 258703.500) (503.0 . 250733.141) (523.0 . 242326.422)
                    (543.0 . 233414.734) (563.0 . 223910.266) (583.0 . 213697.391) (603.0 . 202618.953) (623.0 . 190452.344)
                    (643.0 . 176864.234) (663.0 . 161316.656) (683.0 . 142837.203) (703.0 . 119303.086) (704.0 . 117916.195)
                    (709.0 . 110543.914) (714.0 . 102267.383) (719.0 . 92722.8984) (724.0 . 81227.9766) (729.0 . 66184.1250)
                    (734.0 . 31594.7930)))
   (vapor-pressure (constant . 1.335)        ;; @ 298 K
                   (polynomial piecewise-linear
                         (243.0 . 1.4781E-03) (263.0 . 2.6170E-02) (283.0 . 0.28608766) (303.0 . 2.13941240) (323.0 . 11.8135071)
                         (343.0 . 51.0431252) (363.0 . 180.473221) (383.0 . 540.808899) (403.0 . 1412.23755) (423.0 . 3286.34204)
                         (443.0 . 6939.34131) (463.0 . 13494.9883) (483.0 . 24467.4922) (503.0 . 41782.0703) (523.0 . 67777.8047)
                         (543.0 . 105198.805) (563.0 . 157184.516) (583.0 . 227274.938) (603.0 . 319433.688) (623.0 . 438093.906)
                         (643.0 . 588255.062) (663.0 . 775578.250) (683.0 . 1006606.06) (703.0 . 1288900.00) (723.0 . 1631393.25)
                         (735.0 . 1870107.38)))
 )

 (diesel-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . c10h22<l>)
  (density (constant . 730) (compressible-liquid 101325 730 1.07e+09 7 1.1 0.9))
  (specific-heat (constant . 2090)(polynomial 264 6.33 -0.00296)) ;Sazhin Prog. Energy Comb. Sci. 32 (2006)
  (latent-heat (constant . 277000))
  (vaporization-temperature (constant . 341))
  (boiling-point (constant . 447))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (constant . 3.79e-06))
  (thermal-conductivity (constant . 0.149))
  (viscosity (constant . 0.0024))
  (dpm-surften (constant . 0.0263257) (polynomial piecewise-polynomial (50 700 5.94679e-02 -1.25920e-04 4.21601e-08 2.41128e-11)))
  (vapor-pressure (polynomial piecewise-linear (327 . 1100) (339 . 2100) (358 . 5100) (369 . 8100) (381 . 13100) (397 . 23100) (422 . 50100) (447 . 101000) (476 . 200000) (523 . 500000) (565 . 1000000) (614 . 2000000) (617.7 . 2110000))(constant . 1329) )
    ;; http://webbook.nist.gov (decane)
  (molecular-weight (constant . 142.284))
  )

(diesel-vapor 
 fluid
 (chemical-formula . c10h22) 
 (specific-heat (polynomial piecewise-polynomial (200 1000 59.373746 5.3325763 0.0005 -5.0483178e-06 2.3409914e-09) (1000 6000 2900. 0.3 0.0 0.0 0.0 0.0)))
 (molecular-weight (constant . 142.284)) 
 (formation-enthalpy (constant . -2.49659e+08))
 (reference-temperature (constant . 298.15)) 
 (formation-entropy (constant . 540531.0)) 
 (thermal-conductivity (constant . 0.0178))
 (viscosity (constant . 7e-06))
; Critical Properties from Polling et al.  (decane) 
  (critical-pressure (constant . 2.1100e6))
  (critical-temperature (constant . 617.70))
  (acentric-factor (constant . 0.490))
  (critical-volume (constant . 0.004386)) 
 )

 (diesel-air
  mixture
  (chemical-formula . #f)
  (species (names c10h22 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c10h22 1 0.25 1) (o2 15.5 1.5 1)) ((co2 10 0 1) (h2o 11 0 1)) ((n2 0 1)) (stoichiometry "1c10h22 + 15.5o2 --> 10co2 + 11h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c10h22 1 0.25 1) (o2 15.5 1.5 1)) ((co2 10 0 1) (h2o 11 0 1)) ((n2 0 1)) (stoichiometry "1c10h22 + 15.5o2 --> 10co2 + 11h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c10h22 1 0.25 1) (o2 15.5 1.5 1)) ((co2 10 0 1) (h2o 11 0 1)) ((n2 0 1)) (stoichiometry "1c10h22 + 15.5o2 --> 10co2 + 11h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )

 (dolomite
  (solid inert-particle)
  (chemical-formula . cao_mgo_2co2)
  (density (constant . 2872))
  (specific-heat (constant . 910))
  (thermal-conductivity (constant . 1.75))
  (molecular-weight (constant . 184.41))
  (struct-youngs-modulus (constant . 7.e+09))
  (struct-poisson-ratio (constant . 0.2))
  )

 (electron 
    fluid
	(chemical-formula . e)
	(specific-heat (polynomial piecewise-polynomial (300 1000 38139173 0 0 0 0) (1000 5000 38139173 0 0 0 0)) (polynomial nasa-9-piecewise-polynomial (200.000000 20000.000000 0.000000e+00 0.000000e+00 38139173 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00)))
	(molecular-weight (constant . 0.00055))
  (viscosity (kinetic-theory . #f) (blottner-curve-fit 0.0 0.0 -1.2e1) (constant . 1.72e-05) (gupta-curve-fit-viscosity 0 2.5 -37.4475))
  (thermal-conductivity (gupta-curve-fit-conductivity 0 0 0.00032 2.49375 -27.89805))
  (lennard-jones-length (constant . 425))
  (lennard-jones-energy (constant . 850))
  (characteristic-vibrational-temperature (constant . 0))
	(formation-enthalpy (constant . -3117.7105))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2085868E+05))
	)

 (engine-oil
  fluid
  (chemical-formula . #f)
  (density (constant . 889) (compressible-liquid 101325 889 1.4e+09 7 1.1 0.9))
  (specific-heat (constant . 1845))
  (thermal-conductivity (constant . 0.145))
  (viscosity (constant . 1.06))
  )
 
 (ethane
  fluid
  (chemical-formula . c2h6)
  (density (constant . 1.263))
  (specific-heat (polynomial piecewise-polynomial (300 1000 404.38961 4.2842506 0.001598301 -3.477885e-06 1.2680955e-09) (1000 4000 1334.3642 3.8268563 -0.0012600747 1.8594427e-07 -9.9488587e-12)) (constant . 1731) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -5.148806e+07 9.418579e+05 -5.396727e+03 2.092054e+01 -2.268565e-02 1.399474e-05 -3.648000e-09) (1000.000000 6000.000000 1.389700e+09 -5.621588e+06 9.187307e+03 -1.060911e+00 2.001551e-04 -2.023903e-08 8.476719e-13) ))
  ;(specific-heat                   (polynomial piecewise-polynomial (300 1000 404.38962 4.2842503 0.0015983008 -3.4778848e-06 1.2680954e-09) (1000 4000 1334.3641 3.8268561 -0.0012600744 1.8594426e-07 -9.9488571e-12)))
  (thermal-conductivity (constant . 0.0207))
  (viscosity (constant . 9.29e-06))
  (molecular-weight (constant . 30.07012))
  (formation-enthalpy (constant . -83863288))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 228949.31))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
 ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 4.8720e6))
  (critical-temperature (constant . 305.32))
  (acentric-factor (constant . 0.099))
  (critical-volume (constant . 0.004839)) 
  )
 
 (ethane-air
  mixture
  (chemical-formula . #f)
  (species (names c2h6 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c2h6 1 0.1 1) (o2 3.5 1.65 1)) ((co2 2 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c2h6 + 3.5o2 --> 2co2 + 3h2o") (arrhenius 6.186e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c2h6 1 0.1 1) (o2 3.5 1.65 1)) ((co2 2 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c2h6 + 3.5o2 --> 2co2 + 3h2o") (arrhenius 6.186e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c2h6 1 0.1 1) (o2 3.5 1.65 1)) ((co2 2 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c2h6 + 3.5o2 --> 2co2 + 3h2o") (arrhenius 6.186e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (ethylene
  fluid
  (chemical-formula . c2h4)
  (density (constant . 1.137))
  (specific-heat (polynomial piecewise-polynomial (300 1000 -255.31682 8.2869107 -0.010042929 8.2542788e-06 -2.8859883e-09) (1000 5000 1045.7077 3.4038325 -0.0013094647 2.3248826e-07 -1.5609214e-11)) (constant . 2233) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -3.448749e+07 7.572166e+05 -4.771022e+03 1.963769e+01 -2.337004e-02 1.519028e-05 -4.061447e-09) (1000.000000 6000.000000 1.010287e+09 -4.074778e+06 7.012074e+03 -7.183513e-01 1.313322e-04 -1.289961e-08 5.261441e-13) ))
  (thermal-conductivity (constant . 0.0214))
  (viscosity (constant . 1.03e-05))
  (molecular-weight (constant . 28.05418))
  (formation-enthalpy (constant . 52455400))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 219148.61))
  ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 5.0410e6))
  (critical-temperature (constant . 282.34))
  (acentric-factor (constant . 0.087))
  (critical-volume (constant . 0.004673)) 
  )
 
 (ethylene-air
  mixture
  (chemical-formula . #f)
  (species (names c2h4 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c2h4 1 0.1 1) (o2 3 1.65 1)) ((co2 2 0 1) (h2o 2 0 1)) ((n2 0 1)) (stoichiometry "1c2h4 + 3o2 --> 2co2 + 2h2o") (arrhenius 1.125e+10 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c2h4 1 0.1 1) (o2 3 1.65 1)) ((co2 2 0 1) (h2o 2 0 1)) ((n2 0 1)) (stoichiometry "1c2h4 + 3o2 --> 2co2 + 2h2o") (arrhenius 1.125e+10 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c2h4 1 0.1 1) (o2 3 1.65 1)) ((co2 2 0 1) (h2o 2 0 1)) ((n2 0 1)) (stoichiometry "1c2h4 + 3o2 --> 2co2 + 2h2o") (arrhenius 1.125e+10 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (ethyl-acetate
  fluid
  (chemical-formula . c4h8o2)
  (density (constant . 900))
  (specific-heat (constant . 2010))
  (thermal-conductivity (constant . 0.137))
  (viscosity (constant . 0.000449))
  (molecular-weight (constant . 88.066))
  ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 3.8300e6))
  (critical-temperature (constant . 523.20))
  (acentric-factor (constant . 0.361))
  (critical-volume (constant . 0.003248)) 
  )
 
 (ethyl-alcohol-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . c2h5oh<l>)
  (density (constant . 790) (compressible-liquid 101325 790 1.3e+09 7 1.1 0.9))
  (specific-heat (constant . 2470))
  (latent-heat (constant . 855237))
  (vaporization-temperature (constant . 271))
  (boiling-point (constant . 351))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (film-averaged (averaging-coefficient 0.3333) (film-diffusivity  (polynomial piecewise-linear (273 . 1.15e-05 ) (300 . 1.36E-5) (350 . 1.76E-5) (373 . 2.0E-5) (400 . 2.26E-5) (450 . 2.77E-5) (473 . 3.03E-5)) (constant . 1.37e-05)))(constant . 1.37e-05))
  (thermal-conductivity (constant . 0.182))
  (viscosity (constant . 0.0012))
  (dpm-surften (constant . 0.022348) (polynomial piecewise-polynomial (50 512 2.23811e-02 1.09635e-04 -4.64449e-07 3.22742e-10)))
  (vapor-pressure (polynomial piecewise-linear (271 . 1329) (281 . 2658) (292 . 5316) (299 . 7974) (308 . 13289) (321 . 26579) (337 . 53158) (351 . 101000) (371 . 202000) (399 . 505000) (422 . 1000000) (455 . 2000000) (500 . 5000000) (513.92 . 6.1480e6))(constant . 7974) )
  (molecular-weight (constant . 46.07))
  (formation-enthalpy (constant . -276.0E+06))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  159.86E+03))
  )
 
 (ethyl-alcohol-vapor
  fluid
  (chemical-formula . c2h5oh)
  (density (constant . 2.06))
  (specific-heat (constant . 2407) (polynomial 635.28 3.6118 -0.0010839) (polynomial piecewise-polynomial (100 1000 635.28 3.6118 -0.0010839) (1000 6000 3610.0)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -4.228324e+07 8.084109e+05 -4.953894e+03 1.964864e+01 -2.355842e-02 1.522786e-05 -4.032969e-09) (1000.000000 6000.000000 8.473183e+08 -3.482901e+06 6.222215e+03 -5.840595e-01 1.044057e-04 -1.004285e-08 4.017820e-13) ))
  (thermal-conductivity (constant . 0.0145))
  (viscosity (constant . 1.08e-05))
  (molecular-weight (constant . 46.07))
  (formation-enthalpy (constant . -2.19e+08))
  (reference-temperature (constant . 298.15))
; Critical Properties from Polling et al.  
  (critical-pressure (constant . 6.1480e6))
  (critical-temperature (constant . 513.92))
  (acentric-factor (constant . 0.649))
  (critical-volume (constant . 0.003625))   
  )
 
 (ethyl-alcohol-air
  mixture
  (chemical-formula . #f)
  (species (names c2h5oh o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c2h5oh 1 0.15 1) (o2 3 1.6 1)) ((co2 2 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c2h5oh + 3o2 --> 2co2 + 3h2o") (arrhenius 8.435e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c2h5oh 1 0.15 1) (o2 3 1.6 1)) ((co2 2 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c2h5oh + 3o2 --> 2co2 + 3h2o") (arrhenius 8.435e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c2h5oh 1 0.15 1) (o2 3 1.6 1)) ((co2 2 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c2h5oh + 3o2 --> 2co2 + 3h2o") (arrhenius 8.435e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (ethylene-glycol
  fluid
  (chemical-formula . c2h6o2)
  (density (constant . 1111.4) (compressible-liquid 101325 1111.4 4.03e+09 7 1.1 0.9))
  (specific-heat (constant . 2415))
  (thermal-conductivity (constant . 0.252))
  (viscosity (constant . 0.0157))
  (molecular-weight (constant . 62.0482))
  ; Critical Properties from Somayajulu (1989)  acentric factor from Cranium ver. 1.0.3
  (critical-pressure (constant . 6.8240e6))
  (critical-temperature (constant . 607.00))
  (acentric-factor (constant . 1.208))
  (critical-volume (constant . 0.002932))
  )

  (atomic-fluorine 
fluid
	(chemical-formula . f)
	(specific-heat (polynomial piecewise-polynomial (300 1000 1275.2226 -0.32106291 0.00024380639 -1.1671126e-07 3.7825797e-11) (1000 5000 1176.1226 -0.087980041 3.7627558e-05 -7.1989595e-09 5.1035116e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 4.977764e+05 -6.360637e+04 1.784437e+03 -1.883325e+00 2.507198e-03 -1.671486e-06 4.456593e-10) (1000.000000 6000.000000 6.448661e+06 3.566739e+04 1.069756e+03 9.278900e-03 -1.989916e-06 2.236137e-10 -1.021407e-14) (6000.000000 20000.000000 -1.280854e+10 7.771074e+06 -7.940828e+02 2.341902e-01 -1.537703e-05 4.820697e-10 -4.644653e-15) ))
	(molecular-weight (constant . 18.9984))
	(formation-enthalpy (constant . 78911488))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.1586561E+06))
	)


 (difluoro-nitro-silane
fluid
	(chemical-formula . f2sinh)
	(specific-heat (polynomial piecewise-polynomial (300 1000 507.64648 1.3631802 -0.00021515928 -1.0326872e-06 5.6923582e-10) (1000 3000 1030.1799 0.20331748 -2.7713635e-05 -1.8124513e-08 4.5564895e-12)))
	(molecular-weight (constant . 81.09747))
	(formation-enthalpy (constant . -6.1478054e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2967577E+06))
	)

 (trifluoro-nitro-silane
fluid
	(chemical-formula . f3sin)
	(specific-heat (polynomial piecewise-polynomial (300 1000 505.837 1.0729247 -0.00015765242 -8.1353089e-07 4.3505394e-10) (1000 4000 965.99279 0.093560708 -1.3471257e-05 -4.4236121e-09 9.7409633e-13)))
	(molecular-weight (constant . 99.0879))
	(formation-enthalpy (constant . -8.3692064e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3090871E+06))
	)

 (fluorine
  (fluid inert-particle)
  (chemical-formula . f2)
  (density (constant . 1.5))
  (specific-heat (polynomial piecewise-polynomial (300 1000 643.38437 0.76399708 -0.00053789713 4.0198253e-08 6.2382849e-11) (1000 5000 879.27354 0.13613645 -5.2972167e-05 1.0376461e-08 -7.4794683e-13)) (constant . 1133) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.227976e+06 4.976501e+03 4.313721e+02 1.783736e+00 -2.514158e-03 1.741515e-06 -4.742010e-10) (1000.000000 6000.000000 -6.435872e+08 2.069296e+06 -1.693366e+03 1.672818e+00 -4.903780e-04 6.380461e-08 -3.118264e-12) ))
  ;(specific-heat (polynomial piecewise-polynomial (300 1000 58.644048 3.4663139 -0.0039026085 3.1041558e-06 -1.115263e-09) (1000 5000 755.94621 1.2781103 -0.0005091865 9.271281e-08 -6.3414482e-12)))
  (thermal-conductivity (constant . 0.0268))
  (viscosity (constant . 2.3e-05))
  (molecular-weight (constant . 37.9968))
  (formation-enthalpy (constant . -3184.4595))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  0.2026976E+06))
 ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 5.2150e6))
  (critical-temperature (constant . 144.30))
  (acentric-factor (constant . 0.051))
  (critical-volume (constant . 0.001742))   
  )

  (dinitrogen-difluoride
   fluid
   (chemical-formula . fnnf)
   (specific-heat (polynomial piecewise-polynomial (300 1000 393.88048 1.3315174 -0.00012275754 -9.0793136e-07 4.4940602e-10) (1000 3000 913.83285 0.28647405 -3.5183698e-05 -2.7758588e-08 6.7502437e-12)))
   (molecular-weight (constant . 66.0102))
   (formation-enthalpy (constant . 74792544))
   (reference-temperature (constant . 298))
   (formation-entropy (constant .  0.2655713E+06))
  ; Critical Properties from Polling et al.  assumed the same as cis-difluorodiazene
  (critical-pressure (constant . 6.8000e6))
  (critical-temperature (constant . 272.00))
  (critical-volume (constant . 0.001716)) 
  (acentric-factor (constant . 2.52000E-01))
   )

 (fluorine-nitrate
  fluid
	(chemical-formula . fno3)
	(specific-heat (polynomial piecewise-polynomial (300 1000 306.46703 2.1499824 -0.001696398 4.4328715e-07 1.7046614e-11) (1000 5000 941.87121 0.43305397 -0.00018840708 3.6476061e-08 -2.6082132e-12)))
	(molecular-weight (constant . 81.0033))
	(formation-enthalpy (constant . 10466558))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2928773E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-pressure (constant . 6.220E+06))
    (critical-temperature (constant . 572.02))
    (acentric-factor (constant . 0.407))
    (critical-volume (constant . 0.001926))
	)

 (oxygen-monofluoride
fluid
	(chemical-formula . fo)
	(specific-heat (polynomial piecewise-polynomial (300 1000 684.09421 0.80752074 -0.00061122655 1.7633166e-07 -1.0282048e-11) (1000 5000 929.77626 0.17130313 -6.6438465e-05 1.2680929e-08 -8.8379464e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -9.294221e+06 1.892739e+05 -3.883762e+02 3.805440e+00 -4.977619e-03 3.284995e-06 -8.705858e-10) (1000.000000 6000.000000 -3.796248e+08 1.039939e+06 -1.163507e+02 6.372460e-01 -1.639433e-04 1.721555e-08 -6.478361e-13) ))
	(molecular-weight (constant . 34.9978))
	(formation-enthalpy (constant . 1.0878389e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2165869E+06))
	)
 
(dioxygen-monofluoride 
fluid
	(chemical-formula . fo2)
	(specific-heat (polynomial piecewise-polynomial (300 1000 631.36074 1.0450515 -0.00089959313 3.6402015e-07 -6.3195012e-11) (1000 5000 925.87229 0.23517099 -0.00010156354 1.9557898e-08 -1.3928777e-12)))
	(molecular-weight (constant . 50.9972))
	(formation-enthalpy (constant . 12553201))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2590243E+06))
	)

 (freon-12
  fluid
  (chemical-formula . ccl2f2)
  (density (constant . 1305.8))
  (specific-heat (constant . 978.1))
  (thermal-conductivity (constant . 0.072))
  (viscosity (constant . 0.000254))
  (molecular-weight (constant . 120.92))
  ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 4.1300e6))
  (critical-temperature (constant . 385.10))
  (acentric-factor (constant . 0.179))
  (critical-volume (constant . 0.001795))   
  )
 
 (fuel-oil-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . c19h30<l>)
  (density (constant . 960) (compressible-liquid 101325 960 1.5e+09 7 1.1 0.9))
  (specific-heat (constant . 1880))
  (latent-heat (constant . 124000))
  (vaporization-temperature (constant . 400))
  (boiling-point (constant . 589))
  (volatile-fraction (constant . 0.996))
  (binary-diffusivity (constant . 3.79e-06))
  (thermal-conductivity (constant . 0.12))
  (viscosity (constant . 0.048))
  (vapor-pressure (polynomial piecewise-linear (400 . 1329) (422 . 2658) (450 . 5316) (461 . 7974) (483 . 13289) (516 . 26579) (550 . 53158) (589 . 101000) (600 . 202000) (700 . 505000) (870.32 . 1562000))(constant . 1329) )
  (molecular-weight (constant . 258.19))
  )

  (fluoro-silicon-nitride
fluid
	(chemical-formula . fsin)
	(specific-heat (polynomial piecewise-polynomial (300 1000 581.13166 0.72109272 -0.00015022451 -5.3932747e-07 3.107079e-10) (1000 3000 853.27239 0.091836711 -1.6902968e-05 -6.7642556e-09 1.9386422e-12)))
	(molecular-weight (constant . 61.0911))
	(formation-enthalpy (constant . 2.2750109e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2664043E+06))
	)

 (fuel-oil-vapor
  fluid
  (chemical-formula . c19h30)
  (density (constant . 10.95))
  (specific-heat (constant . 2430))
  (thermal-conductivity (constant . 0.0178))
  (viscosity (constant . 7e-06))
  (molecular-weight (constant . 258.19))
  (formation-enthalpy (constant . -6.4e+08))
  (reference-temperature (constant . 298.15))
  ; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 1.562E+06))
  (critical-temperature (constant . 870.32))
  (acentric-factor (constant . 0.830))
  (critical-volume (constant . 0.003653))
  )
 
 (fuel-oil-air
  mixture
  (chemical-formula . #f)
  (species (names c19h30 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c19h30 1 0.25 1) (o2 26.5 1.5 1)) ((co2 19 0 1) (h2o 15 0 1)) ((n2 0 1)) (stoichiometry "1c19h30 + 26.5o2 --> 19co2 + 15h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c19h30 1 0.25 1) (o2 26.5 1.5 1)) ((co2 19 0 1) (h2o 15 0 1)) ((n2 0 1)) (stoichiometry "1c19h30 + 26.5o2 --> 19co2 + 15h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c19h30 1 0.25 1) (o2 26.5 1.5 1)) ((co2 19 0 1) (h2o 15 0 1)) ((n2 0 1)) (stoichiometry "1c19h30 + 26.5o2 --> 19co2 + 15h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )

 (gallium 
fluid
	(chemical-formula . ga)
	(specific-heat (polynomial piecewise-polynomial (300 600 319.58918 0 0 0 0) (600 1500 319.58918 0 0 0 0)))
	(molecular-weight (constant . 69.72))
	(formation-enthalpy (constant . 2.8672198e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.1833837E+06))
	)

 (digallium-hexahydride 
fluid
	(chemical-formula . ga2h6)
	(specific-heat (polynomial piecewise-polynomial (300 600 -223.70933 2.8376468 0.00042300405 -6.4242213e-06 4.9869294e-09) (600 1500 343.81655 1.0220179 -6.8819284e-06 -3.707695e-07 1.186031e-10)))
	(molecular-weight (constant . 145.48782))
	(formation-enthalpy (constant . 1.3180757e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2889565E+06))
	)

 (gallium-arsenide
fluid
	(chemical-formula . gaas)
	(specific-heat (polynomial piecewise-polynomial (300 600 228.0597 0.13329963 -6.5843284e-05 -1.9609704e-07 1.9347532e-10) (600 1500 257.01218 0.024363604 -1.3102551e-05 -2.5528902e-10 1.5054353e-12)))
	(molecular-weight (constant . 144.6416))
	(formation-enthalpy (constant . 3.6988333e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2645629E+06))
	)
 
(gallium-arsenide-trimer-solid 
fluid
	(chemical-formula . gaas<3c>)
	(specific-heat (polynomial piecewise-polynomial (300 600 281.69979 0.073342276 -5.6442824e-05 4.7238423e-08 -2.913585e-11) (600 1500 284.58492 0.056705101 -1.3650615e-05 -1.0185966e-08 2.4666083e-12)))
	(molecular-weight (constant . 433.9248))
	(formation-enthalpy (constant . 1.0282661e+09))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4184453E+06))
	)

 (gallium-arsenide-trimer-liquid
 fluid
	(chemical-formula . gaas<3l>)
	(specific-heat (polynomial piecewise-polynomial (300 600 256.99906 0.069317762 -5.2236288e-05 3.5968302e-08 -2.4126839e-11) (600 1500 259.98307 0.053696857 -1.5270989e-05 -1.2333985e-08 2.9895703e-12)))
	(molecular-weight (constant . 433.9248))
	(formation-enthalpy (constant . 1.0722e+09))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.5345641E+06))
	)

 (gallium-arsenide-pentamer-solid 
fluid
	(chemical-formula . gaas<5c>)
	(specific-heat (polynomial piecewise-polynomial (300 600 292.75891 0.080640123 -5.6118366e-05 4.3979566e-08 -2.8171184e-11) (600 1500 295.88145 0.063506 -1.3835634e-05 -1.1999362e-08 2.9073771e-12)))
	(molecular-weight (constant . 723.20801))
	(formation-enthalpy (constant . 1.4968965e+09))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.5460711E+06))
	)

 (gallium-arsenide-pentamer-liquid
fluid
	(chemical-formula . gaas<5l>)
	(specific-heat (polynomial piecewise-polynomial (300 600 346.64792 0.083170003 -7.4703991e-05 6.3915596e-08 -3.8394224e-11) (600 1500 350.15871 0.062117167 -1.8963159e-05 -1.1460652e-08 2.7742756e-12)))
	(molecular-weight (constant . 723.20801))
	(formation-enthalpy (constant . 1.7573614e+09))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.8096921E+06))
	)

 (ethyl-gallium 
fluid
	(chemical-formula . gaet)
	(specific-heat (polynomial piecewise-polynomial (300 600 155.40853 2.1816881 0.00046481125 -4.1898716e-06 3.0758187e-09) (600 1500 499.36886 1.129923 3.459759e-05 -3.6075175e-07 1.0426026e-10)))
	(molecular-weight (constant . 98.78215))
	(formation-enthalpy (constant . 74271808))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3414597E+06))
	)

 (diethyl-gallium 
fluid
	(chemical-formula . gaet2)
	(specific-heat (polynomial piecewise-polynomial (300 600 -140.66592 3.8321886 0.00094114907 -7.5999921e-06 5.5452999e-09) (600 1500 469.15077 1.9869635 8.1257892e-05 -6.497164e-07 1.8742828e-10)))
	(molecular-weight (constant . 127.8443))
	(formation-enthalpy (constant . 18834216))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4202432E+06))
	)

 (triethyl-gallium
fluid
	(chemical-formula . gaet3)
	(specific-heat (polynomial piecewise-polynomial (300 600 -346.7763 4.9450784 0.0012527278 -9.9307182e-06 7.2474376e-09) (600 1500 447.0405 2.5461023 0.00011229234 -8.3812141e-07 2.4222286e-10)))
	(molecular-weight (constant . 156.90645))
	(formation-enthalpy (constant . -71332008))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4727698E+06))
	)

 (gallium-hudride 
fluid
	(chemical-formula . gah)
	(specific-heat (polynomial piecewise-polynomial (300 600 414.32756 0.03980621 -2.426325e-05 3.7864045e-07 -3.4515339e-10) (600 1500 379.95047 0.15790374 -5.0847858e-06 -3.2819143e-08 5.8466427e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -5.162682e+06 7.352159e+04 3.851976e+01 7.636848e-01 -4.470418e-04 3.352668e-08 4.263340e-11) (1000.000000 6000.000000 3.829795e+08 -1.303754e+06 2.117237e+03 -9.601212e-01 3.057839e-04 -4.482749e-08 2.383987e-12) ))
	(molecular-weight (constant . 70.72797))
	(formation-enthalpy (constant . 2.2929389e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2057699E+06))
	)

 (gallium-dihydride 
fluid
	(chemical-formula . gah2)
	(specific-heat (polynomial piecewise-polynomial (300 600 412.57757 0.42614169 7.5156649e-05 -3.6037982e-07 1.8375263e-10) (600 1500 436.06789 0.37213728 2.5267751e-06 -1.0325008e-07 2.5719377e-11)))
	(molecular-weight (constant . 71.73594))
	(formation-enthalpy (constant . 1.7155227e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2343298E+06))
	)

 (gallium-trihydride
fluid
	(chemical-formula . gah3)
	(specific-heat (polynomial piecewise-polynomial (300 600 197.29243 1.2855315 0.00027974249 -2.3159964e-06 1.6538635e-09) (600 1500 382.37449 0.73141604 1.2835402e-05 -2.3612405e-07 6.6065414e-11)))
	(molecular-weight (constant . 72.74391))
	(formation-enthalpy (constant . 1.1297427e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2280561E+06))
	)

 (methyl-gallium
fluid
	(chemical-formula . game)
	(specific-heat (polynomial piecewise-polynomial (300 600 299.64524 1.1954671 0.00022878646 -2.0815176e-06 1.5148617e-09) (600 1500 471.83947 0.66944399 2.2152934e-05 -1.9799611e-07 5.6273711e-11)))
	(molecular-weight (constant . 84.75507))
	(formation-enthalpy (constant . 77513232))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2669717E+06))
	)
 
(dimethyl-gallium
 fluid
	(chemical-formula . game2)
	(specific-heat (polynomial piecewise-polynomial (300 600 188.10389 2.4299314 0.00047240298 -4.757269e-06 3.5567776e-09) (600 1500 588.92448 1.1844542 4.2664734e-05 -3.684322e-07 1.0911704e-10)))
	(molecular-weight (constant . 99.79012))
	(formation-enthalpy (constant . 68728080))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3370675E+06))
	)

 (trimethyl-gallium 
fluid
	(chemical-formula . game3)
	(specific-heat (polynomial piecewise-polynomial (300 600 153.52364 3.0129462 0.00072115466 -5.6817587e-06 4.1225131e-09) (600 1500 609.00307 1.6384658 7.552363e-05 -5.1045296e-07 1.4592572e-10)))
	(molecular-weight (constant . 114.82518))
	(formation-enthalpy (constant . -45499568))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3677218E+06))
	)

 (gasoil-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . c16h29<l>)
  (density (constant . 830) (compressible-liquid 101325 830 1.2e+09 7 1.1 0.9))
  (specific-heat (constant . 2050))
  (latent-heat (constant . 180000))
  (vaporization-temperature (constant . 352))
  (boiling-point (constant . 511))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (constant . 3.79e-06))
  (thermal-conductivity (constant . 0.135))
  (viscosity (constant . 0.00332))
  (dpm-surften (constant . 0.0190355) (polynomial piecewise-polynomial (50 548 4.93868e-02 -8.26605e-05 -1.25984e-07 2.06675e-10)))
  (vapor-pressure (polynomial piecewise-linear (352 . 1329) (372 . 2658) (394 . 5316) (405 . 7974) (427 . 13289) (455 . 26579) (483 . 53158) (511 . 101000) (555 . 202000) (600 . 505000))(constant . 1329) )
  (molecular-weight (constant . 221.16))
  )
 
 (gasoil-vapor
  fluid
  (chemical-formula . c16h29)
  (density (constant . 9.4))
  (specific-heat (constant . 2430))
  (thermal-conductivity (constant . 0.0178))
  (viscosity (constant . 7e-06))
  (molecular-weight (constant . 221.16))
  (formation-enthalpy (constant . -3.3e+08))
  (reference-temperature (constant . 298.15))
  )
 
 (gasoil-air
  mixture
  (chemical-formula . #f)
  (species (names c16h29 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c16h29 1 0.25 1) (o2 23.25 1.5 1)) ((co2 16 0 1) (h2o 14.5 0 1)) ((n2 0 1)) (stoichiometry "1c16h29 + 23.25o2 --> 16co2 + 14.5h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c16h29 1 0.25 1) (o2 23.25 1.5 1)) ((co2 16 0 1) (h2o 14.5 0 1)) ((n2 0 1)) (stoichiometry "1c16h29 + 23.25o2 --> 16co2 + 14.5h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c16h29 1 0.25 1) (o2 23.25 1.5 1)) ((co2 16 0 1) (h2o 14.5 0 1)) ((n2 0 1)) (stoichiometry "1c16h29 + 23.25o2 --> 16co2 + 14.5h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (glycerin
  fluid
  (chemical-formula . c3h8o3)
  (density (constant . 1259.9) (compressible-liquid 101325 1259.9 4.35e+09 7 1.1 0.9))
  (specific-heat (constant . 2427))
  (thermal-conductivity (constant . 0.286))
  (viscosity (constant . 0.799))
  (molecular-weight (constant . 92.0644))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 6.657E+06))
  (critical-temperature (constant . 701.18))
  (acentric-factor (constant . 1.806))
  (critical-volume (constant . 0.002769))
  )
 
 (gold
  (solid inert-particle)
  (chemical-formula . au)
  (density (constant . 19320))
  (specific-heat (constant . 129.81))
  (thermal-conductivity (constant . 297.73))
  (atomic-number (constant . 79))
  (electric-conductivity (constant . 4.098e+07))
  (magnetic-permeability (constant . 1.257e-06))
  (struct-youngs-modulus (constant . 7.9e+10))
  (struct-poisson-ratio (constant . 0.43))
  )

(gypsum
 (solid inert-particle)
 (chemical-formula . caso4_2h20)
 (density (constant . 2320))
 (specific-heat (constant . 1138))
 (thermal-conductivity (constant . 0.5))
 (molecular-weight (constant . 172.17))
 (struct-youngs-modulus (constant . 1.5e+09))
 (struct-poisson-ratio (constant . 0.3))
  )

(methyl-methylene-silane
 fluid
 (chemical-formula . h<ch3>sich2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 172.45238 5.1285729 -0.0042489026 1.972465e-06 -3.8539807e-10) (1500 2500 1793.5451 1.0213078 -1.6397998e-05 -1.1581612e-07 2.2427627e-11)))
 (molecular-weight (constant . 58.15612))
 (formation-enthalpy (constant . 1.1040435e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2986499E+06))
 )

 (atomic-hydrogen+
  fluid
  (chemical-formula . h+)
  (specific-heat (polynomial piecewise-polynomial (300 1000 20632.654 0 0 0 0) (1000 5000 20632.654 0 0 0 0)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 0.000000e+00 0.000000e+00 2.063367e+04 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (1000.000000 6000.000000 0.000000e+00 0.000000e+00 2.063367e+04 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (6000.000000 20000.000000 0.000000e+00 0.000000e+00 2.063367e+04 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) ))
  (viscosity (constant . 7.49e-06) (blottner-curve-fit 0.0603 -0.1425 -10.6827)) ; CEA table 1995
  (molecular-weight (constant . 1.00742))
  (characteristic-vibrational-temperature (constant . 0))
  (lennard-jones-length (constant . 2.05))  ; same as h
  (lennard-jones-energy (constant . 145))
  (formation-enthalpy (constant . 1.5362476e+09))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1088276E+06))
; Critical properties assumed the same as atomic-hydrogen
  (critical-pressure (constant . 1.36e+06))
  (critical-temperature (constant . 33.20))
  (critical-volume (constant . 0.0185))
  )

(atomic-hydrogen-
 fluid
 (chemical-formula . h-)
 (specific-heat (polynomial piecewise-polynomial (300 1000 20610.353 0 0 0 0) (1000 5000 20610.353 0 0 0 0)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 0.000000e+00 0.000000e+00 2.061122e+04 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (1000.000000 6000.000000 0.000000e+00 0.000000e+00 2.061122e+04 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (6000.000000 20000.000000 0.000000e+00 0.000000e+00 2.061122e+04 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) ))
 (molecular-weight (constant . 1.00852))
 (formation-enthalpy (constant . 1.3889406e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.1088393E+06))
; Critical properties assumed the same as atomic-hydrogen
  (critical-pressure (constant . 1.36e+06))
  (critical-temperature (constant . 33.20))
  (critical-volume (constant . 0.0185))
 )

(methyl-aluminum-dihydride 
 fluid
 (chemical-formula . h2alme)
 (specific-heat (polynomial piecewise-polynomial (300 600 -118.64225 5.833737 0.0010902798 -1.2250886e-05 9.2657439e-09) (600 1500 924.93144 2.5646353 4.931028e-05 -8.638964e-07 2.6148225e-10)))
 (molecular-weight (constant . 44.0325))
 (formation-enthalpy (constant . 25108194))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2582966E+06))
 )

(methyl-arsenic-dihydride
 fluid
 (chemical-formula . h2asme)
 (specific-heat (polynomial piecewise-polynomial (300 600 -191.06133 4.1260713 0.00090248552 -8.4973429e-06 6.340688e-09) (600 1500 514.03469 1.9476005 7.3994783e-05 -6.3912484e-07 1.8997798e-10)))
 (molecular-weight (constant . 91.9726))
 (formation-enthalpy (constant . 1.006343e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2713777E+06))
 )

(h2c4o
 fluid
 (chemical-formula . h2c4o)
 (specific-heat (polynomial piecewise-polynomial (300 1000 605.51136 1.653806 0.00012416234 -7.7035709e-07 2.0641163e-10) (1000 4000 1292.4465 0.61623382 -6.1483882e-05 -3.4090155e-08 6.427714e-12)))
 (molecular-weight (constant . 66.05994))
 (formation-enthalpy (constant . 2.2840674e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2779602E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 6.979E+06))
  (critical-temperature (constant . 470.96))
  (acentric-factor (constant . 0.252))
  (critical-volume (constant . 0.003088))
 )

(h2cccch-1-buten-3-yne-2-yl-radical
 fluid
 (chemical-formula . h2cccch)
 (specific-heat (polynomial piecewise-polynomial (300 1000 1065.7055 2.0228462 9.1224753e-05 -9.1679233e-07 2.7111014e-10) (1000 4000 1842.0202 0.81638452 -8.7109278e-05 -4.5998165e-08 8.796947e-12)))
 (molecular-weight (constant . 51.06851))
 (formation-enthalpy (constant . 4.6576675e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3052175E+06))
 )

(butatriene
 fluid
 (chemical-formula . h2cccch2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 614.51833 2.7351828 0.00026251818 -1.2391869e-06 3.1098802e-10) (1000 4000 1695.6824 1.149425 -0.00010866583 -6.4200766e-08 1.1780239e-11)))
 (molecular-weight (constant . 52.07648))
 (formation-enthalpy (constant . 3.158615e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2724989E+06))
; Critical Properties from Owczarek&Blazej (2004) only critical temperature available
  (critical-temperature (constant . 455.00))
 )

(propargyl-radical
 fluid
 (chemical-formula . h2ccch)
 (specific-heat (polynomial piecewise-polynomial (300 1000 1012.0506 2.3587152 5.9462896e-05 -1.1663879e-06 4.1502749e-10) (1000 4000 1879.9101 0.92753815 -8.7471788e-05 -5.0424216e-08 9.3165215e-12)))
 (molecular-weight (constant . 39.05736))
 (formation-enthalpy (constant . 3.4744326e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2572543E+06))
 )

(acetic-chloryl 
 fluid
 (chemical-formula . h2ccclo)
 (specific-heat (polynomial piecewise-polynomial (300 1500 180.30038 3.2409897 -0.0034701873 1.909142e-06 -4.1600543e-10) (1500 5000 1330.9509 0.22184877 -4.1737137e-05 -3.3670385e-10 4.9623914e-13)))
 (molecular-weight (constant . 77.49064))
 (formation-enthalpy (constant . -48265664))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2915143E+06))
 )

(vinyl-dichloro-silane
 fluid
 (chemical-formula . h2cch<sicl2h>)
 (specific-heat (polynomial piecewise-polynomial (300 1500 238.26656 2.4893142 -0.002383275 1.214042e-06 -2.5095218e-10) (1500 4000 1099.6115 0.29556491 -3.7919973e-05 -8.9518e-09 1.854577e-12)))
 (molecular-weight (constant . 127.04618))
 (formation-enthalpy (constant . -2.770832e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3586691E+06))
 )

(hydroxy-ethyl-radical
 fluid
 (chemical-formula . h2cch2oh)
 (specific-heat (polynomial piecewise-polynomial (300 1500 240.67688 5.3013884 -0.0044050979 2.1532187e-06 -4.5205613e-10) (1500 4000 2112.5677 0.96853102 -9.0186086e-05 -4.1390372e-08 7.3312742e-12)))
 (molecular-weight (constant . 45.06155))
 (formation-enthalpy (constant . -18649974))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2978182E+06))
 )

(h2ccho 
 fluid
 (chemical-formula . h2ccho)
 (specific-heat (polynomial piecewise-polynomial (300 1500 54.125112 5.2929596 -0.0049344176 2.5238755e-06 -5.3124972e-10) (1500 4000 1875.5161 0.74459367 -9.035304e-05 -2.9072813e-08 5.6814227e-12)))
 (molecular-weight (constant . 43.04561))
 (formation-enthalpy (constant . 14696145))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2588755E+06))
 )

(vinyl-silylidene
 fluid
 (chemical-formula . h2cchsi)
 (specific-heat (polynomial piecewise-polynomial (300 1500 248.21439 3.7120826 -0.0033967851 1.6677663e-06 -3.3314376e-10) (1500 2500 1415.6115 0.59444985 -1.9848509e-05 -6.1552799e-08 1.2020889e-11)))
 (molecular-weight (constant . 55.13221))
 (formation-enthalpy (constant . 4.0907898e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2759434E+06))
 )

(dichloro-vinyl-silane 
 fluid
 (chemical-formula . h2cchsicl2h)
 (specific-heat (polynomial piecewise-polynomial (300 1500 238.22213 2.4895341 -0.0023838148 1.2145323e-06 -2.510969e-10) (1500 4000 1099.7215 0.29546303 -3.7914349e-05 -8.9420967e-09 1.852901e-12)))
 (molecular-weight (constant . 127.04618))
 (formation-enthalpy (constant . -2.7530122e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3586628E+06))
 )

(vinyl-silylidene
 fluid
 (chemical-formula . h2cchsih)
 (specific-heat (polynomial piecewise-polynomial (300 1500 294.60332 3.9062255 -0.0032545588 1.4784028e-06 -2.8044072e-10) (1500 2500 1539.3702 0.73870076 -2.1932132e-05 -8.3677915e-08 1.6869628e-11)))
 (molecular-weight (constant . 56.14018))
 (formation-enthalpy (constant . 3.0786477e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2794796E+06))
 )

(vinyl-silylene
 fluid
 (chemical-formula . h2cchsih2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 67.020667 5.5646718 -0.0050785983 2.410268e-06 -4.6276945e-10) (1500 2500 1876.6009 0.7807224 -3.4117743e-05 -8.1793889e-08 1.6632476e-11)))
 (molecular-weight (constant . 57.14815))
 (formation-enthalpy (constant . 2.4356037e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2884928E+06))
 )

(vinyl-silane 
 fluid
 (chemical-formula . h2cchsih3)
 (specific-heat (polynomial piecewise-polynomial (300 1500 109.88618 5.1129195 -0.0037662399 1.4766492e-06 -2.4551942e-10) (1500 2500 1786.577 1.0960554 -2.9670249e-05 -1.3681475e-07 2.8408919e-11)))
 (molecular-weight (constant . 58.15612))
 (formation-enthalpy (constant . 86598760))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2906866E+06))
 )

(methyl-chloro-silane 
 fluid
 (chemical-formula . h2clsich3)
 (specific-heat (polynomial piecewise-polynomial (300 1500 221.0557 3.2018071 -0.0027446577 1.3273637e-06 -2.730406e-10) (1500 4000 1397.2552 0.47223185 -5.1460724e-05 -1.8145328e-08 3.4161437e-12)))
 (molecular-weight (constant . 80.59))
 (formation-enthalpy (constant . -2.0946096e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3055211E+06))
 ; Critical Properties from Smith (1994) only critical temperature available
  (critical-pressure (constant . 4.1500e6))
  (critical-temperature (constant . 449.00))

 )

(h2clsisicl3-1-chloro-2,2,2-trichlorosilane
 fluid
 (chemical-formula . h2clsisicl3)
 (specific-heat (polynomial piecewise-polynomial (300 1500 371.88401 1.2755141 -0.0014480308 7.9416644e-07 -1.6743514e-10) (1500 4000 778.09818 0.0799989 -1.8594108e-05 8.3273586e-10 1.3589032e-13)))
 (molecular-weight (constant . 199.99994))
 (formation-enthalpy (constant . -6.1322131e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.4255663E+06))
 )

(n-methanyminyl
 fluid
 (chemical-formula . h2cn)
 (specific-heat (polynomial piecewise-polynomial (300 1000 845.75358 1.6891082 0.0003176818 -4.8123882e-07 -6.9729822e-11) (1000 4000 1545.1083 0.88064065 -8.469186e-05 -4.8507612e-08 9.0257825e-12)))
 (molecular-weight (constant . 28.03379))
 (formation-enthalpy (constant . 2.4731354e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2242331E+06))
 )

(h2cnch2
 fluid
 (chemical-formula . h2cnch2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 -23.78167 6.3757143 -0.0058683901 3.019055e-06 -6.4095757e-10) (1500 4000 2105.9891 1.0261822 -0.00011497749 -4.3624901e-08 8.1072807e-12)))
 (molecular-weight (constant . 42.06088))
 (formation-enthalpy (constant . 2.3654317e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2553118E+06))
 )

(h2cnch2o
 fluid
 (chemical-formula . h2cnch2o)
 (specific-heat (polynomial piecewise-polynomial (300 1500 -28.332802 4.7847739 -0.0034827006 1.3516312e-06 -2.2970287e-10) (1500 4000 1901.223 0.69179928 -6.9581049e-05 -2.8776341e-08 5.2128069e-12)))
 (molecular-weight (constant . 58.06028))
 (formation-enthalpy (constant . 1.8822477e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2861247E+06))
 )

(methyl-isocyanate
 fluid
 (chemical-formula . h2cncho)
 (specific-heat (polynomial piecewise-polynomial (300 1500 159.73173 3.7558237 -0.002494389 8.5691855e-07 -1.3052875e-10) (1500 4000 1744.1074 0.57060247 -5.6266098e-05 -2.4728891e-08 4.4317774e-12)))
 (molecular-weight (constant . 57.05231))
 (formation-enthalpy (constant . -2335528))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2788676E+06))
; Critical Properties from Cranium Ver. 1.0.3 the software was unable to compute the critical volume
  (critical-pressure (constant . 5.603E+06))
  (critical-temperature (constant . 491.00))
  (acentric-factor (constant . 0.298))
  	)

 (h2cnh
 fluid
	(chemical-formula . h2cnh)
	(specific-heat (polynomial piecewise-polynomial (300 1000 677.32518 1.9412034 0.00069367825 -1.7629181e-07 -4.6238473e-10) (1000 4000 1494.8842 1.3594511 -0.00011964475 -7.4624464e-08 1.3464578e-11)))
	(molecular-weight (constant . 29.04176))
	(formation-enthalpy (constant . 91426104))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2320196E+06))
	)

 (h2cnnho
 fluid
	(chemical-formula . h2cnnho)
	(specific-heat (polynomial piecewise-polynomial (300 1500 83.84967 4.561519 -0.0042157061 2.0966888e-06 -4.2563963e-10) (1500 4000 1630.1967 0.63210685 -7.0871337e-05 -2.324813e-08 4.3215549e-12)))
	(molecular-weight (constant . 59.04786))
	(formation-enthalpy (constant . 2.0805427e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2807842E+06))
	)

 (nitroso-methanimynyl 
 fluid
	(chemical-formula . h2cnno)
	(specific-heat (polynomial piecewise-polynomial (300 1500 357.89175 2.8550271 -0.002231695 9.7969514e-07 -1.8812596e-10) (1500 4000 1455.7771 0.43920198 -4.4162066e-05 -1.711039e-08 3.10838e-12)))
	(molecular-weight (constant . 58.03989))
	(formation-enthalpy (constant . 2.4417918e+08))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2802710E+06))
; Critical Properties from Cranium Ver. 1.0.3 critical volume missing
    (critical-pressure (constant . 4.776E+06))
    (critical-temperature (constant . 544.44))
    (acentric-factor (constant . 0.345))
	)

 (nitro-methanimynyl
 fluid
	(chemical-formula . h2cnno2)
	(specific-heat (polynomial piecewise-polynomial (300 1000 396.89069 2.0339907 2.6883928e-05 -1.2128272e-06 4.7419648e-10) (1000 4000 1281.0699 0.51258126 -5.1659722e-05 -2.8226107e-08 5.3702471e-12)))
	(molecular-weight (constant . 74.03929))
	(formation-enthalpy (constant . 1.4075874e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3057077E+06))
; Critical Properties from Cranium Ver. 1.0.3 critical volume missing
    (critical-pressure (constant . 4.980E+06))
    (critical-temperature (constant . 676.80))
    (acentric-factor (constant . 0.378))
	)

 (nitroso-methyl-radical
 fluid
	(chemical-formula . h2cno)
	(specific-heat (polynomial piecewise-polynomial (300 1500 197.47833 4.0152405 -0.0037060671 1.8239226e-06 -3.6651213e-10) (1500 4000 1602.2569 0.49721495 -5.6976346e-05 -1.5751192e-08 3.0097452e-12)))
	(molecular-weight (constant . 44.03319))
	(formation-enthalpy (constant . 1.7332174e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2552750E+06))
	)

 (nitro-methylene
 fluid
	(chemical-formula . h2cno2)
	(specific-heat (polynomial piecewise-polynomial (300 1500 161.44545 4.0032435 -0.0039023802 1.9217426e-06 -3.7776386e-10) (1500 4000 1561.5289 0.35797497 -5.4489329e-05 -7.7765691e-09 1.9284341e-12)))
	(molecular-weight (constant . 60.03259))
	(formation-enthalpy (constant . 1.5259336e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2744087E+06))
	)

 (h2cono
 fluid
	(chemical-formula . h2cono)
	(specific-heat (polynomial piecewise-polynomial (300 1500 293.61747 3.7519641 -0.0038773855 2.048573e-06 -4.2587803e-10) (1500 4000 1489.8882 0.41317672 -5.711015e-05 -1.1213728e-08 2.3824188e-12)))
	(molecular-weight (constant . 60.03259))
	(formation-enthalpy (constant . 1.3850019e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2867942E+06))
	)

 (ethyl-gallium-dihydride
 fluid
	(chemical-formula . h2gaet)
	(specific-heat (polynomial piecewise-polynomial (300 600 34.017014 3.2771085 0.00065816002 -6.647665e-06 4.9824182e-09) (600 1500 592.84282 1.5401706 5.0779113e-05 -4.9720055e-07 1.4826892e-10)))
	(molecular-weight (constant . 100.7981))
	(formation-enthalpy (constant . -9619897))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3501479E+06))
	)

 (methyl-gallium-dihydride
 fluid
	(chemical-formula . h2game)
	(specific-heat (polynomial piecewise-polynomial (300 600 50.315978 2.7832596 0.00046416304 -5.842724e-06 4.4774104e-09) (600 1500 558.78043 1.1717474 2.9068415e-05 -3.7915146e-07 1.1742196e-10)))
	(molecular-weight (constant . 86.771))
	(formation-enthalpy (constant . 62765840))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2713725E+06))
	)

 (fluoride-nitride-dihydride
 fluid
	(chemical-formula . h2nf)
	(specific-heat (polynomial piecewise-polynomial (300 1000 616.75801 1.3964694 0.00011724131 -4.626168e-07 8.6274784e-11) (1000 3000 983.74523 0.90337648 -6.5789901e-05 -8.5223418e-08 1.8018336e-11)))
	(molecular-weight (constant . 35.02104))
	(formation-enthalpy (constant . -27147104))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2289939E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-pressure (constant . 6.876E+06))
    (critical-temperature (constant . 442.18))
    (acentric-factor (constant . 0.258))
    (critical-volume (constant . 0.002456))
	)

 (nitrosamide
 fluid
	(chemical-formula . h2nno)
	(specific-heat (polynomial piecewise-polynomial (300 1500 377.32839 3.0436719 -0.0025812138 1.2337543e-06 -2.4728478e-10) (1500 4000 1401.6696 0.54654347 -5.218353e-05 -2.2813844e-08 3.9649561e-12)))
	(molecular-weight (constant . 46.02874))
	(formation-enthalpy (constant . 76195968))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2518374E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-pressure (constant . 7.194E+06))
    (critical-temperature (constant . 522.71))
    (acentric-factor (constant . 0.414))
	)

 (h2no
 fluid
	(chemical-formula . h2no)
	(specific-heat (polynomial piecewise-polynomial (300 1500 657.053 2.2319113 -0.0014205216 5.9101503e-07 -1.2068455e-10) (1500 4000 1473.0519 0.5968796 -4.6072452e-05 -2.8651275e-08 4.8287657e-12)))
	(molecular-weight (constant . 32.02204))
	(formation-enthalpy (constant . 66178060))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2329839E+06))
 ; Critical Properties from Cranium approximated as H3NO     
  (critical-pressure (constant . 8.750e6))
  (critical-temperature (constant . 545.88))
  (acentric-factor (constant . 0.677))
  (critical-volume (constant . 0.0026))
  )

 (hydroxylamine
 fluid
	(chemical-formula . h2noh)
	(specific-heat (polynomial piecewise-polynomial (300 1500 354.17179 4.1747844 -0.0036841711 1.8421818e-06 -3.8057599e-10) (1500 4000 1702.7985 0.76700205 -6.9922921e-05 -3.1477365e-08 5.5154389e-12)))
	(molecular-weight (constant . 33.03001))
	(formation-enthalpy (constant . -50867472))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2350209E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-pressure (constant . 8.751E+06))
    (critical-temperature (constant . 545.88))
    (acentric-factor (constant . 0.677))
    (critical-volume (constant . 0.002604))
	)

(ice
 (fluid inert-particle droplet-particle)
 (chemical-formula . h2o<s>)
 (density (constant . 915))
 (specific-heat (polynomial piecewise-polynomial (200 273.15 -18.123364 7.809018 0 0 0) (273.15 273.15 0 0 0 0 0)))
 (molecular-weight (constant . 18.01534))
 (boiling-point (constant . 373))
 (formation-enthalpy (constant . -2.918437E+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.4479776E+05))
 (species-phase (constant . 1))
 ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 22.0640e6))
  (critical-temperature (constant . 647.14))
  (acentric-factor (constant . 0.344))
  (critical-volume (constant . 0.003106))   
 )

 (dimethyl-silane 
  fluid
  (chemical-formula . h2si<ch3>2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 277.16646 5.0273714 -0.003141258 1.0627491e-06 -1.5982571e-10) (1500 2500 1881.9577 1.4155543 -2.1114791e-05 -1.836607e-07 3.7555888e-11)))
  (molecular-weight (constant . 60.17206))
  (formation-enthalpy (constant . -96570872))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3089583E+06))
  )

(methyl-methylene-silane 
 fluid
 (chemical-formula . h2si<ch3>ch2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 278.31283 5.23761 -0.0041382749 1.8445406e-06 -3.5242972e-10) (1500 2500 1951.7239 1.1154634 -2.1917696e-05 -1.3104194e-07 2.595945e-11)))
 (molecular-weight (constant . 59.16409))
 (formation-enthalpy (constant . 1.0716515e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3340246E+06))
 )

(diamino-silane 
 fluid
 (chemical-formula . h2si<nh2>2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 751.24153 2.7825241 -0.00013377831 -1.7238473e-06 8.1499765e-10) (1000 4000 1742.1151 0.86497677 -7.78191e-05 -4.6617147e-08 8.4828464e-12)))
 (molecular-weight (constant . 62.14722))
 (formation-enthalpy (constant . -1.5544963e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3028742E+06))
 )

 (carbene-silene 
  fluid
  (chemical-formula . h2sic)
  (specific-heat (polynomial piecewise-polynomial (300 1500 475.44149 2.8377871 -0.0026281784 1.2610714e-06 -2.4570474e-10) (1500 2500 1445.1142 0.34154228 -2.6583132e-05 -2.8636809e-08 5.9241357e-12)))
  (molecular-weight (constant . 42.11309))
  (formation-enthalpy (constant . 6.995463e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2519563E+06))
  )

 (athynyl-silenyl-radical
  fluid
  (chemical-formula . h2sicch)
  (specific-heat (polynomial piecewise-polynomial (300 1500 445.27983 3.6312226 -0.0034895256 1.7678035e-06 -3.6100779e-10) (1500 2500 1645.9444 0.45265974 -2.4466135e-05 -3.720065e-08 6.929988e-12)))
  (molecular-weight (constant . 55.13221))
  (formation-enthalpy (constant . 3.8057242e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2795126E+06))
  )

(methylidene-silene 
 fluid
 (chemical-formula . h2sich)
 (specific-heat (polynomial piecewise-polynomial (300 1500 663.80869 2.9741944 -0.0027554955 1.3983255e-06 -2.9057219e-10) (1500 2500 1636.8503 0.45288337 -2.1039142e-05 -3.9102098e-08 7.2483813e-12)))
 (molecular-weight (constant . 43.12106))
 (formation-enthalpy (constant . 4.4110954e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2660661E+06))
 )

 (methylene-silane 
  fluid
  (chemical-formula . h2sich2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 197.78908 4.8275784 -0.0043793815 2.1522326e-06 -4.324835e-10) (1500 2500 1752.953 0.75477668 -1.8280126e-05 -7.5321309e-08 1.3848523e-11)))
  (molecular-weight (constant . 44.12903))
  (formation-enthalpy (constant . 1.7039302e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2504251E+06))
  )

 (methyl-silyl-radical 
  fluid
  (chemical-formula . h2sich3)
  (specific-heat (polynomial piecewise-polynomial (300 1500 385.79683 3.9180016 -0.0023842971 7.657224e-07 -1.0783594e-10) (1500 2500 1656.1841 1.1063816 -2.0604701e-05 -1.4268279e-07 2.9369757e-11)))
  (molecular-weight (constant . 45.137))
  (formation-enthalpy (constant . 1.3854238e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2736849E+06))
  )

 (silylene-amidogen
  fluid
  (chemical-formula . h2sin)
  (specific-heat (polynomial piecewise-polynomial (300 1000 669.04022 1.3781013 6.1243099e-05 -6.9422359e-07 2.1140136e-10) (1000 4000 1286.78 0.40064253 -4.4167285e-05 -2.1985131e-08 4.2925881e-12)))
  (molecular-weight (constant . 44.10864))
  (formation-enthalpy (constant . 6.242569e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2490121E+06)))

(silylene-aminine 
 fluid
 (chemical-formula . h2sinh)
 (specific-heat (polynomial piecewise-polynomial (300 1000 520.08979 2.2953102 -0.00015389353 -1.3658901e-06 6.5956152e-10) (1000 3000 1214.1276 0.90358786 -9.1124034e-05 -9.2412386e-08 2.0998783e-11)))
 (molecular-weight (constant . 45.11661))
 (formation-enthalpy (constant . 1.7135082e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2514506E+06)))

 (amino-silylene
  fluid
  (chemical-formula . h2sinh2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 730.62708 2.1310701 -7.8378629e-05 -1.1222556e-06 5.0451227e-10) (1000 3000 1332.4781 0.98724619 -8.0274011e-05 -9.439518e-08 2.0520427e-11)))
  (molecular-weight (constant . 46.12458))
  (formation-enthalpy (constant . 1.1754088e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2752764E+06))
  )

(h2sinh3
 fluid
 (chemical-formula . h2sinh3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 753.19456 1.9849338 0.00034429015 -6.3123685e-07 -1.4768845e-11) (1000 4000 1536.7189 1.0423862 -9.5903712e-05 -5.7301984e-08 1.0514094e-11)))
 (molecular-weight (constant . 47.13255))
 (formation-enthalpy (constant . 99802632))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2794497E+06))
 )

 (diselene 
  fluid
  (chemical-formula . h2sisih2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 708.90867 1.7302308 -6.3809427e-05 -9.1231913e-07 3.9557466e-10) (1000 3000 1241.107 0.74645352 -7.2007227e-05 -7.3384405e-08 1.6416678e-11)))
  (molecular-weight (constant . 60.20388))
  (formation-enthalpy (constant . 2.6304978e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2799090E+06))
  )

 (triethyl-gallium-arsenic-trihydride 
  fluid
  (chemical-formula . h3asgaet3)
  (specific-heat (polynomial piecewise-polynomial (300 600 -317.72816 3.8606965 0.00099532527 -7.7726587e-06 5.6634537e-09) (600 1500 301.22197 1.9939978 8.9360796e-05 -6.589997e-07 1.9019632e-10)))
  (molecular-weight (constant . 234.85196))
  (formation-enthalpy (constant . -46016204))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.5208961E+06))
  )

(trimethyl-gallium-arsenic-trihydride 
 fluid
 (chemical-formula . h3asgame3)
 (specific-heat (polynomial piecewise-polynomial (300 600 54.65356 2.6803961 0.0005976326 -5.26214e-06 3.8740102e-09) (600 1500 485.43588 1.362824 5.080384e-05 -4.3706626e-07 1.2712156e-10)))
 (molecular-weight (constant . 192.77069))
 (formation-enthalpy (constant . -19660078))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.4289270E+06))
 )

(titan-13species-gokcen
  mixture
  (chemical-formula . #f)
  (species (names (ch4 ch3 ch2 ch c2 h2 cn nh hcn n c h n2) () ()))
  (mass-diffusivity (constant-lewis-number 1.4) (unity-lewis-number . #f))
  (reactions (finite-rate ("reaction-1" ((n2 1. 1. 1.)) ((n 2. 0. 4.286)) ((c 0 4.286) (h 0 4.286)) (stoichiometry 1n2 --> 2n ) (arrhenius 7.0e+18 941197098.4 -1.6) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-2" ((ch4 1. 1. 1.)) ((ch3 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch4 --> 1ch3 + 1h ) (arrhenius 4.7e+44 492216150.4 -8.2) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-3" ((ch3 1. 1. 1.)) ((ch2 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch3 --> 1ch2 + 1h ) (arrhenius 1.02e+13 379139467.2 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-4" ((ch3 1. 1. 1.)) ((ch 1. 0. 1.) (h2 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch3 --> 1ch + 1h2 ) (arrhenius 5e+12 355858973.6 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-5" ((ch2 1. 1. 1.)) ((ch 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch2 --> 1ch + 1h ) (arrhenius 4e+12 347544511.6 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-6" ((ch2 1. 1. 1.)) ((c 1. 0. 1.) (h2 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch2 --> 1c + 1h2 ) (arrhenius 1.3e+11 246939521.4 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-7" ((ch 1. 1. 1.)) ((c 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch --> 1c + 1h ) (arrhenius 1.9e+11 280197369.4 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-8" ((c2 1. 1. 1.)) ((c 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1c2 --> 2c) (arrhenius 1.5e+13 595315479.2 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-9" ((h2 1. 1. 1.)) ((h 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1h2 --> 2h) (arrhenius 2.23e+11 402004237.7 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-10" ((cn 1. 1. 1.)) ((c 1. 0. 1.) (n 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1cn --> 1c + 1n ) (arrhenius 2.53e+11 590326802 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-11" ((nh 1. 1. 1.)) ((n 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1nh --> 1n + 1h ) (arrhenius 1.8e+11 312623771.2 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-12" ((hcn 1. 1. 1.)) ((cn 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1hcn --> 1cn + 1h ) (arrhenius 3.57e+23 522522364.39 -2.6) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-13" ((ch3 1. 1. 1.) (n 1. 1. 1.)) ((hcn 1. 0. 1.) (h 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch3 + 1n --> 1hcn + 2h ) (arrhenius 7.0e+10 0 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-14" ((ch3 1. 1. 1.) (h 1. 1. 1.)) ((ch2 1. 0. 1.) (h2 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch3 + 1h --> 1ch2 + 1h2 ) (arrhenius 6.03e+10 63189911.2 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-15" ((ch2 1. 1. 1.) (n2 1. 1. 1.)) ((hcn 1. 0. 1.) (nh 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch2 + 1n2 --> 1hcn + 1nh ) (arrhenius 4.82e+9 149660316 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-16" ((ch2 1. 1. 1.) (n 1. 1. 1.)) ((hcn 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch2 + 1n --> 1hcn + 1h ) (arrhenius 5.00e+10 0 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-17" ((ch2 1. 1. 1.) (h 1. 1. 1.)) ((ch 1. 0. 1.) (h2 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch2 + 1h --> 1ch + 1h2 ) (arrhenius 6.03e+9 -7483015.8 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-18" ((ch 1. 1. 1.) (n2 1. 1. 1.)) ((hcn 1. 0. 1.) (n 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch + 1n2 --> 1hcn + 1n ) (arrhenius 4.40e+9 91957949.72 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-19" ((ch 1. 1. 1.) (c 1. 1. 1.)) ((c2 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch + 1c --> 1c2 + 1h ) (arrhenius 2.00e+11 0 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-20" ((c2 1. 1. 1.) (n2 1. 1. 1.)) ((cn 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1c2 + 1n2 --> 2cn ) (arrhenius 1.50e+10 174603702 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-21" ((cn 1. 1. 1.) (h2 1. 1. 1.)) ((hcn 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1cn + 1h2 --> 1hcn + 1h) (arrhenius 2.95e+2 9395342.06 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-22" ((cn 1. 1. 1.) (c 1. 1. 1.)) ((c2 1. 0. 1.) (n 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1cn + 1c --> 1c2 + 1n) (arrhenius 5.00e+10 108088006 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-23" ((n 1. 1. 1.) (h2 1. 1. 1.)) ((nh 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1n + 1h2 --> 1nh + 1h) (arrhenius 1.60e+11 105177944.3 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-24" ((c 1. 1. 1.) (n2 1. 1. 1.)) ((cn 1. 0. 1.) (n 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1c + 1n2 --> 1cn + 1n) (arrhenius 5.24e+10 187906841.2 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-25" ((c 1. 1. 1.) (h2 1. 1. 1.)) ((ch 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1c + 1h2 --> 1ch + 1h) (arrhenius 4.00e+11 97279205.4 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-26" ((h 1. 1. 1.) (n2 1. 1. 1.)) ((nh 1. 0. 1.) (n 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1h + 1n2 --> 1nh + 1n) (arrhenius 3.00e+9 593652586.8 0.5) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-27" ((h 1. 1. 1.) (ch4 1. 1. 1.)) ((ch3 1. 0. 1.) (h2 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1h + 1ch4 --> 1ch3 + 1h2) (arrhenius 1.32e+1 33631998.79 3.0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )))
  (density (ideal-gas . #f))
  (specific-heat (mixing-law . #f))
  (thermal-conductivity (ideal-gas-mixing-law . #f))
  (viscosity (ideal-gas-mixing-law . #f))
  (speed-of-sound (none . #f))
  )

(titan-21species-gokcen
  mixture
  (chemical-formula . #f)
  (species (names (ch4 ch3 ch2 ch c2 h2 cn nh hcn n c h ar n2+ cn+ n+ c+ h+ ar+ e n2) () ()))
  (mass-diffusivity (constant-lewis-number 1.4) (unity-lewis-number . #f))
  (reactions (finite-rate ("reaction-1" ((n2 1. 1. 1.)) ((n 2. 0. 4.286)) ((c 0 4.286) (h 0 4.286) (e 0 428.6)) (stoichiometry 1n2 --> 2n ) (arrhenius 7.0e+18 941197098.4 -1.6) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-2" ((ch4 1. 1. 1.)) ((ch3 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch4 --> 1ch3 + 1h ) (arrhenius 4.7e+44 492216150.4 -8.2) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-3" ((ch3 1. 1. 1.)) ((ch2 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch3 --> 1ch2 + 1h ) (arrhenius 1.02e+13 379139467.2 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-4" ((ch3 1. 1. 1.)) ((ch 1. 0. 1.) (h2 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch3 --> 1ch + 1h2 ) (arrhenius 5e+12 355858973.6 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-5" ((ch2 1. 1. 1.)) ((ch 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch2 --> 1ch + 1h ) (arrhenius 4e+12 347544511.6 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-6" ((ch2 1. 1. 1.)) ((c 1. 0. 1.) (h2 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch2 --> 1c + 1h2 ) (arrhenius 1.3e+11 246939521.4 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-7" ((ch 1. 1. 1.)) ((c 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch --> 1c + 1h ) (arrhenius 1.9e+11 280197369.4 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-8" ((c2 1. 1. 1.)) ((c 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1c2 --> 2c) (arrhenius 1.5e+13 595315479.2 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-9" ((h2 1. 1. 1.)) ((h 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1h2 --> 2h) (arrhenius 2.23e+11 402004237.7 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-10" ((cn 1. 1. 1.)) ((c 1. 0. 1.) (n 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1cn --> 1c + 1n ) (arrhenius 2.53e+11 590326802 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-11" ((nh 1. 1. 1.)) ((n 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1nh --> 1n + 1h ) (arrhenius 1.8e+11 312623771.2 0) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-12" ((hcn 1. 1. 1.)) ((cn 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1hcn --> 1cn + 1h ) (arrhenius 3.57e+23 522522364.39 -2.6) (control-temperature 0.5) (use-third-body-efficiencies? . #t) (backward-reaction? . #t) )
                          ("reaction-13" ((ch3 1. 1. 1.) (n 1. 1. 1.)) ((hcn 1. 0. 1.) (h 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch3 + 1n --> 1hcn + 2h ) (arrhenius 7.0e+10 0 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-14" ((ch3 1. 1. 1.) (h 1. 1. 1.)) ((ch2 1. 0. 1.) (h2 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch3 + 1h --> 1ch2 + 1h2 ) (arrhenius 6.03e+10 63189911.2 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-15" ((ch2 1. 1. 1.) (n2 1. 1. 1.)) ((hcn 1. 0. 1.) (nh 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch2 + 1n2 --> 1hcn + 1nh ) (arrhenius 4.82e+9 149660316 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-16" ((ch2 1. 1. 1.) (n 1. 1. 1.)) ((hcn 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch2 + 1n --> 1hcn + 1h ) (arrhenius 5.00e+10 0 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-17" ((ch2 1. 1. 1.) (h 1. 1. 1.)) ((ch 1. 0. 1.) (h2 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch2 + 1h --> 1ch + 1h2 ) (arrhenius 6.03e+9 -7483015.8 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-18" ((ch 1. 1. 1.) (n2 1. 1. 1.)) ((hcn 1. 0. 1.) (n 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch + 1n2 --> 1hcn + 1n ) (arrhenius 4.40e+9 91957949.72 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-19" ((ch 1. 1. 1.) (c 1. 1. 1.)) ((c2 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1ch + 1c --> 1c2 + 1h ) (arrhenius 2.00e+11 0 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-20" ((c2 1. 1. 1.) (n2 1. 1. 1.)) ((cn 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1c2 + 1n2 --> 2cn ) (arrhenius 1.50e+10 174603702 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-21" ((cn 1. 1. 1.) (h2 1. 1. 1.)) ((hcn 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1cn + 1h2 --> 1hcn + 1h) (arrhenius 2.95e+2 9395342.06 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-22" ((cn 1. 1. 1.) (c 1. 1. 1.)) ((c2 1. 0. 1.) (n 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1cn + 1c --> 1c2 + 1n) (arrhenius 5.00e+10 108088006 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-23" ((n 1. 1. 1.) (h2 1. 1. 1.)) ((nh 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1n + 1h2 --> 1nh + 1h) (arrhenius 1.60e+11 105177944.3 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-24" ((c 1. 1. 1.) (n2 1. 1. 1.)) ((cn 1. 0. 1.) (n 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1c + 1n2 --> 1cn + 1n) (arrhenius 5.24e+10 187906841.2 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-25" ((c 1. 1. 1.) (h2 1. 1. 1.)) ((ch 1. 0. 1.) (h 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1c + 1h2 --> 1ch + 1h) (arrhenius 4.00e+11 97279205.4 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-26" ((h 1. 1. 1.) (n2 1. 1. 1.)) ((nh 1. 0. 1.) (n 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1h + 1n2 --> 1nh + 1n) (arrhenius 3.00e+9 593652586.8 0.5) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-27" ((h 1. 1. 1.) (ch4 1. 1. 1.)) ((ch3 1. 0. 1.) (h2 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1h + 1ch4 --> 1ch3 + 1h2) (arrhenius 1.32e+1 33631998.79 3.0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-28" ((n 1. 1. 1.) (n 1. 1. 1.)) ((n2+ 1. 0. 1.) (e 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1n + 1n --> 1n2+ + 1e) (arrhenius 4.40e+4 561226185 1.5) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-29" ((c 1. 1. 1.) (n 1. 1. 1.)) ((cn+ 1. 0. 1.) (e 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1c + 1n --> 1cn+ + 1e) (arrhenius 1.00e+12 1366897552.8 1.5) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-30" ((n 1. 1. 1.) (e 1. 1. 1.)) ((n+ 1. 0. 1.) (e 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1n + 1e --> 1n+ + 2e) (arrhenius 2.50e+31 1401818394.36 -3.82) (control-temperature 0.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-31" ((c 1. 1. 1.) (e 1. 1. 1.)) ((c+ 1. 0. 1.) (e 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1c + 1e --> 1c+ + 2e) (arrhenius 3.70e+28 1086866472.64 -3.00) (control-temperature 0.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-32" ((h 1. 1. 1.) (e 1. 1. 1.)) ((h+ 1. 0. 1.) (e 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1h + 1e --> 1h+ + 2e) (arrhenius 2.20e+27 1312022103.6 -2.80) (control-temperature 0.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-33" ((ar 1. 1. 1.) (e 1. 1. 1.)) ((ar+ 1. 0. 1.) (e 2. 0. 1.)) ((n2 0 1)) (stoichiometry 1ar + 1e --> 1ar+ + 2e) (arrhenius 2.50e+31 1510737745.4 -3.82) (control-temperature 0.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-34" ((cn+ 1. 1. 1.) (n 1. 1. 1.)) ((cn 1. 0. 1.) (n+ 1. 0. 1.)) ((n2 0 1)) (stoichiometry 1cn+ + 1n --> 1cn + 2n+) (arrhenius 9.80e+9 338398603.4 0) (control-temperature 1.0) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )
                          ("reaction-35" ((c+ 1. 1. 1.) (n2 1. 1. 1.)) ((n2+ 1. 0. 1.) (c 1. 0. 1.)) ((n2 0 1.)) (stoichiometry 1c+ + 1n2 --> 1n2+ + 1c) (arrhenius 1.11e11 415723100 -0.11) (control-temperature 1.) (use-third-body-efficiencies? . #f) (backward-reaction? . #t) )))
  (density (ideal-gas . #f))
  (specific-heat (mixing-law . #f))
  (thermal-conductivity (ideal-gas-mixing-law . #f))
  (viscosity (ideal-gas-mixing-law . #f))
  (speed-of-sound (none . #f))
  )

 (h3conho
  fluid
  (chemical-formula . h3conho)
  (specific-heat (polynomial piecewise-polynomial (300 1500 258.71314 3.840244 -0.0030994423 1.4316312e-06 -2.8667075e-10) (1500 4000 1673.9892 0.63969004 -6.3209979e-05 -2.6637793e-08 4.8231819e-12)))
  (molecular-weight (constant . 62.04853))
  (formation-enthalpy (constant . 27459390))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3040121E+06))
  )

 (carbene-silane 
  fluid
  (chemical-formula . h3sic)
  (specific-heat (polynomial piecewise-polynomial (300 1500 199.95123 4.2269663 -0.0037137152 1.6823037e-06 -3.1149179e-10) (1500 2500 1645.8637 0.5677883 -3.3792834e-05 -5.9026424e-08 1.246293e-11)))
  (molecular-weight (constant . 43.12106))
  (formation-enthalpy (constant . 6.1762605e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2582362E+06))
  )

 (ethynyl-silane 
  fluid
  (chemical-formula . h3sicch)
  (specific-heat (polynomial piecewise-polynomial (300 1500 250.64204 4.5597829 -0.004159569 2.0140333e-06 -3.9845051e-10) (1500 2500 1768.08 0.63656745 -2.7874615e-05 -6.2383589e-08 1.2211974e-11)))
  (molecular-weight (constant . 56.14018))
  (formation-enthalpy (constant . 2.2185966e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2679016E+06))
  )

 (methylidene-silane 
  fluid
  (chemical-formula . h3sich)
  (specific-heat (polynomial piecewise-polynomial (300 1500 322.18579 4.546727 -0.004077195 1.950926e-06 -3.8352296e-10) (1500 2500 1836.5823 0.66562572 -2.9020219e-05 -6.6679648e-08 1.3174079e-11)))
  (molecular-weight (constant . 44.12903))
  (formation-enthalpy (constant . 3.8775626e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2801083E+06))
  )

 (methylene-silane
  fluid
  (chemical-formula . h3sich2)
  (specific-heat (polynomial piecewise-polynomial (300 1500 220.98253 5.2097185 -0.0044103743 2.0327063e-06 -3.9158059e-10) (1500 2500 1934.4264 0.90397731 -2.8057282e-05 -1.0014339e-07 1.9939066e-11)))
  (molecular-weight (constant . 45.137))
  (formation-enthalpy (constant . 1.7380026e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2886043E+06))
  )

 (methyl-silane
  fluid
  (chemical-formula . h3sich3)
  (specific-heat (polynomial piecewise-polynomial (300 1500 223.4626 4.9188093 -0.0030767256 9.9142845e-07 -1.3552076e-10) (1500 2500 1841.812 1.3011197 -2.6712278e-05 -1.6971281e-07 3.5246101e-11)))
  (molecular-weight (constant . 46.14497))
  (formation-enthalpy (constant . -30332776))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2612204E+06))
  )

 (nitro-silane 
fluid
	(chemical-formula . h3sin)
	(specific-heat (polynomial piecewise-polynomial (300 1000 514.27243 2.0908417 0.00015336021 -1.0771574e-06 3.1069973e-10) (1000 4000 1467.6894 0.61839471 -6.5968609e-05 -3.4826617e-08 6.7281034e-12)))
	(molecular-weight (constant . 45.11661))
	(formation-enthalpy (constant . 9.8161485e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2382342E+06))
	)

 (nitrene-silane
fluid
	(chemical-formula . h3sinh)
	(specific-heat (polynomial piecewise-polynomial (300 1000 500.82794 2.7231827 -0.00012139064 -1.6094392e-06 7.4182558e-10) (1000 3000 1387.5097 1.0198914 -9.3902082e-05 -1.0126852e-07 2.2775676e-11)))
	(molecular-weight (constant . 46.12458))
	(formation-enthalpy (constant . 2.1480272e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2514506E+06))
	)

 (silyl-silane 
fluid
	(chemical-formula . h3sisih)
	(specific-heat (polynomial piecewise-polynomial (300 1500 510.80276 2.5827757 -0.0019758457 8.294243e-07 -1.5416347e-10) (1500 4000 1556.7007 0.3505256 -4.1409802e-05 -1.3071961e-08 2.5618849e-12)))
	(molecular-weight (constant . 60.20388))
	(formation-enthalpy (constant . 3.1365373e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2752764E+06))
	)

 (methyl-aluminum-hydride 
fluid
	(chemical-formula . halme)
	(specific-heat (polynomial piecewise-polynomial (300 600 216.20213 4.212847 0.00079632725 -8.4384755e-06 6.3265519e-09) (600 1500 929.95489 1.9897525 4.9911838e-05 -6.4227329e-07 1.9101613e-10)))
	(molecular-weight (constant . 43.02453))
	(formation-enthalpy (constant . 1.1402144e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2626866E+06))
	)

 (dimethyl-aluminum-hydride
 fluid
	(chemical-formula . halme2)
	(specific-heat (polynomial piecewise-polynomial (300 600 -213.98355 5.9552159 0.0012439767 -1.2321437e-05 9.2332675e-09) (600 1500 817.00082 2.7556904 9.1333154e-05 -9.0888436e-07 2.7162836e-10)))
	(molecular-weight (constant . 58.05959))
	(formation-enthalpy (constant . -28134740))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3152086E+06))
	)

 (methyl-aluminum-arsenic-hydride
 fluid
	(chemical-formula . hasalme)
	(specific-heat (polynomial piecewise-polynomial (300 600 179.39389 1.7382046 0.00025925851 -3.5309034e-06 2.7128288e-09) (600 1500 490.3851 0.7481235 1.7201295e-05 -2.3246635e-07 7.1902816e-11)))
	(molecular-weight (constant . 117.94613))
	(formation-enthalpy (constant . 2.3640947e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3501429E+06))
	)

 (ethyl-gallium-arsenic-hydride
 fluid
	(chemical-formula . hasgaet)
	(specific-heat (polynomial piecewise-polynomial (300 600 268.53101 1.0929924 0.00052103539 -1.1654703e-06 4.5698197e-10) (600 1500 301.54447 1.1138674 4.3147137e-05 -3.5782379e-07 8.6997987e-11)))
	(molecular-weight (constant . 174.71173))
	(formation-enthalpy (constant . 2.8933811e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4070449E+06))
	)

 (methylgallium-arsenic-hydride
 fluid
	(chemical-formula . hasgame)
	(specific-heat (polynomial piecewise-polynomial (300 600 251.42682 0.90572521 0.00014653654 -1.6081461e-06 1.1898188e-09) (600 1500 388.48652 0.48006839 9.78946e-06 -1.4332282e-07 4.1374235e-11)))
	(molecular-weight (constant . 160.68463))
	(formation-enthalpy (constant . 2.928953e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3677142E+06))
	)

 (methylarsenic-hydride 
fluid
	(chemical-formula . hasme)
	(specific-heat (polynomial piecewise-polynomial (300 600 -14.396664 3.3353409 0.00076164636 -6.6126215e-06 4.8725691e-09) (600 1500 525.85895 1.6834519 6.849029e-05 -5.4109153e-07 1.5778215e-10)))
	(molecular-weight (constant . 90.96464))
	(formation-enthalpy (constant . 1.781455e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2757676E+06))
	)

 (dimethylarsenic-hydride
 fluid
	(chemical-formula . hasme2)
	(specific-heat (polynomial piecewise-polynomial (300 600 -22.812773 2.9253824 0.0006538427 -5.8479877e-06 4.3359262e-09) (600 1500 458.89301 1.4446327 6.3274228e-05 -4.6032674e-07 1.3541653e-10)))
	(molecular-weight (constant . 105.99969))
	(formation-enthalpy (constant . 75737408))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3282830E+06))
	)

 (hcccl
 fluid
	(chemical-formula . hcccl)
	(specific-heat (polynomial piecewise-polynomial (300 1500 408.18041 2.1762822 -0.0024566077 1.3990216e-06 -3.0682009e-10) (1500 4000 1064.4256 0.22250858 -3.3897992e-05 -3.9993208e-09 1.034116e-12)))
	(molecular-weight (constant . 60.48327))
	(formation-enthalpy (constant . 2.299363e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2397327E+06))
; Critical Properties from Cranium Ver. 1.0.3
   (critical-pressure (constant . 5.926E+06))
   (critical-temperature (constant . 459.87))
   (acentric-factor (constant . 0.130))
   (critical-volume (constant . 0.002662))
	)

 (hcchcch-1-butyn-3-enyl-radical 
fluid
	(chemical-formula . hcchcch)
	(specific-heat (polynomial piecewise-polynomial (300 1000 676.28326 2.8105259 -3.8900814e-05 -1.6585206e-06 7.0666689e-10) (1000 4000 1750.6271 0.8760924 -9.0352291e-05 -4.9693198e-08 9.380548e-12)))
	(molecular-weight (constant . 51.06851))
	(formation-enthalpy (constant . 5.434439e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2889623E+06))
	)
 
(ketyl-radical 
fluid
	(chemical-formula . hcco)
	(specific-heat (polynomial piecewise-polynomial (300 1000 1022.9304 0.90246227 4.5964952e-05 -3.0033478e-07 4.5609495e-11) (1000 4000 1369.4703 0.40536534 -4.1087861e-05 -2.1097718e-08 3.9822503e-12)))
	(molecular-weight (constant . 41.02967))
	(formation-enthalpy (constant . 1.7758813e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2541342E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.), acentric factor missing     
  (critical-pressure (constant . 6.58E+06))
  (critical-temperature (constant . 475.33))
  (acentric-factor (constant . 0.100))  
  (critical-volume (constant . 0.0029))       
)

 (methanoic-acid
fluid
	(chemical-formula . hccoh)
	(specific-heat (polynomial piecewise-polynomial (300 1000 771.24879 1.9187099 -6.1694701e-05 -1.0952705e-06 4.8768044e-10) (1000 4000 1449.4195 0.65988714 -5.9823594e-05 -3.5227288e-08 6.4183977e-12)))
	(molecular-weight (constant . 42.03764))
	(formation-enthalpy (constant . 85480120))
	(reference-temperature (constant . 298))
    (formation-entropy (constant .  0.2456154E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-pressure (constant . 8.546E+06))
    (critical-temperature (constant . 503.55))
    (acentric-factor (constant . 0.551))
    (critical-volume (constant . 0.003093))
	)

 (dichloro-ethynyl-silane
fluid
	(chemical-formula . hccsicl2h)
	(specific-heat (polynomial piecewise-polynomial (300 1500 322.30822 2.1157984 -0.0023753764 1.3188926e-06 -2.8248858e-10) (1500 4000 984.51289 0.17296054 -3.0796872e-05 -1.5968841e-09 6.5251099e-13)))
	(molecular-weight (constant . 125.03024))
	(formation-enthalpy (constant . -1.3288357e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3432942E+06))
	)

 (hydrogen-chloride
fluid
	(chemical-formula . hcl)
	(specific-heat (polynomial piecewise-polynomial (300 1000 761.29925 0.28919422 -0.00083618148 1.07267e-06 -4.186729e-10) (1000 5000 628.31005 0.33602657 -0.00011336149 1.8490497e-08 -1.1566027e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 4.703520e+06 -7.054108e+04 1.203005e+03 -1.101175e+00 1.412887e-03 -6.932460e-07 1.121223e-10) (1000.000000 6000.000000 2.088330e+08 -6.317954e+05 1.362204e+03 -8.277407e-02 1.079889e-05 6.408512e-10 -1.517856e-13) ))
	(molecular-weight (constant . 36.46097))
	(formation-enthalpy (constant . -92320736))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.1867978E+06))
; Critical Properties from Cranium Ver. 1.0.3
    (critical-temperature (constant . 324.70))
    (critical-pressure (constant . 8.310000E+006))
    (critical-volume (constant . 2.221558E-003))
    (acentric-factor (constant . 0.121))
	)

 (dichloro-methyl-silane 
fluid
	(chemical-formula . hcl2sich3)
	(specific-heat (polynomial piecewise-polynomial (300 1500 300.33088 2.1647028 -0.0020234157 1.0357566e-06 -2.1778435e-10) (1500 4000 1054.7801 0.2895553 -3.4827916e-05 -9.6585949e-09 1.9144768e-12)))
	(molecular-weight (constant . 115.03503))
	(formation-enthalpy (constant . -3.9398496e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3369666E+06))
	)

 (hcl2sisicl2h-1,1,2,2-tetrachloro-silane 
fluid
	(chemical-formula . hcl2sisicl2h)
	(specific-heat (polynomial piecewise-polynomial (300 1500 341.54073 1.3680212 -0.0015648811 8.6097221e-07 -1.8165865e-10) (1500 4000 774.51927 0.082805491 -1.9551813e-05 9.9496824e-10 1.2459442e-13)))
	(molecular-weight (constant . 199.99994))
	(formation-enthalpy (constant . -6.0771424e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4229524E+06))
	)

 (chloro-acetic-chloryl
fluid
	(chemical-formula . hclccclo)
	(specific-heat (polynomial piecewise-polynomial (300 1500 228.98091 2.2383375 -0.0024497442 1.3194374e-06 -2.7633854e-10) (1500 4000 952.89319 0.17051445 -3.4181823e-05 -2.185038e-09 8.5301542e-13)))
	(molecular-weight (constant . 111.93567))
	(formation-enthalpy (constant . -81312856))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3238852E+06))
	)

 (hclccho
fluid
	(chemical-formula . hclccho)
	(specific-heat (polynomial piecewise-polynomial (300 1500 165.73414 3.0926965 -0.0031344159 1.6714498e-06 -3.6035237e-10) (1500 5000 1317.7873 0.22921489 -4.0310011e-05 -1.4456621e-09 6.26055e-13)))
	(molecular-weight (constant . 77.49064))
	(formation-enthalpy (constant . -25233310))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2932902E+06))
	)

 (dimethyl-chloro-silane 
fluid
	(chemical-formula . hclsi<ch3>2)
	(specific-heat (polynomial piecewise-polynomial (300 1500 301.29143 3.4099701 -0.002740159 1.3039713e-06 -2.7221091e-10) (1500 4000 1564.0886 0.60320771 -5.8681192e-05 -2.5630868e-08 4.6143245e-12)))
	(molecular-weight (constant . 94.6171))
	(formation-enthalpy (constant . -2.8492221e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3495249E+06))
	)

 (methyl-methylene-chloro-silane 
fluid
	(chemical-formula . hclsi<ch3>ch2)
	(specific-heat (polynomial piecewise-polynomial (300 1500 312.52763 3.4361633 -0.0031788497 1.6493289e-06 -3.5323392e-10) (1500 4000 1496.6096 0.51241485 -5.6512939e-05 -1.8810295e-08 3.5571527e-12)))
	(molecular-weight (constant . 93.60912))
	(formation-enthalpy (constant . -79745504))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3620395E+06))
	)

 (chloro-silene 
fluid
	(chemical-formula . hclsich2)
	(specific-heat (polynomial piecewise-polynomial (300 1500 246.70558 2.870068 -0.003008939 1.632141e-06 -3.4799579e-10) (1500 4000 1158.296 0.32416333 -4.2935234e-05 -8.3948691e-09 1.7454728e-12)))
	(molecular-weight (constant . 78.57407))
	(formation-enthalpy (constant . 10830043))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2860970E+06))
	)

 (chloro-methyl-silyl-radical 
fluid
	(chemical-formula . hclsich3)
	(specific-heat (polynomial piecewise-polynomial (300 1500 319.84998 2.5266591 -0.0021653152 1.0622096e-06 -2.219171e-10) (1500 4000 1236.4061 0.39723175 -4.2357963e-05 -1.5451155e-08 2.8802154e-12)))
	(molecular-weight (constant . 79.58203))
	(formation-enthalpy (constant . -37784716))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3096548E+06))
	)

 (hclsisi
 fluid
	(chemical-formula . hclsisi)
	(specific-heat (polynomial piecewise-polynomial (300 1500 449.38694 1.0505215 -0.0011745997 6.4382551e-07 -1.3643872e-10) (1500 4000 786.83078 0.074970257 -1.6413802e-05 3.7940468e-10 1.7273428e-13)))
	(molecular-weight (constant . 92.63297))
	(formation-enthalpy (constant . 2.8055594e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2985337E+06))
	)

 (hydrogen-cyanide 
fluid
	(chemical-formula . hcn)
	(specific-heat (polynomial piecewise-polynomial (300 1000 766.17651 2.6492113 -0.0031719182 2.3016404e-06 -6.8577274e-10) (1000 5000 1122.9255 1.0647564 -0.00039202464 6.8224895e-08 -4.5444522e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.799130e+07 -3.810789e+05 2.683152e+03 -2.008453e+00 2.729738e-03 -1.479481e-06 2.866697e-10) (1000.000000 6000.000000 3.805370e+08 -1.368065e+06 2.996217e+03 -1.801438e-01 3.300684e-05 -3.117779e-09 1.030253e-13) ))
  (viscosity (blottner-curve-fit -0.1050 2.5046 -20.4063))  ; CEA table 1995
  (characteristic-vibrational-temperature (constant . 1024)) ; ref nist webbook
  (lennard-jones-length (constant . 3.630))  ; Svehla 1963
  (lennard-jones-energy (constant . 569.1))
	(molecular-weight (constant . 27.02582))
	(formation-enthalpy (constant . 1.3514917e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2017378E+06))
 ; Critical Properties from Somayajulu (1989)
    (critical-pressure (constant . 5.3900e6))
    (critical-temperature (constant . 456.79))
    (critical-volume (constant . 0.005143))
    (acentric-factor (constant . 3.88000E-01))
	)

 (hcnh
fluid
	(chemical-formula . hcnh)
	(specific-heat (polynomial piecewise-polynomial (300 1000 818.40715 1.8101593 0.00022875873 -6.118779e-07 5.7297393e-11) (1000 4000 1460.1638 0.98847994 -9.9974977e-05 -5.6398748e-08 1.0474786e-11)))
	(molecular-weight (constant . 28.03379))
	(formation-enthalpy (constant . 2.765953e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2338956E+06))
	)

 (hcno 
fluid
	(chemical-formula . hcno)
	(specific-heat (polynomial piecewise-polynomial (250 1000 615.45283 1.8845709 -0.00024739076 -1.1909792e-06 6.2345637e-10) (1000 4000 1293.2645 0.45766997 -4.5827868e-05 -2.4648261e-08 4.6516337e-12)))
	(molecular-weight (constant . 43.02522))
	(formation-enthalpy (constant . 1.6078654e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2250706E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)    
  (critical-pressure (constant . 5.687e+06))
  (critical-temperature (constant . 544.80))
  (acentric-factor (constant . 0.100))  
  (critical-volume (constant . 0.0021))    


	)

 (formyl-radical
fluid
	(chemical-formula . hco)
	(specific-heat (polynomial piecewise-polynomial (300 1000 830.42459 1.7761694 -0.0027571907 3.122549e-06 -1.3107888e-09) (1000 5000 1019.2236 0.95856791 -0.00038250378 7.0786436e-08 -4.9104957e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -3.409413e+06 6.164964e+04 7.822733e+02 5.176471e-01 1.428098e-03 -1.666005e-06 5.357093e-10) (1000.000000 6000.000000 1.980289e+08 -1.043883e+06 2.746965e+03 -3.165821e-01 8.107269e-05 -1.013727e-08 4.984694e-13) ))
	(molecular-weight (constant . 29.01852))
	(formation-enthalpy (constant . 43509884))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2245154E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)    
  (critical-pressure (constant . 7.79E+06))
  (critical-temperature (constant . 420.62))
  (acentric-factor (constant . 0.280))  
  (critical-volume (constant . 0.0034))       
	)

 (formyl-radical+ 
  fluid
  (chemical-formula . hco+)
  (specific-heat (polynomial piecewise-polynomial (300 1000 715.30178 2.4900802 -0.0030384279 2.2586072e-06 -6.9292481e-10) (1000 5000 1057.867 0.98986289 -0.00037721555 6.6575261e-08 -4.4529583e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 3.390160e+07 -4.597904e+05 3.057799e+03 -3.349284e+00 4.627365e-03 -2.859118e-06 6.808878e-10) (1000.000000 6000.000000 3.448854e+08 -1.278219e+06 2.846018e+03 -2.160675e-01 3.872731e-05 -3.733049e-09 1.496007e-13) (6000.000000 20000.000000 -4.349752e+08 -1.583577e+05 2.180722e+03 -3.396666e-03 2.020336e-07 -6.292086e-12 7.998488e-17) ))
  (molecular-weight (constant . 29.01797))
  (formation-enthalpy (constant . 8.3307654e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2033280E+06))
  )

(formic-acid
 fluid
 (chemical-formula . hcooh)
 (specific-heat (polynomial piecewise-polynomial (300 1500 168.46995 3.4159958 -0.002808962 1.3169063e-06 -2.6802178e-10) (1500 4000 1437.8782 0.54636613 -6.2037814e-05 -2.396737e-08 4.5526837e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -5.250281e+06 1.383497e+05 -6.012836e+02 5.089900e+00 -4.281512e-03 2.106505e-06 -5.042647e-10) (1000.000000 6000.000000 8.801579e+07 -1.378754e+06 3.852869e+03 -7.953150e-01 1.990752e-04 -2.464667e-08 1.201028e-12) ))
 (molecular-weight (constant . 46.02589))
 (formation-enthalpy (constant . -3.8748765e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2479868E+06))
 ;; Critical temperature and pressure  from Polling et al. 
 ;; acentric-factor &  critical-volume from http://www.cheric.org/research/kdb/hcprop/cmpsrch.php
 (critical-pressure (constant . 5.807e6))
 (critical-temperature (constant . 588.00))
 (critical-volume (constant . 2.715619E-003)) 
 (acentric-factor (constant . 4.73000E-01))
 )

 (helium+
  fluid
  (chemical-formula . he+)
  (specific-heat (polynomial piecewise-polynomial (300 1000 5193.794 0 0 0 0) (1000 5000 5193.794 0 0 0 0)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 0.000000e+00 0.000000e+00 5.193879e+03 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (1000.000000 6000.000000 0.000000e+00 0.000000e+00 5.193879e+03 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (6000.000000 20000.000000 0.000000e+00 0.000000e+00 5.193879e+03 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) ))
  (molecular-weight (constant . 4.00206))
  (formation-enthalpy (constant . 2.3785323e+09))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1317944E+06))
;; critical properties assumed the same as helium
  (critical-pressure (constant . 0.2290e6))
  (critical-temperature (constant . 5.30))
  (critical-volume (constant . 0.014441))
  (acentric-factor (constant . -0.390))
  )

(helium
 (fluid inert-particle)
 (chemical-formula . he)
 (density (constant . 0.1625))
 (specific-heat (constant . 5193) (polynomial piecewise-polynomial (300 1000 5193.0867 0 0 0 0) (1000 5000 5193.0867 0 0 0 0)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 0.000000e+00 0.000000e+00 5.193167e+03 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (1000.000000 6000.000000 0.000000e+00 0.000000e+00 5.193167e+03 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (6000.000000 20000.000000 7.056154e+09 -4.557602e+06 6.398464e+03 -1.676138e-01 1.298870e-05 -5.348942e-10 9.202210e-15) ))
  (thermal-conductivity (constant . 0.152))
  (viscosity (constant . 1.99e-05))
  (molecular-weight (constant . 4.0026))
  (formation-enthalpy (constant . 0))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 126029.45))
 ; Critical Properties from Somayajulu (1989) and  Polling et al.
  (critical-pressure (constant . 0.2290e6))
  (critical-temperature (constant . 5.30))
  (critical-volume (constant . 0.014441))
  (acentric-factor (constant . -0.390))
  )  
  
 (helium-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . he<l>)
    ;; all properties from http://webbook.nist.gov constant properties at NBP
  (density (constant . 124.74))
  (specific-heat (constant . 5297.1))
  (thermal-conductivity (constant . 0.018656))
  (viscosity (constant . 3.1606e-06))
  (molecular-weight (constant . 4.0026))
  (formation-enthalpy (constant .  0))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 126029.45))
  (latent-heat (constant . 20752))	
  (vaporization-temperature (constant . 2.2))
  (boiling-point (constant . 4.23))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (constant . 5.0e-04)) ; rough guess
  (vapor-pressure (polynomial piecewise-linear (2.2 . 5147.7) (2.7 . 14544) (3.2 . 31661) (3.7 . 58879) (4.2 . 98470) (4.7 . 153010) (5.30 . 0.2290e6))(constant . 14544) )
  )
  
(ethyl-gallium-hydride
 fluid
 (chemical-formula . hgaet)
 (specific-heat (polynomial piecewise-polynomial (300 600 96.922791 2.7346822 0.00056370781 -5.423637e-06 4.0291098e-09) (600 1500 548.24678 1.3415343 4.1738661e-05 -4.3201753e-07 1.2698415e-10)))
 (molecular-weight (constant . 99.79012))
 (formation-enthalpy (constant . 95821120))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3501452E+06))
 )

(diethyl-gallium-hydride 
 fluid
 (chemical-formula . hgaet2)
 (specific-heat (polynomial piecewise-polynomial (300 600 -95.92301 3.3667421 0.00087519522 -6.5299296e-06 4.7232191e-09) (600 1500 420.14947 1.819478 9.1546506e-05 -5.807964e-07 1.6601893e-10)))
 (molecular-weight (constant . 128.85226))
 (formation-enthalpy (constant . -9619057))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.4205543E+06))
 )

(methyl-gallium-hydride
 fluid
 (chemical-formula . hgame)
 (specific-heat (polynomial piecewise-polynomial (300 600 173.02337 1.995973 0.00034401196 -3.986328e-06 3.014014e-09) (600 1500 515.58316 0.92010302 2.2076078e-05 -2.9132799e-07 8.7617689e-11)))
 (molecular-weight (constant . 85.76304))
 (formation-enthalpy (constant . 1.2134367e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2757626E+06))
 )

(dimethyl-gallium-hydride 
 fluid
 (chemical-formula . hgame2)
 (specific-heat (polynomial piecewise-polynomial (300 600 74.559548 2.6929556 0.00044453217 -5.6209495e-06 4.2482481e-09) (600 1500 557.54943 1.1763222 -9.6839457e-06 -4.1254099e-07 1.2395735e-10)))
 (molecular-weight (constant . 100.7981))
 (formation-enthalpy (constant . 10463720))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3326759E+06))
 )

(ethyl-methyl-gallium-hydride
 fluid
 (chemical-formula . hmegaet)
 (specific-heat (polynomial piecewise-polynomial (300 600 -150.54794 3.8905735 0.00085517293 -7.9639036e-06 5.9299481e-09) (600 1500 508.70453 1.8571284 6.9650637e-05 -6.0850078e-07 1.8022231e-10)))
 (molecular-weight (constant . 114.82518))
 (formation-enthalpy (constant . 16741886))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3720166E+06))
 )

(hn<oh>2 
 fluid
 (chemical-formula . hn<oh>2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 55.014677 4.8339134 -0.0046700817 2.2677652e-06 -4.361184e-10) (1500 4000 1689.6204 0.48579797 -6.4659123e-05 -1.2622339e-08 2.7304262e-12)))
 (molecular-weight (constant . 49.02941))
 (formation-enthalpy (constant . -1.030968e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2598098E+06))
; Critical Properties from Cranium Ver. 1.0.3 critical volume missing
  (critical-pressure (constant . 9.593E+06))
  (critical-temperature (constant . 599.54))
  (acentric-factor (constant . 1.269))
 )

(hydrogen-azide
 fluid
 (chemical-formula . hn3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 699.68861 1.1653323 7.8344579e-05 -4.9182408e-07 1.1930599e-10) (1000 4000 1163.8309 0.47425789 -4.6458032e-05 -2.556388e-08 4.7808074e-12)))
 (molecular-weight (constant . 43.02807))
 (formation-enthalpy (constant . 3.0071254e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2390996E+06))
 )

(cyanamidyl-radical 
 fluid
 (chemical-formula . hncn)
 (specific-heat (polynomial piecewise-polynomial (300 1500 598.13941 2.522776 -0.0023537498 1.1724277e-06 -2.3808867e-10) (1500 4000 1469.4488 0.32164435 -4.0436031e-05 -9.8111369e-09 2.0076955e-12)))
 (molecular-weight (constant . 41.03252))
 (formation-enthalpy (constant . 3.198039e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2483698E+06))
 )

(carbodiimid
 fluid
 (chemical-formula . hncnh)
 (specific-heat (polynomial piecewise-polynomial (300 1500 198.16243 4.87308 -0.0054579922 3.030767e-06 -6.4636697e-10) (1500 4000 1656.1525 0.46795169 -6.9265398e-05 -8.6842747e-09 2.169257e-12)))
 (molecular-weight (constant . 42.04049))
 (formation-enthalpy (constant . 1.4941568e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2402708E+06))
 )

(isocyanic-acid-vapor
 fluid
 (chemical-formula . hnco)
 (specific-heat (polynomial piecewise-polynomial (300 1000 713.85253 1.2864669 -9.7674265e-06 -6.7121376e-07 2.6292107e-10) (1000 4000 1200.4023 0.44390657 -4.2825212e-05 -2.3615192e-08 4.3912747e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.463127e+07 -1.846757e+05 1.296373e+03 9.226842e-01 -9.833007e-04 7.357723e-07 -2.322473e-10) (1000.000000 6000.000000 2.429844e+08 -9.736321e+05 2.414866e+03 -1.347971e-01 2.159422e-05 -1.843557e-09 6.479283e-14) ))
 (molecular-weight (constant . 43.02522))
 (formation-enthalpy (constant . -1.0417432e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2387245E+06))
 )

(difluoro-amine-radical
 fluid
 (chemical-formula . hnf)
 (specific-heat (polynomial piecewise-polynomial (300 1000 794.38902 0.7973363 1.0647168e-05 -2.6895759e-07 7.154324e-11) (1000 3000 1010.3465 0.46739339 -3.9730455e-05 -4.2202555e-08 9.1512827e-12)))
 (molecular-weight (constant . 34.01307))
 (formation-enthalpy (constant . 1.3387933e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2300330E+06))
 )

(difluoro-amine
 fluid
 (chemical-formula . hnf2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 403.52089 1.3742581 -3.6495524e-05 -7.8433158e-07 3.3624026e-10) (1000 3000 894.75349 0.47834709 -4.4335676e-05 -4.5847335e-08 1.0274702e-11)))
 (molecular-weight (constant . 53.01147))
 (formation-enthalpy (constant . -57715036))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2513082E+06))
 ; Critical Properties from Somayajulu (1989)  acentric factor missing
  (critical-pressure (constant . 6.2840e6))
  (critical-temperature (constant . 403.00))
  (critical-volume (constant . 0.001834))
 )

(nitrosoamide 
 fluid
 (chemical-formula . hnnho)
 (specific-heat (polynomial piecewise-polynomial (300 1500 144.05469 3.058435 -0.0020611846 7.5888575e-07 -1.2511441e-10) (1500 4000 1347.9513 0.56240671 -4.7227287e-05 -2.5191186e-08 4.2690075e-12)))
 (molecular-weight (constant . 46.02874))
 (formation-enthalpy (constant . 91482280))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2453257E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 7.194E+06))
  (critical-temperature (constant . 522.71))
  (acentric-factor (constant . 0.414))
 )

(hnno 
 fluid
 (chemical-formula . hnno)
 (specific-heat (polynomial piecewise-polynomial (300 1500 413.36409 2.5101411 -0.002178964 9.9596221e-07 -1.8668327e-10) (1500 4000 1291.1231 0.34645015 -3.9236365e-05 -1.2392756e-08 2.2724759e-12)))
 (molecular-weight (constant . 45.02077))
 (formation-enthalpy (constant . 2.3095613e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2532657E+06))
 )

(hnnono
 fluid
 (chemical-formula . hnnono)
 (specific-heat (polynomial piecewise-polynomial (300 1500 292.85572 2.9094388 -0.0027459388 1.3125015e-06 -2.5474404e-10) (1500 4000 1381.6225 0.22367948 -4.0719846e-05 -3.8333299e-09 1.2088156e-12)))
 (molecular-weight (constant . 75.02687))
 (formation-enthalpy (constant . 2.4683232e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2969614E+06))
 )

(nitrosyl-hydride 
 fluid
 (chemical-formula . hno)
 (specific-heat (polynomial piecewise-polynomial (300 1000 746.4504 1.7719328 -0.0024932302 2.5301607e-06 -1.006154e-09) (1000 5000 969.15812 0.86121214 -0.00033787472 6.0782346e-08 -4.118385e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.837681e+07 2.560674e+05 -1.608726e+02 2.143393e+00 -1.754693e-04 -9.840978e-07 4.781508e-10) (1000.000000 6000.000000 -1.554270e+09 5.217814e+06 -5.774262e+03 4.821066e+00 -1.334745e-03 1.716226e-07 -8.430337e-12) ))
 (molecular-weight (constant . 31.01407))
 (formation-enthalpy (constant . 99575256))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2205940E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 9.088E+06))
  (critical-temperature (constant . 405.03))
  (acentric-factor (constant . 0.100))
  (critical-volume (constant . 0.00292))
 )

(hno2
 fluid
 (chemical-formula . hno2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 342.17644 1.7862505 -0.00087799317 1.5387947e-07 -4.1102366e-13) (1500 4000 1145.9235 0.35286456 -3.0778756e-05 -1.7147166e-08 3.0090684e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.519518e+06 2.128680e+04 1.664713e+02 3.436061e+00 -3.984805e-03 2.448684e-06 -6.143076e-10) (1000.000000 6000.000000 1.554167e+08 -7.057237e+05 2.099862e+03 -8.633785e-02 1.261605e-05 -9.508151e-10 2.797423e-14) ))
 (molecular-weight (constant . 47.01347))
 (formation-enthalpy (constant . -59216508))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2374008E+06))
 )

(nitric-acid
 fluid
 (chemical-formula . hno3)
 (density (constant . 1504)) ; density,viscosity from perry's handbook
 (specific-heat (polynomial piecewise-polynomial (300 1000 178.54829 2.9292483 -0.0026109758 1.1576881e-06 -2.1881834e-10) (1000 5000 924.13404 0.76680728 -0.00030793561 5.6589483e-08 -3.9048107e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.214307e+06 1.443222e+04 -5.965460e+01 3.938558e+00 -4.210005e-03 2.270748e-06 -4.991160e-10) (1000.000000 6000.000000 -1.253224e+07 -3.606192e+05 1.912501e+03 -1.032086e-01 2.246683e-05 -2.547329e-09 1.170446e-13) ))
 (molecular-weight (constant . 63.01287))
 (viscosity (constant . 0.0011))
 (formation-enthalpy (constant . -1.3430994e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2663892E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 8.058E+06))
  (critical-temperature (constant . 647.29))
  (acentric-factor (constant . 0.768))
  (critical-volume (constant . 0.002158))
 )

(hydroxylamine-radical
 fluid
 (chemical-formula . hnoh)
 (specific-heat (polynomial piecewise-polynomial (300 1500 551.81523 2.7685398 -0.0019739685 8.0013046e-07 -1.4868524e-10) (1500 4000 1660.7196 0.47282962 -4.8576615e-05 -2.036772e-08 3.7514845e-12)))
 (molecular-weight (constant . 32.02204))
 (formation-enthalpy (constant . 88120664))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2333933E+06))
 )

(methanediol
 fluid
 (chemical-formula . hoch2oh)
 (specific-heat (polynomial piecewise-polynomial (300 1500 -113.33782 5.8456289 -0.0054646788 2.6517242e-06 -5.1820005e-10) (1500 4000 1884.7565 0.69233504 -8.1852577e-05 -2.2428649e-08 4.4177471e-12)))
 (molecular-weight (constant . 48.04183))
 (formation-enthalpy (constant . -4.0388768e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2565353E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 1.031E+07))
  (critical-temperature (constant . 567.19))
  (acentric-factor (constant . 1.223))
  (critical-volume (constant . 0.002727))
 )

(hypochlorous-acid
 fluid
 (chemical-formula . hocl)
 (specific-heat (polynomial piecewise-polynomial (300 1500 453.49745 1.1307301 -0.0011587104 6.3081953e-07 -1.3481658e-10) (1500 4000 785.0149 0.17434529 -1.9910791e-05 -5.3092691e-09 1.0245467e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.567865e+06 5.656633e+04 2.286938e+01 2.564782e+00 -3.455107e-03 2.391173e-06 -6.534914e-10) (1000.000000 6000.000000 1.352311e+08 -4.516133e+05 1.259980e+03 -1.672371e-02 -2.326522e-06 7.250913e-10 -4.837686e-14) ))
 (molecular-weight (constant . 52.46037))
 (formation-enthalpy (constant . -77990464))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2357280E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 1.025E+07))
  (critical-temperature (constant . 501.57))
  (acentric-factor (constant . 0.648))
  (critical-volume (constant . 0.002040))
 )

(cyanic-acid
 fluid
 (chemical-formula . hocn)
 (specific-heat (polynomial piecewise-polynomial (250 1000 701.14353 1.0945663 -2.2613452e-05 -4.5385881e-07 1.5491169e-10) (1000 4000 1090.9763 0.44411318 -4.1791381e-05 -2.3475238e-08 4.3260167e-12)))
 (molecular-weight (constant . 43.02522))
 (formation-enthalpy (constant . -9548452))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2478650E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 7.548E+06))
  (critical-temperature (constant . 604.88))
  (acentric-factor (constant . 0.780))
  (critical-volume (constant . 0.003207))
 )

(hydrocarboxyl-radical
 fluid
 (chemical-formula . hoco)
 (specific-heat (polynomial piecewise-polynomial (300 1500 422.03816 2.4959595 -0.0021431509 9.3213019e-07 -1.6681587e-10) (1500 4000 1388.4285 0.23252947 -3.5292327e-05 -5.7925869e-09 1.3939763e-12)))
 (molecular-weight (constant . 45.01792))
 (formation-enthalpy (constant . -1.9368266e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2515311E+06))
 )

(nitrous-acid
 fluid
 (chemical-formula . hono)
 (specific-heat (polynomial piecewise-polynomial (300 1000 405.05991 2.4934499 -0.0024190833 1.3261605e-06 -3.3193098e-10) (1000 5000 970.35781 0.74596529 -0.00029165115 5.2557678e-08 -3.5744036e-12)))
 (molecular-weight (constant . 47.01347))
 (formation-enthalpy (constant . -76739296))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2515311E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 7.641E+06))
  (critical-temperature (constant . 521.48))
  (acentric-factor (constant . 0.723))
 )

(hydrogen-nitrate
 fluid
 (chemical-formula . hono2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 103.94321 3.1434043 -0.0029106965 1.3643928e-06 -2.6031182e-10) (1500 4000 1287.2915 0.25082367 -4.2750978e-05 -5.2470425e-09 1.4518545e-12)))
 (molecular-weight (constant . 63.01287))
 (formation-enthalpy (constant . -1.2626474e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2642750E+06))
 ; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 8.058E+06))
  (critical-temperature (constant . 647.29))
  (acentric-factor (constant . 0.768))
  (critical-volume (constant . 0.002158))
 )

(dimethyl-silyl-radical
 fluid
 (chemical-formula . hsi<ch3>2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 360.91901 4.3163082 -0.0026193573 8.7274466e-07 -1.3176873e-10) (1500 2500 1715.7912 1.2891308 -1.667605e-05 -1.6703275e-07 3.398174e-11)))
 (molecular-weight (constant . 59.16409))
 (formation-enthalpy (constant . 76891448))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3203412E+06))
 )

(dimethyl-methylene-silane
 fluid
 (chemical-formula . hsi<ch3>2ch2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 382.56607 5.0332333 -0.0036880566 1.5669504e-06 -2.9384874e-10) (1500 2500 1958.4199 1.251249 -1.7566841e-05 -1.5206736e-07 3.0142583e-11)))
 (molecular-weight (constant . 73.19118))
 (formation-enthalpy (constant . 39509564))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3719493E+06))
 )

(trimethyl-silane
 fluid
 (chemical-formula . hsi<ch3>3)
 (specific-heat (polynomial piecewise-polynomial (300 1500 361.31476 4.9008263 -0.0029105051 9.4302077e-07 -1.3856203e-10) (1500 2500 1893.6092 1.4995382 -1.7236683e-05 -1.9567296e-07 3.9783497e-11)))
 (molecular-weight (constant . 74.19915))
 (formation-enthalpy (constant . -1.6416883e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3593113E+06))
  ; Critical Properties from Smith (1994) acentric factor & critical volume missing 
  (critical-pressure (constant . 3.1900e6))
  (critical-temperature (constant . 432.00))
  )

(diaminosilyl-radical
 fluid
 (chemical-formula . hsi<nh2>2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 855.3374 2.2779172 -0.00020682446 -1.4551837e-06 7.5320083e-10) (1000 4000 1593.3665 0.7260546 -6.3477825e-05 -3.8404821e-08 6.9095472e-12)))
 (molecular-weight (constant . 61.13925))
 (formation-enthalpy (constant . 24124384))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3593113E+06))
 )

(triamino-silane 
 fluid
 (chemical-formula . hsi<nh2>3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 761.91177 2.9679557 -0.00028055024 -2.0198813e-06 1.0536531e-09) (1000 4000 1790.1961 0.79691937 -6.9392315e-05 -4.2226746e-08 7.5921538e-12)))
 (molecular-weight (constant . 77.1619))
 (formation-enthalpy (constant . -2.7063507e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3593113E+06))
 )

(silicon-carbide-hydride
 fluid
 (chemical-formula . hsic)
 (specific-heat (polynomial piecewise-polynomial (300 1500 760.79635 1.2354803 -0.0011572224 5.6739128e-07 -1.1322496e-10) (1500 2500 1183.1883 0.15429869 -2.017469e-05 -7.7097018e-09 1.7357757e-12)))
 (molecular-weight (constant . 41.10512))
 (formation-enthalpy (constant . 7.7344365e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3593113E+06))
 )

(vinyl-silylene
 fluid
 (chemical-formula . hsicch)
 (specific-heat (polynomial piecewise-polynomial (300 1500 583.72186 2.5096266 -0.0023830407 1.2105835e-06 -2.4885488e-10) (1500 2500 1397.6115 0.35224077 -1.9641154e-05 -2.8711045e-08 5.3988776e-12)))
 (molecular-weight (constant . 54.12424))
 (formation-enthalpy (constant . 4.3923168e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3593113E+06))
 )

(methylene-silylene
 fluid
 (chemical-formula . hsich2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 458.29607 3.5147352 -0.0031645782 1.5304968e-06 -3.0664262e-10) (1500 2500 1666.2372 0.48883313 -2.9555069e-05 -4.663042e-08 9.3900365e-12)))
 (molecular-weight (constant . 43.12106))
 (formation-enthalpy (constant . 3.5904426e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3593113E+06))
 )

(methyl-silylene 
 fluid
 (chemical-formula . hsich3)
 (specific-heat (polynomial piecewise-polynomial (300 1500 500.84837 2.9164882 -0.0015675484 4.115538e-07 -4.3387832e-11) (1500 2500 1427.8175 0.94212383 -1.6404821e-05 -1.2278193e-07 2.5330675e-11)))
 (molecular-weight (constant . 44.12903))
 (formation-enthalpy (constant . 2.0459515e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2645041E+06))
 )

(chloro-silylene 
 fluid
 (chemical-formula . hsicl)
 (specific-heat (polynomial piecewise-polynomial (300 1000 395.80269 1.1667471 -0.0014930884 1.0704782e-06 -3.1983685e-10) (1000 2000 631.25322 0.25527086 -4.6818131e-05 -2.9435964e-08 9.8328001e-12)))
 (molecular-weight (constant . 64.54697))
 (formation-enthalpy (constant . 71126632))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2502136E+06))
 )

(silicon-nitride-hydride
 fluid
 (chemical-formula . hsin)
 (specific-heat (polynomial piecewise-polynomial (300 1000 938.51741 0.34242955 9.4347371e-05 7.5664755e-08 -1.5265115e-10) (1000 4000 1108.5467 0.22514315 -2.6249417e-05 -1.1398023e-08 2.266049e-12)))
 (molecular-weight (constant . 43.10067))
 (formation-enthalpy (constant . 3.8906922e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2291189E+06))
 )

(nitrene-silylidene-radical 
 fluid
 (chemical-formula . hsinh)
 (specific-heat (polynomial piecewise-polynomial (300 1000 672.24448 1.5921833 -0.00014514168 -9.9356128e-07 4.8652264e-10) (1000 3000 1223.9921 0.48405617 -5.8934032e-05 -4.8584447e-08 1.1717868e-11)))
 (molecular-weight (constant . 44.10864))
 (formation-enthalpy (constant . 3.5476573e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2539261E+06))
 )

 (amino-silylidene 
  fluid
  (chemical-formula . hsinh2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 500.54613 2.2193107 -0.00018110101 -1.3652753e-06 6.9840391e-10) (1000 3000 1138.4967 0.86429264 -6.6034913e-05 -8.2154136e-08 1.7284487e-11)))
  (molecular-weight (constant . 45.11661))
  (formation-enthalpy (constant . 1.0999718e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2512968E+06))
  )

 (disilicon-chloride-hydride 
  fluid
  (chemical-formula . hsisicl)
  (specific-heat (polynomial piecewise-polynomial (300 1500 516.40629 0.89784573 -0.00098467034 5.4912028e-07 -1.2126916e-10) (1500 4000 829.55458 0.065209434 -1.8307738e-05 -3.1950681e-10 3.802571e-13)))
  (molecular-weight (constant . 92.63297))
  (formation-enthalpy (constant . 3.309936e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3052945E+06))
  )

 (hydrogen
  (fluid inert-particle)
  (chemical-formula . h2)
  (density (constant . 0.08189))
  (specific-heat (polynomial piecewise-polynomial (300 1000 13602.452 3.4023168 -0.0033584233 -3.9079528e-07 1.7053451e-09) (1000 5000 12337.526 2.8872753 -0.00023235597 -3.8073793e-08 6.5277423e-12)) (constant . 14283) (polynomial 14274.97 -0.3660015 0.001606264 -4.630396e-07 4.102679e-11) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.682099e+08 -3.303379e+06 3.388144e+04 -5.236921e+01 7.232722e-02 -4.961182e-05 1.389166e-08) (1000.000000 6000.000000 2.313064e+09 -3.452811e+06 1.227185e+04 5.164890e+00 -1.542855e-03 2.448555e-07 -1.487701e-11) (6000.000000 20000.000000 2.048516e+12 -1.298161e+09 3.292945e+05 -3.470552e+01 1.960394e-03 -5.658012e-08 6.621348e-13) ))
  (thermal-conductivity (constant . 0.1672) (polynomial 0.08269088 0.0003561521 1.072322e-08 -4.40516e-12 3.263276e-16))
  (viscosity (constant . 8.411e-06) (polynomial 3.773319e-06 1.932317e-08 -3.231968e-12 4.917018e-16 -3.024337e-20) (sutherland 8.411e-06 273.11 96.67) (power-law 8.411e-06 273.11 0.68) (blottner-curve-fit 0.04315 0.09634 -11.2273))  ; blottner is from CEA table 1995
  (characteristic-vibrational-temperature (constant . 6330)) ; NIST webbook
  (molecular-weight (constant . 2.01594))
  (formation-enthalpy (constant . 0))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 2.92))
  (lennard-jones-energy (constant . 38))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 130579.06))
  ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 1.2930e6))
  (critical-temperature (constant . 32.98))
  (acentric-factor (constant . -0.217))
  (critical-volume (constant . 0.031846))   
  )
  
 (hydrogen-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . h2<l>)
    ;; all properties from http://webbook.nist.gov constant properties at NBP
  (density (constant . 70.850))
  (specific-heat (constant . 9772.2)(polynomial piecewise-linear ( 20.4 . 9772) (22 . 10771) (24 . 12318) (26 . 14486) (28 . 17976) ))
  (thermal-conductivity (constant . 0.10382))
  (viscosity (constant . 1.3320e-05))
  (molecular-weight (constant . 2.01594))
  (formation-enthalpy (constant .  0))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 130579.06))
  (latent-heat (constant . 448700))	
  (vaporization-temperature (constant . 14))
  (boiling-point (constant . 20.4))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (constant . 5.0e-04)) ; rough guess
  (vapor-pressure (polynomial piecewise-linear (14 . 7541.4) (16 . 20755) (18 . 46602) (20 . 90717) (22 . 159130) (24 . 258070) (26 . 393990) (28 . 573590) (30 . 804320) (32 . 1095700) (32.98 . 1.2930e6))(constant . 20755) )
  )
  
 (hydrogen-air
  mixture
  (chemical-formula . #f)
  (species (names h2 o2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((h2 1 1 1) (o2 0.5 1 1)) ((h2o 1 0 1)) ((n2 0 1)) (stoichiometry "1h2 + 0.5o2 --> 1h2o") (arrhenius 9.87e8 3.1e7 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((h2 1 1 1) (o2 0.5 1 1)) ((h2o 1 0 1)) ((n2 0 1)) (stoichiometry "1h2 + 0.5o2 --> 1h2o") (arrhenius 9.87e8 3.1e7 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((h2 1 1 1) (o2 0.5 1 1)) ((h2o 1 0 1)) ((n2 0 1)) (stoichiometry "1h2 + 0.5o2 --> 1h2o") (stoichiometry "1h2 + 0.5o2 --> 1h2o") (arrhenius 9.87e8 3.1e7 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (hydrogen-fluoride
  fluid
  (chemical-formula . hf)
  (specific-heat (polynomial piecewise-polynomial (300 1000 1426.2203 0.18303033 -0.00036689689 2.7322677e-07 -8.5440419e-12) (1000 5000 1228.7869 0.32087352 -4.1142189e-05 -2.0752301e-09 5.9400783e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.326610e+06 2.488068e+04 1.269680e+03 7.001366e-01 -1.366214e-03 1.286641e-06 -4.058126e-10) (1000.000000 6000.000000 3.015987e+08 -6.170698e+05 1.602326e+03 2.966906e-01 -8.755511e-05 1.267593e-08 -6.813609e-13) (6000.000000 20000.000000 7.333485e+10 -3.653051e+07 7.840243e+03 -2.847164e-01 -5.832698e-06 6.249300e-10 -1.129378e-14) ))
  (molecular-weight (constant . 20.00637))
  (formation-enthalpy (constant . -2.725664e+08))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 3.138))
  (lennard-jones-energy (constant . 330))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 173666.53))
   ; Critical Properties from Somayajulu (1989)
  (critical-pressure (constant . 6.4800e6))
  (critical-temperature (constant . 461.00))
  (critical-volume (constant . 0.003449))
  (acentric-factor (constant . 3.29000E-01))
  )
 
 (hydrogen-peroxide
  fluid
  (chemical-formula . h2o2)
  (density (constant . 1.38198))
  (specific-heat (polynomial piecewise-polynomial (300 1000 828.32455 1.6057385 -3.629867e-05 -1.1307015e-06 6.041207e-10) (1000 5000 1117.8349 1.0598966 -0.00036046326 5.7415045e-08 -3.4994401e-12)) (constant . 1235.42) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -2.268268e+07 3.824836e+05 -1.460873e+03 7.994935e+00 -9.611765e-03 6.133567e-06 -1.580301e-09) (1000.000000 6000.000000 3.640725e+08 -1.263944e+06 2.757759e+03 -1.965866e-02 -4.444817e-06 1.698174e-09 -1.180104e-13) ))
  (viscosity (constant . 9.83e-06))
  (thermal-conductivity (constant . 0.00899775))
  (molecular-weight (constant . 34.01474))
  (formation-enthalpy (constant . -1.3610746e+08))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 3.458))
  (lennard-jones-energy (constant . 107.4))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 232855.64))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 9.353E+06))
  (critical-temperature (constant . 545.20))
  (acentric-factor (constant . 1.038))
  (critical-volume (constant . 0.00223430))
  )
  
; property data from 
; THE PROPERTIES OF PURE HYDROGEN PEROXIDE. I., O. Maass, W. H. Hatcher, J. Am. Chem. Soc., 1920, 42 (12), pp 25482569
; THE PROPERTIES OF PURE HYDROGEN PEROXIDE. V. VAPOR PRESSURE, O. Maass, P. G. Hiebert, J. Am. Chem. Soc., 1924, 46 (12), pp 26932700
; http://www.diyspaceexploration.com/transport-properties-of-hydrogen-peroxide
 (hydrogen-peroxide-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . h2o2<l>)
  (density (polynomial piecewise-linear (273 . 1463) (284 . 1451) (291 . 1443))(constant . 1443))
  (specific-heat (constant . 2422))
  (viscosity (polynomial piecewise-linear (273 . 0.001828) (284 . 0.001456) (291 . 0.001272)) (constant . 0.001272))
  (thermal-conductivity (polynomial piecewise-linear (273 . 0.555) (298 . 0.586))(constant . 0.586))
  (latent-heat (constant . 1.43E6))
  (vaporization-temperature (constant . 288))
  (boiling-point (constant . 424.55))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (constant . 1.88e-05))
  (dpm-surften (polynomial piecewise-linear (273 . 0.0788) (284 . 0.07751) (291 . 0.07594)) (constant . 0.07594))
  (vapor-pressure (polynomial piecewise-linear (288 . 147) (293 . 200) (298 . 280) (303 . 367) (308 . 533) (313 . 760) (318 . 1040) (323 . 1387) (328 . 1840) (333 . 2413) (338 . 3106) (343 . 3953) (348 . 5013) (353 . 6319) (358 . 7986) (363 . 9533) (424.55 . 101325) (545.20 . 9.353e6))(constant . 9533) )
  (molecular-weight (constant . 34.01474))
  (formation-enthalpy (constant . -187.281E+06)) ;; https://atct.anl.gov
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 109.6E+03))
  )

(hydrogen-peroxide-water
 (particle-mixture)
 (species (names h2o2<l> h2o<l>))
 )

(hydrogen-peroxide-water-air
 mixture 
 (chemical-formula . #f) 
 (species (names o2 h2o h2o2 n2)) 
)

 (hydrogen-sulfide
  fluid
  (chemical-formula . h2s)
  (density (constant . 1.46))
  (specific-heat (polynomial piecewise-polynomial (300 1000 749.22603 1.3609049 -0.0025152066 2.9323541e-06 -1.1803965e-09) (1000 5000 703.38926 0.93386082 -0.00034726037 6.0942606e-08 -4.0504991e-12)) (constant . 1170) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.920204e+06 -2.510155e+04 1.034360e+03 -1.956065e-01 1.092049e-03 -6.703278e-07 1.104507e-10) (1000.000000 6000.000000 3.494220e+08 -1.290762e+06 2.480620e+03 -2.371569e-01 5.171028e-05 -5.319142e-09 2.286563e-13) ))
  (thermal-conductivity (constant . 0.0134))
  (viscosity (constant . 1.2e-05))
  (molecular-weight (constant . 34.07994))
  (formation-enthalpy (constant . -20506432))
  (reference-temperature (constant . 298))
  (formation-entropy (constant . 205631.95))
  ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 8.9630e6))
  (critical-temperature (constant . 373.40))
  (acentric-factor (constant . 0.090))
  (critical-volume (constant . 0.002876))   
  )
 
 (hydroperoxyl
  fluid
  (chemical-formula . ho2)
  (density (constant . 1.34087))
  (specific-heat (polynomial piecewise-polynomial (300 1000 750.64677 1.258658 -0.0009549446 5.9301627e-07 -2.0376091e-10) (1000 5000 1025.7769 0.53686925 -0.00013371111 1.5396684e-08 -7.1568358e-13)) (constant . 1273) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.914176e+07 3.348748e+05 -1.178245e+03 6.318485e+00 -7.573571e-03 4.775059e-06 -1.216327e-09) (1000.000000 6000.000000 -4.561118e+08 1.250239e+06 -2.618521e+02 1.148712e+00 -2.674848e-04 2.883192e-08 -1.199827e-12) ))
  (viscosity (constant . 9.83e-06))
  (thermal-conductivity (constant . 0.00899775))
  (molecular-weight (constant . 33.00677))
  (formation-enthalpy (constant . 10450196))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 3.458))
  (lennard-jones-energy (constant . 107.4))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 228974.53))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 1.49e+07))
  (critical-temperature (constant . 400.00))
  (acentric-factor (constant . 0.100))  
  (critical-volume (constant . 0.0019))  
  )
 
 (hydroxyl
  fluid
  (chemical-formula . oh)
  (density (constant . 0.691))
  (specific-heat (polynomial piecewise-polynomial (300 1000 1778.1389 0.090484863 -0.00081942138 1.167024e-06 -4.1218527e-10) (1000 5000 1409.2712 0.49569846 -0.00011130898 1.0631305e-08 -2.5060807e-13)) (constant . 1713.21) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -9.771933e+05 4.546609e+04 1.491488e+03 7.477495e-01 -1.543816e-03 1.620841e-06 -5.567132e-10) (1000.000000 6000.000000 4.973787e+08 -1.227057e+06 2.501355e+03 6.381292e-02 -4.050002e-05 9.809170e-09 -7.611761e-13) (6000.000000 20000.000000 1.391943e+11 -9.090800e+07 2.448406e+04 -2.513981e+00 1.405779e-04 -4.022868e-09 4.677184e-14) ))
  (viscosity (constant . 1.967e-05))
  (thermal-conductivity (constant . 0.03607))
  (molecular-weight (constant . 17.00737))
  (formation-enthalpy (constant . 38979600))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 2.75))
  (lennard-jones-energy (constant . 80))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 183587.55))
 ; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 8.20E+06))
  (critical-temperature (constant . 400.00))
  (acentric-factor (constant . 0.200))  
  (critical-volume (constant . 0.0027))
  )

(isopropyl-radical
 fluid
 (chemical-formula . i*c3h7)
 (specific-heat (polynomial piecewise-polynomial (300 1000 330.59182 4.9061376 0.0003050269 -3.514286e-06 1.7033622e-09) (1000 5000 1555.8777 3.0380728 -0.0009999749 1.4427814e-07 -7.4373498e-12)))
 (molecular-weight (constant . 43.08924))
 (formation-enthalpy (constant . 76135704))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2514621E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 4.73E+06))
  (critical-temperature (constant . 427.01))
  (acentric-factor (constant . 0.100))  
  (critical-volume (constant . 0.0044)) 
 )

 (jet-a<g> 
  fluid
  (chemical-formula . jet-a<g>)
  (specific-heat (polynomial piecewise-polynomial (300 1000 103.7058315 6.616633083 -0.004032974 1.46144e-06 -3.23976e-10) (1000 5000 1236.376972 3.888495812 -0.001567869 2.87619e-07 -1.97918e-11)))
  (molecular-weight (constant . 167.31462))
  (formation-enthalpy (constant . -249762823))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.6282967E+06))
  ; Critical Properties from Polling et al.  (decane) 
  (critical-pressure (constant . 2.1100e6))
  (critical-temperature (constant . 617.70))
  (acentric-factor (constant . 0.490))
  (critical-volume (constant . 0.004386))
  )
 
 (isobutyl-alcohol
  fluid
  (chemical-formula . c4h10o)
  (density (constant . 804))
  (specific-heat (constant . 2303))
  (thermal-conductivity (constant . 0.134))
  (viscosity (constant . 0.00395))
  (molecular-weight (constant . 74.0824))
 ; Critical Properties from Polling et al.  1-butanol
  (critical-pressure (constant . 4.423e6))
  (critical-temperature (constant . 563.05))
  (acentric-factor (constant . 0.590))
  (critical-volume (constant . 0.003712))
  )
 
; (jp-4-fuel
;  fluid
;  (chemical-formula . #f)
;  (density (constant . 776))
;  (specific-heat (constant . 1995))
;  (thermal-conductivity (constant . 0.138))
;  (viscosity (constant . 0.000868))
;  (molecular-weight (constant . 110))
;  )
 
  (jet-a1-fuel
   (fluid inert-particle droplet-particle)
   (description . "Liquid Jet-A/Jet-A1/Kerosene/RP-1 \n\nData compiled from \"Die Stoffeigenschaften von Kerosin Jet A-1, DLR Mitteilung 98-01, 1998\". All constant property data valid at 298.15 K and 1 bar. Binary diffusivity data computed from Fuller's method for C12H23 into air @ 1 bar. \n\nANSYS Inc. provides no warranty for this data." )
   (chemical-formula . c12h23<l>)
   (molecular-weight (constant . 167.31))
   (reference-temperature (constant . 298.15))
   (acentric-factor (constant . 0.3599))

   ;; critical pressure & temperature
   (critical-pressure (constant . 23.44E+5))
   (critical-temperature (constant . 684.26))

   (vaporization-temperature (constant . 311.))   ;; flash point, Shell, Civil Aviation Fuels
   (volatile-fraction (constant . 1.))
   (averaging-coefficient-t (none . #f) (constant . 0.3333))
   (averaging-coefficient-y (none . #f) (constant . 0.3333))
   (vaporization-model (convection/diffusion-controlled 1 1) (diffusion-controlled . #f))

   (boiling-point (constant . 477.95))        ;; pvap = 1bar
   (vapor-pressure (constant . 185.311691)    ;; @ 298 K
                   (polynomial piecewise-linear
                      (220.0 . 0.22794105) (240.0 . 2.10709023) (260.0 . 12.9272022) (280.0 . 58.3929939) (300.0 . 208.589905)
                      (320.0 . 619.983704) (340.0 . 1591.29883) (360.0 . 3626.32959) (380.0 . 7494.18457) (400.0 . 14277.6973)
                      (420.0 . 25403.3496) (440.0 . 42649.2383) (460.0 . 68131.3906) (478.0 . 100112.664) (498.0 . 154042.000)
                      (518.0 . 228575.219) (538.0 . 328525.469) (558.0 . 459064.188) (578.0 . 625624.188) (598.0 . 833804.938)
                      (618.0 . 1089274.00) (638.0 . 1397675.38) (658.0 . 1764549.00) (678.0 . 2195254.50) (684.0 . 2337683.25)))
   (density (constant . 801.8)                ;; @ 298 K
            (polynomial piecewise-polynomial (220. 684.26 -751.12 27.835 -0.18703 0.00063739 -1.1945e-6 1.169e-9 -4.6814e-13)))
   (specific-heat (constant . 2066.75)        ;; @ 298 K
                  (polynomial piecewise-polynomial (220. 620 743.71 1.1814 0.022587 -4.9172e-5 3.3626e-8) (620 684. -1.80723e6 8609.8 -13.657 0.0072266)))
   (viscosity (constant . 1.2676E-03)         ;; @ 298 K
              (polynomial piecewise-polynomial (220. 311. 0.40577 -0.0053464 2.6888e-5 -6.0786e-8 5.1934e-11) (311. 685. 0.048224 -0.00043949 1.6207e-6 -2.9991e-9 2.774e-12 -1.0237e-15)))
   (thermal-conductivity (constant . 0.1187)  ;; @ 298 K
                         (polynomial piecewise-polynomial (220. 684. 0.17104 -0.0001756 4.3498e-14 -2.8346e-17)))
   (dpm-surften (constant . 2.25E-2)          ;; @ 298 K
                (polynomial piecewise-linear
                   (220.0 . 2.8171E-02) (260.0 . 2.5234E-02) (270.0 . 2.4509E-02) (310.0 . 2.1648E-02)
                   (320.0 . 2.0943E-02) (360.0 . 1.8168E-02) (370.0 . 1.7485E-02) (410.0 . 1.4805E-02)
                   (420.0 . 1.4148E-02) (460.0 . 1.1576E-02) (470.0 . 1.0948E-02) (510.0 . 8.5051E-03)
                   (520.0 . 7.9124E-03) (560.0 . 5.6257E-03) (570.0 . 5.0774E-03) (610.0 . 2.9985E-03)
                   (620.0 . 2.5127E-03) (630.0 . 2.0434E-03) (640.0 . 1.5930E-03) (645.0 . 1.3759E-03)
                   (650.0 . 1.1649E-03) (655.0 . 9.6062E-04) (660.0 . 7.6398E-04) (665.0 . 5.7620E-04) (670.0 . 3.9905E-04)
                   (675.0 . 2.3542E-04) (680.0 . 9.1142E-05) (684.0 . 1.0000E-07)))
   (binary-diffusivity (constant . 5.767e-06) ;; @ 298 K and 1 bar
                       (polynomial piecewise-polynomial (200. 2500. -7.945e-7 9.2993e-9 4.3137e-11 -5.1253e-15 5.6855e-19)))
   (diffusivity-reference-pressure (constant . 101325)
                                           (none . #f))
   (latent-heat (constant . 252570.53)       ;; @ normal boiling point (478 K)
                (polynomial piecewise-polynomial (220. 670. -3.5123e5 11979 -80.866 0.27854 -0.00052904 5.2499e-7 -2.1365e-10) (670. 684. -9.1016e7 2.733e5 -204.96)))
 )

 (kerosene-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . c12h23<l>)
  (density (constant . 780) (compressible-liquid 101325 780 1.1e+09 7 1.1 0.9))
  (specific-heat (constant . 2090)(polynomial 803.42 5.076 -0.00221 1.67E-6)) ;Sazhin Prog. Energy Comb. Sci. 32 (2006)
  (latent-heat (constant . 226000))
  (vaporization-temperature (constant . 341))
  (boiling-point (constant . 477))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (constant . 3.79e-06))
  (thermal-conductivity (constant . 0.149))
  (viscosity (constant . 0.0024))
  (dpm-surften (constant . 0.0263257) (polynomial piecewise-polynomial (50 700 5.94679e-02 -1.25920e-04 4.21601e-08 2.41128e-11)))
  (vapor-pressure (polynomial piecewise-linear (341 . 1329) (358 . 2658) (377 . 5316) (383 . 7974) (402 . 13289) (422 . 26579) (450 . 53158) (477 . 101000) (521 . 202000) (570 . 500000) (615 . 1000000)(658.1 . 1.8170e6))(constant . 1329) )
  (molecular-weight (constant . 167.31))
  ;; vapour pressure from http://webbook.nist.gov for dodecane
  )
 
 (kerosene-vapor
  fluid
  (chemical-formula . c12h23)
  (density (constant . 7.1))
  (specific-heat (polynomial piecewise-polynomial (300 1000 103.71 6.6168 -0.0040331 1.4615e-06) (1000 4000 1236.4 3.8886 -0.0015679 2.8763e-07)) (constant . 2571))
  (thermal-conductivity (constant . 0.0178))
  (viscosity (constant . 7e-06))
  (molecular-weight (constant . 167.31))
  (formation-enthalpy (constant . -2.5e+08))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  0.3894747E+06))
   ;; Critical properties from http://webbook.nist.gov for dodecane
  (critical-pressure (constant . 1.8170e6))
  (critical-temperature (constant . 658.1))
  (acentric-factor (constant . 0.574))
  (critical-volume (constant . 0.0044))
  )
 
 (kerosene-air
  mixture
  (chemical-formula . #f)
  (species (names c12h23 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c12h23 1 0.25 1) (o2 17.75 1.5 1)) ((co2 12 0 1) (h2o 11.5 0 1)) ((n2 0 1)) (stoichiometry "1c12h23 + 17.75o2 --> 12co2 + 11.5h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c12h23 1 0.25 1) (o2 17.75 1.5 1)) ((co2 12 0 1) (h2o 11.5 0 1)) ((n2 0 1)) (stoichiometry "1c12h23 + 17.75o2 --> 12co2 + 11.5h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c12h23 1 0.25 1) (o2 17.75 1.5 1)) ((co2 12 0 1) (h2o 11.5 0 1)) ((n2 0 1)) (stoichiometry "1c12h23 + 17.75o2 --> 12co2 + 11.5h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (lignite
  (combusting-particle inert-particle)
  (chemical-formula . #f)
  (density (constant . 1250))
  (specific-heat (constant . 1680))
  (latent-heat (constant . 0))
  (thermal-conductivity (constant . 0.33))
  (vaporization-temperature (constant . 400))
  (boiling-point (constant . 400))
  (binary-diffusivity (constant . 4e-05))
  (volatile-fraction (constant . 0.504))
  (combustible-fraction (constant . 0.447))
  (swelling-coefficient (constant . 1))
  (emissivity (constant . 0.9))
  (scattering-factor (constant . 0.9))
  (burn-stoichiometry (constant . 2.67))
  (burn-hreact (constant . 32789000))
  (burn-hreact-fraction (constant . 0.3))
  (devolatilization-model (constant . 20) (single-rate 312000 74000000) (two-competing-rates 200000 1.046e+08 0.3 13000000 1.674e+08 1)(cpd-model 1 0 5 400 50))
  (combustion-model (diffusion-limited . #f) (kinetics/diffusion-limited 5e-12 0.002 79000000) (intrinsic-model 5e-12 0.030198 1.794e+08 0.5 6e-08 300000 1.4142136 0) (cbk -1.0 10.0))
  )
 
 (lignite-volatiles
  fluid
  (chemical-formula . lig_vol)
  (specific-heat (constant . 1500))
  (molecular-weight (constant . 26.631))
  (formation-enthalpy (constant . -1.886e+08))
  (reference-temperature (constant . 298.15))
  ; Critical Properties estimated by assuming that lignite volatiles comprise solely CH2O.
  (critical-pressure (constant . 7.027E+06))
  (critical-temperature (constant . 340.98))
  (acentric-factor (constant . 0.218))
  (critical-volume (constant . 0.003197))
  )
 
 (lignite-volatiles-air
  mixture
  (chemical-formula . #f)
  (species (names lig_vol o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((lig_vol 1 0.2 1) (o2 1.272 1.3 1)) ((co2 1 0 1) (h2o 1.295 0 1)) ((n2 0 1)) (stoichiometry "1lig_vol + 1.272o2 --> 1co2 + 1.295h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((lig_vol 1 0.2 1) (o2 1.272 1.3 1)) ((co2 1 0 1) (h2o 1.295 0 1)) ((n2 0 1)) (stoichiometry "1lig_vol + 1.272o2 --> 1co2 + 1.295h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((lig_vol 1 0.2 1) (o2 1.272 1.3 1)) ((co2 1 0 1) (h2o 1.295 0 1)) ((n2 0 1)) (stoichiometry "1lig_vol + 1.272o2 --> 1co2 + 1.295h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (liquid-solid
  fluid
  (density (constant . 1000) (polynomial 8000 -0.1))
  (specific-heat (constant . 680))
  (thermal-conductivity (constant . 30))
  (viscosity (constant . 0.00553))
  (melting-heat (constant . 100000))
  (tsolidus (constant . 1100))
  (tliqidus (constant . 1200))
  (electric-conductivity (constant . 7.14e+05))
  (magnetic-permeability (constant . 1.257e-06))
  )

 (dimethyl-ethyl-gallium 
  fluid
  (chemical-formula . me2gaet)
  (specific-heat (polynomial piecewise-polynomial (300 600 -207.65849 4.1289533 0.0010030926 -8.2897349e-06 6.0920805e-09) (600 1500 462.94548 2.0877641 9.6479403e-05 -6.7637986e-07 1.9706033e-10)))
  (molecular-weight (constant . 128.85226))
  (formation-enthalpy (constant . -21961184))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.4070641E+06))
  )

 (methyl-ethyl-gallium
  fluid
  (chemical-formula . megaet)
  (specific-heat (polynomial piecewise-polynomial (300 600 -59.68134 3.3269104 0.00076931269 -6.6329251e-06 4.8947572e-09) (600 1500 482.2019 1.6690384 7.4027008e-05 -5.3458273e-07 1.5634119e-10)))
  (molecular-weight (constant . 113.81721))
  (formation-enthalpy (constant . 59628972))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3764068E+06))
  )

 (diethyl-methyl-gallium
  fluid
  (chemical-formula . megaet2)
  (specific-heat (polynomial piecewise-polynomial (300 600 -326.30777 4.764332 0.0011175819 -9.7701958e-06 7.2352407e-09) (600 1500 472.69716 2.3153795 9.8400317e-05 -7.6138401e-07 2.2418779e-10)))
  (molecular-weight (constant . 142.87936))
  (formation-enthalpy (constant . -30641534))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.4465093E+06))
  )

 (mercury
  (fluid inert-particle)
  (chemical-formula . hg)
  (density (constant . 13529) (compressible-liquid 101325 13529 2.85e+10 1 1.1 0.9))
  (specific-heat (constant . 139.3) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 0.000000e+00 0.000000e+00 1.036252e+02 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (1000.000000 6000.000000 2.133259e+06 -6.968878e+03 1.126756e+02 -5.989646e-03 2.138401e-06 -3.926353e-10 2.915929e-14) (6000.000000 20000.000000 2.221080e+10 -1.837836e+07 6.065076e+03 -9.609960e-01 7.943226e-05 -3.075456e-09 4.423653e-14) ))
  (thermal-conductivity (constant . 8.54))
  (viscosity (constant . 0.001523))
  (molecular-weight (constant . 200.59))
  (electric-conductivity (constant . 1.044e+06))
  (magnetic-permeability (constant . 1.257e-06))
 ; Critical Properties from Somayajulu (1989)
  (critical-pressure (constant . 15.0990e6))
  (critical-temperature (constant . 1765.01))
  (critical-volume (constant . 0.000214))
  (acentric-factor (constant . -1.67000E-01))
  )
 
 (methane
  fluid
  (chemical-formula . ch4)
  (density (constant . 0.6679))
  (specific-heat (polynomial piecewise-polynomial (300 1000 403.5847 9.0573346 -0.014425086 1.5805188e-05 -6.3430511e-09) (1000 5000 872.46708 5.3054727 -0.002008295 3.5166462e-07 -2.3339102e-11)) (constant . 2222) (polynomial piecewise-linear (300 . 2226) (600 . 3256) (1000 . 4475) (1500 . 5408) (2000 . 5904) (2500 . 6165)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -9.155638e+07 1.443655e+06 -6.229381e+03 2.028869e+01 -1.871846e-02 1.046088e-05 -2.568473e-09) (1000.000000 6000.000000 1.941611e+09 -7.198127e+06 1.064561e+04 -1.007637e+00 2.240972e-04 -2.104738e-08 8.516152e-13) ))
  (thermal-conductivity (constant . 0.0332))
  (viscosity (constant . 1.087e-05) (blottner-curve-fit -0.01252 0.8606 -13.5495)) ; CEA table 1995
  (characteristic-vibrational-temperature (constant . 1879)) ; ref nist webbook
  (molecular-weight (constant . 16.04303))
  (absorption-coefficient (constant . 0.62) (polynomial piecewise-linear (550 . 0.54) (890 . 0.72) (1220 . 0.68) (1550 . 0.62)))
  (formation-enthalpy (constant . -74895176))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 3.758))
  (lennard-jones-energy (constant . 148.6))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 186040.09))
 ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 4.599e6))
  (critical-temperature (constant . 190.56))
  (acentric-factor (constant . 0.011))
  (critical-volume (constant . 0.006146))
  )
 
 (methane-air
  mixture
  (chemical-formula . #f)
  (species (names ch4 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((ch4 1 0.2 1) (o2 2 1.3 1)) ((co2 1 0 1) (h2o 2 0 1)) ((n2 0 1)) (stoichiometry "1ch4 + 2o2 --> 1co2 + 2h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((ch4 1 0.2 1) (o2 2 1.3 1)) ((co2 1 0 1) (h2o 2 0 1)) ((n2 0 1)) (stoichiometry "1ch4 + 2o2 --> 1co2 + 2h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((ch4 1 0.2 1) (o2 2 1.3 1)) ((co2 1 0 1) (h2o 2 0 1)) ((n2 0 1)) (stoichiometry "1ch4 + 2o2 --> 1co2 + 2h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (methane-air-2step
  mixture
  (chemical-formula . #f)
  (species (names ch4 o2 co2 co h2o n2))
  (reactions (finite-rate ("reaction-1" ((ch4 1 0.7 1) (o2 1.5 0.8 1)) ((co 1 0 1) (h2o 2 0 1)) ((n2 0 1) (co2 0 1)) (stoichiometry "1ch4 + 1.5o2 --> 1co + 2h2o") (arrhenius 5.012e+11 2e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f)) ("reaction-2" ((co 1 1 1) (o2 0.5 0.25 1)) ((co2 1 0 1) (h2o 0 0.5 1)) ((n2 0 1) (ch4 0 1)) (stoichiometry "1co + 0.5o2 --> 1co2") (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f)) ("reaction-3" ((co2 1 1 0)) ((co 1 0 1) (o2 0.5 0 1)) ((n2 0 1) (ch4 0 1) (h2o 0 1)) (stoichiometry "1co2 --> 1co + 0.5o2") (arrhenius 5e+08 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((ch4 1 0.7 1) (o2 1.5 0.8 1)) ((co 1 0 1) (h2o 2 0 1)) ((n2 0 1)) (stoichiometry "1ch4 + 1.5o2 --> 1co + 2h2o") (arrhenius 5.012e+11 2e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f)) ("reaction-2" ((co 1 1 1) (o2 0.5 0.25 1)) ((co2 1 0 1)) ((n2 0 1) (ch4 0 1)) (stoichiometry "1co + 0.5o2 --> 1co2") (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((ch4 1 0.7 1) (o2 1.5 0.8 1)) ((co 1 0 1) (h2o 2 0 1)) ((n2 0 1)) (stoichiometry "1ch4 + 1.5o2 --> 1co + 2h2o") (arrhenius 5.012e+11 2e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f)) ("reaction-2" ((co 1 1 1) (o2 0.5 0.25 1)) ((co2 1 0 1)) ((n2 0 1) (ch4 0 1)) (stoichiometry "1co + 0.5o2 --> 1co2") (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (methyl-alcohol-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . ch3oh<l>)
  (density (constant . 785)(compressible-liquid 101325 785 9.71E8 9 1.1 0.9));compressible liquid data from Perry's handbook
  (specific-heat (constant . 2534)(polynomial piecewise-linear (260 . 2347) (280 . 2434) (300 . 2546) (320 . 2684) (338 . 2826) (360 . 3032) (380 . 3245) (400 . 3491) (420 . 3787) (440 . 4165) (460 . 4709) ))
  (latent-heat (constant . 1100301))
  (vaporization-temperature (constant . 257))
  (boiling-point (constant . 338))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (film-averaged (averaging-coefficient 0.3333) (film-diffusivity  (polynomial piecewise-linear (273 . 1.32e-05 ) (300 . 1.56e-05 ) (350 . 2.04E-5) (400 . 2.58E-5) (450 . 3.17E-5)) (constant . 1.32e-05)))(constant . 1.32e-05)); Binary diffusivity from Perry book extended according to the (T/T0)^1.75 analogy
  (thermal-conductivity (constant . 0.2022))
  (viscosity (constant . 0.0005495))
  (dpm-surften (constant . 0.0222657) (polynomial piecewise-polynomial (50 510 3.05581e-02 3.09802e-05 -2.24373e-07 9.07172e-11)))
  (vapor-pressure (polynomial piecewise-linear (257 . 1329) (267 . 2658) (278 . 5316) (285 . 7974) (294 . 13289) (308 . 26579) (323 . 53158) (338 . 101000) (357 . 202000) (386 . 505000) (410 . 1000000) (439 . 2000000) (458 . 3000000) (485 . 5000000) (512.64 . 8097000))(constant . 13289) )
   ;; http://webbook.nist.gov
  (molecular-weight (constant . 32.032))
  (formation-enthalpy (constant . -238.4E+06))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  127.19E+03))
  )
 
 (methyl-alcohol-vapor
  fluid
  (chemical-formula . ch3oh)
  (density (constant . 1.43))
  (specific-heat (polynomial piecewise-polynomial (300 1000 690.24415 1.9049676 0.0018604779 -2.2816497e-06 6.2030285e-10) (1000 5000 1045.4569 2.4330296 -0.00079147706 1.1310155e-07 -5.7726906e-12)) (constant . 1820) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -6.270880e+07 1.046291e+06 -5.310184e+03 1.791421e+01 -1.971823e-02 1.193173e-05 -3.006684e-09) (1000.000000 6000.000000 8.852585e+08 -3.491402e+06 5.868070e+03 -5.555665e-01 9.678889e-05 -9.078865e-09 3.544661e-13) ))
  (thermal-conductivity (constant . 0.0163))
  (viscosity (constant . 1.35e-05))
  (molecular-weight (constant . 32.04))
  (formation-enthalpy (constant . -2.0109698e+08))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 239626.22))
   ; Critical Properties from Polling et al.  methanol
  (critical-pressure (constant . 8.097e6))
  (critical-temperature (constant . 512.64))
  (acentric-factor (constant . 0.565))
  (critical-volume (constant . 0.006146))
  )
 
 (methyl-alcohol-air
  mixture
  (chemical-formula . #f)
  (species (names ch3oh o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((ch3oh 1 0.25 1) (o2 1.5 1.5 1)) ((co2 1 0 1) (h2o 2 0 1)) ((n2 0 1)) (stoichiometry "1ch3oh + 1.5o2 --> 1co2 + 2h2o") (arrhenius 1.799e+10 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((ch3oh 1 0.25 1) (o2 1.5 1.5 1)) ((co2 1 0 1) (h2o 2 0 1)) ((n2 0 1)) (stoichiometry "1ch3oh + 1.5o2 --> 1co2 + 2h2o") (arrhenius 1.799e+10 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((ch3oh 1 0.25 1) (o2 1.5 1.5 1)) ((co2 1 0 1) (h2o 2 0 1)) ((n2 0 1)) (stoichiometry "1ch3oh + 1.5o2 --> 1co2 + 2h2o") (arrhenius 1.799e+10 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )

 (atomic-nitrogen
  fluid
  (chemical-formula . n)
  (specific-heat (polynomial piecewise-linear (300 . 1483.98) (400 . 1483.92) (500 . 1483.9399) (600 . 1483.97) (700 . 1483.97) (800 . 1483.95) (900 . 1483.9301) (1000 . 1483.95) (1200 . 1486.09) (1400 . 1484.7) (1600 . 1483.33) (1800 . 1482.29) (2000 . 1481.89) (2500 . 1485.36) (3000 . 1497.87) (3500 . 1521.87) (4000 . 1558.74) (4500 . 1608.83) (5000 . 1671.41) (5500 . 1744.76) (6000 . 1826.0601) (7000 . 1953.84) (8000 . 2057.3401) (9000 . 2134.3201) (10000 . 2183.1599) (11000 . 2207.05) (12000 . 2213.96) (13000 . 2216.6599) (14000 . 2232.73) (15000 . 2284.55) (16000 . 2435.23) (17000 . 2592.01) (18000 . 2787.45) (19000 . 3015.3201) (20000 . 3266.55) (21000 . 3529.24) (22000 . 3788.6299) (23000 . 4027.1599) (24000 . 4224.3901) (25000 . 4357.0898) (26000 . 4488.4502) (27000 . 4546.4902) (28000 . 4560.0698) (29000 . 4560.0698) (30000 . 4467.96)) (polynomial piecewise-polynomial (300 1000 1485.8164 -0.01294053 3.2176118e-05 -3.3523767e-08 1.2464975e-11) (1000 5000 1454.4726 0.063286133 -4.4314045e-05 1.1157565e-08 -6.0902134e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 0.000000e+00 0.000000e+00 1.484013e+03 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (1000.000000 6000.000000 5.269137e+07 -6.358885e+04 1.402207e+03 1.731380e-01 -1.026649e-04 2.381934e-08 -1.589216e-12) (6000.000000 20000.000000 3.250095e+11 -1.844672e+08 4.105838e+04 -4.065001e+00 2.272067e-04 -6.519967e-09 7.586190e-14) ))
  (viscosity (blottner-curve-fit 1.16e-2 6.03e-1 -1.24e1) (gupta-curve-fit-viscosity 0.0120 0.5930 -12.3805))
  (thermal-conductivity (gupta-curve-fit-conductivity 0 0 0.01619 0.55022 -12.92190))
  (molecular-weight (constant . 14.0067))
  (characteristic-vibrational-temperature (constant . 0))
  (formation-enthalpy (constant . 4.7260291e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1531803E+06))
  (lennard-jones-length (constant . 3.298))
  (lennard-jones-energy (constant . 71.4))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 3.39E+06))
  (critical-temperature (constant . 126.20))
  (acentric-factor (constant . 0.040))  
  (critical-volume (constant . 0.0019))  
  )

 (n-propyl
  fluid
  (chemical-formula . n*c3h7)
  (specific-heat (polynomial piecewise-polynomial (300 1000 370.96541 4.7832455 0.00034929894 -3.4409218e-06 1.6561431e-09) (1000 5000 1539.4612 3.0412098 -0.0009982098 1.4363458e-07 -7.3805353e-12)))
  (molecular-weight (constant . 43.08924))
  (formation-enthalpy (constant . 94544600))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2683324E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 4.68E+06))
  (critical-temperature (constant . 423.41))
  (acentric-factor (constant . 0.100))  
  (critical-volume (constant . 0.0045))  
  )

 (dinitrogen-dihydride 
  fluid
  (chemical-formula . n2h2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 447.98181 3.6168373 -0.0047503559 4.4455092e-06 -1.6871693e-09) (1000 5000 933.39314 1.6723095 -0.00063787678 1.1248802e-07 -7.5119873e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -4.164261e+07 6.497465e+05 -2.604158e+03 9.093507e+00 -8.643914e-03 4.765856e-06 -1.111537e-09) (1000.000000 6000.000000 1.721508e+09 -4.856309e+06 5.600498e+03 -2.701582e-01 -1.165218e-04 3.095279e-08 -2.111778e-12) ))
  (molecular-weight (constant . 30.02934))
  (formation-enthalpy (constant . 2.1296224e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2184487E+06))
  )

 (hydrazine-radical
  fluid
  (chemical-formula . n2h3)
  (specific-heat (polynomial piecewise-polynomial (300 1000 850.31218 1.2633071 0.0035758702 -5.1424899e-06 2.0057841e-09) (1000 5000 1189.891 1.9325739 -0.00066854908 1.0502489e-07 -6.1584733e-12)))
  (molecular-weight (constant . 31.03731))
  (formation-enthalpy (constant . 2.2426200e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2285195E+06))
  )

 (hydrazine
  fluid
  (chemical-formula . n2h4)
  (specific-heat (polynomial piecewise-polynomial (300 1000 16.715725 7.1343366 -0.0075227991 4.5281271e-06 -1.1473876e-09) (1000 5000 1291.3947 2.4896149 -0.00092045617 1.588986e-07 -1.0455545e-11)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -4.309006e+07 7.875706e+05 -4.506542e+03 1.857694e+01 -2.300584e-02 1.504603e-05 -3.969841e-09) (1000.000000 6000.000000 8.545295e+08 -3.113138e+06 5.460103e+03 -3.630842e-01 5.015820e-05 -3.419731e-09 8.215556e-14) ))
  (molecular-weight (constant . 32.04528))
  (formation-enthalpy (constant . 95350056))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2386010E+06))
  ; Critical Properties from Polling et al. 
  (critical-pressure (constant . 14.7000e6))
  (critical-temperature (constant . 653.01))
  (critical-volume (constant . 0.002261))
  (acentric-factor (constant . 3.16000E-01))
  )

 (hydrazine-liquid
  fluid
  (chemical-formula . n2h4<l>)
  (density (constant . 1011))
  (specific-heat (polynomial piecewise-polynomial (300 450 2347.4136 2.3977864 0.00058729083 -2.3227141e-06 3.8577549e-09) (450 600 2306.741 2.1613575 0.0012831523 -1.2737345e-07 -8.7068866e-10)))
  (molecular-weight (constant . 32.04528))
  (formation-enthalpy (constant . 50600512))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1214638E+06))
  (species-phase (constant . 1))
 ; Critical Properties from Polling et al. 
  (critical-pressure (constant . 14.7000e6))
  (critical-temperature (constant . 653.01))
  (critical-volume (constant . 0.002261))
  (acentric-factor (constant . 3.16000E-01))
  )

 (nitrous-oxide
  fluid
  (chemical-formula . n2o)
  (specific-heat (polynomial piecewise-polynomial (300 1000 480.40209 1.7931449 -0.0018499269 1.183286e-06 -3.5926868e-10) (1000 5000 891.44932 0.54286542 -0.00022621572 4.2514557e-08 -2.9759269e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 8.100887e+06 -1.216603e+05 1.139949e+03 4.279556e-02 6.560434e-04 -6.853179e-07 2.149738e-10) (1000.000000 6000.000000 6.495572e+07 -4.542449e+05 1.723924e+03 -1.020429e-01 2.484401e-05 -2.671594e-09 1.205447e-13) ))
  (molecular-weight (constant . 44.0128))
  (formation-enthalpy (constant . 82054816))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2198740E+06))
  ; Critical Properties from Polling et al. 
  (critical-pressure (constant . 7.2550e6))
  (critical-temperature (constant . 309.60))
  (critical-volume (constant . 0.002204))
  (acentric-factor (constant . 1.65000E-01))
  )

 (nitrous-oxide+
  fluid
  (chemical-formula . n2o+)
  (specific-heat (polynomial piecewise-polynomial (300 1000 602.09817 1.5775306 -0.0014913564 8.6850165e-07 -2.6089839e-10) (1000 5000 1019.8319 0.42494812 -0.00018091986 3.4441859e-08 -2.4263977e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 -1.063314e+07 1.265941e+05 1.616710e+01 2.880889e+00 -2.886437e-03 1.479424e-06 -3.112855e-10) (1000.000000 6000.000000 -5.648396e+06 -2.227823e+05 1.567977e+03 -5.452931e-02 1.077400e-05 -1.125255e-09 5.354830e-14) ))
  (molecular-weight (constant . 44.01225))
  (formation-enthalpy (constant . 1.33346e+09))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2337473E+06))
;; critical properties assumed the same as nitrous-oxide
  (critical-pressure (constant . 7.2550e6))
  (critical-temperature (constant . 309.60))
  (critical-volume (constant . 0.002204))
  (acentric-factor (constant . 1.65000E-01))
  )

 (dinitrogen-tetroxide
  fluid
  (chemical-formula . n2o4)
  (specific-heat (polynomial piecewise-polynomial (300 1000 327.52704 2.2362068 -0.0019634623 8.9703737e-07 -2.008592e-10) (1000 5000 947.19738 0.53966914 -0.00023169321 4.4430182e-08 -3.1545253e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -3.438119e+06 5.071966e+04 -1.882864e+01 3.512521e+00 -3.996261e-03 2.258022e-06 -5.131854e-10) (1000.000000 6000.000000 -4.141233e+07 -1.450113e+05 1.512783e+03 -4.600770e-02 1.033432e-05 -1.189448e-09 5.400428e-14) ))
  (molecular-weight (constant . 92.011))
  (formation-enthalpy (constant . 9087015))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.3043097E+06))
  ; Critical Properties from Polling et al.
  (critical-pressure (constant . 10.1000e6))
  (critical-temperature (constant . 431.01))
  (critical-volume (constant . 1.815000E-003))
  (acentric-factor (constant . 1.007))
  )

 (trinitrogen
  fluid
  (chemical-formula . n3)
  (specific-heat (polynomial piecewise-polynomial (300 1000 570.2923 1.7670083 -0.0016895835 9.9834861e-07 -3.0100292e-10) (1000 5000 1030.585 0.48368431 -0.00020557097 3.9126297e-08 -2.7615011e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 6.603672e+06 -5.868150e+04 6.557910e+02 1.330009e+00 -8.273127e-04 1.705317e-07 1.361998e-11) (1000.000000 6000.000000 5.004615e+07 -4.675385e+05 1.807580e+03 -1.229331e-01 2.619964e-05 -2.926453e-09 1.329919e-13) ))
  (molecular-weight (constant . 42.0201))
  (formation-enthalpy (constant . 4.1423686e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2263677E+06))
  )

 (n-butane
  fluid
  (chemical-formula . c4h10)
  (density (constant . 2.46))
  (specific-heat (polynomial piecewise-polynomial (300 1500 -322.79595 8.4134721 -0.0064738654 2.9139734e-06 -5.8354252e-10) (1500 4000 2859.1432 1.4837692 -0.00013747711 -6.6129543e-08 1.1733664e-11)) (constant . 2620))
  (thermal-conductivity (constant . 0.0159))
  (viscosity (constant . 7e-06))
  (molecular-weight (constant . 58.1243))
  (formation-enthalpy (constant . -1.3322502e+08))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  0.3003988E+06))
   ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 3.7960e6))
  (critical-temperature (constant . 425.12))
  (acentric-factor (constant . 0.200))
  (critical-volume (constant . 0.004387))
  )
 
 (n-butane-air
  mixture
  (chemical-formula . #f)
  (species (names c4h10 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c4h10 1 0.15 1) (o2 6.5 1.6 1)) ((co2 4 0 1) (h2o 5 0 1)) ((n2 0 1)) (stoichiometry "1c4h10 + 6.5o2 --> 4co2 + 5h2o") (arrhenius 4.161e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c4h10 1 0.15 1) (o2 6.5 1.6 1)) ((co2 4 0 1) (h2o 5 0 1)) ((n2 0 1)) (stoichiometry "1c4h10 + 6.5o2 --> 4co2 + 5h2o") (arrhenius 4.161e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c4h10 1 0.15 1) (o2 6.5 1.6 1)) ((co2 4 0 1) (h2o 5 0 1)) ((n2 0 1)) (stoichiometry "1c4h10 + 6.5o2 --> 4co2 + 5h2o") (arrhenius 4.161e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (n-heptane-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . c7h16<l>)
  (density (constant . 684)(compressible-liquid 101325 684 8.55E8 7 1.1 0.9))
  (specific-heat (constant . 2219)(polynomial piecewise-linear (280 . 2175) (300 . 2248) (320 . 2327) (340 . 2412) (360 . 2503) (371 . 2558) (380 . 2599) (400 . 2701) (420 . 2810) (440 . 2931) (460 . 3072) (480 . 3255) ))
  (latent-heat (constant . 320096))
  (vaporization-temperature (constant . 271))
  (boiling-point (constant . 371))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (constant . 6.31e-06))
  (thermal-conductivity (constant . 0.14))
  (viscosity (constant . 0.000409))
  (dpm-surften (constant . 0.0198263) (polynomial piecewise-polynomial (50 540 2.98018e-02 6.85525e-05 -4.81995e-07 4.68524e-10)))
  (vapor-pressure (polynomial piecewise-linear (271 . 1329) (283 . 2658) (295 . 5316) (304 . 7974) (315 . 13289) (332 . 26579) (351 . 53158) (371 . 101000) (398 . 202000) (439 . 505000) (474 . 1000000) (518 . 2000000) (540.20 . 2740000))(constant . 5316) )
   ;; http://webbook.nist.gov
  (molecular-weight (constant . 100.1334))
  (formation-enthalpy (constant . -224.4E+06))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  328.57E+03))
  )
 
 (n-heptane-vapor
  fluid
  (chemical-formula . c7h16)
  (density (constant . 4.25))
  (specific-heat (polynomial piecewise-polynomial (300 1000 9.25450E+02 -7.87785E-01 1.62277E-02 -2.07234E-05 8.17206E-09) (1000 4000 1.53800E+03 3.24784E+00 -1.14532E-03 1.84541E-07 -1.10733E-11)) (constant . 2471))
  (thermal-conductivity (constant . 0.0178))
  (viscosity (constant . 7e-06))
  (molecular-weight (constant . 100.204))
  (formation-enthalpy (constant . -1.87800E+08))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  0.4280063E+06))
  ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 2.7400e6))
  (critical-temperature (constant . 540.20))
  (acentric-factor (constant . 0.350))
  (critical-volume (constant . 0.004271))
  )
 
 (n-heptane-air
  mixture
  (chemical-formula . #f)
  (species (names c7h16 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c7h16 1 0.25 1) (o2 11 1.5 1)) ((co2 7 0 1) (h2o 8 0 1)) ((n2 0 1)) (stoichiometry "1c7h16 + 11o2 --> 7co2 + 8h2o") (arrhenius 2.868e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c7h16 1 0.25 1) (o2 11 1.5 1)) ((co2 7 0 1) (h2o 8 0 1)) ((n2 0 1)) (stoichiometry "1c7h16 + 11o2 --> 7co2 + 8h2o") (arrhenius 2.868e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c7h16 1 0.25 1) (o2 11 1.5 1)) ((co2 7 0 1) (h2o 8 0 1)) ((n2 0 1)) (stoichiometry "1c7h16 + 11o2 --> 7co2 + 8h2o") (arrhenius 2.868e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (n-hexane-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . c6h14<l>)
  (density (constant . 660)(compressible-liquid 101325 660 8.55E8 7 1.1 0.9));compressible liquid data from Perry's handbook
  (specific-heat (constant . 2512)(polynomial piecewise-linear (280 . 2178) (300 . 2260) (320 . 2348) (340 . 2443) (360 . 2545) (380 . 2655) (400 . 2774) (420 . 2910) (440 . 3076) ))
  (latent-heat (constant . 336970))
  (vaporization-temperature (constant . 248))
  (boiling-point (constant . 342))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (film-averaged (averaging-coefficient 0.3333) (film-diffusivity  (polynomial piecewise-linear (250 . 6.1E-6) (300 . 8.39E-6) (350 . 1.10E-5) (373 . 1.23E-5) (400 . 1.39E-5) (450 . 1.71E-5) (473 . 1.86E-5)) (constant . 7.57e-06)))(constant . 7.57e-06)) ;;data from Poling Table 11-2 extended according to the (T/T0)^1.75 analogy
  (thermal-conductivity (constant . 0.137))
  (viscosity (constant . 0.00032))
  (dpm-surften (constant . 0.0179449) (polynomial piecewise-polynomial (50 507 1.84098e-02 1.63917e-04 -7.84057e-07 7.67674e-10)))
  (vapor-pressure (polynomial piecewise-linear (248 . 1329) (259 . 2658) (271 . 5316) (278 . 7974) (289 . 13289) (305 . 26579) (323 . 53158) (342 . 101000) (366 . 202000) (405 . 505000) (438 . 1000000) (480 . 2000000) (507 . 3000000) (507.60 . 3025000))(constant . 13289) )
   ;; http://webbook.nist.gov
  (molecular-weight (constant . 86.17848))
  (formation-enthalpy (constant . -198.7E+06))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  296.06E+03))
  )
 
 (n-hexane-vapor
  fluid
  (chemical-formula . c6h14)
  (density (constant . 3.65))
  (specific-heat (polynomial piecewise-polynomial (300 1000 177.15066 4.9189005 0.0012152249 -4.2724015e-06 1.8062994e-09) (1000 4000 2200.1561 2.0241009 -0.00034063286 -5.2737319e-08 1.4268634e-11)) (constant . 2402))
  (thermal-conductivity (constant . 0.0138))
  (viscosity (constant . 7.6e-06))
  (molecular-weight (constant . 86.17848))
  (formation-enthalpy (constant . -1.6697746e+08))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  0.3886308E+06))
  ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 3.0250e6))
  (critical-temperature (constant . 507.60))
  (acentric-factor (constant . 0.300))
  (critical-volume (constant . 0.004270))
  )
 
 (n-hexane-air
  mixture
  (chemical-formula . #f)
  (species (names c6h14 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c6h14 1 0.25 1) (o2 9.5 1.5 1)) ((co2 6 0 1) (h2o 7 0 1)) ((n2 0 1)) (stoichiometry "1c6h14 + 9.5o2 --> 6co2 + 7h2o") (arrhenius 3.205e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c6h14 1 0.25 1) (o2 9.5 1.5 1)) ((co2 6 0 1) (h2o 7 0 1)) ((n2 0 1)) (stoichiometry "1c6h14 + 9.5o2 --> 6co2 + 7h2o") (arrhenius 3.205e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c6h14 1 0.25 1) (o2 9.5 1.5 1)) ((co2 6 0 1) (h2o 7 0 1)) ((n2 0 1)) (stoichiometry "1c6h14 + 9.5o2 --> 6co2 + 7h2o") (arrhenius 3.205e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (n-octane-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . c8h18<l>)
  (density (constant . 720)(compressible-liquid 101325 720 8.55E8 7 1.1 0.9))
  (specific-heat (constant . 2420)(polynomial piecewise-linear (280 . 2165) (300 . 2233) (320 . 2308) (340 . 2389) (360 . 2474) (380 . 2562) (399 . 2649) (420 . 2750) (440 . 2852) (460 . 2961) (480 . 3085) (500 . 3237)))
  (latent-heat (constant . 306446))
  (vaporization-temperature (constant . 292))
  (boiling-point (constant . 399))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (film-averaged (averaging-coefficient 0.3333) (film-diffusivity  (polynomial piecewise-linear (300 . 5.96E-6) (350 . 7.8E-6) (373 . 8.72E-6) (400 . 9.85E-6) (450 . 1.21E-5) (473 . 1.32E-5)) (constant . 5.05e-06))) (constant . 5.05e-06)) ;;data from Perry's extended according to the (T/T0)^1.75 analogy
  (thermal-conductivity (constant . 0.147))
  (viscosity (constant . 0.00054))
  (dpm-surften (constant . 0.0212127) (polynomial piecewise-polynomial (50 566 4.92478e-02 -8.01202e-05 -8.54913e-08 1.29716e-10)))
  (vapor-pressure (polynomial piecewise-linear (292 . 1329) (305 . 2658) (318 . 5316) (327 . 7974) (339 . 13289) (357 . 26579) (377 . 53158) (399 . 101000) (426 . 202000) (469 . 505000) (507 . 1000000) (553 . 2000000) (568.70 . 2490000))(constant . 1329) )
   ;; http://webbook.nist.gov
  (molecular-weight (constant . 114.1502))
  (formation-enthalpy (constant . -250.3E+6))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  361.2E+03))
  )
 
 (n-octane-vapor
  fluid
  (chemical-formula . c8h18)
  (density (constant . 4.84))
  (specific-heat (polynomial 299.23 5.14 -0.0016176) (constant . 2467))
  (thermal-conductivity (constant . 0.0178))
  (viscosity (constant . 6.75e-06))
  (molecular-weight (constant . 114.22))
  (formation-enthalpy (constant . -2.09e+08))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  0.467115E+06))
   ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 2.4900e6))
  (critical-temperature (constant . 568.70))
  (acentric-factor (constant . 0.399))
  (critical-volume (constant . 0.004307))
  )
 
 (n-octane-air
  mixture
  (chemical-formula . #f)
  (species (names c8h18 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c8h18 1 0.25 1) (o2 12.5 1.5 1)) ((co2 8 0 1) (h2o 9 0 1)) ((n2 0 1)) (stoichiometry "1c8h18 + 12.5o2 --> 8co2 + 9h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c8h18 1 0.25 1) (o2 12.5 1.5 1)) ((co2 8 0 1) (h2o 9 0 1)) ((n2 0 1)) (stoichiometry "1c8h18 + 12.5o2 --> 8co2 + 9h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c8h18 1 0.25 1) (o2 12.5 1.5 1)) ((co2 8 0 1) (h2o 9 0 1)) ((n2 0 1)) (stoichiometry "1c8h18 + 12.5o2 --> 8co2 + 9h2o") (arrhenius 2.587e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (n-pentane-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . c5h12<l>)
  (density (constant . 626)(compressible-liquid 101325 626 8.55E8 7 1.1 0.9))
  (specific-heat (constant . 2177)(polynomial piecewise-linear (240 . 2098) (260 . 2161) (280 . 2237) (300 . 2324) (320 . 2422) (340 . 2532) (360 . 2656) (380 . 2801) (400 . 2981) (420 . 3233)))
  (latent-heat (constant . 357486))
  (vaporization-temperature (constant . 223))
  (boiling-point (constant . 309))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (constant . 8.83e-06))
  (thermal-conductivity (constant . 0.136))
  (viscosity (constant . 0.000229))
  (dpm-surften (constant . 0.0155075) (polynomial piecewise-polynomial (50 469 3.27586e-02 3.21705e-05 -4.51891e-07 5.02269e-10)))
  (vapor-pressure (polynomial piecewise-linear (223 . 1329) (233 . 2658) (244 . 5316) (251 . 7974) (260 . 13289) (275 . 26579) (292 . 53158) (309 . 101000) (331 . 202000) (365 . 505000) (398 . 1000000) (437 . 2000000) (462 . 3000000) (469.70 . 3370000))(constant . 53158) )
   ;; http://webbook.nist.gov
  (molecular-weight (constant . 72.15139))
  (formation-enthalpy (constant . -173.5E+06))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant .  263.47E+03))
  )
 
 (n-pentane-vapor
  fluid
  (chemical-formula . c5h12)
  (density (constant . 3.05))
  (specific-heat (polynomial piecewise-polynomial (300 1000 216.39996 4.7495633 0.0014441594 -4.2654521e-06 1.7579836e-09) (1000 4000 1921.881 2.436617 -0.000407161 -6.6170065e-08 1.7468977e-11)) (constant . 2436))
  (thermal-conductivity (constant . 0.0144))
  (viscosity (constant . 7.2e-06))
  (molecular-weight (constant . 72.15139))
  (formation-enthalpy (constant . -1.4635715e+08))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 349316.12))
; Critical Properties from Polling et al.  
  (critical-pressure (constant . 3.3700e6))
  (critical-temperature (constant . 469.70))
  (acentric-factor (constant . 0.252))
  (critical-volume (constant . 0.004307))  
  )
 
 (n-pentane-air
  mixture
  (chemical-formula . #f)
  (species (names c5h12 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c5h12 1 0.25 1) (o2 8 1.5 1)) ((co2 5 0 1) (h2o 6 0 1)) ((n2 0 1)) (stoichiometry "1c5h12 + 8o2 --> 5co2 + 6h2o") (arrhenius 3.599e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c5h12 1 0.25 1) (o2 8 1.5 1)) ((co2 5 0 1) (h2o 6 0 1)) ((n2 0 1)) (stoichiometry "1c5h12 + 8o2 --> 5co2 + 6h2o") (arrhenius 3.599e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c5h12 1 0.25 1) (o2 8 1.5 1)) ((co2 5 0 1) (h2o 6 0 1)) ((n2 0 1)) (stoichiometry "1c5h12 + 8o2 --> 5co2 + 6h2o") (arrhenius 3.599e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )

 (carbon-dinitride
  fluid
  (chemical-formula . ncn)
  (specific-heat (polynomial piecewise-polynomial (300 1500 644.2299 2.0735031 -0.0020608371 9.88575e-07 -1.8630617e-10) (1500 4000 1381.8516 0.12688281 -2.8868931e-05 5.599491e-10 3.4689911e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.546906e+07 2.006180e+05 -3.041438e+02 4.043705e+00 -4.255144e-03 2.249578e-06 -4.784423e-10) (1000.000000 6000.000000 -3.089580e+07 -1.609019e+05 1.660883e+03 -3.380554e-02 6.008459e-06 -6.268230e-10 4.106929e-14) ))
  (molecular-weight (constant . 40.02455))
  (formation-enthalpy (constant . 4.5017318e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2291484E+06))
  )

 (carbon-oxide-nitride
  fluid
  (chemical-formula . nco)
  (specific-heat (polynomial piecewise-polynomial (300 1000 560.06145 1.7554834 -0.0017701554 1.1629199e-06 -3.7750088e-10) (1000 5000 991.77946 0.51978375 -0.0002192983 4.1433134e-08 -2.889723e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.881478e+06 -3.873248e+04 8.380653e+02 7.724847e-01 7.628717e-05 -5.646667e-07 2.442909e-10) (1000.000000 6000.000000 1.462945e+07 -3.200300e+05 1.696842e+03 -7.449463e-02 1.392768e-05 -1.323160e-09 5.914631e-14) ))
  (molecular-weight (constant . 42.01725))
  (formation-enthalpy (constant . 1.5941726e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2321246E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.), acentric factor missing     
  (critical-pressure (constant . 7.99E+06))
  (critical-temperature (constant . 530.30))
  (acentric-factor (constant . 0.100))  
  (critical-volume (constant . 0.0023))  
  )

 (nitrogen-fluoride
  fluid
  (chemical-formula . nf)
  (specific-heat (polynomial piecewise-polynomial (300 1000 723.47437 0.8343768 -0.00067793166 2.8263164e-07 -6.2351189e-11) (1000 5000 972.92369 0.19023812 -7.6705365e-05 1.4798364e-08 -1.054871e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -8.829419e+06 1.681404e+05 -3.027170e+02 3.657985e+00 -4.592081e-03 2.922552e-06 -7.490465e-10) (1000.000000 6000.000000 2.016068e+08 -8.156226e+05 2.192514e+03 -6.804274e-01 2.305028e-04 -3.439279e-08 1.822506e-12) ))
  (molecular-weight (constant . 33.0051))
  (formation-enthalpy (constant . 2.4895304e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2151708E+06))
  )

 (nitrogen-oxide-monofluoride
  fluid
  (chemical-formula . nfo)
  (specific-heat (polynomial piecewise-polynomial (300 1000 568.76858 1.2266709 -0.0011793633 6.4956617e-07 -1.7366182e-10) (1000 5000 877.93402 0.32889051 -0.00013951031 2.6540514e-08 -1.8739436e-12)))
  (molecular-weight (constant . 49.0045))
  (formation-enthalpy (constant . -65691188))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2480238E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 6.094E+06))
  (critical-temperature (constant . 415.83))
  (acentric-factor (constant . 0.297))
  )

 (nitrogen-dioxygen-monofluoride 
  fluid
  (chemical-formula . nfo2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 313.05167 1.9749972 -0.0016635295 6.2115687e-07 -8.7644082e-11) (1000 5000 871.91179 0.4428897 -0.00019086221 3.6704523e-08 -2.611641e-12)))
  (molecular-weight (constant . 65.0039))
  (formation-enthalpy (constant . -1.087845e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2601847E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 6.390E+06))
  (critical-temperature (constant . 552.46))
  (acentric-factor (constant . 0.330))
  (critical-volume (constant . 0.002092))
  )

 (nitrogen-hydride 
  fluid
  (chemical-formula . nh)
  (specific-heat (polynomial piecewise-polynomial (300 1000 1849.3836 0.69385075 -0.0019334907 2.3361578e-06 -8.6252745e-10) (1000 5000 1528.4817 0.76159499 -0.00024652376 4.2598659e-08 -2.7784804e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 7.529154e+06 -1.052301e+05 2.502146e+03 -1.347165e+00 1.316604e-03 -1.435778e-07 -1.472815e-10) (1000.000000 6000.000000 1.084333e+09 -3.202295e+06 5.169725e+03 -1.269713e+00 3.364674e-04 -3.681340e-08 1.320285e-12) (6000.000000 20000.000000 5.274327e+10 -4.754455e+07 1.650440e+04 -1.649952e+00 9.172053e-05 -2.627458e-09 3.084504e-14) ))
  (molecular-weight (constant . 15.01467))
  (characteristic-vibrational-temperature (constant . 4722)) ; NIST webbook
  (viscosity (blottner-curve-fit -0.006729 0.7515 -12.7274))  ; ref Svehla 1963
  (lennard-jones-length (constant . 3.312)) ; Svehla 1963
  (lennard-jones-energy (constant . 65.3))
  (formation-enthalpy (constant . 3.5648883e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1811449E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 8.02E+06))
  (critical-temperature (constant . 405.77))
  (acentric-factor (constant . 0.100))  
  (critical-volume (constant . 0.0035))  
  )

(nitrogen-dihydride
 fluid
 (chemical-formula . nh2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 1781.1617 1.7121708 -0.0034318762 4.4579451e-06 -1.8535775e-09) (1000 5000 1536.6598 1.5218126 -0.00047032107 8.3921426e-08 -6.2487397e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.616943e+07 2.465222e+05 7.133171e+02 3.268860e+00 -3.101021e-03 2.325950e-06 -7.318865e-10) (1000.000000 6000.000000 8.660829e+08 -2.911343e+06 5.174614e+03 -6.114322e-01 2.197084e-04 -3.393608e-08 1.878421e-12) ))
 (molecular-weight (constant . 16.02264))
 (formation-enthalpy (constant . 1.9037878e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.1945902E+06))
; Critical Properties from Tang and Brezinsky (2006), Vc with Joback Method (Polling et al.)     
  (critical-pressure (constant . 8.02E+06))
  (critical-temperature (constant . 446.94))
  (acentric-factor (constant . 0.100))  
  (critical-volume (constant . 0.0035)) 
 )

 (nickel
  (solid inert-particle)
  (chemical-formula . ni)
  (density (constant . 8900))
  (specific-heat (constant . 460.6) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -4.583830e+06 8.521188e+04 -1.528888e+02 1.543387e+00 -1.940137e-03 1.178284e-06 -2.860397e-10) (1000.000000 6000.000000 -6.995513e+07 1.548210e+05 3.414679e+02 -2.265236e-03 -1.483761e-06 6.551458e-10 -6.302236e-15) (6000.000000 20000.000000 4.947696e+10 -2.343369e+07 4.745405e+03 -4.996449e-01 4.589850e-05 -2.272469e-09 4.158313e-14) ))
  (thermal-conductivity (constant . 91.74))
  (atomic-number (constant . 28))
  (electric-conductivity (constant . 1.282e+07))
  (magnetic-permeability (constant . 1.257e-06))
; Critical Properties from Cheng and Xu (2007), acentric factor missing
  (critical-pressure (constant . 1.080E+09))
  (critical-temperature (constant . 9460.00))
  (critical-volume (constant . 0.000391))
  (struct-youngs-modulus (constant . 1.9e+11))
  (struct-poisson-ratio (constant . 0.31))
  )
 
 (nitrogen
  (fluid inert-particle)
  (chemical-formula . n2)
  (density (constant . 1.138))
  (specific-heat (polynomial piecewise-polynomial (300 1000 979.04298 0.4179639 -0.0011762792 1.6743943e-06 -7.2562971e-10) (1000 5000 868.62291 0.44162954 -0.00016872295 2.9967875e-08 -2.0043858e-12)) (constant . 1040.67) (polynomial 938.8992 0.3017911 -8.109228e-05 8.263892e-09 -1.537235e-13) (polynomial piecewise-linear (300 . 1045) (600 . 1075) (1000 . 1164) (1500 . 1239) (2000 . 1283) (2500 . 1314)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 6.560439e+06 -1.133329e+05 1.805372e+03 -2.531997e+00 4.109665e-03 -2.856960e-06 7.478551e-10) (1000.000000 6000.000000 1.744345e+08 -6.646148e+05 1.800686e+03 -1.822274e-01 4.427720e-05 -5.707826e-09 3.151908e-13) (6000.000000 20000.000000 2.466471e+11 -1.905690e+08 5.996197e+04 -9.097272e+00 7.381193e-04 -2.880752e-08 4.266652e-13) ))
  (thermal-conductivity (constant . 0.0242) (polynomial 0.004737109 7.271938e-05 -1.122018e-08 1.454901e-12 -7.871726e-17) (gupta-curve-fit-conductivity 0.03607 -1.07503 11.95029 -57.90063 93.21782))
  (viscosity (constant . 1.663e-05) (polynomial 7.473306e-06 4.083689e-08 -8.244628e-12 1.305629e-15 -8.177936e-20) (sutherland 1.663e-05 273.11 106.67) (power-law 1.663e-05 273.11 0.67) (blottner-curve-fit 2.68e-2 3.18e-1 -1.13e1) (gupta-curve-fit-viscosity 0.0203 0.4329 -11.8153))
  (molecular-weight (constant . 28.0134))
  (characteristic-vibrational-temperature (constant . 3395))
  (formation-enthalpy (constant .  0))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 3.621))
  (lennard-jones-energy (constant . 97.53))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 191494.78))
  ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 3.3980e6))
  (critical-temperature (constant . 126.20))
  (acentric-factor (constant . 0.037))
  (critical-volume (constant . 0.003216)) 
  )

	(nitrogen+ fluid
		(chemical-formula . n2+)
		(specific-heat (polynomial piecewise-linear (300 . 1037.25) (400 . 1047.15) (500 . 1063.26) (600 . 1084.3199) (700 . 1108.8) (800 . 1134.95) (900 . 1160.75) (1000 . 1183.92) (1200 . 1205.3199) (1400 . 1241.4) (1600 . 1277.33) (1800 . 1312.75) (2000 . 1347.36) (2500 . 1428.5) (3000 . 1499.11) (3500 . 1556.6) (4000 . 1599.4301) (4500 . 1627.1801) (5000 . 1640.52) (5500 . 1641.23) (6000 . 1632.16) (7000 . 1628.87) (8000 . 1627.96) (9000 . 1623.5601) (10000 . 1618.67) (11000 . 1614.99) (12000 . 1612.85) (13000 . 1611.25) (14000 . 1607.85) (15000 . 1598.97) (16000 . 1576.38) (17000 . 1555.98) (18000 . 1532.95) (19000 . 1507.84) (20000 . 1481.22) (21000 . 1453.7) (22000 . 1425.96) (23000 . 1398.71) (24000 . 1372.72) (25000 . 1348.8) (26000 . 1323.22) (27000 . 1300.0699) (28000 . 1278.09) (29000 . 1257.34) (30000 . 1237.8199)) (polynomial piecewise-polynomial (300 1000 978.64881 0.42231184 -0.0011894032 1.683012e-06 -7.2625775e-10) (1000 5000 865.1349 0.44500061 -0.00017000545 3.0207478e-08 -2.0257667e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 -1.03111253e+07  8.00250725e+04  9.39361061e+02 -6.32858120e-01 1.99763492e-03 -1.67317684e-06  4.81344295e-10) (1000.000000 6000.000000 -8.44586266e+08  2.09511041e+06 -8.56246934e+02  9.10796812e-01 -1.29455754e-04  6.24035540e-09  1.60630429e-13) (6000.000000 20000.000000 -1.10198416e+11  9.31754221e+07 -2.85036628e+04  4.66337059e+00 -3.48764602e-04  1.23008834e-08 -1.66860253e-13)))
		(molecular-weight (constant . 28.013399))
		(formation-enthalpy (constant . 1510510000.))
		(reference-temperature (constant . 298.14999))
		(formation-entropy (constant . 191494.8))
		(density (constant . 1))
		(thermal-conductivity (constant . 0.0454) (gupta-curve-fit-conductivity 0 -0.03723 0.84192 -3.59040 -18.65620))
		(viscosity (blottner-curve-fit 2.68e-2 3.18e-1 -1.13e1) (constant . 1.72e-05) (gupta-curve-fit-viscosity 0 2.5 -32.0827))
    (characteristic-vibrational-temperature (constant . 3395))
		(therm-exp-coeff (constant . 0))
		(speed-of-sound (none . #f))
		(lennard-jones-length (constant . 3.6210001))
		(lennard-jones-energy (constant . 97.529999))
	)

  (nitrogen-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . n2<l>)
    ;; all properties from http://webbook.nist.gov constant properties at NBP
  (density (constant . 806.08))
  (specific-heat (constant . 2041.5)(polynomial piecewise-linear (77.4 . 2041) (80 . 2056) (90 . 2141) (100 . 2318) (110 . 2743) ))
  (thermal-conductivity (constant . 0.14581))
  (viscosity (constant . 0.00016065))
  (molecular-weight (constant .  28.0134))
  (formation-enthalpy (constant .  0))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 191494.78))
  (latent-heat (constant . 199178))	
  (vaporization-temperature (constant . 65))
  (boiling-point (constant . 77.4))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (constant . 3.0e-05)) ; rough guess
  (vapor-pressure (polynomial piecewise-linear (65 . 17404) (75 . 76043) (85 . 228860) (95 . 540520) (105 . 1083300) (115 . 1937000) (125 . 3206900) (126.2 . 3.3980e6)) (constant . 17404) )
  )
  
 (dinitrogen-hydride
  fluid
  (chemical-formula . nnh)
  (specific-heat (polynomial piecewise-polynomial (250 1000 1003.101 0.58833242 0.00020542524 1.4099182e-07 -2.7706961e-10) (1000 4000 1264.9525 0.4625064 -4.6780832e-05 -2.4523125e-08 4.6262187e-12)))
  (molecular-weight (constant . 29.02137))
  (formation-enthalpy (constant . 2.4505427e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2243717E+06))
  )

 (nitrogen-oxide
  fluid
  (chemical-formula . no)
  (specific-heat (polynomial piecewise-linear (300 . 969.8099999999999) (400 . 986.08) (500 . 1008.74) (600 . 1034.9) (700 . 1062.11) (800 . 1088.32) (900 . 1111.92) (1000 . 1131.71) (1200 . 1157.92) (1400 . 1180.22) (1600 . 1198.07) (1800 . 1212.12) (2000 . 1223) (2500 . 1239.91) (3000 . 1248.06) (3500 . 1253.37) (4000 . 1259.99) (4500 . 1270.32) (5000 . 1285) (5500 . 1302.91) (6000 . 1321.17) (7000 . 1358.01) (8000 . 1389.22) (9000 . 1420.33) (10000 . 1451.33) (11000 . 1481.9) (12000 . 1511.39) (13000 . 1538.81) (14000 . 1562.87) (15000 . 1581.93) (16000 . 1589.33) (17000 . 1594.64) (18000 . 1594.32) (19000 . 1588.57) (20000 . 1577.74) (21000 . 1562.35) (22000 . 1543.07) (23000 . 1520.75) (24000 . 1496.37) (25000 . 1471.11) (26000 . 1442.88) (27000 . 1414.98) (28000 . 1387.05) (29000 . 1359.35) (30000 . 1332.11)) (polynomial piecewise-polynomial (300 1000 935.60007 0.34720925 -0.00091515347 1.4457943e-06 -6.7783063e-10) (1000 5000 899.27216 0.35166341 -0.00013898446 2.5407012e-08 -1.7388453e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -3.169705e+06 4.257434e+04 9.508338e+02 -7.394466e-01 2.350131e-03 -2.129486e-06 6.613634e-10) (1000.000000 6000.000000 6.204150e+07 -3.573526e+05 1.505702e+03 -1.013059e-01 2.737940e-05 -3.923841e-09 2.599178e-13) (6000.000000 20000.000000 -2.653244e+11 1.638290e+08 -3.836529e+04 4.694885e+00 -2.791293e-04 8.070548e-09 -9.130497e-14) ))
  (viscosity (blottner-curve-fit 4.36e-2 -3.36e-2 -9.58e0) (gupta-curve-fit-viscosity 0.0452 -0.0609 -9.4596))
	(thermal-conductivity (gupta-curve-fit-conductivity 0.02792 -0.87133 10.17967 -52.03466 88.67060))
  (molecular-weight (constant . 30.0061))
  (characteristic-vibrational-temperature (constant . 2817))
  (formation-enthalpy (constant . 90288480))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2106400E+06))
  (lennard-jones-length (constant . 3.47))
  (lennard-jones-energy (constant . 119))
   ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 6.4800e6))
  (critical-temperature (constant . 180.00))
  (acentric-factor (constant . 0.582))
  (critical-volume (constant . 0.001933)) 
  )

 (nitrogen-oxide+
  fluid
  (chemical-formula . no+)
  (specific-heat (polynomial piecewise-linear (300 . 968.53998) (400 . 974.87) (500 . 986.40997) (600 . 1002.74) (700 . 1022.95) (800 . 1045.64) (900 . 1068.9301) (1000 . 1090.45) (1200 . 1123.4301) (1400 . 1146.48) (1600 . 1166.12) (1800 . 1182.71) (2000 . 1196.6) (2500 . 1221.59) (3000 . 1236.37) (3500 . 1244.95) (4000 . 1250.6801) (4500 . 1256.25) (5000 . 1263.6899) (5500 . 1274.35) (6000 . 1288.9301) (7000 . 1323.26) (8000 . 1384.95) (9000 . 1485.05) (10000 . 1620.79) (11000 . 1782.45) (12000 . 1953.37) (13000 . 2109.96) (14000 . 2221.71) (15000 . 2300.5701) (16000 . 2352.8501) (17000 . 2378.8799) (18000 . 2379.3501) (19000 . 2356.1499) (20000 . 2312.4299) (21000 . 2252.54) (22000 . 2182.0601) (23000 . 2107.8) (24000 . 2037.78) (25000 . 1981.25) (26000 . 1899.14) (27000 . 1831.8101) (28000 . 1767.99) (29000 . 1707.95) (30000 . 1651.74)) (polynomial piecewise-polynomial (300 1000 913.67353 0.39427335 -0.0011104353 1.5712721e-06 -6.7803943e-10) (1000 5000 807.6961 0.41545576 -0.0001587183 2.8201917e-08 -1.8912702e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 3.874118e+05 -4.407088e+04 1.419541e+03 -1.771869e+00 3.114349e-03 -2.213615e-06 5.839506e-10) (1000.000000 6000.000000 1.681947e+08 -6.313375e+05 1.684842e+03 -1.681108e-01 3.968043e-05 -4.843637e-09 2.475869e-13) (6000.000000 20000.000000 7.416237e+11 -5.079054e+08 1.412989e+05 -1.971221e+01 1.473510e-03 -5.440000e-08 7.773326e-13) ))
  (molecular-weight (constant . 30.00555))
  (viscosity (blottner-curve-fit 3.02e-1 -3.5039791 -3.74e0) (gupta-curve-fit-viscosity 0 2.5 -32.0453))
	(thermal-conductivity (gupta-curve-fit-conductivity -0.06836 2.57829 -35.72737 219.09215 -519.00261))
  (characteristic-vibrational-temperature (constant . 2817))
  (formation-enthalpy (constant . 9.9022938e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.1981059E+06))
  (lennard-jones-length (constant . 3.47))
  (lennard-jones-energy (constant . 119))
;;critical properties assumed the same as nitrogen-oxide
  (critical-pressure (constant . 6.4800e6))
  (critical-temperature (constant . 180.00))
  (acentric-factor (constant . 0.582))
  (critical-volume (constant . 0.001933))
  )

 (nitrogen-dioxide
  fluid
  (chemical-formula . no2)
  (specific-heat (polynomial piecewise-polynomial (300 1000 482.64393 1.4166122 -0.0014573411 1.1135752e-06 -4.1930889e-10) (1000 5000 846.30926 0.44502226 -0.00018836208 3.5727543e-08 -2.5151789e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.019672e+07 1.740965e+05 -4.399834e+02 3.483997e+00 -3.387847e-03 1.652844e-06 -3.212701e-10) (1000.000000 6000.000000 1.303589e+08 -6.926595e+05 2.013240e+03 -4.044797e-01 1.183355e-04 -1.375579e-08 6.015268e-13) ))
  (molecular-weight (constant . 46.0055))
  (formation-enthalpy (constant . 33090538))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2399096E+06))
; Critical Properties from Air Liquide
  (critical-pressure (constant . 1.013E+07))
  (critical-temperature (constant . 430.80))
  (critical-volume (constant . 3.647390E-003))
  (acentric-factor (constant . 8.34000E-01)) 
;; acentric factor and critical volume http://www.cheric.org/research/kdb/hcprop/cmpsrch.php
  )

 (nitrogen-dioxide- 
  fluid
  (chemical-formula . no2-)
  (specific-heat (polynomial piecewise-polynomial (300 1000 442.51524 1.6233434 -0.0014192938 7.0974816e-07 -1.936795e-10) (1000 5000 911.40555 0.39152268 -0.00017088159 3.282491e-08 -2.2380609e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 -2.317026e+06 1.263296e+05 -5.083080e+02 4.360715e+00 -5.117435e-03 3.019036e-06 -7.198893e-10) (1000.000000 6000.000000 2.395887e+07 -2.813952e+05 1.468706e+03 -4.931314e-02 -8.507752e-06 5.108623e-09 -4.254253e-13) ))
  (molecular-weight (constant . 46.00605))
  (formation-enthalpy (constant . -2.0273266e+08))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2364733E+06))
;;critical properties assumed the same as nitrogen-dioxide
  (critical-pressure (constant . 1.013E+07))
  (critical-temperature (constant . 430.80))
  (critical-volume (constant . 3.647390E-003))
  (acentric-factor (constant . 8.34000E-01))
  )

(nitrogen-trioxide
 fluid
 (chemical-formula . no3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 163.73615 2.5193103 -0.0018026227 1.7091341e-07 1.8156817e-10) (1000 5000 954.77381 0.43529211 -0.00019196743 3.7506147e-08 -2.6992746e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 4.566425e+06 3.039463e+04 -5.086284e+02 5.592690e+00 -7.656635e-03 5.141365e-06 -1.370397e-09) (1000.000000 6000.000000 -5.288485e+07 -1.105504e+05 1.423171e+03 -3.283619e-02 7.249187e-06 -8.307731e-10 3.848490e-14) ))
 (molecular-weight (constant . 62.0049))
 (formation-enthalpy (constant . 71133024))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2525485E+06))
 )
 
(atomic-oxygen+
 fluid
 (chemical-formula . o+)
 (specific-heat (polynomial piecewise-linear (300 . 1299.12) (400 . 1299.14) (500 . 1299.12) (600 . 1299.11) (700 . 1299.11) (800 . 1299.12) (900 . 1299.14) (1000 . 1299.12) (1200 . 1299.02) (1400 . 1299.01) (1600 . 1299.02) (1800 . 1299.03) (2000 . 1299.04) (2500 . 1299.12) (3000 . 1299.73) (3500 . 1301.87) (4000 . 1307.01) (4500 . 1317.16) (5000 . 1334.86) (5500 . 1363.11) (6000 . 1405.46) (7000 . 1473.03) (8000 . 1564.49) (9000 . 1652.85) (10000 . 1732.49) (11000 . 1799.3) (12000 . 1850.6) (13000 . 1885.24) (14000 . 1903.54) (15000 . 1907.29) (16000 . 1900.45) (17000 . 1887.24) (18000 . 1870.2) (19000 . 1850.51) (20000 . 1829.36) (21000 . 1807.9399) (22000 . 1787.4399) (23000 . 1769.08) (24000 . 1754.05) (25000 . 1743.6) (26000 . 1731.64) (27000 . 1725.86) (28000 . 1724.08) (29000 . 1726.6899) (30000 . 1734.01)) (polynomial piecewise-polynomial (300 1000 1298.8303 0.0030248682 -5.8252454e-06 4.2780899e-09 -9.9590985e-13) (1000 5000 1300.1798 -0.0031738428 3.8063209e-06 -1.786855e-09 2.8615885e-13)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 0.000000e+00 0.000000e+00 1.299230e+03 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (1000.000000 6000.000000 -1.125919e+08 3.463983e+05 8.845490e+02 2.450343e-01 -7.416688e-05 1.048008e-08 -4.732916e-13) (6000.000000 20000.000000 -1.114134e+11 7.636968e+07 -1.912915e+04 2.617254e+00 -1.604743e-04 4.774323e-09 -5.582339e-14) ))
 (molecular-weight (constant . 15.99886))
 (viscosity (blottner-curve-fit 2.03e-2 4.29e-1 -1.16e1) (constant . 1.72e-05) (gupta-curve-fit-viscosity 0 2.5 -32.3606))
 (thermal-conductivity (gupta-curve-fit-conductivity -0.04013 1.32468 -16.22091 89.96782 -208.57442))
 (characteristic-vibrational-temperature (constant . 0.))
 (formation-enthalpy (constant . 1.5688563e+09))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.1548554E+06))
  (lennard-jones-length (constant . 2.75))
  (lennard-jones-energy (constant . 80))
; Critical properties assumed the same as atomic-oxygen
  (critical-pressure (constant . 2.69e+06))
  (critical-temperature (constant . 44.50))
  (critical-volume (constant . 0.0022))  
 )

(atomic-oxygen- 
 fluid
 (chemical-formula . o-)
 (specific-heat (polynomial piecewise-polynomial (300 1000 1427.6098 -0.29749124 0.00014095703 1.3986384e-07 -1.0405209e-10) (1000 5000 1330.0808 -0.037143855 1.715776e-05 -3.4613465e-09 2.5466528e-13)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 -2.959887e+06 5.712515e+04 1.135303e+03 2.767876e-01 -2.753595e-04 1.491526e-07 -3.390597e-11) (1000.000000 6000.000000 5.076710e+06 3.720533e+03 1.296522e+03 1.022809e-03 -2.236691e-07 2.552594e-11 -1.180451e-15) (6000.000000 20000.000000 2.942497e+05 3.935014e+03 1.298284e+03 9.679285e-05 -5.982424e-09 1.916915e-13 -2.490867e-18) ))
 (molecular-weight (constant . 15.99994))
 (formation-enthalpy (constant . 1.017637e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.1576821E+06))
; Critical properties assumed the same as atomic-oxygen
  (critical-pressure (constant . 2.69e+06))
  (critical-temperature (constant . 44.50))
  (critical-volume (constant . 0.0022))
 )

(atomic-nitrogen+ fluid
  (chemical-formula . n+)
  (specific-heat (polynomial piecewise-linear (300 . 1574.12) (400 . 1561.64) (500 . 1550.26) (600 . 1539.9301) (700 . 1530.6) (800 . 1522.22) (900 . 1514.75) (1000 . 1508.14) (1200 . 1497.3199) (1400 . 1489.41) (1600 . 1484.11) (1800 . 1481.09) (2000 . 1480.0601) (2500 . 1484.49) (3000 . 1495.98) (3500 . 1511.47) (4000 . 1528.6) (4500 . 1545.7) (5000 . 1561.8) (5500 . 1576.65) (6000 . 1590.66) (7000 . 1620.97) (8000 . 1641.3101) (9000 . 1657.9301) (10000 . 1670.64) (11000 . 1679.6801) (12000 . 1685.73) (13000 . 1689.91) (14000 . 1693.78) (15000 . 1699.3199) (16000 . 1710.86) (17000 . 1719.42) (18000 . 1729.09) (19000 . 1740.14) (20000 . 1752.8101) (21000 . 1767.33) (22000 . 1783.91) (23000 . 1802.71) (24000 . 1823.89) (25000 . 1847.59) (26000 . 1874.89) (27000 . 1905.0601) (28000 . 1938.77) (29000 . 1976.1) (30000 . 2017.11)) (polynomial piecewise-polynomial (300 1000 1957.2976 0.84462367 -0.0023788064 3.366024e-06 -1.4525155e-09) (1000 5000 1730.2698 0.89000122 -0.0003400109 6.0414955e-08 -4.0515334e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 3.10875745e+06  1.36526722e+03  1.47658630e+03  1.62498875e-02 -1.86062438e-05  1.09823571e-08 -2.63997067e-12) (1000.000000 6000.000000 1.72440552e+08 -5.08001905e+05  2.06419636e+03 -3.13914290e-01 8.02762174e-05 -8.25012762e-09  2.99543054e-13) (6000.000000 20000.000000 9.77128859e+09 -6.60780662e+06  2.95436515e+03 -1.19041206e-01 6.06950250e-06 -1.59764736e-10  2.10132180e-15)))
  (molecular-weight (constant . 14.0067))
  (formation-enthalpy (constant . 1883390000.))
  (reference-temperature (constant . 298.14999))
  (formation-entropy (constant . 153187.59))
  (density (constant . 1))
  (thermal-conductivity (constant . 0.0454) (gupta-curve-fit-conductivity 0 0 0.03088 2.06339 -31.51368))
  (viscosity (blottner-curve-fit 1.16e-2 6.03e-1 -1.24e1) (constant . 1.72e-05) (gupta-curve-fit-viscosity 0 2.5 -32.4285))
  (characteristic-vibrational-temperature (constant . 0.))
  (therm-exp-coeff (constant . 0))
  (speed-of-sound (none . #f))
  (lennard-jones-length (constant . 3.2980001))
  (lennard-jones-energy (constant . 71.400002))
)


(dioxygen-
 fluid
 (chemical-formula . o2-)
 (specific-heat (polynomial piecewise-polynomial (300 1000 746.3029 0.87294974 -0.00069241319 2.5482736e-07 -4.3416217e-11) (1000 5000 1008.9172 0.19247758 -7.6955364e-05 1.487337e-08 -1.0618011e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 4.895101e+06 2.986672e+04 3.946665e+02 2.082810e+00 -2.559441e-03 1.570433e-06 -3.862109e-10) (1000.000000 6000.000000 -1.470225e+07 -6.150080e+04 1.214909e+03 -5.695960e-03 4.443334e-06 -4.561698e-10 2.140268e-14) ))
 (molecular-weight (constant . 31.99935))
 (formation-enthalpy (constant . -48600532))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2094697E+06))
 )

(ozone 
 fluid
 (chemical-formula . o3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 426.57769 1.6599477 -0.0012276859 2.3616527e-07 5.1440796e-11) (1000 5000 940.48602 0.31532971 -0.000133478 2.5971039e-08 -1.8631106e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -2.210451e+06 1.020307e+05 -4.406378e+02 4.658485e+00 -6.109607e-03 4.004794e-06 -1.047001e-09) (1000.000000 6000.000000 -4.772558e+09 1.239045e+07 -9.935708e+03 3.581092e+00 3.590149e-05 -1.477495e-07 1.442524e-11) ))
 (molecular-weight (constant . 47.9982))
 (formation-enthalpy (constant . 1.4267808e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2388357E+06))
  ; Critical Properties from Polling et al.  
 (critical-pressure (constant . 5.5700e6))
 (critical-temperature (constant . 261.05))
 (acentric-factor (constant . 0.224))
 (critical-volume (constant . 0.001863)) 
 )

(oc<oh>2
 fluid
 (chemical-formula . oc<oh>2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 47.457293 4.0784336 -0.0039404826 1.9476231e-06 -3.8957509e-10) (1500 4000 1532.4267 0.34250537 -5.7996192e-05 -7.7497475e-09 2.0716531e-12)))
 (molecular-weight (constant . 62.02529))
 (formation-enthalpy (constant . -6.1525165e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2694742E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 7.790E+06))
  (critical-temperature (constant . 651.58))
  (acentric-factor (constant . 0.991))
  (critical-volume (constant . 0.002225))
 )

(ethanedial
 fluid
 (chemical-formula . ochcho)
 (specific-heat (polynomial piecewise-polynomial (300 1500 266.97269 3.2925219 -0.0027477072 1.2260987e-06 -2.3098344e-10) (1500 4000 1514.0252 0.41650506 -4.945882e-05 -1.4864477e-08 2.9255447e-12)))
 (molecular-weight (constant . 58.03704))
 (formation-enthalpy (constant . -2.0723229e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2719116E+06))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 5.881E+06))
  (critical-temperature (constant . 524.03))
  (acentric-factor (constant . 0.410))
  (critical-volume (constant . 0.003205))
 )

(ochnnho
 fluid
 (chemical-formula . ochnnho)
 (specific-heat (polynomial piecewise-polynomial (300 1500 157.80722 3.1176603 -0.0023452694 9.6016264e-07 -1.7332775e-10) (1500 4000 1394.0434 0.45946603 -5.1070581e-05 -1.9677943e-08 3.6737415e-12)))
 (molecular-weight (constant . 74.03929))
 (formation-enthalpy (constant . -8764868))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2893581E+06))
 )

(hydroxyl+
 fluid
 (chemical-formula . oh+)
 (specific-heat (polynomial piecewise-polynomial (300 1000 1626.5015 0.65793127 -0.0018465911 2.2917587e-06 -8.7069107e-10) (1000 5000 1329.3001 0.73751428 -0.0002458771 4.0391237e-08 -2.4187231e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 2.948812e+07 -3.702628e+05 3.572697e+03 -4.647832e+00 5.879191e-03 -3.338651e-06 7.341136e-10) (1000.000000 6000.000000 2.464369e+08 -6.746959e+05 2.016903e+03 4.073417e-01 -1.683183e-04 3.320967e-08 -2.133459e-12) (6000.000000 20000.000000 5.662763e+11 -3.344643e+08 7.705878e+04 -7.912321e+00 4.324795e-04 -1.210025e-08 1.372675e-13) ))
 (molecular-weight (constant . 17.00682))
 (formation-enthalpy (constant . 1.3171804e+09))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.1826641E+06))
; critical properties assumed the same as hydroxyl
  (critical-pressure (constant . 8.20E+06))
  (critical-temperature (constant . 400.00))
  (acentric-factor (constant . 0.200))  
  (critical-volume (constant . 0.0027))
 )

(hydroxyl-
 fluid
 (chemical-formula . oh-)
 (specific-heat (polynomial piecewise-polynomial (300 1000 1657.2237 0.38728655 -0.00095004759 9.7856718e-07 -2.7874721e-10) (1000 5000 1391.3703 0.50930215 -0.000118148 1.2139227e-08 -3.801114e-13)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 1.423013e+07 -1.572615e+05 2.371473e+03 -1.260787e+00 9.801541e-04 -3.889785e-08 -1.134397e-10) (1000.000000 6000.000000 2.303180e+08 -4.190671e+05 1.547819e+03 6.030483e-01 -1.955070e-04 3.050036e-08 -1.639803e-12) ))
 (molecular-weight (constant . 17.00792))
 (formation-enthalpy (constant . -1.436076e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.1723563E+06))
; critical properties assumed the same as hydroxyl
  (critical-pressure (constant . 8.20E+06))
  (critical-temperature (constant . 400.00))
  (acentric-factor (constant . 0.200))  
  (critical-volume (constant . 0.0027))
 )

(onhnho
 fluid
 (chemical-formula . onhnho)
 (specific-heat (polynomial piecewise-polynomial (300 1500 104.75528 3.4927321 -0.0030356535 1.4073338e-06 -2.6980487e-10) (1500 4000 1347.8001 0.47255783 -5.1852062e-05 -1.7407345e-08 3.2149836e-12)))
 (molecular-weight (constant . 62.02814))
 (formation-enthalpy (constant . 98418096))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2617399E+06))
 )

(onhnoh
 fluid
 (chemical-formula . onhnoh)
 (specific-heat (polynomial piecewise-polynomial (300 1500 141.18189 3.7661298 -0.0035351803 1.7033411e-06 -3.3222837e-10) (1500 4000 1502.4349 0.35525025 -5.0408209e-05 -8.5193621e-09 1.9653844e-12)))
 (molecular-weight (constant . 62.02814))
 (formation-enthalpy (constant . -7416927.5))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2717155E+06))
 )
 
 (oxygen
  (fluid inert-particle)
  (chemical-formula . o2)
  (density (constant . 1.2999))
  (specific-heat (polynomial piecewise-polynomial (300 1000 834.82647 0.29295801 -0.00014956371 3.4138849e-07 -2.2783585e-10) (1000 5000 960.75234 0.15941258 -3.2708852e-05 4.6127648e-09 -2.9528324e-13)) (constant . 919.31) (polynomial 811.1803 0.4108345 -0.0001750725 3.757596e-08 -2.973548e-12) (polynomial piecewise-linear (300 . 914) (600 . 1005) (1000 . 1084) (1500 . 1136) (2000 . 1175) (2500 . 1215)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -8.900882e+06 1.259430e+05 2.907605e+02 1.115711e+00 -1.776324e-04 -5.257471e-07 2.699811e-10) (1000.000000 6000.000000 -2.696950e+08 6.092737e+05 4.728337e+02 3.294337e-01 -5.685410e-05 5.336324e-09 -2.128966e-13) (6000.000000 20000.000000 1.292766e+11 -7.447206e+07 1.738401e+04 -1.603184e+00 7.837713e-05 -1.928359e-09 1.891139e-14) ))
  (thermal-conductivity (constant . 0.0246) (polynomial 0.003921754 8.081213e-05 -1.354094e-08 2.220444e-12 -1.416139e-16) (gupta-curve-fit-conductivity 0.07987 -2.58428 31.25959 -166.76267 321.69820))
  (viscosity (constant . 1.919e-05) (polynomial 7.879426e-06 4.924946e-08 -9.851545e-12 1.527411e-15 -9.425674e-20) (sutherland 1.919e-05 273.11 138.9) (power-law 1.919e-05 273.11 0.69) (blottner-curve-fit 4.49e-2 -8.26e-2 -9.20e0) (gupta-curve-fit-viscosity 0.0484 -0.1455 -8.9231))
  (molecular-weight (constant . 31.9988))
  (characteristic-vibrational-temperature (constant . 2239))
  (formation-enthalpy (constant . 0))
  (reference-temperature (constant . 298.15))
  (lennard-jones-length (constant . 3.458))
  (lennard-jones-energy (constant . 107.4))
  (thermal-accom-coefficient (constant . 0.9137))
  (velocity-accom-coefficient (constant . 0.9137))
  (formation-entropy (constant . 205026.86))
   ; Critical Properties from Polling et al.
  (critical-pressure (constant . 5.0430e6))
  (critical-temperature (constant . 154.58))
  (acentric-factor (constant . 0.021))
  (critical-volume (constant . 0.002293)) 
  )

	(oxygen+ fluid
		(chemical-formula . o2+)
		(specific-heat (polynomial piecewise-linear (300 . 925.37) (400 . 949.29) (500 . 971.51) (600 . 992.11) (700 . 1011.17) (800 . 1028.76) (900 . 1044.94) (1000 . 1059.81) (1200 . 1085.85) (1400 . 1107.41) (1600 . 1125.04) (1800 . 1139.21) (2000 . 1150.41) (2500 . 1168.32) (3000 . 1176.8) (3500 . 1181.32) (4000 . 1186.43) (4500 . 1195.73) (5000 . 1211.88) (5500 . 1236.62) (6000 . 1270.76) (7000 . 1370.75) (8000 . 1481.23) (9000 . 1585.54) (10000 . 1676.63) (11000 . 1749.01) (12000 . 1798.74) (13000 . 1823.44) (14000 . 1822.28) (15000 . 1795.99) (16000 . 1740.79) (17000 . 1685.15) (18000 . 1626.15) (19000 . 1565.69) (20000 . 1505.51) (21000 . 1447.18) (22000 . 1392.06) (23000 . 1341.38) (24000 . 1296.15) (25000 . 1243.02) (26000 . 1204.6) (27000 . 1168.95) (28000 . 1136.18) (29000 . 1106.29) (30000 . 1079.2)) (polynomial piecewise-polynomial (300 1000 649.39301 0.0015123826 -2.9125235e-06 2.1389721e-09 -4.9793801e-13) (1000 5000 650.06781 -0.0015868674 1.9030957e-06 -8.9339713e-10 1.4307454e-13)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 -2.23647064e+07  2.73316311e+05 -1.41153357e+02  1.70743235e+00 -8.50774944e-04  1.54359960e-08  8.41556197e-11) (1000.000000 6000.000000 1.91880674e+07 -2.19810676e+05  1.29533021e+03 -4.18600273e-02 1.66999437e-05 -3.91039096e-09  4.10143752e-13) (6000.000000 20000.000000 -4.05898045e+11  3.01776479e+08 -8.58112994e+04  1.22407598e+01 -8.71613258e-04  3.03481483e-08 -4.13077152e-13)))
		(molecular-weight (constant . 31.9988))
		(formation-enthalpy (constant . 1171670000.))
		(reference-temperature (constant . 298.14999))
		(formation-entropy (constant . 205026.91))
		(density (constant . 1))
		(thermal-conductivity (constant . 0.0454) (gupta-curve-fit-conductivity -0.08373 2.75459 -33.74529 185.13274 -401.50753))
		(viscosity (blottner-curve-fit 4.49e-2 -8.26e-2 -9.20e0) (constant . 1.72e-05) (gupta-curve-fit-viscosity 0 2.5 -32.0148))
    (characteristic-vibrational-temperature (constant . 2239))
		(therm-exp-coeff (constant . 0))
		(speed-of-sound (none . #f))
		(lennard-jones-length (constant . 3.4579999))
		(lennard-jones-energy (constant . 107.4))
	)

  
  (oxygen-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . o2<l>)
    ;; all properties from http://webbook.nist.gov constant properties at NBP
  (density (constant . 1142))
  (specific-heat (constant . 1699)(polynomial piecewise-linear  (90 . 1699) (100 . 1738) (110 . 1807) (120 . 1927) (130 . 2153)))
  (thermal-conductivity (constant . 0.15))
  (viscosity (constant . 0.00019582))
  (molecular-weight (constant . 31.9988))
  (formation-enthalpy (constant . 0))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 205026.86))
  (latent-heat (constant . 213086))	
  (vaporization-temperature (constant . 55))
  (boiling-point (constant . 90.2))
  (volatile-fraction (constant . 1))
  (binary-diffusivity (constant . 3.0e-05)) ; rough guess
  (vapor-pressure (polynomial piecewise-linear  (55 . 146) (84 . 50146) (90 . 100150) (100 . 250150) (110 . 550150) (120 . 1050100) (130 . 1750100) (140 . 2800100) (145 . 3500100) (150 . 4150100) (154.58 . 5.0430e6))(constant . 2658) )
  )
  
 (peat
  (combusting-particle inert-particle)
  (chemical-formula . #f)
  (density (constant . 1150))
  (specific-heat (constant . 2000))
  (latent-heat (constant . 0))
  (thermal-conductivity (constant . 0.50))
  (vaporization-temperature (constant . 400))
  (boiling-point (constant . 400))
  (binary-diffusivity (constant . 4e-05))
  (volatile-fraction (constant . 0.653))
  (combustible-fraction (constant . 0.307))
  (swelling-coefficient (constant . 1))
  (emissivity (constant . 0.9))
  (scattering-factor (constant . 0.9))
  (burn-stoichiometry (constant . 2.67))
  (burn-hreact (constant . 32789000))
  (burn-hreact-fraction (constant . 0.3))
  (devolatilization-model (constant . 20) (single-rate 312000 74000000) (two-competing-rates 200000 1.046e+08 0.3 13000000 1.674e+08 1)(cpd-model 1 0 5 400 50))
  (combustion-model (diffusion-limited . #f) (kinetics/diffusion-limited 5e-12 0.002 79000000) (intrinsic-model 5e-12 0.030198 1.794e+08 0.5 6e-08 300000 1.4142136 0) (cbk -1.0 10.0))
  )
 
 (peat-volatiles
  fluid
  (chemical-formula . peat_vol)
  (specific-heat (constant . 1500))
  (molecular-weight (constant . 31.085))
  (formation-enthalpy (constant . -2.804e+08))
  (reference-temperature (constant . 298.15))
  ; Critical Properties estimated by assuming that peat volatiles comprise solely CH2O.
  (critical-pressure (constant . 7.027E+06))
  (critical-temperature (constant . 340.98))
  (acentric-factor (constant . 0.218))
  (critical-volume (constant . 0.003197))
  )
 
 (peat-volatiles-air
  mixture
  (chemical-formula . #f)
  (species (names peat_vol o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((peat_vol 1 0.2 1) (o2 1.127 1.3 1)) ((co2 1 0 1) (h2o 1.285 0 1)) ((n2 0 1)) (stoichiometry "1peat_vol + 1.127o2 --> 1co2 + 1.285h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((peat_vol 1 0.2 1) (o2 1.127 1.3 1)) ((co2 1 0 1) (h2o 1.285 0 1)) ((n2 0 1)) (stoichiometry "1peat_vol + 1.127o2 --> 1co2 + 1.285h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((peat_vol 1 0.2 1) (o2 1.127 1.3 1)) ((co2 1 0 1) (h2o 1.285 0 1)) ((n2 0 1)) (stoichiometry "1peat_vol + 1.127o2 --> 1co2 + 1.285h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )

  (pem-mixture
    mixture
    (chemical-formula . #f)
    (species (names h2o h2 o2 n2))
    (reactions (finite-rate ("reaction-1" () () () (stoichiometry "  ") (arrhenius 1e+15 1e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" () () ((o2 0 1) (h2o 0 1) (n2 0 1)) (stoichiometry "  ") (arrhenius 1e+15 100 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" () () ((o2 0 1) (h2o 0 1) (n2 0 1)) (stoichiometry "  ") (arrhenius 1e+15 100 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
    (electric-conductivity (constant . 1.0e-16))
    (dual-electric-conductivity (constant . 1.0e-16))
  )

 (propane
  fluid
  (chemical-formula . c3h8)
  (density (constant . 1.91))
  (specific-heat (polynomial piecewise-polynomial (300 1000 169.11057 5.0322586 0.0010240719 -4.0084819e-06 1.7427903e-09) (1000 5000 1418.8474 3.5616926 -0.0011848069 1.7307314e-07 -9.0735927e-12)) (constant . 1549) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -4.585147e+07 8.774347e+05 -5.538588e+03 2.240583e+01 -2.593267e-02 1.660792e-05 -4.414298e-09) (1000.000000 6000.000000 1.210796e+09 -5.015610e+06 8.550074e+03 -9.467856e-01 1.786088e-04 -1.805760e-08 7.561657e-13) ))
  (thermal-conductivity (constant . 0.0177))
  (viscosity (constant . 7.95e-06))
  (molecular-weight (constant . 44.09))
  (formation-enthalpy (constant . -1.0386024e+08))
  (reference-temperature (constant . 298.15))
  (formation-entropy (constant . 270137.91))
 ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 4.2480e6))
  (critical-temperature (constant . 369.83))
  (acentric-factor (constant . 0.152))
  (critical-volume (constant . 0.004536)) 
  )
 
 (propane-air
  mixture
  (chemical-formula . #f)
  (species (names c3h8 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c3h8 1 0.1 1) (o2 5 1.65 1)) ((co2 3 0 1) (h2o 4 0 1)) ((n2 0 1)) (stoichiometry "1c3h8 + 5o2 --> 3co2 + 4h2o") (arrhenius 4.836e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c3h8 1 0.1 1) (o2 5 1.65 1)) ((co2 3 0 1) (h2o 4 0 1)) ((n2 0 1)) (stoichiometry "1c3h8 + 5o2 --> 3co2 + 4h2o") (arrhenius 4.836e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c3h8 1 0.1 1) (o2 5 1.65 1)) ((co2 3 0 1) (h2o 4 0 1)) ((n2 0 1)) (stoichiometry "1c3h8 + 5o2 --> 3co2 + 4h2o") (arrhenius 4.836e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (propane-air-2step
  mixture
  (chemical-formula . #f)
  (species (names c3h8 o2 co2 co h2o n2))
  (reactions (finite-rate ("reaction-1" ((c3h8 1 0.1 1) (o2 3.5 1.65 1)) ((co 3 0 1) (h2o 4 0 1)) ((n2 0 1) (co2 0 1)) (stoichiometry "1c3h8 + 3.5o2 --> 3co + 4h2o") (arrhenius 5.62e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f)) ("reaction-2" ((co 1 1 1) (o2 0.5 0.25 1) (h2o 0 0.5 1)) ((co2 1 0 1)) ((n2 0 1) (c3h8 0 1)) (stoichiometry "1co + 0.5o2 --> 1co2") (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f)) ("reaction-3" ((co2 1 1 1)) ((co 1 0 1) (o2 0.5 0 1)) ((n2 0 1) (c3h8 0 1) (h2o 0 1)) (stoichiometry "1co2 --> 1co + 0.5o2") (arrhenius 5e+08 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c3h8 1 0.1 1) (o2 3.5 1.65 1)) ((co 3 0 1) (h2o 4 0 1)) ((n2 0 1)) (stoichiometry "1c3h8 + 3.5o2 --> 3co + 4h2o") (arrhenius 5.62e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f)) ("reaction-2" ((co 1 1 1) (o2 0.5 0.25 1)) ((co2 1 0 1)) ((n2 0 1) (c3h8 0 1)) (stoichiometry "1co + 0.5o2 --> 1co2") (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c3h8 1 0.1 1) (o2 3.5 1.65 1)) ((co 3 0 1) (h2o 4 0 1)) ((n2 0 1)) (stoichiometry "1c3h8 + 3.5o2 --> 3co + 4h2o") (arrhenius 5.62e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f)) ("reaction-2" ((co 1 1 1) (o2 0.5 0.25 1)) ((co2 1 0 1)) ((n2 0 1) (c3h8 0 1)) (stoichiometry "1co + 0.5o2 --> 1co2") (arrhenius 2.239e+12 1.7e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )
 
 (propylene
  fluid
  (chemical-formula . c3h6)
  (density (constant . 1.7))
  ;(specific-heat                  (polynomial piecewise-polynomial (300 1000 295.04486 4.1343564 0.00088649244 -3.2974057e-06 1.4142933e-09) (1000 5000 1330.1469 2.9455615 -0.0009779919 1.424938e-07 -7.4411961e-12)))
  (specific-heat (polynomial piecewise-polynomial (300 1000 295.04489 4.1343579 0.00088649252 -3.297406e-06 1.4142935e-09) (1000 5000 1330.147 2.9455618 -0.00097799208 1.4249381e-07 -7.4411975e-12)) (constant . 1440))
  (thermal-conductivity (constant . 0.0168))
  (viscosity (constant . 8.7e-06))
  (molecular-weight (constant . 42.08127))
  (formation-enthalpy (constant . 20444056))
  (reference-temperature (constant . 298))
  (formation-entropy (constant .  0.2573729E+06))
  ;(formation-entropy (constant . 257367.64))
  ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 4.600e6))
  (critical-temperature (constant . 364.90))
  (acentric-factor (constant . 0.142))
  (critical-volume (constant . 0.004387)) 
  )

 (propylene-air
  mixture
  (chemical-formula . #f)
  (species (names c3h6 o2 co2 h2o n2))
  (reactions (finite-rate ("reaction-1" ((c3h6 1 -0.1 1) (o2 4.5 1.85 1)) ((co2 3 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c3h6 + 4.5o2 --> 3co2 + 3h2o") (arrhenius 2.362e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c3h6 1 -0.1 1) (o2 4.5 1.85 1)) ((co2 3 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c3h6 + 4.5o2 --> 3co2 + 3h2o") (arrhenius 2.362e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c3h6 1 -0.1 1) (o2 4.5 1.85 1)) ((co2 3 0 1) (h2o 3 0 1)) ((n2 0 1)) (stoichiometry "1c3h6 + 4.5o2 --> 3co2 + 3h2o") (arrhenius 2.362e+09 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
  )

(sulfur
 (fluid inert-particle)
 (chemical-formula . s)
 (molecular-weight (constant . 32.064))
 (formation-enthalpy (constant . 2.7699347e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.1677381E+06))
 (specific-heat (polynomial piecewise-polynomial (300 1000 826.48884 -0.41379201 0.00052004328 -3.9079301e-07 1.2787038e-10) (1000 5000 752.5401 -0.14221675 7.1686706e-05 -1.3009604e-08 8.1698664e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -8.232126e+04 -4.990615e+04 1.215259e+03 -1.514622e+00 1.954685e-03 -1.261091e-06 3.259247e-10) (1000.000000 6000.000000 -1.258669e+08 3.730779e+05 3.263206e+02 9.847903e-02 4.228246e-07 -2.475490e-09 2.085092e-13) (6000.000000 20000.000000 -3.376002e+10 1.791546e+07 -3.049871e+03 4.152675e-01 -2.723954e-05 1.125804e-09 -1.990231e-14) ))
 (thermal-conductivity (constant . 0.269))
  ; Critical Properties from Polling et al. 
 (critical-pressure (constant . 18.200e6))
 (critical-temperature (constant . 1313.01))
 (critical-volume (constant . 0.004928)) 
 (acentric-factor (constant . 1.71000E-01))
 )

(sulfur-liquid
 fluid
 (chemical-formula . s<l>)
 (density (constant . 2000))
 (specific-heat (polynomial piecewise-polynomial (388.36 1000 -3294.8037 23.525458 -0.043956734 3.3892749e-05 -9.1472653e-09) (1000 2000 934.44716 0.25679811 -0.00026227122 1.0511251e-07 -1.4697154e-11)))
 (molecular-weight (constant . 32.064))
 (formation-enthalpy (constant . 1847948.7))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3669813E+05))
 (species-phase (constant . 1))
 ; Critical Properties from Polling et al.
 (critical-pressure (constant . 18.200e6))
 (critical-temperature (constant . 1313.01))
 (critical-volume (constant . 0.004928)) 
 (acentric-factor (constant . 1.71000E-01))
 )

(sulfur+ 
 fluid
 (chemical-formula . s+)
 (specific-heat (polynomial piecewise-polynomial (300 1000 613.55089 0.23676894 -0.00055499449 5.3837125e-07 -1.8498734e-10) (1000 5000 623.53424 0.062517 -5.2945152e-05 1.7096095e-08 -1.4928257e-12)) (polynomial nasa-9-piecewise-polynomial (298.150000 1000.000000 0.000000e+00 0.000000e+00 6.482423e+02 0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00) (1000.000000 6000.000000 3.490703e+08 -1.051934e+06 1.854864e+03 -6.543519e-01 1.667160e-04 -1.667713e-08 5.552553e-13) (6000.000000 20000.000000 3.999018e+10 -2.652798e+07 6.720449e+03 -5.474974e-01 2.389569e-05 -5.093029e-10 5.435430e-15) ))
 (molecular-weight (constant . 32.06345))
 (formation-enthalpy (constant . 1.282348e+09))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.1635211E+06))
;; critical properties assumed the same as sulfur
 (critical-pressure (constant . 18.200e6))
 (critical-temperature (constant . 1313.01))
 (critical-volume (constant . 0.004928)) 
 (acentric-factor (constant . 1.71000E-01)) 
 )

(sulfur-triazine 
 fluid
 (chemical-formula . s-triazine)
 (specific-heat (polynomial piecewise-polynomial (300 1000 46.079908 2.797826 0.00023681474 -1.5349854e-06 4.6626092e-10) (1000 4000 1336.8345 0.79083251 -7.9211989e-05 -4.4969304e-08 8.5104594e-12)))
 (molecular-weight (constant . 81.07746))
 (formation-enthalpy (constant . 2.3585693e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2698473E+06))
 )

(sulfur-hydride 
 fluid
 (chemical-formula . sh)
 (specific-heat (polynomial piecewise-polynomial (300 1000 1039.1241 -0.095228169 -0.00069835646 1.3500538e-06 -6.0185653e-10) (1000 5000 767.73217 0.31648532 -0.00010682471 1.742109e-08 -1.0764232e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.606243e+06 -9.422016e+04 1.897532e+03 -3.240110e+00 4.795993e-03 -3.180174e-06 8.132880e-10) (1000.000000 6000.000000 4.229975e+08 -1.301487e+06 2.312332e+03 -5.841183e-01 1.645078e-04 -2.128893e-08 9.715591e-13) ))
 (molecular-weight (constant . 33.07197))
 (formation-enthalpy (constant . 1.393301e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.1955201E+06))
 )

(silicon
 fluid
 (chemical-formula . si)
 (specific-heat (polynomial piecewise-polynomial (300 1000 921.69839 -0.69004668 0.0010415956 -7.156777e-07 1.8922041e-10) (1000 4000 821.73749 -0.18393196 0.00014338864 -3.7762207e-08 3.3584231e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.911906e+04 4.578413e+04 5.555031e+02 3.909636e-01 -4.528606e-04 2.649738e-07 -5.781315e-11) (1000.000000 6000.000000 -1.826368e+08 6.633353e+05 -1.316976e+02 5.062476e-01 -1.216054e-04 1.349619e-08 -5.593749e-13) (6000.000000 20000.000000 -2.749204e+11 1.611647e+08 -3.572450e+04 4.025165e+00 -2.251839e-04 6.364140e-09 -7.324411e-14) ))
 (molecular-weight (constant . 28.086))
 (formation-enthalpy (constant . 4.5063136e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.1678636E+06))
 )

(dimethyl-silylene
 fluid
 (chemical-formula . si<ch3>2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 330.05985 3.9656014 -0.002572432 9.6259246e-07 -1.6508883e-10) (1500 2500 1562.005 1.1418408 -1.3004473e-05 -1.4504624e-07 2.9136271e-11)))
 (molecular-weight (constant . 58.15612))
 (formation-enthalpy (constant . 1.3470792e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3231849E+06))
 )

(trimethyl-silyl-radical
 fluid
 (chemical-formula . si<ch3>3)
 (specific-heat (polynomial piecewise-polynomial (300 1500 443.8339 4.2426567 -0.0023537689 7.0209818e-07 -9.5758268e-11) (1500 2500 1745.3001 1.4110171 -1.3515484e-05 -1.8519832e-07 3.7584608e-11)))
 (molecular-weight (constant . 73.19118))
 (formation-enthalpy (constant . 13711357))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3650281E+06))
 )

(trimethyl-methylene-silane
 fluid
 (chemical-formula . si<ch3>3ch2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 501.30793 4.7619837 -0.0032353911 1.303698e-06 -2.3960732e-10) (1500 2500 1965.2479 1.3423473 -1.4278945e-05 -1.6664386e-07 3.3067172e-11)))
 (molecular-weight (constant . 87.21827))
 (formation-enthalpy (constant . -28061052))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4179649E+06))
 )

(tetramethyl-silane 
 fluid
 (chemical-formula . si<ch3>4)
 (specific-heat (polynomial piecewise-polynomial (300 1500 472.07211 4.6676051 -0.0025876802 7.7568293e-07 -1.072074e-10) (1500 2500 1906.8864 1.5530604 -1.400928e-05 -2.0367325e-07 4.125057e-11)))
 (molecular-weight (constant . 88.22624))
 (formation-enthalpy (constant . -2.3227389e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4019013E+06))
 ; Critical Properties from Sladkov (2001) acentric factor missing
  (critical-pressure (constant . 2.8200e6))
  (critical-temperature (constant . 448.60))
  (critical-volume (constant . 0.004092))
 )

(silicon-liquid 
 fluid
 (chemical-formula . si<l>)
 (density (constant . 2000))
 (specific-heat (polynomial piecewise-polynomial (300 1000 968.39676 0 0 0 0) (1000 4500 968.39676 0 0 0 0)))
 (molecular-weight (constant . 28.086))
 (formation-enthalpy (constant . 48469744))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4445061E+05))
 (species-phase (constant . 1))
 )

(triamino-silane
 fluid
 (chemical-formula . si<nh2>3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 829.58023 2.658777 -0.00046905113 -1.9171738e-06 1.146481e-09) (1000 3000 1535.6446 0.82776033 -5.6428806e-05 -7.3625624e-08 1.5262287e-11)))
 (molecular-weight (constant . 76.15392))
 (formation-enthalpy (constant . -77946928))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3526380E+06))
 )

(tetramino-silane 
 fluid
 (chemical-formula . si<nh2>4)
 (specific-heat (polynomial piecewise-polynomial (300 1000 762.59981 3.1261318 -0.00038486441 -2.2508213e-06 1.2316528e-09) (1000 4000 1832.9636 0.74774108 -6.3840172e-05 -3.9153397e-08 6.9878671e-12)))
 (molecular-weight (constant . 92.17656))
 (formation-enthalpy (constant . -3.877423e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3572627E+06))
 )

(disilicon
 fluid
 (chemical-formula . si2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 509.15028 0.50919944 -0.0006568465 3.789145e-07 -8.1032963e-11) (1500 4000 651.69668 0.017088858 -8.8886066e-06 2.1744579e-09 -2.0091779e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.831899e+06 -1.517071e+04 6.446079e+02 1.896239e-01 -3.747873e-04 3.353697e-07 -1.036336e-10) (1000.000000 6000.000000 2.027974e+08 -6.227321e+05 1.382134e+03 -4.069411e-01 1.418978e-04 -2.031510e-08 1.001364e-12) ))
 (molecular-weight (constant . 56.172))
 (formation-enthalpy (constant . 6.1002144e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2294411E+06))
 )

(disilicon-carbide 
 fluid
 (chemical-formula . si2c)
 (specific-heat (polynomial piecewise-polynomial (300 1000 506.93987 0.85746965 -0.00088566344 5.6502497e-07 -1.8211289e-10) (1000 5000 772.38939 0.14757967 -8.2899195e-05 2.7368889e-08 -2.7804767e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -5.552939e+05 1.603372e+04 3.010961e+02 1.556665e+00 -2.020532e-03 1.299073e-06 -3.340314e-10) (1000.000000 6000.000000 -1.529647e+07 -4.161702e+04 8.846189e+02 -1.239845e-02 2.741709e-06 -3.146716e-10 1.459550e-14) ))
 (molecular-weight (constant . 68.18315))
 (formation-enthalpy (constant . 5.3558506e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2422039E+06))
 )

(disilicon-pentachloride 
 fluid
 (chemical-formula . si2cl5)
 (specific-heat (polynomial piecewise-polynomial (300 1500 433.88539 0.74330315 -0.00096994519 5.6391295e-07 -1.2126246e-10) (1500 4000 641.25922 0.021087184 -1.1254076e-05 2.8360222e-09 -2.6903852e-13)))
 (molecular-weight (constant . 233.437))
 (formation-enthalpy (constant . -6.3448262e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4607140E+06))
 )

(disilicon-pentachloride-hydride
 fluid
 (chemical-formula . si2cl5h)
 (specific-heat (polynomial piecewise-polynomial (300 1500 391.80905 1.0318138 -0.0012541134 7.0890834e-07 -1.5104347e-10) (1500 4000 701.2517 0.047769203 -1.5041891e-05 2.1259856e-09 -1.0920539e-13)))
 (molecular-weight (constant . 234.44498))
 (formation-enthalpy (constant . -7.9068032e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4560183E+06))
 )

(disilicon-hexachloride
 fluid
 (chemical-formula . si2cl6)
 (specific-heat (polynomial piecewise-polynomial (300 1500 424.35318 0.81085923 -0.0010700224 6.2613424e-07 -1.3517038e-10) (1500 4000 647.93507 0.021349646 -1.2003423e-05 3.1358894e-09 -3.0440762e-13)))
 (molecular-weight (constant . 268.88998))
 (formation-enthalpy (constant . -9.7379885e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4680482E+06))
 )

(disilicon-hexafluoride
 fluid
 (chemical-formula . si2f6)
 (specific-heat (polynomial piecewise-polynomial (300 1000 488.52087 1.0604411 -0.00018934161 -8.1610545e-07 4.5966319e-10) (1000 3000 894.18305 0.14017068 -2.2210233e-05 -1.220504e-08 3.2398194e-12)))
 (molecular-weight (constant . 170.1624))
 (formation-enthalpy (constant . -2.3833559e+09))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4065640E+06))
 )

(disilicon-pentahydride
 fluid
 (chemical-formula . si2h5)
 (specific-heat (polynomial piecewise-polynomial (300 1000 214.45325 4.8210877 -0.0057965146 4.1552475e-06 -1.2714165e-09) (1000 2000 1147.8916 1.2613579 -0.00014821423 -1.9591521e-07 5.7738486e-11)))
 (molecular-weight (constant . 61.21185))
 (formation-enthalpy (constant . 2.3305349e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2880918E+06))
 )

(trisilicon
 fluid
 (chemical-formula . si3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 524.18893 0.58418653 -0.00050080868 5.2337043e-08 6.9386125e-11) (1000 4000 692.86993 0.068891831 -4.7549848e-05 1.697991e-08 -1.9015325e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.099591e+06 1.555116e+04 2.453263e+02 1.610125e+00 -2.179123e-03 1.353916e-06 -3.219302e-10) (1000.000000 6000.000000 -1.676903e+08 4.635630e+05 2.583871e+02 1.933111e-01 -2.546759e-05 6.018094e-10 6.008642e-14) ))
 (molecular-weight (constant . 84.258))
 (formation-enthalpy (constant . 6.3600032e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2678308E+06))
 )

(trisilicon-octahydride 
 fluid
 (chemical-formula . si3h8)
 (specific-heat (polynomial piecewise-polynomial (300 1000 56.914958 5.7754335 -0.0069997303 4.9414705e-06 -1.4824469e-09) (1000 2000 1208.8317 1.4081805 -0.00017440373 -2.1508883e-07 6.4121772e-11)))
 (molecular-weight (constant . 92.32176))
 (formation-enthalpy (constant . 1.2091238e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3412673E+06))
 )

(trisilicon-tetranitride
 fluid
 (chemical-formula . si3n4<a>)
 (specific-heat (polynomial piecewise-polynomial (300 1000 393.02603 1.3595554 -0.0012759567 1.0468058e-06 -3.9307522e-10) (1000 3000 572.96647 0.70689689 -0.00010130494 -6.4282049e-08 1.60794e-11)))
 (molecular-weight (constant . 140.28481))
 (formation-enthalpy (constant . -7.4477088e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.1129475E+06))
 )

(silicon-bicarbide
 fluid
 (chemical-formula . sic2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 582.02661 1.3985492 -0.0017230259 1.272368e-06 -4.175722e-10) (1000 5000 918.05772 0.32989523 -0.00018070592 4.9566252e-08 -4.4675456e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -6.573561e+06 1.096183e+05 3.763766e+00 2.446057e+00 -2.290728e-03 1.017285e-06 -1.690186e-10) (1000.000000 6000.000000 1.121234e+09 -3.935079e+06 6.247667e+03 -3.195887e+00 1.006429e-03 -1.411887e-07 7.229144e-12) ))
 (molecular-weight (constant . 52.1083))
 (formation-enthalpy (constant . 6.1507987e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2366324E+06))
 )

(ethynel-silylynyl 
 fluid
 (chemical-formula . sicch)
 (specific-heat (polynomial piecewise-polynomial (300 1500 617.69409 2.1193314 -0.002310492 1.2744648e-06 -2.7283985e-10) (1500 2500 1288.1107 0.19109024 -1.8460863e-05 -5.1560088e-09 4.6289594e-13)))
 (molecular-weight (constant . 53.11627))
 (formation-enthalpy (constant . 5.2625168e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2521741E+06))
 )

(silynyl-radical
 fluid
 (chemical-formula . sich)
 (specific-heat (polynomial piecewise-polynomial (300 1500 773.09015 1.6057714 -0.0019634849 1.1888335e-06 -2.7070583e-10) (1500 2500 1256.5122 0.11308887 -1.4191131e-05 7.0744804e-09 -2.4337119e-12)))
 (molecular-weight (constant . 41.10512))
 (formation-enthalpy (constant . 5.2048221e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2294352E+06))
 )

(methylene-silylene
 fluid
 (chemical-formula . sich2)
 (specific-heat (polynomial piecewise-polynomial (300 1500 551.67194 2.2483298 -0.0020566174 1.0598082e-06 -2.2364328e-10) (1500 2500 1233.1901 0.42403278 -1.2648076e-05 -4.0812853e-08 7.5849982e-12)))
 (molecular-weight (constant . 42.11309))
 (formation-enthalpy (constant . 3.1027264e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2339888E+06))
 )

(methyl-silylidine
 fluid
 (chemical-formula . sich3)
 (specific-heat (polynomial piecewise-polynomial (300 1500 471.36288 2.6374694 -0.0017866613 7.1434016e-07 -1.304161e-10) (1500 2500 1288.3344 0.73990153 -1.1881863e-05 -9.0203833e-08 1.8020992e-11)))
 (molecular-weight (constant . 43.12106))
 (formation-enthalpy (constant . 3.1184704e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2515954E+06))
 )

(silicon-chloride
 fluid
 (chemical-formula . sicl)
 (specific-heat (polynomial piecewise-polynomial (300 1000 405.17747 0.75092245 -0.0012746373 1.0001961e-06 -2.9823982e-10) (1000 2000 557.23691 0.052607503 -3.7792567e-05 1.3213349e-08 -1.8463669e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.762346e+06 -2.840258e+04 6.587493e+02 -8.594088e-02 6.332829e-05 -1.832241e-08 5.641455e-13) (1000.000000 6000.000000 -3.365160e+07 9.542334e+04 4.714088e+02 7.763498e-02 -2.217082e-05 3.237934e-09 -1.443858e-13) ))
 (molecular-weight (constant . 63.539))
 (formation-enthalpy (constant . 1.5857746e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2376641E+06))
 )

(silicon-dichloride
 fluid
 (chemical-formula . sicl2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 321.40177 1.0988385 -0.0018764101 1.4788468e-06 -4.4240939e-10) (1000 2000 545.19635 0.069227802 -4.8443235e-05 1.6566234e-08 -2.2792851e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 4.455912e+06 -8.531787e+04 8.674832e+02 -5.216959e-01 5.639434e-04 -3.282044e-07 7.943880e-11) (1000.000000 6000.000000 -6.760275e+06 -2.241729e+03 5.896696e+02 -7.057026e-04 1.589243e-07 -1.851218e-11 8.694307e-16) ))
 (molecular-weight (constant . 98.992))
 (formation-enthalpy (constant . -1.686268e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2811801E+06))
 )

(dichlorosilane
 fluid
 (chemical-formula . sicl2h2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 90.562285 2.6853714 -0.0038621557 2.8765071e-06 -8.5300466e-10) (1000 2000 636.04475 0.41438282 -9.0194942e-05 -3.6379272e-08 1.3426393e-11)))
 (molecular-weight (constant . 101.00793))
 (formation-enthalpy (constant . -3.1172765e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2861958E+06))
 )

(silicon-trichloride
 fluid
 (chemical-formula . sicl3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 277.40381 1.3863443 -0.0023464048 1.8386742e-06 -5.4800222e-10) (1000 2000 562.64402 0.086909741 -5.7618174e-05 1.8443099e-08 -2.3636053e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 5.374739e+06 -1.037384e+05 9.347330e+02 -5.525710e-01 5.624217e-04 -3.099750e-07 7.144569e-11) (1000.000000 6000.000000 -9.134158e+06 -3.304036e+03 6.209428e+02 -1.015618e-03 2.267614e-07 -2.623272e-11 1.225165e-15) ))
 (molecular-weight (constant . 134.44499))
 (formation-enthalpy (constant . -3.2009533e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3159073E+06))
 )

(vinyl-trichlorosilane
 fluid
 (chemical-formula . sicl3ch2ch)
 (specific-heat (polynomial piecewise-polynomial (300 1500 235.17013 2.2264063 -0.0019579905 9.3786542e-07 -1.8861653e-10) (1500 4000 1061.3623 0.27930659 -3.4728309e-05 -9.5430064e-09 1.9257464e-12)))
 (molecular-weight (constant . 163.50714))
 (formation-enthalpy (constant . -5.8824211e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4002583E+06))
 )

(trichloro-silane
 fluid
 (chemical-formula . sicl3h)
 (specific-heat (polynomial piecewise-polynomial (300 1000 177.01078 2.0306555 -0.0031729703 2.4245287e-06 -7.1945811e-10) (1000 2000 593.13926 0.21872569 -7.4573386e-05 -9.876381e-10 3.4629801e-12)))
 (molecular-weight (constant . 135.45297))
	(formation-enthalpy (constant . -4.9625072e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3133938E+06))
	)

 (silicon-tetrachloride
 fluid
	(chemical-formula . sicl4)
	(specific-heat (polynomial piecewise-polynomial (300 1000 257.0238 1.5278536 -0.0025714531 2.0077519e-06 -5.9698893e-10) (1000 2000 573.02468 0.096508699 -6.2105137e-05 1.9086446e-08 -2.3276845e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 5.734382e+06 -1.069783e+05 9.339113e+02 -4.717068e-01 4.326430e-04 -2.135135e-07 4.379492e-11) (1000.000000 6000.000000 -1.028950e+07 -4.118289e+03 6.392838e+02 -1.233839e-03 2.724318e-07 -3.119371e-11 1.442992e-15) ))
	(molecular-weight (constant . 169.89799))
	(formation-enthalpy (constant . -6.6278176e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3309671E+06))
 ; Critical Properties from Somayajulu (1989) 
  (critical-pressure (constant . 3.5930e6))
  (critical-temperature (constant . 508.10))
  (critical-volume (constant . 0.001977))
  (acentric-factor (constant . 0.258))
	)

 (chloro-silane
fluid
	(chemical-formula . siclh3)
	(specific-heat (polynomial piecewise-polynomial (300 1000 63.168892 3.3767747 -0.0041238548 2.8763311e-06 -8.467244e-10) (1000 2000 744.98988 0.78419269 -0.00010249616 -1.1592298e-07 3.4932716e-11)))
	(molecular-weight (constant . 66.56291))
	(formation-enthalpy (constant . -1.3473792e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2502060E+06))
	)

 (silicon-fluoride
 fluid
	(chemical-formula . sif)
	(specific-heat (polynomial piecewise-polynomial (300 1000 555.34655 0.45709712 -0.00010234639 -3.1913593e-07 1.8385403e-10) (1000 3000 727.53674 0.062666396 -1.2714423e-05 -3.8679504e-09 1.1945169e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.372500e+06 5.900167e+03 3.901090e+02 1.316527e+00 -1.893929e-03 1.327126e-06 -3.658514e-10) (1000.000000 6000.000000 -3.195912e+07 5.116354e+04 7.245182e+02 5.074618e-02 -1.422044e-05 2.095011e-09 -8.918621e-14) ))
	(molecular-weight (constant . 47.0844))
	(formation-enthalpy (constant . -51966604))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2205473E+06))
	)

 (diamino-fluoro-silane 
fluid
	(chemical-formula . sif<nh2>2)
	(specific-heat (polynomial piecewise-polynomial (300 1000 757.58135 1.8542082 -0.00026710006 -1.3052229e-06 7.3443316e-10) (1000 4000 1353.2722 0.48317878 -4.2075583e-05 -2.4946155e-08 4.4710491e-12)))
	(molecular-weight (constant . 79.12968))
	(formation-enthalpy (constant . -3.9889341e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3251147E+06))
	)

 (triamino-fluoro-silane
 fluid
	(chemical-formula . sif<nh2>3)
	(specific-heat (polynomial piecewise-polynomial (300 1000 732.96075 2.3999782 -0.00038933354 -1.7089042e-06 9.9675366e-10) (1000 3000 1407.8369 0.72780131 -5.2635408e-05 -6.5273405e-08 1.3724933e-11)))
	(molecular-weight (constant . 95.15232))
	(formation-enthalpy (constant . -7.1360147e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3678675E+06))
	)

 (silicon-difluoride
 fluid
	(chemical-formula . sif2)
	(specific-heat (polynomial piecewise-polynomial (300 1000 483.80978 0.75974157 -0.00014692058 -5.7618565e-07 3.2805702e-10) (1000 3000 772.82714 0.098237587 -1.6850821e-05 -7.882233e-09 2.1705168e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 5.099527e+06 -5.029456e+04 5.102169e+02 1.451298e+00 -2.211490e-03 1.585871e-06 -4.425455e-10) (1000.000000 6000.000000 -2.107857e+07 -2.322607e+04 8.979727e+02 -6.857245e-03 1.508502e-06 -1.723168e-10 7.959754e-15) ))
	(molecular-weight (constant . 66.0828))
	(formation-enthalpy (constant . -6.2704525e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2568571E+06))
	)

 (diamino-difluoro-silane 
fluid
	(chemical-formula . sif2<nh2>2)
	(specific-heat (polynomial piecewise-polynomial (300 1000 646.84743 1.9622013 -0.00035534072 -1.4534069e-06 8.6124275e-10) (1000 3000 1221.3562 0.51775176 -4.1272952e-05 -4.6227847e-08 9.9363431e-12)))
	(molecular-weight (constant . 98.12808))
	(formation-enthalpy (constant . -1.0342929e+09))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3463645E+06))
	)

 (silicon-difluoride-nitride
 fluid
	(chemical-formula . sif2n)
	(specific-heat (polynomial piecewise-polynomial (300 1000 529.715 0.98171963 -0.0001888758 -7.5883396e-07 4.3382481e-10) (1000 3000 901.85945 0.12389975 -2.0686423e-05 -1.0330788e-08 2.8075041e-12)))
	(molecular-weight (constant . 80.0895))
	(formation-enthalpy (constant . -2.6406066e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2950434E+06))
	)

 (difluoro-aminosilyl-radical
 fluid
	(chemical-formula . sif2nh2)
	(specific-heat (polynomial piecewise-polynomial (300 1000 596.49097 1.3013746 -0.00018871147 -8.8291868e-07 4.9102506e-10) (1000 3000 999.72198 0.37691662 -3.3126935e-05 -3.363666e-08 7.3858978e-12)))
	(molecular-weight (constant . 82.10544))
	(formation-enthalpy (constant . -6.9962848e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3242173E+06))
	)

 (silicon-trifluoride 
fluid
	(chemical-formula . sif3)
	(specific-heat (polynomial piecewise-polynomial (300 1000 455.66671 0.98581181 -0.00017644211 -7.5923463e-07 4.2781415e-10) (1000 3000 833.06302 0.12936418 -2.0563512e-05 -1.1233231e-08 2.9857139e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 5.624141e+06 -7.015851e+04 5.256785e+02 1.771866e+00 -2.676148e-03 1.902292e-06 -5.268326e-10) (1000.000000 6000.000000 -2.837587e+07 -3.348832e+04 1.002189e+03 -9.959917e-03 2.197527e-06 -2.516431e-10 1.164777e-14) ))
	(molecular-weight (constant . 85.0812))
	(formation-enthalpy (constant . -9.9342528e+08))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2835570E+06))
	)

 (trifluoro-silane-nitrene
fluid
	(chemical-formula . sif3nh)
	(specific-heat (polynomial piecewise-polynomial (300 1000 499.53067 1.327134 -0.00023186966 -1.0084937e-06 5.7541712e-10) (1000 3000 966.66819 0.23928741 -2.7887078e-05 -2.1468609e-08 5.1186968e-12)))
	(molecular-weight (constant . 100.09588))
	(formation-enthalpy (constant . -1.0445807e+09))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3502231E+06))
	)

 (trifluoro-amino-silane
 fluid
	(chemical-formula . sif3nh2)
	(specific-heat (polynomial piecewise-polynomial (300 1000 512.27899 1.4621621 -0.0002148245 -1.0421258e-06 5.7931361e-10) (1000 3000 995.84378 0.36046202 -3.406402e-05 -3.2804539e-08 7.367454e-12)))
	(molecular-weight (constant . 101.10384))
	(formation-enthalpy (constant . -1.3301051e+09))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3390543E+06))
	)

 (trifluorosilyl-silyl-nitrene
 fluid
	(chemical-formula . sif3nhsih3)
	(specific-heat (polynomial piecewise-polynomial (300 1000 393.90276 1.8626153 -0.00017221997 -1.2565234e-06 6.354408e-10) (1000 3000 1058.2197 0.49362851 -5.1395631e-05 -4.8478317e-08 1.1241329e-11)))
	(molecular-weight (constant . 131.20578))
	(formation-enthalpy (constant . -1.3396269e+09))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4053743E+06))
	)

 (trifluorosilyl-silyl-nitryne
 fluid
	(chemical-formula . sif3nsih3)
	(specific-heat (polynomial piecewise-polynomial (300 1000 408.97857 1.6616072 -0.00015910817 -1.130017e-06 5.696174e-10) (1000 3000 1021.2034 0.40685297 -4.6341556e-05 -4.0184673e-08 9.5479635e-12)))
	(molecular-weight (constant . 130.19781))
	(formation-enthalpy (constant . -1.0578802e+09))
	(reference-temperature (constant . 298))
       (formation-entropy (constant .  0.4156757E+06))
	)

(silicon-tetrafluoride
 fluid
 (chemical-formula . sif4)
 (specific-heat (polynomial piecewise-polynomial (300 1000 171.54513 2.7178435 -0.0038000012 2.5979985e-06 -7.0452511e-10) (1000 2000 797.67015 0.28220271 -9.5651837e-05 -8.2804103e-09 6.9192582e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 9.912058e+05 -9.872222e+03 2.143346e+02 2.610161e+00 -3.637343e-03 2.464915e-06 -6.604319e-10) (1000.000000 6000.000000 -3.094586e+07 -5.030252e+04 1.076079e+03 -1.503772e-02 3.326277e-06 -3.817526e-10 1.770432e-14) ))
 (molecular-weight (constant . 104.0796))
 (formation-enthalpy (constant . -1.6150276e+09))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2826363E+06))
 ; Critical Properties from Somayajulu (1989)  acentric factor missing
  (critical-pressure (constant . 3.7200e6))
  (critical-temperature (constant . 259.00))
  (critical-volume (constant . 0.001980))
 )

(fluoro-silane
 fluid
 (chemical-formula . sifh3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 337.19575 2.2256887 -4.6565539e-05 -1.2947796e-06 5.5377826e-10) (1000 3000 1128.2526 0.78767151 -7.9098669e-05 -7.9888464e-08 1.8380791e-11)))
 (molecular-weight (constant . 50.10831))
 (formation-enthalpy (constant . -3.5776285e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2385250E+06))
 )

(fluoro-amino-silylidene
 fluid
 (chemical-formula . sifnh)
 (specific-heat (polynomial piecewise-polynomial (300 1000 721.7505 0.81287865 -0.00018201986 -5.7135966e-07 3.4853176e-10) (1000 3000 959.08191 0.20368757 -2.0569758e-05 -1.6012146e-08 3.5936949e-12)))
 (molecular-weight (constant . 62.09907))
 (formation-enthalpy (constant . -56430572))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2885111E+06))
 )

(fluoro-aminosilane 
 fluid
 (chemical-formula . sifnh2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 555.20022 1.4563927 -0.00013368987 -9.4118472e-07 4.7890025e-10) (1000 4000 1056.3148 0.42279867 -4.4285903e-05 -2.3669326e-08 4.4604581e-12)))
 (molecular-weight (constant . 63.10704))
 (formation-enthalpy (constant . -3.3489622e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2703877E+06))
 )

(silicon-hydride
 fluid
 (chemical-formula . sih)
 (specific-heat (polynomial piecewise-polynomial (300 1000 1096.2369 -0.77235247 0.0019572954 -1.5500982e-06 4.2069886e-10) (1000 2000 888.88424 0.3129086 8.2835645e-06 -7.8448304e-08 2.0152305e-11)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -7.617890e+05 8.358104e+03 1.203197e+03 -1.366088e+00 3.178590e-03 -2.638281e-06 7.852311e-10) (1000.000000 6000.000000 -4.203566e+08 1.060273e+06 -2.516622e+01 6.788242e-01 -1.366600e-04 1.383174e-08 -5.001608e-13) ))
 (molecular-weight (constant . 29.09397))
 (formation-enthalpy (constant . 3.8368672e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.1849393E+06))
 )

(chloro-silyl-radical
 fluid
 (chemical-formula . sih2cl)
 (specific-heat (polynomial piecewise-polynomial (300 1000 215.51681 2.4876547 -0.0033267196 2.4559585e-06 -7.414994e-10) (1000 2000 704.65553 0.51321534 -8.347642e-05 -6.3764443e-08 2.0281531e-11)))
 (molecular-weight (constant . 65.55494))
 (formation-enthalpy (constant . 32632408))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2606746E+06))
 )

(fluoro-silyl-radical
 fluid
 (chemical-formula . sih2f)
 (specific-heat (polynomial piecewise-polynomial (300 1000 471.18206 1.5491077 -7.0896391e-05 -9.1253413e-07 4.0845528e-10) (1000 3000 1019.456 0.52053824 -5.501457e-05 -5.1684743e-08 1.2019455e-11)))
 (molecular-weight (constant . 49.10034))
 (formation-enthalpy (constant . -1.7642131e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2498168E+06))
 )

(difluoro-dichloro-silane
 fluid
 (chemical-formula . sih2f2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 329.8272 1.7783312 -0.00014203015 -1.1825664e-06 5.823308e-10) (1000 3000 976.46615 0.47756915 -5.1555711e-05 -4.7784679e-08 1.1197791e-11)) (polynomial nasa-9-piecewise-polynomial (300.000000 1000.000000 0.000000e+00 0.000000e+00 2.365719e+01 3.672614e+00 -4.380065e-03 2.767726e-06 -7.226327e-10) (1000.000000 5000.000000 0.000000e+00 0.000000e+00 8.666555e+02 7.587798e-01 -3.207732e-04 6.093668e-08 -4.300399e-12) ))
 (molecular-weight (constant . 68.09874))
 (formation-enthalpy (constant . -7.7985107e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2628229E+06))
 )

(silyl-radical
 fluid
 (chemical-formula . sih3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 787.53488 1.7282874 0.00016013109 -5.928863e-07 8.1584703e-11) (1000 3000 1340.5357 0.99760338 -9.6454448e-05 -9.9665277e-08 2.2632631e-11)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 1.160241e+06 6.086148e+04 1.739436e+02 3.264493e+00 -1.161968e-03 -4.743754e-07 3.164944e-10) (1000.000000 6000.000000 1.618650e+08 -1.261832e+06 3.552315e+03 -3.359069e-01 7.184882e-05 -8.046697e-09 3.664076e-13) ))
 (molecular-weight (constant . 31.10991))
 (formation-enthalpy (constant . 1.9843896e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2167634E+06))
 )

(amino-silane
 fluid
 (chemical-formula . sih3nh2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 517.98164 2.9542342 -5.7028702e-05 -1.6179663e-06 7.0199998e-10) (1000 3000 1430.6216 1.2728829 -0.00010676374 -1.2500097e-07 2.7481241e-11)))
 (molecular-weight (constant . 47.13255))
 (formation-enthalpy (constant . -47682004))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2747632E+06))
 )

(disilyl-nitrene 
 fluid
 (chemical-formula . sih3nhsih3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 265.76232 3.165201 -6.7262024e-05 -1.8639282e-06 8.1225191e-10) (1000 3000 1362.099 1.1483608 -0.0001084403 -1.1639421e-07 2.6399836e-11)))
 (molecular-weight (constant . 77.2345))
 (formation-enthalpy (constant . -59898824))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3596578E+06))
 )

(disilyl-carbyne
 fluid
 (chemical-formula . sih3nsih3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 308.41511 2.8148166 -4.5816329e-05 -1.6403205e-06 6.9680072e-10) (1000 3000 1310.4839 1.0021202 -9.9906602e-05 -1.0232206e-07 2.3521122e-11)))
 (molecular-weight (constant . 76.22652))
 (formation-enthalpy (constant . 2.0462114e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3627678E+06))
 )

(sih3sih2ch3-2-methyl-disilane
 fluid
 (chemical-formula . sih3sih2ch3)
 (specific-heat (polynomial piecewise-polynomial (300 1500 232.5016 4.7419905 -0.0038117837 1.7318857e-06 -3.4357587e-10) (1500 4000 2057.3901 0.70333945 -7.5201878e-05 -2.8185806e-08 5.2674391e-12)))
 (molecular-weight (constant . 76.24691))
 (formation-enthalpy (constant . 17323540))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.3427008E+06))
 )

(dichloro-silyl-radical
 fluid
 (chemical-formula . sihcl2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 196.91297 1.9963468 -0.0030906233 2.371248e-06 -7.0925449e-10) (1000 2000 601.10484 0.23855554 -7.3580903e-05 -6.232319e-09 4.7826911e-12)))
 (molecular-weight (constant . 99.99997))
 (formation-enthalpy (constant . -1.4352147e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2941514E+06))
 )

(fluoro-silylene
 fluid
 (chemical-formula . sihf)
 (specific-heat (polynomial piecewise-polynomial (300 1000 557.32672 0.86116687 -5.4856573e-05 -4.8791498e-07 2.1572853e-10) (1000 3000 877.12187 0.26507743 -3.1821797e-05 -2.4895762e-08 5.9688058e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 3.790726e+06 -1.067619e+04 3.677959e+02 1.942456e+00 -2.286442e-03 1.436229e-06 -3.475980e-10) (1000.000000 6000.000000 7.001510e+08 -1.607079e+06 1.852928e+03 3.229751e-01 -1.953317e-04 3.389025e-08 -1.979011e-12) ))
 (molecular-weight (constant . 48.09237))
 (formation-enthalpy (constant . -1.4938264e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2387942E+06))
 )

(difluoro-silyl-radical
 fluid
 (chemical-formula . sihf2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 418.52993 1.2846334 -0.00015355541 -9.0069707e-07 4.7030057e-10) (1000 3000 894.32168 0.27923665 -3.3924593e-05 -2.6934978e-08 6.5127595e-12)))
 (molecular-weight (constant . 67.09077))
 (formation-enthalpy (constant . -5.8397837e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2722152E+06))
 )

(trifluoro-silane
 fluid
 (chemical-formula . sihf3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 378.39862 1.4138253 -0.00017925587 -1.0219911e-06 5.4253236e-10) (1000 3000 904.31677 0.28466964 -3.4552147e-05 -2.7604221e-08 6.6790877e-12)) (polynomial nasa-9-piecewise-polynomial (300.000000 1000.000000 0.000000e+00 0.000000e+00 8.755474e+01 3.212771e+00 -4.242662e-03 2.832544e-06 -7.595967e-10) (1000.000000 5000.000000 0.000000e+00 0.000000e+00 8.455497e+02 4.397087e-01 -1.881147e-04 3.602524e-08 -2.556866e-12) ))
 (molecular-weight (constant . 86.08917))
 (formation-enthalpy (constant . -1.2076988e+09))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2788983E+06))
 )

(silicon-nitride
 fluid
 (chemical-formula . sin)
 (specific-heat (polynomial piecewise-polynomial (300 1000 622.0404 0.51047758 -0.00011465555 -3.5665538e-07 2.0564177e-10) (1000 3000 814.37558 0.069557405 -1.4144888e-05 -4.2565664e-09 1.3170085e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -2.893164e+06 2.716022e+04 7.266151e+02 -1.216487e+00 4.561787e-03 -4.532246e-06 1.460864e-09) (1000.000000 6000.000000 -5.792928e+08 1.156278e+06 2.610261e+02 2.485576e-01 -7.454551e-05 1.360538e-08 -8.276188e-13) ))
 (molecular-weight (constant . 42.0927))
 (formation-enthalpy (constant . 4.8346448e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2173917E+06))
 )

(silicon-nitride-hydride
 fluid
 (chemical-formula . sinh)
 (specific-heat (polynomial piecewise-polynomial (300 1000 610.92552 1.1199728 -0.00018373138 -7.7005644e-07 4.4043865e-10) (1000 3000 950.79079 0.31416999 -2.6373932e-05 -2.6822693e-08 5.7851627e-12)))
 (molecular-weight (constant . 43.10067))
 (formation-enthalpy (constant . 1.6064267e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2161616E+06))
 )

(silicon-nitride-dihydride
 fluid
 (chemical-formula . sinh2)
 (specific-heat (polynomial piecewise-polynomial (300 1000 633.87133 1.3687086 -0.00016439249 -8.2938879e-07 4.5607416e-10) (1000 3000 977.62668 0.56863015 -4.0818541e-05 -5.1321243e-08 1.0755973e-11)))
 (molecular-weight (constant . 44.10864))
 (formation-enthalpy (constant . 2.0364091e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2450531E+06))
 )

(silane
 fluid
 (chemical-formula . sih4)
 (density (constant . 1.308))
 (specific-heat (polynomial piecewise-polynomial (300 1000 640.74501 2.3307888 0.00056573183 -6.9413865e-07 -1.7139957e-10) (1000 4000 1784.6135 1.0433735 -0.00010829324 -5.9317202e-08 1.1350822e-11)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 2.038171e+07 -1.430621e+05 6.469453e+02 3.733268e+00 -2.191844e-03 7.056608e-07 -1.407205e-10) (1000.000000 6000.000000 3.340531e+08 -2.022730e+06 4.734518e+03 -5.114537e-01 1.076054e-04 -1.190036e-08 5.366192e-13) ))
 (molecular-weight (constant . 32.11788))
 (formation-enthalpy (constant . 33892444))
 (reference-temperature (constant . 298.15))
 (lennard-jones-length (constant . 4.084))
 (lennard-jones-energy (constant . 207.6))
 (thermal-accom-coefficient (constant . 0.9137))
 (velocity-accom-coefficient (constant . 0.9137))
 (formation-entropy (constant . 204594.73))
 ; Critical Properties from Somayajulu (1989) 
  (critical-pressure (constant . 4.8400e6))
  (critical-temperature (constant . 269.70))
  (critical-volume (constant . 0.004842))
  (acentric-factor (constant . 0.089))
 )

(silane-hydrogen
 mixture
 (chemical-formula . #f)
 (species (names (sih4 h2) (si<s>)))
 (reactions (finite-rate ("reaction-1" ((sih4 1 1 0)) ((h2 2 0 0) (si<s> 1 0 0)) () (stoichiometry "1sih4 --> 2h2 + 1si<s>") (arrhenius 0.334 100000 0.5) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (surface-reaction? . #t))))
 (viscosity (polynomial 3.17e-06 2.04e-08 -3.52e-12))
 (thermal-conductivity (polynomial 0.038 0.000541 -2.51e-07 8.57e-11))
 (mass-diffusivity (dilute-approx (sih4 (polynomial 0 7.234e-08 4.569e-10 -8.016e-14)) (h2 (constant . 2.88e-05))))
 )

(silane-hydrogen-3-step
 mixture
 (chemical-formula . #f)
 (species (names (sih4 sih2 h2) (si<s>)))
 (reactions (finite-rate ("reaction-1" ((sih4 1 1 0)) ((sih2 1 0 0) (h2 1 0 0)) ((si<s> 0 0)) (stoichiometry "1sih4 --> 1sih2 + 1h2") (arrhenius 2.115e+15 2.59e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (surface-reaction? . #f)) ("reaction-2" ((sih4 1 1 0)) ((h2 2 0 0) (si<s> 1 0 0)) ((sih2 0 0)) (stoichiometry "1sih4 --> 2h2 + 1si<s>") (arrhenius 0.334 78150000 0.5) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (surface-reaction? . #t)) ("reaction-3" ((sih2 1 1 0)) ((h2 1 0 0) (si<s> 1 0 0)) ((sih4 0 0)) (stoichiometry "1sih2 --> 1h2 + 1si<s>") (arrhenius 1e+15 100 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (surface-reaction? . #t))))
 (viscosity (polynomial 3.17e-06 2.04e-08 -3.52e-12))
 (thermal-conductivity (polynomial 0.038 0.000541 -2.51e-07 8.57e-11))
 (mass-diffusivity (constant-dilute-appx 0.000288))
 )

(silicon-solid
 (fluid inert-particle droplet-particle)
 (chemical-formula . si<s>)
 (density (constant . 2000))
 (specific-heat (polynomial piecewise-polynomial (273 1000 170.11206 3.0387201 -0.0052555797 4.3146586e-06 -1.3295637e-09) (1000 2500 749.04106 0.25229083 -9.5424799e-05 3.7916328e-08 -5.4790954e-12)))
 (molecular-weight (constant . 28.086))
 (formation-enthalpy (constant . 0.0))
 (reference-temperature (constant . 298.15))
 (lennard-jones-length (constant . 0))
 (lennard-jones-energy (constant . 0))
 (thermal-accom-coefficient (constant . 0.9137))
 (velocity-accom-coefficient (constant . 0.9137))
 (formation-entropy (constant . 18822.82))
 (species-phase (constant . 1))
 (boiling-point (constant . 3538))
 )

(silicon-carbide
 fluid
 (chemical-formula . sic)
 (density (constant . 3170))
 (specific-heat (polynomial piecewise-polynomial (300 1000 503.41867 1.9806401 -0.00057989548 -2.8200516e-06 1.9069021e-09) (1000 5000 1041.8069 -0.10203714 6.4473164e-05 -1.4310273e-08 1.0815081e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.290489e+06 6.514914e+04 8.072917e+01 2.462452e+00 -3.399256e-03 2.346953e-06 -6.314879e-10) (1000.000000 6000.000000 -1.299919e+07 1.495054e+05 4.485015e+02 4.564683e-01 -1.362265e-04 1.902994e-08 -1.030422e-12) ))
 (molecular-weight (constant . 40.09715))
 (formation-enthalpy (constant . 7.1970611e+08))
 (reference-temperature (constant . 298.15))
 (lennard-jones-length (constant . 0))
 (lennard-jones-energy (constant . 0))
 (thermal-accom-coefficient (constant . 0.9137))
 (velocity-accom-coefficient (constant . 0.9137))
       (formation-entropy (constant .  0.2131108E+06))
 )
 
(silylene
 fluid
 (chemical-formula . sih2)
 (density (constant . 1.226))
 (specific-heat (polynomial piecewise-polynomial (300 1000 959.84165 0.59089826 0.00021191376 1.4411518e-07 -2.7341158e-10) (1000 3000 1144.1534 0.59389591 -6.0509303e-05 -5.7277551e-08 1.3094981e-11)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -5.409245e+07 7.620169e+05 -2.737010e+03 7.632321e+00 -2.846832e-03 -2.499934e-06 1.627656e-09) (1000.000000 6000.000000 -5.539155e+08 1.054471e+06 1.148539e+03 2.858770e-01 -5.684648e-05 6.294684e-09 -2.939814e-13) ))
 (molecular-weight (constant . 30.10194))
 (formation-enthalpy (constant . 2.711351e+08))
 (reference-temperature (constant . 298.15))
 (lennard-jones-length (constant . 3.803))
 (lennard-jones-energy (constant . 133.1))
 (thermal-accom-coefficient (constant . 0.9137))
 (velocity-accom-coefficient (constant . 0.9137))
 (formation-entropy (constant . 207099.81))
 )

(sodium-sulfide 
 fluid               
 (chemical-formula . na2s)
 (specific-heat (polynomial piecewise-polynomial ( 300.00 1000.00  0.1034212E+04 -0.3316082E-01  0.5872429E-03 -0.6438555E-06  0.2452215E-09) (1000.00 1276.00  0.4759588E+05 -0.1127703E+03  0.8647597E-01 -0.2011294E-04  0.0000000E+00)))
 (molecular-weight (constant .  0.7804360E+02))
 (formation-enthalpy (constant . -0.3661175E+09))
 (reference-temperature (constant . 298.00))
 (formation-entropy (constant .  0.9620290E+05))
 )

(sulfur-nitride
 fluid
 (chemical-formula . sn)
 (specific-heat (polynomial piecewise-polynomial (300 1000 614.92069 0.32446316 -0.00036436165 3.8040318e-07 -1.7194366e-10) (1000 5000 701.71572 0.1223297 -4.9183403e-05 9.2687644e-09 -6.4857653e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.233546e+07 2.070947e+05 -5.193399e+02 3.112760e+00 -3.715754e-03 2.276319e-06 -5.664820e-10) (1000.000000 6000.000000 -8.729559e+07 1.909446e+05 5.569479e+02 1.644273e-01 -4.988137e-05 7.502558e-09 -3.840909e-13) ))
 (molecular-weight (constant . 46.0707))
 (formation-enthalpy (constant . 2.635941e+08))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2219665E+06))
 )

(sulfur-oxide 
 fluid
 (chemical-formula . so)
 (specific-heat (polynomial piecewise-polynomial (300 1000 532.8691 0.3119136 0.00011598811 -3.5791081e-07 1.4729244e-10) (1000 5000 695.59379 0.044714632 1.5479116e-05 -6.1931814e-09 5.584762e-13)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -5.782384e+06 1.107756e+05 -1.741313e+02 2.389775e+00 -2.948463e-03 1.835854e-06 -4.576764e-10) (1000.000000 6000.000000 -2.496847e+08 7.116282e+05 -9.312851e+01 4.833396e-01 -1.147454e-04 1.355875e-08 -6.159057e-13) ))
 (molecular-weight (constant . 48.0634))
 (formation-enthalpy (constant . 5002038.5))
 (reference-temperature (constant . 298))
       (formation-entropy (constant .  0.2218385E+06))
 )

(sulfur-trioxide
 fluid
 (chemical-formula . so3)
 (specific-heat (polynomial piecewise-polynomial (300 1000 267.43922 1.5734001 -0.0012772035 4.4034439e-07 -5.4695059e-11) (1000 5000 732.20137 0.33715043 -0.00014631191 2.8262736e-08 -2.0171161e-12)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -4.105155e+06 6.447746e+04 -1.493209e+02 2.870521e+00 -3.266025e-03 1.861822e-06 -4.285286e-10) (1000.000000 6000.000000 -2.249759e+07 -1.351245e+05 1.138488e+03 -3.985814e-02 8.795756e-06 -1.008318e-09 4.673855e-14) ))
 (molecular-weight (constant . 80.06219))
 (formation-enthalpy (constant . -3.957823e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.2566855E+06))
  ; Critical Properties from Polling et al.
  (critical-pressure (constant . 8.2100e6))
  (critical-temperature (constant . 490.90))
  (critical-volume (constant . 0.001580)) 
  (acentric-factor (constant . 4.81000E-01))
 )

(sodium-sulfate 
 (fluid inert-particle droplet-particle)              
 (chemical-formula . na2so4)
 (specific-heat (polynomial 0.3414945E+03  0.1804088E+01  0.3500367E-02 -0.1520640E-04  0.1450836E-07) (polynomial nasa-9-piecewise-polynomial (300.000000 1000.000000 0.000000e+00 0.000000e+00 1.213281e+02 3.194951e+00 -4.597533e-03 3.225517e-06 -8.936324e-10) (1000.000000 5000.000000 0.000000e+00 0.000000e+00 8.900883e+02 2.516077e-01 -1.112654e-04 2.176766e-08 -1.567590e-12) ))
 (boiling-point (constant . 1702))
 (molecular-weight (constant .  0.1420412E+03))
 (formation-enthalpy (constant . -0.1387835E+10))
 (reference-temperature (constant . 298.00))
 (formation-entropy (constant .  0.1495323E+06))
 )

(steel
 (solid inert-particle)
 (chemical-formula . #f)
 (density (constant . 8030))
 (specific-heat (constant . 502.48))
 (thermal-conductivity (constant . 16.27))
 (atomic-number (constant . 26)) ;; use the atomic number for Fe
 (electric-conductivity (constant . 8.33e+06))
 (magnetic-permeability (constant . 1.257e-06))
 (struct-youngs-modulus (constant . 2.09e+11))
 (struct-poisson-ratio (constant . 0.3))
 )

(sulfur-solid 
 (fluid inert-particle droplet-particle)
 (chemical-formula . s<s>)
 (density (constant . 2046))
 (specific-heat (polynomial piecewise-polynomial (273 388.36 -1313.0409 0.74729881 -0.0055310171 0.00021985875 -4.4976266e-07) (388.36 388.36 0 0 0 0 0)) (constant . 634))
 (molecular-weight (constant . 32.064))
 (boiling-point (constant . 717.76))
 (formation-enthalpy (constant . 16919.988))
 (reference-temperature (constant . 298))
 (formation-entropy (constant .  0.3190344E+05))
 (species-phase (constant . 1))
 (thermal-conductivity (constant . 0.269))
  ; Critical Properties from Polling et al. 
 (critical-pressure (constant . 18.200e6))
 (critical-temperature (constant . 1313.01))
 (critical-volume (constant . 0.004928)) 
 (acentric-factor (constant . 1.71000E-01))   
 )

(sulfur-dioxide
 fluid
 (chemical-formula . so2)
 (density (constant . 2.77))
 (specific-heat (polynomial piecewise-polynomial (300 1000 377.8587 1.0516444 -0.00089638195 4.3205361e-07 -1.1391317e-10) (1000 5000 681.95091 0.25678391 -0.0001064779 2.0458964e-08 -1.4541688e-12)) (constant . 622.28) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -6.892529e+06 1.179761e+05 -3.058826e+02 2.860984e+00 -3.258548e-03 1.877041e-06 -4.372455e-10) (1000.000000 6000.000000 -1.463476e+07 -1.070997e+05 9.884446e+02 -2.594772e-02 7.340004e-06 -7.078734e-10 3.787427e-14) ))
 (thermal-conductivity (constant . 0.0104))
 (viscosity (constant . 1.2e-05))
 (molecular-weight (constant . 64.0648))
 (absorption-coefficient (constant . 0.74) (polynomial piecewise-linear (550 . 1.1) (890 . 1.28) (1220 . 1.05) (1550 . 0.74)))
 (formation-enthalpy (constant . -2.9686122e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant . 248098.25))
  ; Critical Properties from Polling et al. 
 (critical-pressure (constant . 7.8840e6))
 (critical-temperature (constant . 430.80))
 (critical-volume (constant . 0.001904)) 
 (acentric-factor (constant . 2.56000E-01))   
 )

(sulfur-vapor
 fluid
 (chemical-formula . s2)
 (density (constant . 2.71))
 (specific-heat (polynomial piecewise-polynomial (300 1000 409.39931 0.40185458 -0.00020235431 -1.7605357e-07 1.4747213e-10) (1000 5000 506.21987 0.089793697 -1.5987382e-05 1.1388407e-10 1.7822804e-13)) (constant . 537) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 4.574038e+06 -5.473867e+04 6.064117e+02 2.235161e-01 -5.007208e-04 4.325201e-07 -1.287473e-10) (1000.000000 6000.000000 -2.058949e+06 8.187783e+04 3.175851e+02 2.575086e-01 -8.437283e-05 1.300110e-08 -7.256287e-13) ))
 (thermal-conductivity (constant . 0.0104))
 (viscosity (constant . 1.2e-05))
 (molecular-weight (constant . 64.128))
 (formation-enthalpy (constant . 1.2848931e+08))
 (reference-temperature (constant . 298))
 (formation-entropy (constant . 228064.2))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 9.664E+06))
  (critical-temperature (constant . 1252.90))
  (acentric-factor (constant . 0.132))
  (critical-volume (constant . 0.002089))
 )
 
(titanium
 (solid inert-particle)
 (chemical-formula . ti)
 (density (constant . 4850))
 (specific-heat (constant . 544.25) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -7.938377e+06 1.147822e+05 7.460839e+01 6.279288e-01 -6.165971e-04 3.057028e-07 -5.302560e-11) (1000.000000 6000.000000 -2.961205e+07 1.865277e+05 2.053050e+02 3.899981e-02 5.370263e-05 -9.970397e-09 5.084828e-13) (6000.000000 20000.000000 2.002404e+11 -1.254528e+08 3.086930e+04 -3.487988e+00 2.120961e-04 -6.620472e-09 8.334261e-14) ))
 (thermal-conductivity (constant . 7.44))
 (atomic-number (constant . 22))
 (electric-conductivity (constant . 2.381e+06))
 (magnetic-permeability (constant . 1.257e-06))
 (struct-youngs-modulus (constant . 1.1e+11))
 (struct-poisson-ratio (constant . 0.3))
 )
 
(toluene-liquid
 (fluid inert-particle droplet-particle)
 (chemical-formula . c7h8<l>)
 (density (constant . 866)(compressible-liquid 101325 866 1.35E9 7 1.1 0.9));compressible liquid data from Perry's handbook
 (specific-heat (constant . 1675)(polynomial piecewise-linear (280 . 1645) (300 . 1707) (320 . 1773) (340 . 1842) (360 . 1914) (380 . 1989) (400 . 2066) (420 . 2145) (440 . 2228) (460 . 2317) (480 . 2415) (500 . 2529) (520 . 2671)))
 (latent-heat (constant . 363431))
 (vaporization-temperature (constant . 279))
 (boiling-point (constant . 384))
 (volatile-fraction (constant . 1))
 (binary-diffusivity (film-averaged (averaging-coefficient 0.3333) (film-diffusivity  (polynomial piecewise-linear (300 . 8.96E-6) (350 . 1.17E-5) (373 . 1.31E-5) (400 . 1.48E-5) (450 . 1.82E-5) (473 . 1.99E-5)) (constant . 8.8e-06)))(constant . 8.8e-06));;data from Perry's extended according to the (T/T0)^1.75 analogy
 (thermal-conductivity (constant . 0.151))
 (viscosity (constant . 0.000586))
 (dpm-surften (constant . 0.0279574) (polynomial piecewise-polynomial (50 591 7.04298e-02 -1.51769e-04 5.92297e-09 8.42193e-11)))
 (vapor-pressure (polynomial piecewise-linear (279 . 1329) (291 . 2658) (305 . 5316) (313 . 7974) (325 . 13289) (343 . 26579) (363 . 53158) (384 . 101000) (410 . 202000) (448 . 505000) (490 . 1000000) (536 . 2000000) (566 . 3000000) (591.75 . 4108000))(constant . 2658) )
  ;; http://webbook.nist.gov
 (molecular-weight (constant . 92.0702))
 (species-phase (constant . 1))
 (formation-enthalpy (constant . 12.0E+6))
 (reference-temperature (constant . 298.15))
 (formation-entropy (constant . 220.96E+03))
 )
 
(toluene-vapor
 fluid
 (chemical-formula . c7h8)
 (density (constant . 3.91))
 (specific-heat (polynomial 26.177 4.2489 -0.0014192) (constant . 1676) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -2.597110e+07 5.535299e+05 -4.128219e+03 1.747849e+01 -2.079402e-02 1.316874e-05 -3.420822e-09) (1000.000000 6000.000000 5.580840e+08 -2.698397e+06 5.398096e+03 -5.140896e-01 9.752577e-05 -9.914624e-09 4.173358e-13) ))
 (thermal-conductivity (constant . 0.0112))
 (viscosity (constant . 9e-06))
 (molecular-weight (constant . 92.13))
 (formation-enthalpy (constant . 50000000))
 (reference-temperature (constant . 298.15))
  ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 4.1080e6))
  (critical-temperature (constant . 591.75))
  (acentric-factor (constant . 0.264))
  (critical-volume (constant . 0.003430))
 )
 
(toluene-air
 mixture
 (chemical-formula . #f)
 (species (names c7h8 o2 co2 h2o n2))
 (reactions (finite-rate ("reaction-1" ((c7h8 1 -0.1 1) (o2 9 1.85 1)) ((co2 7 0 1) (h2o 4 0 1)) ((n2 0 1)) (stoichiometry "1c7h8 + 9o2 --> 7co2 + 4h2o") (arrhenius 8.997e+08 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((c7h8 1 -0.1 1) (o2 9 1.85 1)) ((co2 7 0 1) (h2o 4 0 1)) ((n2 0 1)) (stoichiometry "1c7h8 + 9o2 --> 7co2 + 4h2o") (arrhenius 8.997e+08 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((c7h8 1 -0.1 1) (o2 9 1.85 1)) ((co2 7 0 1) (h2o 4 0 1)) ((n2 0 1)) (stoichiometry "1c7h8 + 9o2 --> 7co2 + 4h2o") (arrhenius 8.997e+08 1.256e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
 )

(tungsten-hexafluoride
 fluid
 (chemical-formula . wf6)
 (specific-heat (polynomial 325 0.469 -0.000294))
 (molecular-weight (constant . 297.84))
 (formation-enthalpy (constant . -1.722e+09))
 (reference-temperature (constant . 298.15))
 (lennard-jones-length (constant . 5.21))
 (lennard-jones-energy (constant . 338))
 (thermal-accom-coefficient (constant . 0.9137))
 (velocity-accom-coefficient (constant . 0.9137))
 ; Critical Properties from Somayajulu (1989)  acentric factor missing
  (critical-pressure (constant . 4.3400e6))
  (critical-temperature (constant . 444.00))
  (critical-volume (constant . 0.000782))
 )

(turpentine
 fluid
 (chemical-formula . c10h16)
 (density (constant . 855))
 (specific-heat (constant . 1800))
 (thermal-conductivity (constant . 0.128))
 (viscosity (constant . 0.001487))
 (molecular-weight (constant . 136.1364))
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 2.746E+06))
  (critical-temperature (constant . 658.85))
  (acentric-factor (constant . 0.333))
  (critical-volume (constant . 0.003549))
 )

(urea-water-air
 mixture 
 (chemical-formula . #f) 
 (species (names o2 h2o co<nh2>2 hnco nh3 co2 n2)) 
 (reactions (finite-rate ("reaction-1" ((co<nh2>2 1. 1. 1)) ((nh3 1. 0. 1) (hnco 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co2 0 1) (n2 0 1)) (stoichiometry "1co<nh2>2 --> 1nh3 + 1hnco") (arrhenius 1000000000000000. 100. 0.) (mixing-rate 4. 0.5) (use-third-body-efficiencies? . #f)) ("reaction-2" ((hnco 1. 1. 1) (h2o 1. -.001 1)) ((nh3 1. 0. 1) (co2 1. 0. 1)) ((o2 0 1) (co<nh2>2 1. 1) (n2 0 1)) (stoichiometry "1hnco + 1h2o --> 1nh3 + 1co2") (arrhenius 250000. 62220000. 0.) (mixing-rate 4. 0.5) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((co<nh2>2 1. 1. 1)) ((nh3 1. 0. 1) (hnco 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co2 0 1) (n2 0 1)) (stoichiometry "1co<nh2>2 --> 1nh3 + 1hnco") (arrhenius 1000000000000000. 100. 0.) (mixing-rate 4. 0.5) (use-third-body-efficiencies? . #f)) ("reaction-2" ((hnco 1. 1. 1) (h2o 1. -.001 1)) ((nh3 1. 0. 1) (co2 1. 0. 1)) ((o2 0 1) (co<nh2>2 1. 1) (n2 0 1)) (stoichiometry "1hnco + 1h2o --> 1nh3 + 1co2") (arrhenius 250000. 62220000. 0.) (mixing-rate 4. 0.5) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((co<nh2>2 1. 1. 1)) ((nh3 1. 0. 1) (hnco 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co2 0 1) (n2 0 1)) (stoichiometry "1co<nh2>2 --> 1nh3 + 1hnco") (arrhenius 1000000000000000. 100. 0.) (mixing-rate 4. 0.5) (use-third-body-efficiencies? . #f)) ("reaction-2" ((hnco 1. 1. 1) (h2o 1. -.001 1)) ((nh3 1. 0. 1) (co2 1. 0. 1)) ((o2 0 1) (co<nh2>2 1. 1) (n2 0 1)) (stoichiometry "1hnco + 1h2o --> 1nh3 + 1co2") (arrhenius 250000. 62220000. 0.) (mixing-rate 4. 0.5) (use-third-body-efficiencies? . #f)))) 
)

;; Reaction mechanism from 
;; Brack, W., Heine, B., Birkhold, F., Kruse, M., Deutschmann, O., 2016. 
;; Formation of urea-based deposits in an exhaust system: numerical predictions and
;; experimental observations on a hot gas test bench. 
;; Emission Control Sci. Technol. 2 (3), 115-123.
;; for reaction-4 which is a surface reaction units are converted to kg/m2/s from mol/mm2/s in the publication 
;; for the other volume reactions units are converted to kmol/m3/s from mol/ml/s in the publication 


(urea-water-deposits
 particle-mixture 
 (species (names h2o<l> co<nh2>2<l> hnco<l> cya_c3h3n3o3<s> co<nh2>2<s> triu_c3h6n4o3<s> biu_c2h5n3o2<s> biu_c2h5n3o2<l> ammd_c3h4n4o2<s>))
 (reaction-model (multicomponent-reactions) (none . #f))
 )

(urea-water-deposits-air-brack 
 mixture 
 (species (names (o2 h2o co<nh2>2 hnco nh3 co2 ammd_c3h4n4o2 n2) (co<nh2>2<l> cya_c3h3n3o3<s> co<nh2>2<s> triu_c3h6n4o3<s> biu_c2h5n3o2<s> biu_c2h5n3o2<l> ammd_c3h4n4o2<s> hnco<l>) ())) 
 (reactions (finite-rate 
             ("reaction-1" ((hnco 1. 1. 1) (h2o 1. -0.001 1)) ((nh3 1. 0. 1) (co2 1. 0. 1)) ((o2 0 1) (co<nh2>2 1. 1) (ammd_c3h4n4o2 0 1) (n2 0 1)) (stoichiometry 1hnco + 1h2o --> 1nh3 + 1co2) (arrhenius 250000. 62220000. 0.)) 
             ("reaction-2" ((hnco<l> 1. 0. 1)) ((hnco 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1hnco<l> --> 1hnco) (arrhenius 1e+21 100. 0.) (particle-reaction? . #t) (reaction-model phase-change) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-3" ((co<nh2>2<s> 1. 1. 1)) ((co<nh2>2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1co<nh2>2<s> --> 1co<nh2>2<l>) (arrhenius 1.0e+15 160000000. 1.5) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-4" ((cya_c3h3n3o3<s> 1. 1. 1)) ((hnco 3. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1cya_c3h3n3o3<s> --> 3hnco) (arrhenius 8898000. 118420000. 0.) (particle-reaction? . #t) (reaction-model surface-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-5" ((biu_c2h5n3o2<l> 1. 1. 1)) ((hnco<l> 1. 0. 1) (co<nh2>2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1biu_c2h5n3o2<l> --> 1hnco<l> + 1co<nh2>2<l>) (arrhenius 1.107E+20 208230000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-6" ((hnco<l> 1. 1. 1) (co<nh2>2<l> 1. 1. 1)) ((biu_c2h5n3o2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1hnco<l> + 1co<nh2>2<l> --> 1biu_c2h5n3o2<l>) (arrhenius 3.517e+08 75450000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-7" ((co<nh2>2<l> 1. 0.3 1)) ((hnco<l> 1. 0. 1) (nh3 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1co<nh2>2<l> --> 1hnco<l> + 1nh3) (arrhenius 2518000. 74000000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-8" ((biu_c2h5n3o2<l> 2. 2. 1)) ((hnco<l> 1. 0. 1) (nh3 1. 0. 1) (h2o 1. 0. 1) (ammd_c3h4n4o2<s> 1. 0. 1)) ((o2 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1)) (stoichiometry 2biu_c2h5n3o2<l> --> 1hnco<l> + 1nh3 + 1h2o + 1ammd_c3h4n4o2<s>) (arrhenius 3.637E+23 257760000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-9" ((biu_c2h5n3o2<l> 1. 1. 1) (hnco<l> 1. 1. 1)) ((cya_c3h3n3o3<s> 1. 0. 1) (nh3 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1biu_c2h5n3o2<l> + 1hnco<l> --> 1cya_c3h3n3o3<s> + 1nh3) (arrhenius 9.397E+17 158680000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-10" ((hnco<l> 1. 1. 1) (biu_c2h5n3o2<l> 1. 1. 1)) ((triu_c3h6n4o3<s> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (biu_c2h5n3o2<s> 1. 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1hnco<l> + 1biu_c2h5n3o2<l> --> 1triu_c3h6n4o3<s>) (arrhenius 1.091E+12 116970000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-11" ((triu_c3h6n4o3<s> 1. 1. 1)) ((nh3 1. 0. 1) (cya_c3h3n3o3<s> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (co<nh2>2<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1triu_c3h6n4o3<s> --> 1nh3 + 1cya_c3h3n3o3<s>) (arrhenius 1.238E+18 194940000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-12" ((co<nh2>2<l> 1. 1. 1) (hnco<l> 2. 2. 1)) ((ammd_c3h4n4o2<s> 1. 0. 1) (h2o 1. 0. 1)) ((o2 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1)) (stoichiometry 1co<nh2>2<l> + 2hnco<l> --> 1ammd_c3h4n4o2<s> + 1h2o) (arrhenius 1.274E+14 110400000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-13" ((biu_c2h5n3o2<l> 1. 1. 1)) ((biu_c2h5n3o2<s> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1biu_c2h5n3o2<l> --> 1biu_c2h5n3o2<s>) (arrhenius 8.193E+26 271500000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-14" ((biu_c2h5n3o2<s> 1. 1. 1)) ((biu_c2h5n3o2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1biu_c2h5n3o2<s> --> 1biu_c2h5n3o2<l>) (arrhenius 3162000000. 122000000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-15" ((biu_c2h5n3o2<s> 1. 1. 1)) ((hnco 2. 0. 1) (nh3 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0. 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 1. 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1biu_c2h5n3o2<s> --> 2hnco + 1nh3) (arrhenius 5.626E+24 266380000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-16" ((ammd_c3h4n4o2<s> 1. 1. 1)) ((ammd_c3h4n4o2 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (hnco<l> 0 1)) (stoichiometry 1ammd_c3h4n4o2<s> --> 1ammd_c3h4n4o2) (arrhenius 1.0e+14 201670000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.))
             ("reaction-17" ((co<nh2>2<l> 1 0 1)) ((hnco 1 0 1) (nh3 1 0 1)) ((o2 0 0) (h2o 0 0) (co<nh2>2 1. 0) (co2 0 0) (ammd_c3h4n4o2 0 0) (n2 0 0) (cya_c3h3n3o3<s> 0 0) (co<nh2>2<s> 0 0) (triu_c3h6n4o3<s> 0 0) (biu_c2h5n3o2<s> 0 0) (biu_c2h5n3o2<l> 0 0) (ammd_c3h4n4o2<s> 0 0) (hnco<l> 0 0)) (stoichiometry 1co<nh2>2<l> --> 1hnco + 1nh3) (arrhenius 0.42 69000000. 0) (mixing-rate 4 0.5) (control-temperature 1 0.) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (particle-reaction? . #t) (reaction-model "thermolysis") (diffusion-species o2) (catalyst-species co<nh2>2<l>) (particle-rate 5e-12 1)) 
             ("reaction-18" ((co<nh2>2<s> 1 0 1)) ((hnco 1 0 1) (nh3 1 0 1)) ((o2 0 0) (h2o 0 0) (co<nh2>2 0 0) (co2 0 0) (ammd_c3h4n4o2 0 0) (n2 0 0) (co<nh2>2<l> 0 0) (cya_c3h3n3o3<s> 0 0) (triu_c3h6n4o3<s> 0 0) (biu_c2h5n3o2<s> 0 0) (biu_c2h5n3o2<l> 0 0) (ammd_c3h4n4o2<s> 0 0) (hnco<l> 0 0)) (stoichiometry 1co<nh2>2<s> --> 1hnco + 1nh3) (arrhenius 0.42 69000000. 0) (mixing-rate 4 0.5) (control-temperature 1 0.) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (particle-reaction? . #t) (reaction-model "thermolysis") (diffusion-species o2) (catalyst-species hnco<l>) (particle-rate 5e-12 1.))) 
            (eddy-dissipation 
             ("reaction-1" ((hnco 1. 1. 1) (h2o 1. -0.001 1)) ((nh3 1. 0. 1) (co2 1. 0. 1)) ((o2 0 1) (co<nh2>2 1. 1) (ammd_c3h4n4o2 0 1) (n2 0 1)) (stoichiometry 1hnco + 1h2o --> 1nh3 + 1co2) (arrhenius 250000. 62220000. 0.)) 
             ("reaction-2" ((hnco<l> 1. 0. 1)) ((hnco 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1hnco<l> --> 1hnco) (arrhenius 1e+21 100. 0.) (particle-reaction? . #t) (reaction-model phase-change) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-3" ((co<nh2>2<s> 1. 1. 1)) ((co<nh2>2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1co<nh2>2<s> --> 1co<nh2>2<l>) (arrhenius 1.0e+15 160000000. 1.5) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.))
             ("reaction-4" ((cya_c3h3n3o3<s> 1. 1. 1)) ((hnco 3. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1cya_c3h3n3o3<s> --> 3hnco) (arrhenius 8898000. 118420000. 0.) (particle-reaction? . #t) (reaction-model surface-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-5" ((biu_c2h5n3o2<l> 1. 1. 1)) ((hnco<l> 1. 0. 1) (co<nh2>2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1biu_c2h5n3o2<l> --> 1hnco<l> + 1co<nh2>2<l>) (arrhenius 1.107e+20 208230000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-6" ((hnco<l> 1. 1. 1) (co<nh2>2<l> 1. 1. 1)) ((biu_c2h5n3o2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1hnco<l> + 1co<nh2>2<l> --> 1biu_c2h5n3o2<l>) (arrhenius 3.517e+08 75450000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-7" ((co<nh2>2<l> 1. 0.3 1)) ((hnco<l> 1. 0. 1) (nh3 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1co<nh2>2<l> --> 1hnco<l> + 1nh3) (arrhenius 2518000. 74000000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-8" ((biu_c2h5n3o2<l> 2. 2. 1)) ((hnco<l> 1. 0. 1) (nh3 1. 0. 1) (h2o 1. 0. 1) (ammd_c3h4n4o2<s> 1. 0. 1)) ((o2 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1)) (stoichiometry 2biu_c2h5n3o2<l> --> 1hnco<l> + 1nh3 + 1h2o + 1ammd_c3h4n4o2<s>) (arrhenius 3.637E+23 257760000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-9" ((biu_c2h5n3o2<l> 1. 1. 1) (hnco<l> 1. 1. 1)) ((cya_c3h3n3o3<s> 1. 0. 1) (nh3 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1biu_c2h5n3o2<l> + 1hnco<l> --> 1cya_c3h3n3o3<s> + 1nh3) (arrhenius 9.397E+17 158680000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-10" ((hnco<l> 1. 1. 1) (biu_c2h5n3o2<l> 1. 1. 1)) ((triu_c3h6n4o3<s> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (biu_c2h5n3o2<s> 1. 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1hnco<l> + 1biu_c2h5n3o2<l> --> 1triu_c3h6n4o3<s>) (arrhenius 1.091E+12 116970000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-11" ((triu_c3h6n4o3<s> 1. 1. 1)) ((nh3 1. 0. 1) (cya_c3h3n3o3<s> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (co<nh2>2<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1triu_c3h6n4o3<s> --> 1nh3 + 1cya_c3h3n3o3<s>) (arrhenius 1.238E+18 194940000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-12" ((co<nh2>2<l> 1. 1. 1) (hnco<l> 2. 2. 1)) ((ammd_c3h4n4o2<s> 1. 0. 1) (h2o 1. 0. 1)) ((o2 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1)) (stoichiometry 1co<nh2>2<l> + 2hnco<l> --> 1ammd_c3h4n4o2<s> + 1h2o) (arrhenius 1.274E+14 110400000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-13" ((biu_c2h5n3o2<l> 1. 1. 1)) ((biu_c2h5n3o2<s> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1biu_c2h5n3o2<l> --> 1biu_c2h5n3o2<s>) (arrhenius 8.193E+26 271500000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-14" ((biu_c2h5n3o2<s> 1. 1. 1)) ((biu_c2h5n3o2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1biu_c2h5n3o2<s> --> 1biu_c2h5n3o2<l>) (arrhenius 3162000000. 122000000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-15" ((biu_c2h5n3o2<s> 1. 1. 1)) ((hnco 2. 0. 1) (nh3 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0. 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 1. 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1biu_c2h5n3o2<s> --> 2hnco + 1nh3) (arrhenius 5.626E+24 266380000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-16" ((ammd_c3h4n4o2<s> 1. 1. 1)) ((ammd_c3h4n4o2 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (hnco<l> 0 1)) (stoichiometry 1ammd_c3h4n4o2<s> --> 1ammd_c3h4n4o2) (arrhenius 1.0e+14 201670000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-17" ((co<nh2>2<l> 1 0 1)) ((hnco 1 0 1) (nh3 1 0 1)) ((o2 0 0) (h2o 0 0) (co<nh2>2 1. 0) (co2 0 0) (ammd_c3h4n4o2 0 0) (n2 0 0) (cya_c3h3n3o3<s> 0 0) (co<nh2>2<s> 0 0) (triu_c3h6n4o3<s> 0 0) (biu_c2h5n3o2<s> 0 0) (biu_c2h5n3o2<l> 0 0) (ammd_c3h4n4o2<s> 0 0) (hnco<l> 0 0)) (stoichiometry 1co<nh2>2<l> --> 1hnco + 1nh3) (arrhenius 0.42 69000000. 0) (mixing-rate 4 0.5) (control-temperature 1 0.) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (particle-reaction? . #t) (reaction-model "thermolysis") (diffusion-species o2) (catalyst-species co<nh2>2<l>) (particle-rate 5e-12 1)) 
             ("reaction-18" ((co<nh2>2<s> 1 0 1)) ((hnco 1 0 1) (nh3 1 0 1)) ((o2 0 0) (h2o 0 0) (co<nh2>2 0 0) (co2 0 0) (ammd_c3h4n4o2 0 0) (n2 0 0) (co<nh2>2<l> 0 0) (cya_c3h3n3o3<s> 0 0) (triu_c3h6n4o3<s> 0 0) (biu_c2h5n3o2<s> 0 0) (biu_c2h5n3o2<l> 0 0) (ammd_c3h4n4o2<s> 0 0) (hnco<l> 0 0)) (stoichiometry 1co<nh2>2<s> --> 1hnco + 1nh3) (arrhenius 0.42 69000000. 0) (mixing-rate 4 0.5) (control-temperature 1 0.) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (particle-reaction? . #t) (reaction-model "thermolysis") (diffusion-species o2) (catalyst-species hnco<l>) (particle-rate 5e-12 1.))) 
            (finite-rate/eddy-dissipation 
             ("reaction-1" ((hnco 1. 1. 1) (h2o 1. -0.001 1)) ((nh3 1. 0. 1) (co2 1. 0. 1)) ((o2 0 1) (co<nh2>2 1. 1) (ammd_c3h4n4o2 0 1) (n2 0 1)) (stoichiometry 1hnco + 1h2o --> 1nh3 + 1co2) (arrhenius 250000. 62220000. 0.)) 
             ("reaction-2" ((hnco<l> 1. 0. 1)) ((hnco 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1hnco<l> --> 1hnco) (arrhenius 1e+21 100. 0.) (particle-reaction? . #t) (reaction-model phase-change) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-3" ((co<nh2>2<s> 1. 1. 1)) ((co<nh2>2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1co<nh2>2<s> --> 1co<nh2>2<l>) (arrhenius 1.0e+15 160000000. 1.5) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.))
             ("reaction-4" ((cya_c3h3n3o3<s> 1. 1. 1)) ((hnco 3. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1cya_c3h3n3o3<s> --> 3hnco) (arrhenius 8898000. 118420000. 0.) (particle-reaction? . #t) (reaction-model surface-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-5" ((biu_c2h5n3o2<l> 1. 1. 1)) ((hnco<l> 1. 0. 1) (co<nh2>2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1biu_c2h5n3o2<l> --> 1hnco<l> + 1co<nh2>2<l>) (arrhenius 1.107e+20 208230000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-6" ((hnco<l> 1. 1. 1) (co<nh2>2<l> 1. 1. 1)) ((biu_c2h5n3o2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1hnco<l> + 1co<nh2>2<l> --> 1biu_c2h5n3o2<l>) (arrhenius 3.517e+08 75450000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-7" ((co<nh2>2<l> 1. 0.3 1)) ((hnco<l> 1. 0. 1) (nh3 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1co<nh2>2<l> --> 1hnco<l> + 1nh3) (arrhenius 2518000. 74000000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.)) 
             ("reaction-8" ((biu_c2h5n3o2<l> 2. 2. 1)) ((hnco<l> 1. 0. 1) (nh3 1. 0. 1) (h2o 1. 0. 1) (ammd_c3h4n4o2<s> 1. 0. 1)) ((o2 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1)) (stoichiometry 2biu_c2h5n3o2<l> --> 1hnco<l> + 1nh3 + 1h2o + 1ammd_c3h4n4o2<s>) (arrhenius 3.637E+23 257760000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-9" ((biu_c2h5n3o2<l> 1. 1. 1) (hnco<l> 1. 1. 1)) ((cya_c3h3n3o3<s> 1. 0. 1) (nh3 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1biu_c2h5n3o2<l> + 1hnco<l> --> 1cya_c3h3n3o3<s> + 1nh3) (arrhenius 9.397E+17 158680000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-10" ((hnco<l> 1. 1. 1) (biu_c2h5n3o2<l> 1. 1. 1)) ((triu_c3h6n4o3<s> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (biu_c2h5n3o2<s> 1. 1) (ammd_c3h4n4o2<s> 0 1)) (stoichiometry 1hnco<l> + 1biu_c2h5n3o2<l> --> 1triu_c3h6n4o3<s>) (arrhenius 1.091E+12 116970000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-11" ((triu_c3h6n4o3<s> 1. 1. 1)) ((nh3 1. 0. 1) (cya_c3h3n3o3<s> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (co<nh2>2<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1triu_c3h6n4o3<s> --> 1nh3 + 1cya_c3h3n3o3<s>) (arrhenius 1.238E+18 194940000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-12" ((co<nh2>2<l> 1. 1. 1) (hnco<l> 2. 2. 1)) ((ammd_c3h4n4o2<s> 1. 0. 1) (h2o 1. 0. 1)) ((o2 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1)) (stoichiometry 1co<nh2>2<l> + 2hnco<l> --> 1ammd_c3h4n4o2<s> + 1h2o) (arrhenius 1.274E+14 110400000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-13" ((biu_c2h5n3o2<l> 1. 1. 1)) ((biu_c2h5n3o2<s> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1biu_c2h5n3o2<l> --> 1biu_c2h5n3o2<s>) (arrhenius 8.193E+26 271500000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-14" ((biu_c2h5n3o2<s> 1. 1. 1)) ((biu_c2h5n3o2<l> 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1biu_c2h5n3o2<s> --> 1biu_c2h5n3o2<l>) (arrhenius 3162000000. 122000000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-15" ((biu_c2h5n3o2<s> 1. 1. 1)) ((hnco 2. 0. 1) (nh3 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (co2 0 1) (ammd_c3h4n4o2 0 1) (n2 0 1) (co<nh2>2<l> 0. 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 1. 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<l> 0 1) (ammd_c3h4n4o2<s> 0 1) (hnco<l> 0 1)) (stoichiometry 1biu_c2h5n3o2<s> --> 2hnco + 1nh3) (arrhenius 5.626E+24 266380000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 0.)) 
             ("reaction-16" ((ammd_c3h4n4o2<s> 1. 1. 1)) ((ammd_c3h4n4o2 1. 0. 1)) ((o2 0 1) (h2o 0 1) (co<nh2>2 0 1) (hnco 0 1) (nh3 0 1) (co2 0 1) (n2 0 1) (co<nh2>2<l> 0 1) (cya_c3h3n3o3<s> 0 1) (co<nh2>2<s> 0 1) (triu_c3h6n4o3<s> 0 1) (biu_c2h5n3o2<s> 0 1) (biu_c2h5n3o2<l> 0 1) (hnco<l> 0 1)) (stoichiometry 1ammd_c3h4n4o2<s> --> 1ammd_c3h4n4o2) (arrhenius 1.0e+14 201670000. 0.) (particle-reaction? . #t) (reaction-model volume-kinetics) (catalyst-species hnco<l>) (diffusion-species o2) (particle-rate 5e-12 1.))
             ("reaction-17" ((co<nh2>2<l> 1 0 1)) ((hnco 1 0 1) (nh3 1 0 1)) ((o2 0 0) (h2o 0 0) (co<nh2>2 1. 0) (co2 0 0) (ammd_c3h4n4o2 0 0) (n2 0 0) (cya_c3h3n3o3<s> 0 0) (co<nh2>2<s> 0 0) (triu_c3h6n4o3<s> 0 0) (biu_c2h5n3o2<s> 0 0) (biu_c2h5n3o2<l> 0 0) (ammd_c3h4n4o2<s> 0 0) (hnco<l> 0 0)) (stoichiometry 1co<nh2>2<l> --> 1hnco + 1nh3) (arrhenius 0.42 69000000. 0) (mixing-rate 4 0.5) (control-temperature 1 0.) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (particle-reaction? . #t) (reaction-model "thermolysis") (diffusion-species o2) (catalyst-species co<nh2>2<l>) (particle-rate 5e-12 1)) 
             ("reaction-18" ((co<nh2>2<s> 1 0 1)) ((hnco 1 0 1) (nh3 1 0 1)) ((o2 0 0) (h2o 0 0) (co<nh2>2 0 0) (co2 0 0) (ammd_c3h4n4o2 0 0) (n2 0 0) (co<nh2>2<l> 0 0) (cya_c3h3n3o3<s> 0 0) (triu_c3h6n4o3<s> 0 0) (biu_c2h5n3o2<s> 0 0) (biu_c2h5n3o2<l> 0 0) (ammd_c3h4n4o2<s> 0 0) (hnco<l> 0 0)) (stoichiometry 1co<nh2>2<s> --> 1hnco + 1nh3) (arrhenius 0.42 69000000. 0) (mixing-rate 4 0.5) (control-temperature 1 0.) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f) (particle-reaction? . #t) (reaction-model "thermolysis") (diffusion-species o2) (catalyst-species hnco<l>) (particle-rate 5e-12 1.)))) 
(chemical-formula . #f) (density (incompressible-ideal-gas . #f)) (specific-heat (mixing-law . #f)) (thermal-conductivity (constant . 0.0454)) (viscosity (constant . 1.72e-05)) (mass-diffusivity (constant-dilute-appx 2.88e-05)))

;; urea properties computed according to the following data that are average values taken from nist webbook
;; enthalpy of fusion 14 kJ/mol
;; enthalpy of sublimation 97.9 kJ/mol

 (urea-solid
  (fluid combusting-particle inert-particle droplet-particle)
  (chemical-formula . co<nh2>2<s>)
  (density (constant . 1335)) ; Perrys Chem Eng Handbook. nist data (1330) (cr66621)
  (specific-heat (constant . 1548.6)) ; nist data
  (boiling-point (constant . 483))
  (latent-heat (constant . 1.63E6)) ; enthalpy of sublimation from nist
  (vaporization-temperature (constant . 420)) ; from Birkhold PhD
 (binary-diffusivity (constant . 2.33e-05)(polynomial piecewise-linear (298 . 2.33e-05 ) (358 . 3.32E-5) )) ; Binary diffusivity for ammonia-nitrogen from Poling book
  (volatile-fraction (constant . 1.0)) ; it could be assumed that gaseous urea can be released as volitiles
  (combustible-fraction (constant . 0.0))
  (swelling-coefficient (constant . 1.0))
  (emissivity (constant . 0.9))
  (scattering-factor (constant . 0.9))
  (burn-stoichiometry (constant . 0.0))
  (burn-hreact (constant . 0.0))
  (burn-hreact-fraction (constant . 0.0))
  (devolatilization-model (constant . 100) (single-rate 28000 69000000)) ; very roughly approximated from birkhold thesis
  (combustion-model (diffusion-limited . #f))
  (thermal-conductivity (constant . 0.5)) ; to yield wt average AdBlue conductivity 0.57 as in BASF datasheet 
  (viscosity (constant . 0.0023)) ; to yield wt average AdBlue viscosity .0014 as in BASF datasheet
  (dpm-surften (constant . 0.0719404)) ; same as water-liquid
  (molecular-weight (constant . 60.05583)) ; nist
  (formation-enthalpy (constant . -333.39e+06)) ;nist
  (formation-entropy (constant .  0.10493e+06)) ;nist
  )

 (urea-liquid
  (fluid inert-particle droplet-particle)
  (chemical-formula . co<nh2>2<l>)
  (density (constant . 1280)) ; to yield wt average AdBlue density 1085 as in BASF datasheet
  (specific-heat (constant . 2375)) ; to yield wt average AdBlue cp 3640 as in BASF datasheet
  (latent-heat (constant . 1.398E6)) ; computed as (enthalpy of sublimation - enthalpy of fusion) from nist 
;  (latent-heat (constant . 2.82E6)) ; as above but this value also contains the decomposition enthalpy to NH3 and HNCO
;  (heat-of-pyrolysis (constant . 1.42E6)) ; must be used to substract the decomposition enthalpy added above
  (vaporization-temperature (constant . 420)) ; from Birkhold PhD
  (boiling-point (constant . 483)) ; from Birkhold PhD
  (binary-diffusivity (film-averaged (averaging-coefficient 0.3333) (film-diffusivity  (polynomial piecewise-linear (298 . 2.33e-05 ) (358 . 3.32E-5) (400 . 3.90E-5) (450 . 4.79E-5) (500 . 5.76E-5)) (constant . 2.33e-05))) (constant . 2.33e-05)(polynomial piecewise-linear (298 . 2.33e-05 ) (358 . 3.32E-5) (400 . 3.90E-5) (450 . 4.79E-5) (500 . 5.76E-5))) ; Binary diffusivity for ammonia-nitrogen from Poling book Table 11-2 extended according to the (T/T0)^1.75 analogy
  (volatile-fraction (constant . 1.0))
  (emissivity (constant . 0.9))
  (scattering-factor (constant . 0.9))
  (thermal-conductivity (constant . 0.5)) ; to yield wt average AdBlue conductivity 0.57 as in BASF datasheet 
  (viscosity (constant . 0.0023)) ; to yield wt average AdBlue viscosity .0014 as in BASF datasheet
  (dpm-surften (constant . 0.0719404)) ; same as water-liquid
  (vapor-pressure (polynomial piecewise-linear (420 . 48) (430 . 188) (440 . 690) (450 . 2390) (460 . 7839) (470 . 24443) (480 . 72692) (482 . 89909) (483 . 101000) (490 . 206780) (510 . 1479530) (520 . 3739209) (639.74 . 7.735E+06) )(constant . 2390) ) ; from Birkhold PhD
  (molecular-weight (constant .  60.05583))
  (formation-enthalpy (constant . -319.39e+06)) ; from nist solid Hform-enthalpy of fusion -333.39e+06 + 14.E6 
  (reference-temperature (constant . 298))
  (thermolysis-model  (none . #f) (single-rate 0.42 6.9e7) (secondary-rate 0.42 6.9e7 0.42 6.9e7) (constant . 10))
 )

(urea-vapor
 fluid
 (chemical-formula . co<nh2>2)
 (density (constant . 2.45422)) ;computed using state eq at 298 K and 1 bar
 (specific-heat (polynomial piecewise-polynomial (300 1000 409.39931 0.40185458 -0.00020235431 -1.7605357e-07 1.4747213e-10) (1000 5000 506.21987 0.089793697 -1.5987382e-05 1.1388407e-10 1.7822804e-13)) (constant . 537))
 (thermal-conductivity (constant . 0.0104)) ;not known yet
 (viscosity (constant . 1.2e-05)) ; not known yet
 (molecular-weight (constant . 60.05583))
 (formation-enthalpy (constant . -2.355e+08)) ;this value is from nist
 (reference-temperature (constant . 298))
 (formation-entropy (constant . 228064.2)) ; not confirmed
; Critical Properties from Cranium Ver. 1.0.3
  (critical-pressure (constant . 7.735E+06))
  (critical-temperature (constant . 639.74))
  (acentric-factor (constant . 0.562))
  (critical-volume (constant . 0.002600))
 )

(urea-water
 (particle-mixture)
 (species (names co<nh2>2<l> h2o<l>))
 )

(water-liquid
 (fluid inert-particle droplet-particle)
 (chemical-formula . h2o<l>)
 (density (constant . 998.2) (compressible-liquid 101325 998.2 2.2e+09 7.15 1.1 0.9))
 (specific-heat (constant . 4182) (polynomial piecewise-linear (280 . 4201) (300 . 4181) (320 . 4181) (340 . 4188) (360 . 4202) (373 . 4216) (380 . 4224) (400 . 4256) (420 . 4299) (440 . 4357)(460 . 4433) (480 . 4533) (500 . 4664) (520 . 4838) (540 . 5077) (560 . 5424) (580 . 5969) ))
 (latent-heat (constant . 2263073))
 (vaporization-temperature (constant . 284))
 (boiling-point (constant . 373))
 (volatile-fraction (constant . 1))
 (binary-diffusivity (film-averaged (averaging-coefficient 0.3333) (film-diffusivity  (polynomial piecewise-linear (273 . 2.20e-05 ) (300 . 2.59E-5) (313 . 2.92E-5) (350 . 3.40E-5) (373 . 3.80E-5) (400 . 4.29E-5) (450 . 5.28E-5) (473 . 5.76E-5)) (constant . 3.05e-05)))(constant . 3.05e-05));; Binary diffusivity from Perry's and Poling books extended according to the (T/T0)^1.75 analogy
 (thermal-conductivity (constant . 0.6))
 (viscosity (constant . 0.001003))
 (dpm-surften (constant . 0.0719404) (polynomial piecewise-polynomial (50 641 6.49503e-02 2.46819e-04 -9.28884e-07 6.01831e-10)))
 (vapor-pressure (polynomial piecewise-linear (273 . 610) (274 . 657) (275 . 706) (280 . 1002) (284 . 1329) (290 . 1937) (295 . 2658) (300 . 3565) (307 . 5316) (310 . 6275) (315 . 7974) (320 . 10612) (325 . 13289) (330 . 17308) (340 . 26579) (350 . 41877) (356 . 53158) (360 . 62498) (370 . 90935) (371 . 94295) (372 . 97757) (373 . 101000) (393 . 202000) (425 . 505000) (453 . 1000000) (486 . 2000000) (507 . 3000000) (537 . 5000000) (584 . 10000000) (615 . 15000000) (639 . 20000000) (647.14 . 22064000))(constant . 2658) ) 
 ;; http://webbook.nist.gov
 (molecular-weight (constant . 18.0152))
 (species-phase (constant . 1))
 (formation-enthalpy (constant . -2.8584122e+08))
 (reference-temperature (constant . 298))
 (lennard-jones-length (constant . 1.0))   ; non physical 
 (lennard-jones-energy (constant . 100.0)) ; non physical
 (formation-entropy (constant . 69902.211))
 )

(water-vapor
 (fluid inert-particle)
 (chemical-formula . h2o)
 (density (constant . 0.5542) (compressible-liquid 101325 0.5542 9.97e+04 1 1.1 0.9))
 (specific-heat (polynomial piecewise-polynomial (300 1000 1563.0767 1.6037546 -0.0029327841 3.2161009e-06 -1.1568268e-09) (1000 5000 1233.2338 1.4105233 -0.00040291411 5.5427718e-08 -2.949824e-12)) (constant . 2014) (polynomial 1609.791 0.740494 -9.129835e-06 -3.813924e-08 4.80227e-12) (polynomial piecewise-linear (300 . 1858) (600 . 2020) (1000 . 2275) (1500 . 2601) (2000 . 2833) (2500 . 2996)) (polynomial nasa-9-piecewise-polynomial (200.000000 1000.000000 -1.822076e+07 2.656404e+05 4.300395e+02 3.333451e+00 -3.388762e-03 2.286868e-06 -6.170259e-10) (1000.000000 6000.000000 4.776638e+08 -1.113517e+06 2.144289e+03 1.057811e+00 -3.155357e-04 4.350536e-08 -2.225641e-12) ))
 (thermal-conductivity (constant . 0.0261) (polynomial -0.007967996 6.881332e-05 4.49046e-08 -9.099937e-12 6.173314e-16))
 (viscosity (constant . 1.34e-05) (polynomial -4.418944e-06 4.687638e-08 -5.389431e-12 3.202856e-16 4.919179e-22) (sutherland 1.703e-05 416.67 861.11) (power-law 1.703e-05 416.67 1.04))
 (molecular-weight (constant . 18.01534))
 (absorption-coefficient (constant . 0.54) (polynomial piecewise-linear (550 . 1.1) (890 . 0.91) (1220 . 0.7) (1550 . 0.54)))
 (formation-enthalpy (constant . -2.418379e+08))
 (reference-temperature (constant . 298.15))
 (lennard-jones-length (constant . 2.605))
 (lennard-jones-energy (constant . 572.4))
 (thermal-accom-coefficient (constant . 0.9137))
 (velocity-accom-coefficient (constant . 0.9137))
 (formation-entropy (constant . 188696.44))
 ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 22.0640e6))
  (critical-temperature (constant . 647.14))
  (acentric-factor (constant . 0.344))
  (critical-volume (constant . 0.003106))   
 )

(wood
 (solid combusting-particle inert-particle)
 (chemical-formula . #f)
 (density (constant . 700))
 (specific-heat (constant . 2310))
 (latent-heat (constant . 0))
 (vaporization-temperature (constant . 400))
 (boiling-point (constant . 400))
 (binary-diffusivity (constant . 4e-05))
 (volatile-fraction (constant . 0.8))
 (combustible-fraction (constant . 0.2))
 (swelling-coefficient (constant . 1))
 (emissivity (constant . 0.9))
 (scattering-factor (constant . 0.9))
 (burn-stoichiometry (constant . 2.67))
 (burn-hreact (constant . 32789000))
 (burn-hreact-fraction (constant . 0.3))
 (thermal-conductivity (constant . 0.173))
 (devolatilization-model (constant . 20) (single-rate 312000 74000000) (two-competing-rates 200000 1.046e+08 0.3 13000000 1.674e+08 1)(cpd-model 1 0 5 400 50))
 (combustion-model (diffusion-limited . #f) (kinetics/diffusion-limited 5e-12 0.002 79000000) (intrinsic-model 5e-12 0.030198 1.794e+08 0.5 6e-08 300000 1.4142136 0) (cbk -1.0 10.0))
 (struct-youngs-modulus (constant . 1.1e+10))
 (struct-poisson-ratio (constant . 0.4))
 )
 
(wood-volatiles
 fluid
 (chemical-formula . wood_vol)
 (specific-heat (constant . 1500))
 (molecular-weight (constant . 31.626))
 (formation-enthalpy (constant . -2.548e+08))
 (reference-temperature (constant . 298.15))
 ; Critical Properties estimated by assuming that wood volatiles comprise solely CH2O.
  (critical-pressure (constant . 7.027E+06))
  (critical-temperature (constant . 340.98))
  (acentric-factor (constant . 0.218))
  (critical-volume (constant . 0.003197))
 )
 
(gasoline-vapor 
 fluid
 (chemical-formula . c8h18<iso>) 
 (specific-heat (polynomial piecewise-polynomial (200 1000 59.373746 5.3325763 0.0012977682 -5.0483178e-06 2.3409914e-09) (1000 6000 1163.8328 4.0263761 -0.0014212586 2.2692963e-07 -1.3488045e-11)))
 (molecular-weight (constant . 114.23092)) 
 (formation-enthalpy (constant . -2.2400542e+08))
 (reference-temperature (constant . 298.15)) 
 (formation-entropy (constant . 423081.79)) 
 (thermal-conductivity (constant . 0.0454)) 
 (viscosity (constant . 1.72e-05)) 
  ; Critical Properties from Polling et al.  
  (critical-pressure (constant . 2.5700e6))
  (critical-temperature (constant . 543.90))
  (acentric-factor (constant . 0.304))
  (critical-volume (constant . 0.004112))
 )

(wood-volatiles-air
 mixture
 (chemical-formula . #f)
 (species (names wood_vol o2 co2 h2o n2))
 (reactions (finite-rate ("reaction-1" ((wood_vol 1 0.2 1) (o2 1.058 1.3 1)) ((co2 1 0 1) (h2o 1.191 0 1)) ((n2 0 1)) (stoichiometry "1wood_vol + 1.058o2 --> 1co2 + 1.191h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (finite-rate/eddy-dissipation ("reaction-1" ((wood_vol 1 0.2 1) (o2 1.058 1.3 1)) ((co2 1 0 1) (h2o 1.191 0 1)) ((n2 0 1)) (stoichiometry "1wood_vol + 1.058o2 --> 1co2 + 1.191h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))) (eddy-dissipation ("reaction-1" ((wood_vol 1 0.2 0) (o2 1.058 1.3 1)) ((co2 1 0 1) (h2o 1.191 0 1)) ((n2 0 1)) (stoichiometry "1wood_vol + 1.058o2 --> 1co2 + 1.191h2o") (arrhenius 2.119e+11 2.027e+08 0) (mixing-rate 4 0.5) (specified-rate-exponents? . #t) (use-third-body-efficiencies? . #f))))
 )

(ammelide-solid
 (fluid inert-particle droplet-particle)
 (chemical-formula . ammd_c3h4n4o2<s>)
 (density (constant . 1573)); www.chemsrc.com
 (boiling-point (constant . 968)) ; www.chemspider.com
 (molecular-weight (constant .  128.0895));nist
 (specific-heat (constant . 1080)(polynomial 16.35750944 4.684574078 -0.004438572 2.41201E-06 -5.70049E-10)) ; THERMO.DB
 (latent-heat (constant . 8.2E5)); Enthalpy vaporization reported 105.6±3.0 kJ/mol from www.chemspider.com
 (thermal-conductivity (constant . 0.5)) ; same as urea-solid and urea-liquid
 (viscosity (constant . 0.0023)) ; same as urea-solid and urea-liquid
 (dpm-surften (constant . 0.0719404)) ; same as water-liquid
 (formation-enthalpy (constant . -492.9e+06)) ;nist
 (formation-entropy (constant . 149.2E+03)); THERMO.DB
 (reference-temperature (constant . 298.15))
)

(biuret-liquid
 (fluid inert-particle droplet-particle)
 (chemical-formula . biu_c2h5n3o2<l>)
 (molecular-weight (constant . 103.08));nist
 (density (constant . 1700))
 (specific-heat (constant . 2560) (polynomial 6578.213038 -32.45789678 0.063639891)) ; THERMO.DB
 (thermal-conductivity (constant . 0.5)) ; same as urea-solid and urea-liquid
 (viscosity (constant . 0.0023)) ; same as urea-solid and urea-liquid
 (dpm-surften (constant . 0.0719404)) ; same as water-liquid
 (formation-enthalpy (constant . -537.0E+06)) ;nist
 (formation-entropy (constant . 203.37e+03 )) ;nist
 (reference-temperature (constant . 298.15))
)

(biuret-solid
 (fluid inert-particle droplet-particle)
 (chemical-formula . biu_c2h5n3o2<s>)
 (molecular-weight (constant . 103.08));nist
 (density (constant . 1400)) ;www.chemsrc.com
 (specific-heat (constant . 1270)) ;nist
 (thermal-conductivity (constant . 0.5)) ; same as urea-solid and urea-liquid
 (viscosity (constant . 0.0023)) ; same as urea-solid and urea-liquid
 (dpm-surften (constant . 0.0719404)) ; same as water-liquid
 (formation-enthalpy (constant . -563.7e+06)) ;nist
 (formation-entropy (constant . 146.1e+03)) ;nist
 (reference-temperature (constant . 298.15))
)

(cyanuric-acid-solid
 (fluid inert-particle droplet-particle)
 (chemical-formula . cya_c3h3n3o3<s>)
 (molecular-weight (constant . 129.0742));nist
 (density (constant . 2000)) ;www.chemsrc.com 
 (specific-heat (constant . 1007 )(polynomial 159.8305471 2.911503616)) ;nist
 (thermal-conductivity (constant . 0.5)) ; same as urea-solid and urea-liquid
 (viscosity (constant . 0.0023)) ; same as urea-solid and urea-liquid
 (dpm-surften (constant . 0.0719404)) ; same as water-liquid
 (formation-enthalpy (constant . -703.5e+06)) ;nist
 (formation-entropy (constant . 142.2e+03)) ;nist
 (reference-temperature (constant . 298.15))
)

(isocyanic-acid-liquid
 (fluid inert-particle droplet-particle)
 (chemical-formula . hnco<l>)
 (specific-heat  (constant . 2790) (polynomial 4567.549099 -17.31179547 0.038117374 )) ; THERMO.DB
 (density (constant . 1320)) ; THERMO.DB
 (molecular-weight (constant . 43.02522))
 (boiling-point (constant . 296.6))
 (vapor-pressure  (polynomial piecewise-linear (273.15 . 35900.) (323.15 . 268000.) (373.15 . 1120000.) (423.15 . 3240000.) (473.15 . 7390000.) (523.15 . 14300000.) (573.15 . 24400000.) (623.15 . 38100000.) (673.15 . 55600000.) (723.15 . 76800000.) (773.15 . 102000000.) (823.15 . 130000000.) (873.15 . 161000000.)) (constant . 101330)) ; from the Brack et al. reference listed above urea-water-deposits particle-mixture material
 (latent-heat (constant . 8.37E5))
 (binary-diffusivity (constant . 2.33e-05)) ; same as urea-liquid
 (thermal-conductivity (constant . 0.5)) ; same as urea-liquid 
 (viscosity (constant . 0.0023)) ; same as urea-liquid
 (dpm-surften (constant . 0.0719404)) ; same as water-liquid
 (formation-enthalpy (constant . -148.e+06)) ; THERMO.DB
 (formation-entropy (constant . 203.37e+03)) ; THERMO.DB
 (reference-temperature (constant . 298.15))
 )

(triuret-solid
 (fluid inert-particle droplet-particle)
 (chemical-formula . triu_c3h6n4o3<s>)
 (molecular-weight (constant . 146.105));nist
 (density (constant . 1547)) ;www.chemsrc.com
 (specific-heat (constant . 899)) ;nist
 (thermal-conductivity (constant . 0.5)) ; same as urea-solid and urea-liquid
 (viscosity (constant . 0.0023)) ; same as urea-solid and urea-liquid
 (dpm-surften (constant . 0.0719404)) ; same as water-liquid
 (formation-enthalpy (constant . -708.9e+06)) ;THERMO.DB
 (formation-entropy (constant . 335.9e+03)) ;THERMO.DB
 (reference-temperature (constant . 298.15))
)

)

