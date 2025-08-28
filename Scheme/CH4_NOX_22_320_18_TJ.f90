!--------------------------------------------------------------------------------------------------
!     Copyright (c) CERFACS (all rights reserved)
!--------------------------------------------------------------------------------------------------
!     FILE CH4_NOX_22_320_18_TJ.f90
!>    @file    CH4_NOX_22_320_18_TJ.f90
!!    @details File that contains the subroutine and module used to calculate the source terms for
!!             CH4_NOX_22_320_18_TJ analytical mechanism. Derived from GRI 2.11.
!!    @authors T. Jaravel
!!    @date    15-07-2015
!!    @since   V7.0.1
!--------------------------------------------------------------------------------------------------

!--------------------------------------------------------------------------------------------------
!     MODULE mod_CH4_NOX_22_320_18_TJ
!>    @details Module generated from YARC Fortran routine generator to compute the chemical source terms.
!!    @authors T. Jaravel
!!    @date    15-07-2015
!--------------------------------------------------------------------------------------------------
MODULE mod_CH4_NOX_22_320_18_TJ

  USE mod_param_defs

  IMPLICIT NONE

  INTEGER, PARAMETER :: nspec = 22                                      !< Number of species (transported)
  INTEGER, PARAMETER :: nreac = 320                                     !< Number of reactions
  INTEGER, PARAMETER :: isc_T = 1
  INTEGER, PARAMETER :: neq = nspec + 1

  INTEGER, PARAMETER :: nqss = 18                                       !< Number of QSS species
  INTEGER, DIMENSION(nspec + nqss) :: iqss

  REAL(pr), DIMENSION(nspec + nqss) :: W_sp,Cp_sp,h_sp,dh_sp
  CHARACTER(LEN=15), DIMENSION(nspec + nqss) :: gname
  CHARACTER(LEN=5), DIMENSION(nreac) :: rname

! Post processing variables
! Number of groups
  INTEGER, PARAMETER :: ng = 41
! Max number of species in groups
  INTEGER, PARAMETER :: maxppn = 1
! Number of species in each group
  INTEGER, DIMENSION(ng) :: ppn
! Species in each group
  INTEGER, DIMENSION(ng,maxppn) :: pp
! Name of species in each group
  CHARACTER(LEN=30), DIMENSION(ng) :: ppname
! Actual expression of each reaction
  CHARACTER(LEN=65), DIMENSION(nreac) :: reacexp
! Link between backward and forward rates
  INTEGER, DIMENSION(nreac) :: fofb

! Index of species
  INTEGER, PARAMETER :: sN2 = 1
  INTEGER, PARAMETER :: sH = 2
  INTEGER, PARAMETER :: sH2 = 3
  INTEGER, PARAMETER :: sO = 4
  INTEGER, PARAMETER :: sO2 = 5
  INTEGER, PARAMETER :: sOH = 6
  INTEGER, PARAMETER :: sH2O = 7
  INTEGER, PARAMETER :: sH2O2 = 8
  INTEGER, PARAMETER :: sHO2 = 9
  INTEGER, PARAMETER :: sCO = 10
  INTEGER, PARAMETER :: sCH2O = 11
  INTEGER, PARAMETER :: sCH3 = 12
  INTEGER, PARAMETER :: sCH3OH = 13
  INTEGER, PARAMETER :: sC2H2 = 14
  INTEGER, PARAMETER :: sCH4 = 15
  INTEGER, PARAMETER :: sC2H6 = 16
  INTEGER, PARAMETER :: sC2H4 = 17
  INTEGER, PARAMETER :: sCO2 = 18
  INTEGER, PARAMETER :: sNO = 19
  INTEGER, PARAMETER :: sHCN = 20
  INTEGER, PARAMETER :: sNO2 = 21
  INTEGER, PARAMETER :: sN2O = 22
  INTEGER, PARAMETER :: sC = 23
  INTEGER, PARAMETER :: sCH = 24
  INTEGER, PARAMETER :: sCH2 = 25
  INTEGER, PARAMETER :: sHCO = 26
  INTEGER, PARAMETER :: s1XCH2 = 27
  INTEGER, PARAMETER :: sCH3O = 28
  INTEGER, PARAMETER :: sC2H5 = 29
  INTEGER, PARAMETER :: sC2H3 = 30
  INTEGER, PARAMETER :: sHCCO = 31
  INTEGER, PARAMETER :: sN = 32
  INTEGER, PARAMETER :: sNH = 33
  INTEGER, PARAMETER :: sHNO = 34
  INTEGER, PARAMETER :: sNH2 = 35
  INTEGER, PARAMETER :: sNCO = 36
  INTEGER, PARAMETER :: sHCNO = 37
  INTEGER, PARAMETER :: sHNCO = 38
  INTEGER, PARAMETER :: sHOCN = 39
  INTEGER, PARAMETER :: sNNH = 40

! Index of reactions
  INTEGER, PARAMETER :: r1 = 1
  INTEGER, PARAMETER :: r2 = 2
  INTEGER, PARAMETER :: r3 = 3
  INTEGER, PARAMETER :: r4f = 4
  INTEGER, PARAMETER :: r5f = 5
  INTEGER, PARAMETER :: r6f = 6
  INTEGER, PARAMETER :: r7f = 7
  INTEGER, PARAMETER :: r8f = 8
  INTEGER, PARAMETER :: r9 = 9
  INTEGER, PARAMETER :: r10f = 10
  INTEGER, PARAMETER :: r11f = 11
  INTEGER, PARAMETER :: r12f = 12
  INTEGER, PARAMETER :: r13f = 13
  INTEGER, PARAMETER :: r14f = 14
  INTEGER, PARAMETER :: r15 = 15
  INTEGER, PARAMETER :: r16f = 16
  INTEGER, PARAMETER :: r17 = 17
  INTEGER, PARAMETER :: r18 = 18
  INTEGER, PARAMETER :: r19f = 19
  INTEGER, PARAMETER :: r20f = 20
  INTEGER, PARAMETER :: r21f = 21
  INTEGER, PARAMETER :: r22 = 22
  INTEGER, PARAMETER :: r23 = 23
  INTEGER, PARAMETER :: r24f = 24
  INTEGER, PARAMETER :: r25 = 25
  INTEGER, PARAMETER :: r26 = 26
  INTEGER, PARAMETER :: r27 = 27
  INTEGER, PARAMETER :: r28f = 28
  INTEGER, PARAMETER :: r29 = 29
  INTEGER, PARAMETER :: r30f = 30
  INTEGER, PARAMETER :: r31 = 31
  INTEGER, PARAMETER :: r32 = 32
  INTEGER, PARAMETER :: r33 = 33
  INTEGER, PARAMETER :: r36 = 34
  INTEGER, PARAMETER :: r37 = 35
  INTEGER, PARAMETER :: r38 = 36
  INTEGER, PARAMETER :: r39f = 37
  INTEGER, PARAMETER :: r40f = 38
  INTEGER, PARAMETER :: r41 = 39
  INTEGER, PARAMETER :: r42 = 40
  INTEGER, PARAMETER :: r43f = 41
  INTEGER, PARAMETER :: r44 = 42
  INTEGER, PARAMETER :: r45 = 43
  INTEGER, PARAMETER :: r46f = 44
  INTEGER, PARAMETER :: r47 = 45
  INTEGER, PARAMETER :: r48 = 46
  INTEGER, PARAMETER :: r49f = 47
  INTEGER, PARAMETER :: r50 = 48
  INTEGER, PARAMETER :: r51f = 49
  INTEGER, PARAMETER :: r52 = 50
  INTEGER, PARAMETER :: r53 = 51
  INTEGER, PARAMETER :: r54f = 52
  INTEGER, PARAMETER :: r55f = 53
  INTEGER, PARAMETER :: r56f = 54
  INTEGER, PARAMETER :: r57 = 55
  INTEGER, PARAMETER :: r58f = 56
  INTEGER, PARAMETER :: r59 = 57
  INTEGER, PARAMETER :: r60f = 58
  INTEGER, PARAMETER :: r61f = 59
  INTEGER, PARAMETER :: r62 = 60
  INTEGER, PARAMETER :: r63f = 61
  INTEGER, PARAMETER :: r64 = 62
  INTEGER, PARAMETER :: r65 = 63
  INTEGER, PARAMETER :: r66f = 64
  INTEGER, PARAMETER :: r67 = 65
  INTEGER, PARAMETER :: r68 = 66
  INTEGER, PARAMETER :: r69f = 67
  INTEGER, PARAMETER :: r70f = 68
  INTEGER, PARAMETER :: r71f = 69
  INTEGER, PARAMETER :: r72f = 70
  INTEGER, PARAMETER :: r73f = 71
  INTEGER, PARAMETER :: r74 = 72
  INTEGER, PARAMETER :: r75f = 73
  INTEGER, PARAMETER :: r76f = 74
  INTEGER, PARAMETER :: r77f = 75
  INTEGER, PARAMETER :: r78 = 76
  INTEGER, PARAMETER :: r79f = 77
  INTEGER, PARAMETER :: r80 = 78
  INTEGER, PARAMETER :: r81 = 79
  INTEGER, PARAMETER :: r82 = 80
  INTEGER, PARAMETER :: r83f = 81
  INTEGER, PARAMETER :: r84 = 82
  INTEGER, PARAMETER :: r85f = 83
  INTEGER, PARAMETER :: r86 = 84
  INTEGER, PARAMETER :: r87 = 85
  INTEGER, PARAMETER :: r88 = 86
  INTEGER, PARAMETER :: r89 = 87
  INTEGER, PARAMETER :: r90f = 88
  INTEGER, PARAMETER :: r91f = 89
  INTEGER, PARAMETER :: r92 = 90
  INTEGER, PARAMETER :: r93f = 91
  INTEGER, PARAMETER :: r94 = 92
  INTEGER, PARAMETER :: r95 = 93
  INTEGER, PARAMETER :: r96 = 94
  INTEGER, PARAMETER :: r97 = 95
  INTEGER, PARAMETER :: r98 = 96
  INTEGER, PARAMETER :: r99 = 97
  INTEGER, PARAMETER :: r100f = 98
  INTEGER, PARAMETER :: r101 = 99
  INTEGER, PARAMETER :: r102f = 100
  INTEGER, PARAMETER :: r103 = 101
  INTEGER, PARAMETER :: r104 = 102
  INTEGER, PARAMETER :: r105f = 103
  INTEGER, PARAMETER :: r106f = 104
  INTEGER, PARAMETER :: r107f = 105
  INTEGER, PARAMETER :: r108f = 106
  INTEGER, PARAMETER :: r109 = 107
  INTEGER, PARAMETER :: r110 = 108
  INTEGER, PARAMETER :: r111 = 109
  INTEGER, PARAMETER :: r112f = 110
  INTEGER, PARAMETER :: r113f = 111
  INTEGER, PARAMETER :: r114 = 112
  INTEGER, PARAMETER :: r115 = 113
  INTEGER, PARAMETER :: r116 = 114
  INTEGER, PARAMETER :: r117 = 115
  INTEGER, PARAMETER :: r118 = 116
  INTEGER, PARAMETER :: r119f = 117
  INTEGER, PARAMETER :: r120f = 118
  INTEGER, PARAMETER :: r121f = 119
  INTEGER, PARAMETER :: r122 = 120
  INTEGER, PARAMETER :: r123 = 121
  INTEGER, PARAMETER :: r124f = 122
  INTEGER, PARAMETER :: r125f = 123
  INTEGER, PARAMETER :: r126 = 124
  INTEGER, PARAMETER :: r127 = 125
  INTEGER, PARAMETER :: r128 = 126
  INTEGER, PARAMETER :: r129f = 127
  INTEGER, PARAMETER :: r130 = 128
  INTEGER, PARAMETER :: r131f = 129
  INTEGER, PARAMETER :: r132f = 130
  INTEGER, PARAMETER :: r133 = 131
  INTEGER, PARAMETER :: r134f = 132
  INTEGER, PARAMETER :: r135 = 133
  INTEGER, PARAMETER :: r138 = 134
  INTEGER, PARAMETER :: rnog139f = 135
  INTEGER, PARAMETER :: rnog140f = 136
  INTEGER, PARAMETER :: rnog141 = 137
  INTEGER, PARAMETER :: rnog142f = 138
  INTEGER, PARAMETER :: rnog143f = 139
  INTEGER, PARAMETER :: rnog144f = 140
  INTEGER, PARAMETER :: rnog145f = 141
  INTEGER, PARAMETER :: rnog146f = 142
  INTEGER, PARAMETER :: rnog147f = 143
  INTEGER, PARAMETER :: rnog148 = 144
  INTEGER, PARAMETER :: rnog149f = 145
  INTEGER, PARAMETER :: rnog150f = 146
  INTEGER, PARAMETER :: rnog151f = 147
  INTEGER, PARAMETER :: rnog152f = 148
  INTEGER, PARAMETER :: rnog153 = 149
  INTEGER, PARAMETER :: rnog154 = 150
  INTEGER, PARAMETER :: rnog155f = 151
  INTEGER, PARAMETER :: rnog156 = 152
  INTEGER, PARAMETER :: rnog157f = 153
  INTEGER, PARAMETER :: rnog158f = 154
  INTEGER, PARAMETER :: rnog159 = 155
  INTEGER, PARAMETER :: rnog160 = 156
  INTEGER, PARAMETER :: rnog161f = 157
  INTEGER, PARAMETER :: rnog162f = 158
  INTEGER, PARAMETER :: rnog163f = 159
  INTEGER, PARAMETER :: rnog164f = 160
  INTEGER, PARAMETER :: rnog165 = 161
  INTEGER, PARAMETER :: rnog166 = 162
  INTEGER, PARAMETER :: rnog167f = 163
  INTEGER, PARAMETER :: rnog168 = 164
  INTEGER, PARAMETER :: rnog169 = 165
  INTEGER, PARAMETER :: rnog170f = 166
  INTEGER, PARAMETER :: rnog171f = 167
  INTEGER, PARAMETER :: rnog172f = 168
  INTEGER, PARAMETER :: rnog173f = 169
  INTEGER, PARAMETER :: rnog174f = 170
  INTEGER, PARAMETER :: rnog175f = 171
  INTEGER, PARAMETER :: rnog176f = 172
  INTEGER, PARAMETER :: rnog177 = 173
  INTEGER, PARAMETER :: rnog178f = 174
  INTEGER, PARAMETER :: rnog179 = 175
  INTEGER, PARAMETER :: rnog180f = 176
  INTEGER, PARAMETER :: rnog181 = 177
  INTEGER, PARAMETER :: rnog182 = 178
  INTEGER, PARAMETER :: rnog183f = 179
  INTEGER, PARAMETER :: rnog184 = 180
  INTEGER, PARAMETER :: rnog185 = 181
  INTEGER, PARAMETER :: rnog186f = 182
  INTEGER, PARAMETER :: rnog187 = 183
  INTEGER, PARAMETER :: rnog188 = 184
  INTEGER, PARAMETER :: rnog189f = 185
  INTEGER, PARAMETER :: rnog190 = 186
  INTEGER, PARAMETER :: rnog191f = 187
  INTEGER, PARAMETER :: rnog192f = 188
  INTEGER, PARAMETER :: rnog193f = 189
  INTEGER, PARAMETER :: rnog194f = 190
  INTEGER, PARAMETER :: rnog195f = 191
  INTEGER, PARAMETER :: rnog196 = 192
  INTEGER, PARAMETER :: rnog197 = 193
  INTEGER, PARAMETER :: rnog198 = 194
  INTEGER, PARAMETER :: rnog199 = 195
  INTEGER, PARAMETER :: rnog200 = 196
  INTEGER, PARAMETER :: r201f = 197
  INTEGER, PARAMETER :: r202f = 198
  INTEGER, PARAMETER :: rnog203f = 199
  INTEGER, PARAMETER :: rnog204f = 200
  INTEGER, PARAMETER :: rnog205 = 201
  INTEGER, PARAMETER :: rnog206 = 202
  INTEGER, PARAMETER :: rnog207f = 203
  INTEGER, PARAMETER :: rnog208f = 204
  INTEGER, PARAMETER :: rnog209f = 205
  INTEGER, PARAMETER :: rnog210f = 206
  INTEGER, PARAMETER :: rnog211f = 207
  INTEGER, PARAMETER :: rnog212f = 208
  INTEGER, PARAMETER :: rnog213 = 209
  INTEGER, PARAMETER :: rnog214f = 210
  INTEGER, PARAMETER :: r4b = 211
  INTEGER, PARAMETER :: r5b = 212
  INTEGER, PARAMETER :: r6b = 213
  INTEGER, PARAMETER :: r7b = 214
  INTEGER, PARAMETER :: r8b = 215
  INTEGER, PARAMETER :: r10b = 216
  INTEGER, PARAMETER :: r11b = 217
  INTEGER, PARAMETER :: r12b = 218
  INTEGER, PARAMETER :: r13b = 219
  INTEGER, PARAMETER :: r14b = 220
  INTEGER, PARAMETER :: r16b = 221
  INTEGER, PARAMETER :: r19b = 222
  INTEGER, PARAMETER :: r20b = 223
  INTEGER, PARAMETER :: r21b = 224
  INTEGER, PARAMETER :: r24b = 225
  INTEGER, PARAMETER :: r28b = 226
  INTEGER, PARAMETER :: r30b = 227
  INTEGER, PARAMETER :: r39b = 228
  INTEGER, PARAMETER :: r40b = 229
  INTEGER, PARAMETER :: r43b = 230
  INTEGER, PARAMETER :: r46b = 231
  INTEGER, PARAMETER :: r49b = 232
  INTEGER, PARAMETER :: r51b = 233
  INTEGER, PARAMETER :: r54b = 234
  INTEGER, PARAMETER :: r55b = 235
  INTEGER, PARAMETER :: r56b = 236
  INTEGER, PARAMETER :: r58b = 237
  INTEGER, PARAMETER :: r60b = 238
  INTEGER, PARAMETER :: r61b = 239
  INTEGER, PARAMETER :: r63b = 240
  INTEGER, PARAMETER :: r66b = 241
  INTEGER, PARAMETER :: r69b = 242
  INTEGER, PARAMETER :: r70b = 243
  INTEGER, PARAMETER :: r71b = 244
  INTEGER, PARAMETER :: r72b = 245
  INTEGER, PARAMETER :: r73b = 246
  INTEGER, PARAMETER :: r75b = 247
  INTEGER, PARAMETER :: r76b = 248
  INTEGER, PARAMETER :: r77b = 249
  INTEGER, PARAMETER :: r79b = 250
  INTEGER, PARAMETER :: r83b = 251
  INTEGER, PARAMETER :: r85b = 252
  INTEGER, PARAMETER :: r90b = 253
  INTEGER, PARAMETER :: r91b = 254
  INTEGER, PARAMETER :: r93b = 255
  INTEGER, PARAMETER :: r100b = 256
  INTEGER, PARAMETER :: r102b = 257
  INTEGER, PARAMETER :: r105b = 258
  INTEGER, PARAMETER :: r106b = 259
  INTEGER, PARAMETER :: r107b = 260
  INTEGER, PARAMETER :: r108b = 261
  INTEGER, PARAMETER :: r112b = 262
  INTEGER, PARAMETER :: r113b = 263
  INTEGER, PARAMETER :: r119b = 264
  INTEGER, PARAMETER :: r120b = 265
  INTEGER, PARAMETER :: r121b = 266
  INTEGER, PARAMETER :: r124b = 267
  INTEGER, PARAMETER :: r125b = 268
  INTEGER, PARAMETER :: r129b = 269
  INTEGER, PARAMETER :: r131b = 270
  INTEGER, PARAMETER :: r132b = 271
  INTEGER, PARAMETER :: r134b = 272
  INTEGER, PARAMETER :: rnog139b = 273
  INTEGER, PARAMETER :: rnog140b = 274
  INTEGER, PARAMETER :: rnog142b = 275
  INTEGER, PARAMETER :: rnog143b = 276
  INTEGER, PARAMETER :: rnog144b = 277
  INTEGER, PARAMETER :: rnog145b = 278
  INTEGER, PARAMETER :: rnog146b = 279
  INTEGER, PARAMETER :: rnog147b = 280
  INTEGER, PARAMETER :: rnog149b = 281
  INTEGER, PARAMETER :: rnog150b = 282
  INTEGER, PARAMETER :: rnog151b = 283
  INTEGER, PARAMETER :: rnog152b = 284
  INTEGER, PARAMETER :: rnog155b = 285
  INTEGER, PARAMETER :: rnog157b = 286
  INTEGER, PARAMETER :: rnog158b = 287
  INTEGER, PARAMETER :: rnog161b = 288
  INTEGER, PARAMETER :: rnog162b = 289
  INTEGER, PARAMETER :: rnog163b = 290
  INTEGER, PARAMETER :: rnog164b = 291
  INTEGER, PARAMETER :: rnog167b = 292
  INTEGER, PARAMETER :: rnog170b = 293
  INTEGER, PARAMETER :: rnog171b = 294
  INTEGER, PARAMETER :: rnog172b = 295
  INTEGER, PARAMETER :: rnog173b = 296
  INTEGER, PARAMETER :: rnog174b = 297
  INTEGER, PARAMETER :: rnog175b = 298
  INTEGER, PARAMETER :: rnog176b = 299
  INTEGER, PARAMETER :: rnog178b = 300
  INTEGER, PARAMETER :: rnog180b = 301
  INTEGER, PARAMETER :: rnog183b = 302
  INTEGER, PARAMETER :: rnog186b = 303
  INTEGER, PARAMETER :: rnog189b = 304
  INTEGER, PARAMETER :: rnog191b = 305
  INTEGER, PARAMETER :: rnog192b = 306
  INTEGER, PARAMETER :: rnog193b = 307
  INTEGER, PARAMETER :: rnog194b = 308
  INTEGER, PARAMETER :: rnog195b = 309
  INTEGER, PARAMETER :: r201b = 310
  INTEGER, PARAMETER :: r202b = 311
  INTEGER, PARAMETER :: rnog203b = 312
  INTEGER, PARAMETER :: rnog204b = 313
  INTEGER, PARAMETER :: rnog207b = 314
  INTEGER, PARAMETER :: rnog208b = 315
  INTEGER, PARAMETER :: rnog209b = 316
  INTEGER, PARAMETER :: rnog210b = 317
  INTEGER, PARAMETER :: rnog211b = 318
  INTEGER, PARAMETER :: rnog212b = 319
  INTEGER, PARAMETER :: rnog214b = 320

! Index of third bodies
  INTEGER, PARAMETER :: mM26 = 1
  INTEGER, PARAMETER :: mM37 = 2
  INTEGER, PARAMETER :: mM5 = 3
  INTEGER, PARAMETER :: mM24 = 4
  INTEGER, PARAMETER :: mM17 = 5
  INTEGER, PARAMETER :: mM4 = 6
  INTEGER, PARAMETER :: mM29 = 7
  INTEGER, PARAMETER :: mM36 = 8
  INTEGER, PARAMETER :: mM31 = 9
  INTEGER, PARAMETER :: mM18 = 10
  INTEGER, PARAMETER :: mM19 = 11
  INTEGER, PARAMETER :: mM8 = 12
  INTEGER, PARAMETER :: mM1 = 13
  INTEGER, PARAMETER :: mM6 = 14
  INTEGER, PARAMETER :: mM38 = 15
  INTEGER, PARAMETER :: mM3 = 16
  INTEGER, PARAMETER :: mM16 = 17
  INTEGER, PARAMETER :: mM22 = 18
  INTEGER, PARAMETER :: mM32 = 19
  INTEGER, PARAMETER :: mM15 = 20
  INTEGER, PARAMETER :: mM11 = 21
  INTEGER, PARAMETER :: mM7 = 22
  INTEGER, PARAMETER :: mM25 = 23
  INTEGER, PARAMETER :: mM30 = 24
  INTEGER, PARAMETER :: mM27 = 25
  INTEGER, PARAMETER :: mM13 = 26
  INTEGER, PARAMETER :: mM20 = 27
  INTEGER, PARAMETER :: mM28 = 28
  INTEGER, PARAMETER :: mM9 = 29
  INTEGER, PARAMETER :: mM21 = 30

  CONTAINS


!--------------------------------------------------------------------------------------------------
!     SUBROUTINE INTERNALAVBP
!>    @details Subroutine for calculating the species production rates.
!!    @authors T. Jaravel
!!    @date    15-07-2015
!!    @param [in]    P        Pressure
!!    @param [in]    T        Temperature
!!    @param [in]    C        Activity Concentration
!!    @param [out]   WDOT     Species Productions rates [mol/m3/s]
!--------------------------------------------------------------------------------------------------
  SUBROUTINE INTERNALAVBP ( P, T, C, WDOT )

    IMPLICIT NONE

    REAL(pr), DIMENSION(nspec) :: c,WDOT
    REAL(pr), DIMENSION(nqss) :: cqss
    REAL(pr), DIMENSION(nreac) :: w,k
    REAL(pr), DIMENSION(31) :: m

    REAL(pr) :: T,P


    CALL get_thirdbodies ( M,c )
    CALL get_rate_coefficients ( k,M,T,P )
    CALL get_QSS ( cqss,c,k,M )
    CALL get_reaction_rates ( w,k,M,c,cqss )
    CALL get_production_rates ( WDOT,w )


  END SUBROUTINE INTERNALAVBP


! Subroutine to define groups for post-processing (postproc)
  SUBROUTINE pp_data

    IMPLICIT NONE

!   Number of species in each group
    ppn(1) = 1
    ppn(2) = 1
    ppn(3) = 1
    ppn(4) = 1
    ppn(5) = 1
    ppn(6) = 1
    ppn(7) = 1
    ppn(8) = 1
    ppn(9) = 1
    ppn(10) = 1
    ppn(11) = 1
    ppn(12) = 1
    ppn(13) = 1
    ppn(14) = 1
    ppn(15) = 1
    ppn(16) = 1
    ppn(17) = 1
    ppn(18) = 1
    ppn(19) = 1
    ppn(20) = 1
    ppn(21) = 1
    ppn(22) = 1
    ppn(23) = 1
    ppn(24) = 1
    ppn(25) = 1
    ppn(26) = 1
    ppn(27) = 1
    ppn(28) = 1
    ppn(29) = 1
    ppn(30) = 1
    ppn(31) = 1
    ppn(32) = 1
    ppn(33) = 1
    ppn(34) = 1
    ppn(35) = 1
    ppn(36) = 1
    ppn(37) = 1
    ppn(38) = 1
    ppn(39) = 1
    ppn(40) = 1
    ppn(41) = 1

!   Indices of species in each group
    pp(1,1) = 1
    pp(2,1) = 2
    pp(3,1) = 3
    pp(4,1) = 4
    pp(5,1) = 5
    pp(6,1) = 6
    pp(7,1) = 7
    pp(8,1) = 8
    pp(9,1) = 9
    pp(10,1) = 10
    pp(11,1) = 11
    pp(12,1) = 12
    pp(13,1) = 13
    pp(14,1) = 14
    pp(15,1) = 15
    pp(16,1) = 16
    pp(17,1) = 17
    pp(18,1) = 18
    pp(19,1) = 19
    pp(20,1) = 20
    pp(21,1) = 21
    pp(22,1) = 22
    pp(23,1) = 23
    pp(24,1) = 24
    pp(25,1) = 25
    pp(26,1) = 26
    pp(27,1) = 27
    pp(28,1) = 28
    pp(29,1) = 29
    pp(30,1) = 30
    pp(31,1) = 31
    pp(32,1) = 32
    pp(33,1) = 33
    pp(34,1) = 34
    pp(35,1) = 35
    pp(36,1) = 36
    pp(37,1) = 37
    pp(38,1) = 38
    pp(39,1) = 39
    pp(40,1) = 40
    pp(41,1) = 1

!   Name of group of species
    ppname(1) = TRIM(gname(sN2))
    ppname(2) = TRIM(gname(sH))
    ppname(3) = TRIM(gname(sH2))
    ppname(4) = TRIM(gname(sO))
    ppname(5) = TRIM(gname(sO2))
    ppname(6) = TRIM(gname(sOH))
    ppname(7) = TRIM(gname(sH2O))
    ppname(8) = TRIM(gname(sH2O2))
    ppname(9) = TRIM(gname(sHO2))
    ppname(10) = TRIM(gname(sC))
    ppname(11) = TRIM(gname(sCO))
    ppname(12) = TRIM(gname(sCH))
    ppname(13) = TRIM(gname(sCH2))
    ppname(14) = TRIM(gname(sHCO))
    ppname(15) = TRIM(gname(sCH2O))
    ppname(16) = TRIM(gname(sCH3))
    ppname(17) = TRIM(gname(s1XCH2))
    ppname(18) = TRIM(gname(sCH3OH))
    ppname(19) = TRIM(gname(sCH3O))
    ppname(20) = TRIM(gname(sC2H2))
    ppname(21) = TRIM(gname(sC2H5))
    ppname(22) = TRIM(gname(sCH4))
    ppname(23) = TRIM(gname(sC2H3))
    ppname(24) = TRIM(gname(sC2H6))
    ppname(25) = TRIM(gname(sC2H4))
    ppname(26) = TRIM(gname(sCO2))
    ppname(27) = TRIM(gname(sHCCO))
    ppname(28) = TRIM(gname(sN))
    ppname(29) = TRIM(gname(sNO))
    ppname(30) = TRIM(gname(sHCN))
    ppname(31) = TRIM(gname(sNH))
    ppname(32) = TRIM(gname(sHNO))
    ppname(33) = TRIM(gname(sNH2))
    ppname(34) = TRIM(gname(sNCO))
    ppname(35) = TRIM(gname(sHCNO))
    ppname(36) = TRIM(gname(sNO2))
    ppname(37) = TRIM(gname(sN2O))
    ppname(38) = TRIM(gname(sHNCO))
    ppname(39) = TRIM(gname(sHOCN))
    ppname(40) = TRIM(gname(sNNH))
    ppname(41) = 'N2X'


  END SUBROUTINE pp_data


! Species names (postproc)
  SUBROUTINE species_name

    IMPLICIT NONE

    gname(sN2) = 'N2'
    gname(sH) = 'H'
    gname(sH2) = 'H2'
    gname(sO) = 'O'
    gname(sO2) = 'O2'
    gname(sOH) = 'OH'
    gname(sH2O) = 'H2O'
    gname(sH2O2) = 'H2O2'
    gname(sHO2) = 'HO2'
    gname(sC) = 'C'
    gname(sCO) = 'CO'
    gname(sCH) = 'CH'
    gname(sCH2) = 'CH2'
    gname(sHCO) = 'HCO'
    gname(sCH2O) = 'CH2O'
    gname(sCH3) = 'CH3'
    gname(s1XCH2) = '1-CH2'
    gname(sCH3OH) = 'CH3OH'
    gname(sCH3O) = 'CH3O'
    gname(sC2H2) = 'C2H2'
    gname(sC2H5) = 'C2H5'
    gname(sCH4) = 'CH4'
    gname(sC2H3) = 'C2H3'
    gname(sC2H6) = 'C2H6'
    gname(sC2H4) = 'C2H4'
    gname(sCO2) = 'CO2'
    gname(sHCCO) = 'HCCO'
    gname(sN) = 'N'
    gname(sNO) = 'NO'
    gname(sHCN) = 'HCN'
    gname(sNH) = 'NH'
    gname(sHNO) = 'HNO'
    gname(sNH2) = 'NH2'
    gname(sNCO) = 'NCO'
    gname(sHCNO) = 'HCNO'
    gname(sNO2) = 'NO2'
    gname(sN2O) = 'N2O'
    gname(sHNCO) = 'HNCO'
    gname(sHOCN) = 'HOCN'
    gname(sNNH) = 'NNH'


  END SUBROUTINE species_name


! Reaction names (postproc)
  SUBROUTINE reaction_name

    IMPLICIT NONE

    rname(r1) = '1'
    rname(r2) = '2'
    rname(r3) = '3'
    rname(r4f) = '4f'
    rname(r5f) = '5f'
    rname(r6f) = '6f'
    rname(r7f) = '7f'
    rname(r8f) = '8f'
    rname(r9) = '9'
    rname(r10f) = '10f'
    rname(r11f) = '11f'
    rname(r12f) = '12f'
    rname(r13f) = '13f'
    rname(r14f) = '14f'
    rname(r15) = '15'
    rname(r16f) = '16f'
    rname(r17) = '17'
    rname(r18) = '18'
    rname(r19f) = '19f'
    rname(r20f) = '20f'
    rname(r21f) = '21f'
    rname(r22) = '22'
    rname(r23) = '23'
    rname(r24f) = '24f'
    rname(r25) = '25'
    rname(r26) = '26'
    rname(r27) = '27'
    rname(r28f) = '28f'
    rname(r29) = '29'
    rname(r30f) = '30f'
    rname(r31) = '31'
    rname(r32) = '32'
    rname(r33) = '33'
    rname(r36) = '36'
    rname(r37) = '37'
    rname(r38) = '38'
    rname(r39f) = '39f'
    rname(r40f) = '40f'
    rname(r41) = '41'
    rname(r42) = '42'
    rname(r43f) = '43f'
    rname(r44) = '44'
    rname(r45) = '45'
    rname(r46f) = '46f'
    rname(r47) = '47'
    rname(r48) = '48'
    rname(r49f) = '49f'
    rname(r50) = '50'
    rname(r51f) = '51f'
    rname(r52) = '52'
    rname(r53) = '53'
    rname(r54f) = '54f'
    rname(r55f) = '55f'
    rname(r56f) = '56f'
    rname(r57) = '57'
    rname(r58f) = '58f'
    rname(r59) = '59'
    rname(r60f) = '60f'
    rname(r61f) = '61f'
    rname(r62) = '62'
    rname(r63f) = '63f'
    rname(r64) = '64'
    rname(r65) = '65'
    rname(r66f) = '66f'
    rname(r67) = '67'
    rname(r68) = '68'
    rname(r69f) = '69f'
    rname(r70f) = '70f'
    rname(r71f) = '71f'
    rname(r72f) = '72f'
    rname(r73f) = '73f'
    rname(r74) = '74'
    rname(r75f) = '75f'
    rname(r76f) = '76f'
    rname(r77f) = '77f'
    rname(r78) = '78'
    rname(r79f) = '79f'
    rname(r80) = '80'
    rname(r81) = '81'
    rname(r82) = '82'
    rname(r83f) = '83f'
    rname(r84) = '84'
    rname(r85f) = '85f'
    rname(r86) = '86'
    rname(r87) = '87'
    rname(r88) = '88'
    rname(r89) = '89'
    rname(r90f) = '90f'
    rname(r91f) = '91f'
    rname(r92) = '92'
    rname(r93f) = '93f'
    rname(r94) = '94'
    rname(r95) = '95'
    rname(r96) = '96'
    rname(r97) = '97'
    rname(r98) = '98'
    rname(r99) = '99'
    rname(r100f) = '100f'
    rname(r101) = '101'
    rname(r102f) = '102f'
    rname(r103) = '103'
    rname(r104) = '104'
    rname(r105f) = '105f'
    rname(r106f) = '106f'
    rname(r107f) = '107f'
    rname(r108f) = '108f'
    rname(r109) = '109'
    rname(r110) = '110'
    rname(r111) = '111'
    rname(r112f) = '112f'
    rname(r113f) = '113f'
    rname(r114) = '114'
    rname(r115) = '115'
    rname(r116) = '116'
    rname(r117) = '117'
    rname(r118) = '118'
    rname(r119f) = '119f'
    rname(r120f) = '120f'
    rname(r121f) = '121f'
    rname(r122) = '122'
    rname(r123) = '123'
    rname(r124f) = '124f'
    rname(r125f) = '125f'
    rname(r126) = '126'
    rname(r127) = '127'
    rname(r128) = '128'
    rname(r129f) = '129f'
    rname(r130) = '130'
    rname(r131f) = '131f'
    rname(r132f) = '132f'
    rname(r133) = '133'
    rname(r134f) = '134f'
    rname(r135) = '135'
    rname(r138) = '138'
    rname(rnog139f) = 'nog139f'
    rname(rnog140f) = 'nog140f'
    rname(rnog141) = 'nog141'
    rname(rnog142f) = 'nog142f'
    rname(rnog143f) = 'nog143f'
    rname(rnog144f) = 'nog144f'
    rname(rnog145f) = 'nog145f'
    rname(rnog146f) = 'nog146f'
    rname(rnog147f) = 'nog147f'
    rname(rnog148) = 'nog148'
    rname(rnog149f) = 'nog149f'
    rname(rnog150f) = 'nog150f'
    rname(rnog151f) = 'nog151f'
    rname(rnog152f) = 'nog152f'
    rname(rnog153) = 'nog153'
    rname(rnog154) = 'nog154'
    rname(rnog155f) = 'nog155f'
    rname(rnog156) = 'nog156'
    rname(rnog157f) = 'nog157f'
    rname(rnog158f) = 'nog158f'
    rname(rnog159) = 'nog159'
    rname(rnog160) = 'nog160'
    rname(rnog161f) = 'nog161f'
    rname(rnog162f) = 'nog162f'
    rname(rnog163f) = 'nog163f'
    rname(rnog164f) = 'nog164f'
    rname(rnog165) = 'nog165'
    rname(rnog166) = 'nog166'
    rname(rnog167f) = 'nog167f'
    rname(rnog168) = 'nog168'
    rname(rnog169) = 'nog169'
    rname(rnog170f) = 'nog170f'
    rname(rnog171f) = 'nog171f'
    rname(rnog172f) = 'nog172f'
    rname(rnog173f) = 'nog173f'
    rname(rnog174f) = 'nog174f'
    rname(rnog175f) = 'nog175f'
    rname(rnog176f) = 'nog176f'
    rname(rnog177) = 'nog177'
    rname(rnog178f) = 'nog178f'
    rname(rnog179) = 'nog179'
    rname(rnog180f) = 'nog180f'
    rname(rnog181) = 'nog181'
    rname(rnog182) = 'nog182'
    rname(rnog183f) = 'nog183f'
    rname(rnog184) = 'nog184'
    rname(rnog185) = 'nog185'
    rname(rnog186f) = 'nog186f'
    rname(rnog187) = 'nog187'
    rname(rnog188) = 'nog188'
    rname(rnog189f) = 'nog189f'
    rname(rnog190) = 'nog190'
    rname(rnog191f) = 'nog191f'
    rname(rnog192f) = 'nog192f'
    rname(rnog193f) = 'nog193f'
    rname(rnog194f) = 'nog194f'
    rname(rnog195f) = 'nog195f'
    rname(rnog196) = 'nog196'
    rname(rnog197) = 'nog197'
    rname(rnog198) = 'nog198'
    rname(rnog199) = 'nog199'
    rname(rnog200) = 'nog200'
    rname(r201f) = '201f'
    rname(r202f) = '202f'
    rname(rnog203f) = 'nog203f'
    rname(rnog204f) = 'nog204f'
    rname(rnog205) = 'nog205'
    rname(rnog206) = 'nog206'
    rname(rnog207f) = 'nog207f'
    rname(rnog208f) = 'nog208f'
    rname(rnog209f) = 'nog209f'
    rname(rnog210f) = 'nog210f'
    rname(rnog211f) = 'nog211f'
    rname(rnog212f) = 'nog212f'
    rname(rnog213) = 'nog213'
    rname(rnog214f) = 'nog214f'
    rname(r4b) = '4b'
    rname(r5b) = '5b'
    rname(r6b) = '6b'
    rname(r7b) = '7b'
    rname(r8b) = '8b'
    rname(r10b) = '10b'
    rname(r11b) = '11b'
    rname(r12b) = '12b'
    rname(r13b) = '13b'
    rname(r14b) = '14b'
    rname(r16b) = '16b'
    rname(r19b) = '19b'
    rname(r20b) = '20b'
    rname(r21b) = '21b'
    rname(r24b) = '24b'
    rname(r28b) = '28b'
    rname(r30b) = '30b'
    rname(r39b) = '39b'
    rname(r40b) = '40b'
    rname(r43b) = '43b'
    rname(r46b) = '46b'
    rname(r49b) = '49b'
    rname(r51b) = '51b'
    rname(r54b) = '54b'
    rname(r55b) = '55b'
    rname(r56b) = '56b'
    rname(r58b) = '58b'
    rname(r60b) = '60b'
    rname(r61b) = '61b'
    rname(r63b) = '63b'
    rname(r66b) = '66b'
    rname(r69b) = '69b'
    rname(r70b) = '70b'
    rname(r71b) = '71b'
    rname(r72b) = '72b'
    rname(r73b) = '73b'
    rname(r75b) = '75b'
    rname(r76b) = '76b'
    rname(r77b) = '77b'
    rname(r79b) = '79b'
    rname(r83b) = '83b'
    rname(r85b) = '85b'
    rname(r90b) = '90b'
    rname(r91b) = '91b'
    rname(r93b) = '93b'
    rname(r100b) = '100b'
    rname(r102b) = '102b'
    rname(r105b) = '105b'
    rname(r106b) = '106b'
    rname(r107b) = '107b'
    rname(r108b) = '108b'
    rname(r112b) = '112b'
    rname(r113b) = '113b'
    rname(r119b) = '119b'
    rname(r120b) = '120b'
    rname(r121b) = '121b'
    rname(r124b) = '124b'
    rname(r125b) = '125b'
    rname(r129b) = '129b'
    rname(r131b) = '131b'
    rname(r132b) = '132b'
    rname(r134b) = '134b'
    rname(rnog139b) = 'nog139b'
    rname(rnog140b) = 'nog140b'
    rname(rnog142b) = 'nog142b'
    rname(rnog143b) = 'nog143b'
    rname(rnog144b) = 'nog144b'
    rname(rnog145b) = 'nog145b'
    rname(rnog146b) = 'nog146b'
    rname(rnog147b) = 'nog147b'
    rname(rnog149b) = 'nog149b'
    rname(rnog150b) = 'nog150b'
    rname(rnog151b) = 'nog151b'
    rname(rnog152b) = 'nog152b'
    rname(rnog155b) = 'nog155b'
    rname(rnog157b) = 'nog157b'
    rname(rnog158b) = 'nog158b'
    rname(rnog161b) = 'nog161b'
    rname(rnog162b) = 'nog162b'
    rname(rnog163b) = 'nog163b'
    rname(rnog164b) = 'nog164b'
    rname(rnog167b) = 'nog167b'
    rname(rnog170b) = 'nog170b'
    rname(rnog171b) = 'nog171b'
    rname(rnog172b) = 'nog172b'
    rname(rnog173b) = 'nog173b'
    rname(rnog174b) = 'nog174b'
    rname(rnog175b) = 'nog175b'
    rname(rnog176b) = 'nog176b'
    rname(rnog178b) = 'nog178b'
    rname(rnog180b) = 'nog180b'
    rname(rnog183b) = 'nog183b'
    rname(rnog186b) = 'nog186b'
    rname(rnog189b) = 'nog189b'
    rname(rnog191b) = 'nog191b'
    rname(rnog192b) = 'nog192b'
    rname(rnog193b) = 'nog193b'
    rname(rnog194b) = 'nog194b'
    rname(rnog195b) = 'nog195b'
    rname(r201b) = '201b'
    rname(r202b) = '202b'
    rname(rnog203b) = 'nog203b'
    rname(rnog204b) = 'nog204b'
    rname(rnog207b) = 'nog207b'
    rname(rnog208b) = 'nog208b'
    rname(rnog209b) = 'nog209b'
    rname(rnog210b) = 'nog210b'
    rname(rnog211b) = 'nog211b'
    rname(rnog212b) = 'nog212b'
    rname(rnog214b) = 'nog214b'


  END SUBROUTINE reaction_name


! List of QSS species (postproc)
  SUBROUTINE QSS_list

    IMPLICIT NONE

    iqss(sN2) = 0
    iqss(sH) = 0
    iqss(sH2) = 0
    iqss(sO) = 0
    iqss(sO2) = 0
    iqss(sOH) = 0
    iqss(sH2O) = 0
    iqss(sH2O2) = 0
    iqss(sHO2) = 0
    iqss(sC) = 1
    iqss(sCO) = 0
    iqss(sCH) = 1
    iqss(sCH2) = 1
    iqss(sHCO) = 1
    iqss(sCH2O) = 0
    iqss(sCH3) = 0
    iqss(s1XCH2) = 1
    iqss(sCH3OH) = 0
    iqss(sCH3O) = 1
    iqss(sC2H2) = 0
    iqss(sC2H5) = 1
    iqss(sCH4) = 0
    iqss(sC2H3) = 1
    iqss(sC2H6) = 0
    iqss(sC2H4) = 0
    iqss(sCO2) = 0
    iqss(sHCCO) = 1
    iqss(sN) = 1
    iqss(sNO) = 0
    iqss(sHCN) = 0
    iqss(sNH) = 1
    iqss(sHNO) = 1
    iqss(sNH2) = 1
    iqss(sNCO) = 1
    iqss(sHCNO) = 1
    iqss(sNO2) = 0
    iqss(sN2O) = 0
    iqss(sHNCO) = 1
    iqss(sHOCN) = 1
    iqss(sNNH) = 1


  END SUBROUTINE QSS_list

!--------------------------------------------------------------------------------------------------
!     FUNCTION getlindratecoeff
!>    @details Function for calculating fall-off coefficients.
!
!!    @authors T. Jaravel
!!    @date    15-07-2015
!
!     Input:
!            Tloc  Temperature
!            k0
!            kinf
!            fc
!            concin
!            Ploc  Pressure
!
!--------------------------------------------------------------------------------------------------
  REAL(pr) FUNCTION getlindratecoeff ( Tloc,k0,kinf,fc,concin,Ploc )

  IMPLICIT NONE

  REAL(pr) ::  Tloc,k0,kinf,fc,Ploc
  REAL(pr), PARAMETER :: R = 8.31434_pr
  REAL(pr) :: ntmp,ccoeff,dcoeff,lgknull
  REAL(pr) :: f
  REAL(pr) :: conc, concin


  IF ( concin>0.0_pr ) THEN
    conc = concin
  ELSE
    conc = Ploc / ( R * Tloc )
  END IF
  ntmp = 0.75_pr - 1.27_pr * LOG10( fc )

  ccoeff = - 0.4_pr - 0.67_pr * LOG10( fc )
  dcoeff = 0.14_pr
  k0 = k0 * conc / MAX(kinf, 1.0e-60_pr)
  lgknull = LOG10(k0)
  f = (lgknull+ccoeff)/(ntmp-dcoeff*(lgknull+ccoeff))
  f = fc**(1.0_pr / ( f * f + 1.0_pr ))
  getlindratecoeff = kinf * f * k0 / ( 1.0_pr + k0 )


END FUNCTION getlindratecoeff


!--------------------------------------------------------------------------------------------------
!     SUBROUTINE get_thirdbodies
!>    @details Subroutine for calculating the third-body concentrations.
!
!!    @authors T. Jaravel
!!    @date    15-07-2015
!
!     Input:
!            c     Concentrations
!
!     Output:
!            M     Third-body concentrations.
!
!--------------------------------------------------------------------------------------------------
SUBROUTINE get_thirdbodies ( M,c )

  IMPLICIT NONE

  REAL(pr), DIMENSION(nspec) :: c
  REAL(pr), DIMENSION(31) :: M


  M(mM26) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (1_pr)*c(sCH4)&
             + (-1_pr)*c(sH2O)&
             + sum(c)
  M(mM37) = sum(c)
  M(mM5) = (2_pr)*c(sC2H6)&
             + (1_pr)*c(sCH4)&
             + (-1_pr)*c(sH2)&
             + (-1_pr)*c(sCO2)&
             + (-1_pr)*c(sH2O)&
             + sum(c)
  M(mM24) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM17) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM4) = (0.5_pr)*c(sCO2)&
             + (-0.25_pr)*c(sCO)&
             + (0.5_pr)*c(sC2H6)&
             + (-1_pr)*c(sH2O)&
             + (-1_pr)*c(sN2)&
             + (-1_pr)*c(sO2)&
             + sum(c)
  M(mM29) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM36) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM31) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM18) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM19) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM8) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM1) = (1.4_pr)*c(sH2)&
             + (2.6_pr)*c(sCO2)&
             + (0.75_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (14.4_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM6) = (-0.27_pr)*c(sH2)&
             + (2_pr)*c(sC2H6)&
             + (2.65_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM38) = sum(c)
  M(mM3) = (1_pr)*c(sH2)&
             + (2.5_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (5_pr)*c(sO2)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM16) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM22) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM32) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM15) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM11) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM7) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM25) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM30) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM27) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM13) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM20) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM28) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM9) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)
  M(mM21) = (1_pr)*c(sH2)&
             + (1_pr)*c(sCO2)&
             + (0.5_pr)*c(sCO)&
             + (2_pr)*c(sC2H6)&
             + (5_pr)*c(sH2O)&
             + (1_pr)*c(sCH4)&
             + sum(c)


END SUBROUTINE get_thirdbodies


!--------------------------------------------------------------------------------------------------
!     SUBROUTINE get_rate_coefficients
!>    @details Subroutine for calculating the reaction coefficients.
!
!!    @authors T. Jaravel
!!    @date    15-07-2015
!
!     Input:
!            M     Third-body concentrations
!            Tloc  Temperature
!            Ploc  Pressure
!
!     Output:
!            k     Reaction coefficients
!
!--------------------------------------------------------------------------------------------------
SUBROUTINE get_rate_coefficients ( k,M,Tloc,Ploc )

  IMPLICIT NONE

  REAL(pr), DIMENSION(nreac) :: k
  REAL(pr), DIMENSION(31) :: M
  REAL(pr) :: Tloc,Ploc

  REAL(pr) :: k8f_0, k8f_inf, FC8f
  REAL(pr) :: k41_0, k41_inf, FC41
  REAL(pr) :: k49f_0, k49f_inf, FC49f
  REAL(pr) :: k60f_0, k60f_inf, FC60f
  REAL(pr) :: k63f_0, k63f_inf, FC63f
  REAL(pr) :: k66f_0, k66f_inf, FC66f
  REAL(pr) :: k75f_0, k75f_inf, FC75f
  REAL(pr) :: k93f_0, k93f_inf, FC93f
  REAL(pr) :: k94_0, k94_inf, FC94
  REAL(pr) :: k96_0, k96_inf, FC96
  REAL(pr) :: k98_0, k98_inf, FC98
  REAL(pr) :: k113f_0, k113f_inf, FC113f
  REAL(pr) :: k116_0, k116_inf, FC116
  REAL(pr) :: k122_0, k122_inf, FC122
  REAL(pr) :: k124f_0, k124f_inf, FC124f
  REAL(pr) :: k127_0, k127_inf, FC127
  REAL(pr) :: knog212f_0, knog212f_inf, FCnog212f
  REAL(pr) :: k8b_0, k8b_inf, FC8b
  REAL(pr) :: k49b_0, k49b_inf, FC49b
  REAL(pr) :: k60b_0, k60b_inf, FC60b
  REAL(pr) :: k63b_0, k63b_inf, FC63b
  REAL(pr) :: k66b_0, k66b_inf, FC66b
  REAL(pr) :: k75b_0, k75b_inf, FC75b
  REAL(pr) :: k93b_0, k93b_inf, FC93b
  REAL(pr) :: k113b_0, k113b_inf, FC113b
  REAL(pr) :: k124b_0, k124b_inf, FC124b
  REAL(pr) :: knog212b_0, knog212b_inf, FCnog212b


! Rate coefficients

  k(r1) = (9.00000000e+04_pr)*Tloc**(-0.600_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r2) = (1.00000000e+06_pr)*Tloc**(-1.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r3) = (1.20000000e+05_pr)*Tloc**(-1.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r4f) = (5.00000000e-02_pr)*Tloc**(2.670_pr)*&
    exp(-(2.632e+04_pr)/(8.314_pr*Tloc))

  k(r5f) = (2.20000000e+10_pr)*Tloc**(-2.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r6f) = (3.57000000e-02_pr)*Tloc**(2.400_pr)*&
    exp(-(-8.829e+03_pr)/(8.314_pr*Tloc))

  k(r7f) = (2.16000000e+02_pr)*Tloc**(1.510_pr)*&
    exp(-(1.435e+04_pr)/(8.314_pr*Tloc))

  k8f_0 = (2.30000000e+06_pr)*Tloc**(-0.900_pr)*&
    exp(-(-7.113e+03_pr)/(8.314_pr*Tloc))

  k8f_inf = (7.40000000e+07_pr)*Tloc**(-0.370_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  FC8f = (2.654e-01_pr)*&
    exp(-Tloc/(9.400e+01_pr)) + (7.346e-01_pr)*&
    exp(-Tloc/(1.756e+03_pr)) + (1.000e+00_pr)*&
    exp(-(5.182e+03_pr)/Tloc)

  k(r8f) =&
    getlindratecoeff&
    (Tloc, k8f_0, k8f_inf, FC8f, M(mM20), Ploc )

  k(r9) = (6.00000000e+07_pr)*Tloc**(-1.250_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r10f) = (2.80000000e+06_pr)*Tloc**(-0.860_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r11f) = (9.38000000e+06_pr)*Tloc**(-0.760_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r12f) = (3.00000000e+08_pr)*Tloc**(-1.720_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r13f) = (8.30000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(6.031e+04_pr)/(8.314_pr*Tloc))

  k(r14f) = (2.90000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(-2.092e+03_pr)/(8.314_pr*Tloc))

  k(r15) = (3.97000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(2.808e+03_pr)/(8.314_pr*Tloc))

  k(r16f) = (2.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r17) = (1.30000000e+05_pr)*Tloc**(0.000_pr)*&
    exp(-(-6.821e+03_pr)/(8.314_pr*Tloc))

  k(r18) = (4.20000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(5.021e+04_pr)/(8.314_pr*Tloc))

  k(r19f) = (2.80000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(4.469e+03_pr)/(8.314_pr*Tloc))

  k(r20f) = (1.34000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(2.657e+03_pr)/(8.314_pr*Tloc))

  k(r21f) = (5.80000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(4.000e+04_pr)/(8.314_pr*Tloc))

  k(r22) = (1.75000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(1.339e+03_pr)/(8.314_pr*Tloc))

  k(r23) = (9.63000000e+00_pr)*Tloc**(2.000_pr)*&
    exp(-(1.674e+04_pr)/(8.314_pr*Tloc))

  k(r24f) = (1.21000000e+01_pr)*Tloc**(2.000_pr)*&
    exp(-(2.176e+04_pr)/(8.314_pr*Tloc))

  k(r25) = (1.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(1.506e+04_pr)/(8.314_pr*Tloc))

  k(r26) = (5.80000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(2.410e+03_pr)/(8.314_pr*Tloc))

  k(r27) = (5.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r28f) = (1.10700000e+02_pr)*Tloc**(1.790_pr)*&
    exp(-(6.988e+03_pr)/(8.314_pr*Tloc))

  k(r29) = (5.70000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r30f) = (1.10000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r31) = (3.30000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r32) = (3.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r33) = (1.71300000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(-3.159e+03_pr)/(8.314_pr*Tloc))

  k(r36) = (2.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r37) = (2.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r38) = (8.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r39f) = (1.13000000e+01_pr)*Tloc**(2.000_pr)*&
    exp(-(1.255e+04_pr)/(8.314_pr*Tloc))

  k(r40f) = (5.00000000e-01_pr)*Tloc**(2.000_pr)*&
    exp(-(3.025e+04_pr)/(8.314_pr*Tloc))

  k41_0 = (3.20000000e+15_pr)*Tloc**(-3.140_pr)*&
    exp(-(5.147e+03_pr)/(8.314_pr*Tloc))

  k41_inf = (2.50000000e+10_pr)*Tloc**(-0.800_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  FC41 = (3.200e-01_pr)*&
    exp(-Tloc/(7.800e+01_pr)) + (6.800e-01_pr)*&
    exp(-Tloc/(1.995e+03_pr)) + (1.000e+00_pr)*&
    exp(-(5.590e+03_pr)/Tloc)

  k(r41) =&
    getlindratecoeff&
    (Tloc, k41_0, k41_inf, FC41, M(mM7), Ploc )

  k(r42) = (1.32000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(6.277e+03_pr)/(8.314_pr*Tloc))

  k(r43f) = (3.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r44) = (1.20000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r45) = (3.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r46f) = (3.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r47) = (1.50000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r48) = (1.50000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k49f_0 = (2.70000000e+26_pr)*Tloc**(-6.300_pr)*&
    exp(-(1.297e+04_pr)/(8.314_pr*Tloc))

  k49f_inf = (2.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  FC49f = (8.493e-01_pr)*&
    exp(-Tloc/(1.340e+02_pr)) + (1.507e-01_pr)*&
    exp(-Tloc/(2.383e+03_pr)) + (1.000e+00_pr)*&
    exp(-(7.265e+03_pr)/Tloc)

  k(r49f) =&
    getlindratecoeff&
    (Tloc, k49f_0, k49f_inf, FC49f, M(mM24), Ploc )

  k(r50) = (2.80000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r51f) = (7.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r52) = (2.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r53) = (5.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r54f) = (4.99000000e+06_pr)*Tloc**(0.100_pr)*&
    exp(-(4.436e+04_pr)/(8.314_pr*Tloc))

  k(r55f) = (2.50100000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r56f) = (2.45000000e-02_pr)*Tloc**(2.470_pr)*&
    exp(-(2.168e+04_pr)/(8.314_pr*Tloc))

  k(r57) = (3.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r58f) = (5.60000000e+01_pr)*Tloc**(1.600_pr)*&
    exp(-(2.268e+04_pr)/(8.314_pr*Tloc))

  k(r59) = (8.43000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k60f_0 = (1.77000000e+38_pr)*Tloc**(-9.670_pr)*&
    exp(-(2.603e+04_pr)/(8.314_pr*Tloc))

  k60f_inf = (2.12000000e+10_pr)*Tloc**(-0.970_pr)*&
    exp(-(2.594e+03_pr)/(8.314_pr*Tloc))

  FC60f = (4.675e-01_pr)*&
    exp(-Tloc/(1.510e+02_pr)) + (5.325e-01_pr)*&
    exp(-Tloc/(1.038e+03_pr)) + (1.000e+00_pr)*&
    exp(-(4.970e+03_pr)/Tloc)

  k(r60f) =&
    getlindratecoeff&
    (Tloc, k60f_0, k60f_inf, FC60f, M(mM25), Ploc )

  k(r61f) = (2.67500000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(1.205e+05_pr)/(8.314_pr*Tloc))

  k(r62) = (3.60000000e+04_pr)*Tloc**(0.000_pr)*&
    exp(-(3.741e+04_pr)/(8.314_pr*Tloc))

  k63f_0 = (2.47700000e+21_pr)*Tloc**(-4.760_pr)*&
    exp(-(1.021e+04_pr)/(8.314_pr*Tloc))

  k63f_inf = (1.27000000e+10_pr)*Tloc**(-0.630_pr)*&
    exp(-(1.603e+03_pr)/(8.314_pr*Tloc))

  FC63f = (2.170e-01_pr)*&
    exp(-Tloc/(7.400e+01_pr)) + (7.830e-01_pr)*&
    exp(-Tloc/(2.941e+03_pr)) + (1.000e+00_pr)*&
    exp(-(6.964e+03_pr)/Tloc)

  k(r63f) =&
    getlindratecoeff&
    (Tloc, k63f_0, k63f_inf, FC63f, M(mM8), Ploc )

  k(r64) = (4.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r65) = (1.20000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(-2.385e+03_pr)/(8.314_pr*Tloc))

  k66f_0 = (2.70000000e+26_pr)*Tloc**(-6.300_pr)*&
    exp(-(1.297e+04_pr)/(8.314_pr*Tloc))

  k66f_inf = (6.30000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  FC66f = (7.895e-01_pr)*&
    exp(-Tloc/(8.350e+01_pr)) + (2.105e-01_pr)*&
    exp(-Tloc/(5.398e+03_pr)) + (1.000e+00_pr)*&
    exp(-(8.370e+03_pr)/Tloc)

  k(r66f) =&
    getlindratecoeff&
    (Tloc, k66f_0, k66f_inf, FC66f, M(mM21), Ploc )

  k(r67) = (1.00000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r68) = (6.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r69f) = (2.46000000e+00_pr)*Tloc**(2.000_pr)*&
    exp(-(3.460e+04_pr)/(8.314_pr*Tloc))

  k(r70f) = (6.60000000e+02_pr)*Tloc**(1.620_pr)*&
    exp(-(4.536e+04_pr)/(8.314_pr*Tloc))

  k(r71f) = (1.00000000e+02_pr)*Tloc**(1.600_pr)*&
    exp(-(1.306e+04_pr)/(8.314_pr*Tloc))

  k(r72f) = (1.02000000e+03_pr)*Tloc**(1.500_pr)*&
    exp(-(3.599e+04_pr)/(8.314_pr*Tloc))

  k(r73f) = (1.60000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(-2.385e+03_pr)/(8.314_pr*Tloc))

  k(r74) = (1.50000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(9.875e+04_pr)/(8.314_pr*Tloc))

  k75f_0 = (2.69000000e+16_pr)*Tloc**(-3.740_pr)*&
    exp(-(8.101e+03_pr)/(8.314_pr*Tloc))

  k75f_inf = (5.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  FC75f = (4.243e-01_pr)*&
    exp(-Tloc/(2.370e+02_pr)) + (5.757e-01_pr)*&
    exp(-Tloc/(1.652e+03_pr)) + (1.000e+00_pr)*&
    exp(-(5.069e+03_pr)/Tloc)

  k(r75f) =&
    getlindratecoeff&
    (Tloc, k75f_0, k75f_inf, FC75f, M(mM22), Ploc )

  k(r76f) = (4.76000000e+01_pr)*Tloc**(1.228_pr)*&
    exp(-(2.930e+02_pr)/(8.314_pr*Tloc))

  k(r77f) = (2.50000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(2.000e+05_pr)/(8.314_pr*Tloc))

  k(r78) = (6.02000000e+02_pr)*Tloc**(0.000_pr)*&
    exp(-(1.255e+04_pr)/(8.314_pr*Tloc))

  k(r79f) = (9.00000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r80) = (3.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r81) = (7.34000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r82) = (3.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r83f) = (1.87000000e+11_pr)*Tloc**(-1.000_pr)*&
    exp(-(7.114e+04_pr)/(8.314_pr*Tloc))

  k(r84) = (5.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r85f) = (2.24400000e+12_pr)*Tloc**(-1.000_pr)*&
    exp(-(7.114e+04_pr)/(8.314_pr*Tloc))

  k(r86) = (7.60000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(1.674e+03_pr)/(8.314_pr*Tloc))

  k(r87) = (2.64800000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r88) = (1.00000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(3.348e+04_pr)/(8.314_pr*Tloc))

  k(r89) = (3.43000000e+03_pr)*Tloc**(1.180_pr)*&
    exp(-(-1.870e+03_pr)/(8.314_pr*Tloc))

  k(r90f) = (1.00000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(1.674e+05_pr)/(8.314_pr*Tloc))

  k(r91f) = (2.30000000e+04_pr)*Tloc**(1.050_pr)*&
    exp(-(1.370e+04_pr)/(8.314_pr*Tloc))

  k(r92) = (3.90000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(1.481e+04_pr)/(8.314_pr*Tloc))

  k93f_0 = (2.20000000e+18_pr)*Tloc**(-4.800_pr)*&
    exp(-(2.326e+04_pr)/(8.314_pr*Tloc))

  k93f_inf = (5.40000000e+05_pr)*Tloc**(0.454_pr)*&
    exp(-(1.088e+04_pr)/(8.314_pr*Tloc))

  FC93f = (2.420e-01_pr)*&
    exp(-Tloc/(9.400e+01_pr)) + (7.580e-01_pr)*&
    exp(-Tloc/(1.555e+03_pr)) + (1.000e+00_pr)*&
    exp(-(4.200e+03_pr)/Tloc)

  k(r93f) =&
    getlindratecoeff&
    (Tloc, k93f_0, k93f_inf, FC93f, M(mM11), Ploc )

  k94_0 = (1.89500000e+20_pr)*Tloc**(-2.669_pr)*&
    exp(-(3.756e+05_pr)/(8.314_pr*Tloc))

  k94_inf = (1.53000000e+14_pr)*Tloc**(0.381_pr)*&
    exp(-(3.685e+05_pr)/(8.314_pr*Tloc))

  FC94 = (2.176e-01_pr)*&
    exp(-Tloc/(2.710e+02_pr)) + (7.824e-01_pr)*&
    exp(-Tloc/(2.755e+03_pr)) + (1.000e+00_pr)*&
    exp(-(6.570e+03_pr)/Tloc)

  k(r94) =&
    getlindratecoeff&
    (Tloc, k94_0, k94_inf, FC94, M(mM9), Ploc )

  k(r95) = (3.32000000e-03_pr)*Tloc**(2.810_pr)*&
    exp(-(2.452e+04_pr)/(8.314_pr*Tloc))

  k96_0 = (1.61200000e+25_pr)*Tloc**(-4.102_pr)*&
    exp(-(3.552e+05_pr)/(8.314_pr*Tloc))

  k96_inf = (1.36800000e+11_pr)*Tloc**(0.818_pr)*&
    exp(-(3.354e+05_pr)/(8.314_pr*Tloc))

  FC96 = (6.800e-02_pr)*&
    exp(-Tloc/(1.970e+02_pr)) + (9.320e-01_pr)*&
    exp(-Tloc/(1.540e+03_pr)) + (1.000e+00_pr)*&
    exp(-(1.030e+04_pr)/Tloc)

  k(r96) =&
    getlindratecoeff&
    (Tloc, k96_0, k96_inf, FC96, M(mM19), Ploc )

  k(r97) = (2.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k98_0 = (8.60000000e+16_pr)*Tloc**(-4.000_pr)*&
    exp(-(1.266e+04_pr)/(8.314_pr*Tloc))

  k98_inf = (5.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  FC98 = (1.098e-01_pr)*&
    exp(-Tloc/(1.440e+02_pr)) + (8.902e-01_pr)*&
    exp(-Tloc/(2.838e+03_pr)) + (1.000e+00_pr)*&
    exp(-(4.557e+04_pr)/Tloc)

  k(r98) =&
    getlindratecoeff&
    (Tloc, k98_0, k98_inf, FC98, M(mM13), Ploc )

  k(r99) = (5.00000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r100f) = (1.60000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r101) = (4.28000000e-19_pr)*Tloc**(7.600_pr)*&
    exp(-(-1.477e+04_pr)/(8.314_pr*Tloc))

  k(r102f) = (3.20000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r103) = (1.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r104) = (1.30000000e-01_pr)*Tloc**(2.500_pr)*&
    exp(-(2.092e+04_pr)/(8.314_pr*Tloc))

  k(r105f) = (4.20000000e+00_pr)*Tloc**(2.100_pr)*&
    exp(-(2.038e+04_pr)/(8.314_pr*Tloc))

  k(r106f) = (6.30000000e+00_pr)*Tloc**(2.000_pr)*&
    exp(-(6.277e+03_pr)/(8.314_pr*Tloc))

  k(r107f) = (1.00000000e+01_pr)*Tloc**(1.500_pr)*&
    exp(-(4.159e+04_pr)/(8.314_pr*Tloc))

  k(r108f) = (7.00000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r109) = (3.40000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(2.887e+03_pr)/(8.314_pr*Tloc))

  k(r110) = (1.40000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r111) = (4.83000000e-10_pr)*Tloc**(4.000_pr)*&
    exp(-(-8.369e+03_pr)/(8.314_pr*Tloc))

  k(r112f) = (1.02000000e+01_pr)*Tloc**(2.000_pr)*&
    exp(-(7.950e+03_pr)/(8.314_pr*Tloc))

  k113f_0 = (3.80000000e+28_pr)*Tloc**(-7.270_pr)*&
    exp(-(3.021e+04_pr)/(8.314_pr*Tloc))

  k113f_inf = (5.60000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(1.004e+04_pr)/(8.314_pr*Tloc))

  FC113f = (2.493e-01_pr)*&
    exp(-Tloc/(9.850e+01_pr)) + (7.507e-01_pr)*&
    exp(-Tloc/(1.302e+03_pr)) + (1.000e+00_pr)*&
    exp(-(4.167e+03_pr)/Tloc)

  k(r113f) =&
    getlindratecoeff&
    (Tloc, k113f_0, k113f_inf, FC113f, M(mM15), Ploc )

  k(r114) = (1.02000000e+01_pr)*Tloc**(2.000_pr)*&
    exp(-(7.950e+03_pr)/(8.314_pr*Tloc))

  k(r115) = (3.98000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(-1.004e+03_pr)/(8.314_pr*Tloc))

  k116_0 = (1.40000000e+18_pr)*Tloc**(-3.860_pr)*&
    exp(-(1.389e+04_pr)/(8.314_pr*Tloc))

  k116_inf = (6.08000000e+06_pr)*Tloc**(0.270_pr)*&
    exp(-(1.172e+03_pr)/(8.314_pr*Tloc))

  FC116 = (2.180e-01_pr)*&
    exp(-Tloc/(2.075e+02_pr)) + (7.820e-01_pr)*&
    exp(-Tloc/(2.663e+03_pr)) + (1.000e+00_pr)*&
    exp(-(6.095e+03_pr)/Tloc)

  k(r116) =&
    getlindratecoeff&
    (Tloc, k116_0, k116_inf, FC116, M(mM16), Ploc )

  k(r117) = (5.00000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r118) = (3.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r119f) = (1.32500000e+00_pr)*Tloc**(2.530_pr)*&
    exp(-(5.122e+04_pr)/(8.314_pr*Tloc))

  k(r120f) = (2.27000000e-01_pr)*Tloc**(2.000_pr)*&
    exp(-(3.850e+04_pr)/(8.314_pr*Tloc))

  k(r121f) = (3.60000000e+00_pr)*Tloc**(2.000_pr)*&
    exp(-(1.046e+04_pr)/(8.314_pr*Tloc))

  k122_0 = (7.00000000e+44_pr)*Tloc**(-9.310_pr)*&
    exp(-(4.179e+05_pr)/(8.314_pr*Tloc))

  k122_inf = (8.00000000e+12_pr)*Tloc**(0.440_pr)*&
    exp(-(3.714e+05_pr)/(8.314_pr*Tloc))

  FC122 = (2.655e-01_pr)*&
    exp(-Tloc/(1.800e+02_pr)) + (7.345e-01_pr)*&
    exp(-Tloc/(1.035e+03_pr)) + (1.000e+00_pr)*&
    exp(-(5.417e+03_pr)/Tloc)

  k(r122) =&
    getlindratecoeff&
    (Tloc, k122_0, k122_inf, FC122, M(mM27), Ploc )

  k(r123) = (1.92000000e+01_pr)*Tloc**(1.830_pr)*&
    exp(-(9.210e+02_pr)/(8.314_pr*Tloc))

  k124f_0 = (1.20000000e+30_pr)*Tloc**(-7.620_pr)*&
    exp(-(2.916e+04_pr)/(8.314_pr*Tloc))

  k124f_inf = (1.08000000e+06_pr)*Tloc**(0.454_pr)*&
    exp(-(7.616e+03_pr)/(8.314_pr*Tloc))

  FC124f = (2.470e-02_pr)*&
    exp(-Tloc/(2.100e+02_pr)) + (9.753e-01_pr)*&
    exp(-Tloc/(9.840e+02_pr)) + (1.000e+00_pr)*&
    exp(-(4.374e+03_pr)/Tloc)

  k(r124f) =&
    getlindratecoeff&
    (Tloc, k124f_0, k124f_inf, FC124f, M(mM17), Ploc )

  k(r125f) = (8.40000000e+05_pr)*Tloc**(0.000_pr)*&
    exp(-(1.622e+04_pr)/(8.314_pr*Tloc))

  k(r126) = (2.00000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k127_0 = (1.99000000e+29_pr)*Tloc**(-7.080_pr)*&
    exp(-(2.797e+04_pr)/(8.314_pr*Tloc))

  k127_inf = (5.21000000e+11_pr)*Tloc**(-0.990_pr)*&
    exp(-(6.611e+03_pr)/(8.314_pr*Tloc))

  FC127 = (1.578e-01_pr)*&
    exp(-Tloc/(1.250e+02_pr)) + (8.422e-01_pr)*&
    exp(-Tloc/(2.219e+03_pr)) + (1.000e+00_pr)*&
    exp(-(6.882e+03_pr)/Tloc)

  k(r127) =&
    getlindratecoeff&
    (Tloc, k127_0, k127_inf, FC127, M(mM18), Ploc )

  k(r128) = (1.32000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r129f) = (3.54000000e+00_pr)*Tloc**(2.120_pr)*&
    exp(-(3.640e+03_pr)/(8.314_pr*Tloc))

  k(r130) = (8.98000000e+01_pr)*Tloc**(1.920_pr)*&
    exp(-(2.381e+04_pr)/(8.314_pr*Tloc))

  k(r131f) = (1.15000000e+02_pr)*Tloc**(1.900_pr)*&
    exp(-(3.151e+04_pr)/(8.314_pr*Tloc))

  k(r132f) = (6.14000000e+00_pr)*Tloc**(1.740_pr)*&
    exp(-(4.373e+04_pr)/(8.314_pr*Tloc))

  k(r133) = (4.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(-2.301e+03_pr)/(8.314_pr*Tloc))

  k(r134f) = (1.00000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(r135) = (1.60000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(3.573e+03_pr)/(8.314_pr*Tloc))

  k(r138) = (1.00000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog139f) = (2.65000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(2.678e+04_pr)/(8.314_pr*Tloc))

  k(rnog140f) = (7.33300000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(4.687e+03_pr)/(8.314_pr*Tloc))

  k(rnog141) = (3.70000000e+06_pr)*Tloc**(0.150_pr)*&
    exp(-(-3.770e+02_pr)/(8.314_pr*Tloc))

  k(rnog142f) = (2.00000000e+03_pr)*Tloc**(1.200_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog143f) = (3.20000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(1.381e+03_pr)/(8.314_pr*Tloc))

  k(rnog144f) = (5.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog145f) = (4.61000000e-01_pr)*Tloc**(2.000_pr)*&
    exp(-(2.720e+04_pr)/(8.314_pr*Tloc))

  k(rnog146f) = (2.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(5.795e+04_pr)/(8.314_pr*Tloc))

  k(rnog147f) = (2.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog148) = (1.28000000e+00_pr)*Tloc**(1.500_pr)*&
    exp(-(4.180e+02_pr)/(8.314_pr*Tloc))

  k(rnog149f) = (4.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(1.527e+04_pr)/(8.314_pr*Tloc))

  k(rnog150f) = (7.00000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog151f) = (9.00000000e+01_pr)*Tloc**(1.500_pr)*&
    exp(-(-1.925e+03_pr)/(8.314_pr*Tloc))

  k(rnog152f) = (4.60000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog153) = (2.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog154) = (2.90000000e+08_pr)*Tloc**(-0.690_pr)*&
    exp(-(3.180e+03_pr)/(8.314_pr*Tloc))

  k(rnog155f) = (2.35000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog156) = (2.90000000e+08_pr)*Tloc**(-0.690_pr)*&
    exp(-(3.180e+03_pr)/(8.314_pr*Tloc))

  k(rnog157f) = (2.11000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(-2.009e+03_pr)/(8.314_pr*Tloc))

  k(rnog158f) = (4.16000000e+08_pr)*Tloc**(-0.450_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog159) = (5.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog160) = (3.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog161f) = (3.80000000e+07_pr)*Tloc**(-0.360_pr)*&
    exp(-(2.427e+03_pr)/(8.314_pr*Tloc))

  k(rnog162f) = (3.50000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(1.381e+03_pr)/(8.314_pr*Tloc))

  k(rnog163f) = (1.06000000e+08_pr)*Tloc**(-1.410_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog164f) = (8.95000000e+07_pr)*Tloc**(-1.320_pr)*&
    exp(-(3.096e+03_pr)/(8.314_pr*Tloc))

  k(rnog165) = (2.90000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog166) = (3.10000000e+11_pr)*Tloc**(-1.380_pr)*&
    exp(-(5.314e+03_pr)/(8.314_pr*Tloc))

  k(rnog167f) = (3.80000000e+07_pr)*Tloc**(-0.360_pr)*&
    exp(-(2.427e+03_pr)/(8.314_pr*Tloc))

  k(rnog168) = (9.60000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(1.205e+05_pr)/(8.314_pr*Tloc))

  k(rnog169) = (3.10000000e+11_pr)*Tloc**(-1.380_pr)*&
    exp(-(5.314e+03_pr)/(8.314_pr*Tloc))

  k(rnog170f) = (2.16000000e+07_pr)*Tloc**(-0.230_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog171f) = (4.50000000e+05_pr)*Tloc**(0.720_pr)*&
    exp(-(2.762e+03_pr)/(8.314_pr*Tloc))

  k(rnog172f) = (1.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(5.440e+04_pr)/(8.314_pr*Tloc))

  k(rnog173f) = (2.50000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog174f) = (1.30000000e+01_pr)*Tloc**(1.900_pr)*&
    exp(-(-3.975e+03_pr)/(8.314_pr*Tloc))

  k(rnog175f) = (1.32000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(1.506e+03_pr)/(8.314_pr*Tloc))

  k(rnog176f) = (3.90000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(-1.004e+03_pr)/(8.314_pr*Tloc))

  k(rnog177) = (1.60000000e-04_pr)*Tloc**(2.560_pr)*&
    exp(-(3.766e+04_pr)/(8.314_pr*Tloc))

  k(rnog178f) = (1.10700000e-02_pr)*Tloc**(2.640_pr)*&
    exp(-(2.084e+04_pr)/(8.314_pr*Tloc))

  k(rnog179) = (4.40000000e-03_pr)*Tloc**(2.260_pr)*&
    exp(-(2.678e+04_pr)/(8.314_pr*Tloc))

  k(rnog180f) = (1.10000000e+00_pr)*Tloc**(2.030_pr)*&
    exp(-(5.595e+04_pr)/(8.314_pr*Tloc))

  k(rnog181) = (2.76700000e-03_pr)*Tloc**(2.640_pr)*&
    exp(-(2.084e+04_pr)/(8.314_pr*Tloc))

  k(rnog182) = (2.00000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(8.369e+04_pr)/(8.314_pr*Tloc))

  k(rnog183f) = (8.80000000e+10_pr)*Tloc**(-0.500_pr)*&
    exp(-(2.009e+05_pr)/(8.314_pr*Tloc))

  k(rnog184) = (2.35000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog185) = (2.85000000e+11_pr)*Tloc**(-1.520_pr)*&
    exp(-(3.096e+03_pr)/(8.314_pr*Tloc))

  k(rnog186f) = (5.40000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog187) = (2.50000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog188) = (5.70000000e+12_pr)*Tloc**(-2.000_pr)*&
    exp(-(3.348e+03_pr)/(8.314_pr*Tloc))

  k(rnog189f) = (1.55000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(2.866e+04_pr)/(8.314_pr*Tloc))

  k(rnog190) = (9.80000000e+01_pr)*Tloc**(1.410_pr)*&
    exp(-(3.557e+04_pr)/(8.314_pr*Tloc))

  k(rnog191f) = (4.65000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(2.866e+04_pr)/(8.314_pr*Tloc))

  k(rnog192f) = (1.18000000e+10_pr)*Tloc**(0.000_pr)*&
    exp(-(3.545e+05_pr)/(8.314_pr*Tloc))

  k(rnog193f) = (2.20000000e+00_pr)*Tloc**(2.110_pr)*&
    exp(-(4.770e+04_pr)/(8.314_pr*Tloc))

  k(rnog194f) = (1.05000000e-01_pr)*Tloc**(2.500_pr)*&
    exp(-(5.565e+04_pr)/(8.314_pr*Tloc))

  k(rnog195f) = (2.25000000e+01_pr)*Tloc**(1.700_pr)*&
    exp(-(1.590e+04_pr)/(8.314_pr*Tloc))

  k(rnog196) = (1.70000000e+08_pr)*Tloc**(-0.750_pr)*&
    exp(-(1.209e+04_pr)/(8.314_pr*Tloc))

  k(rnog197) = (2.70000000e+05_pr)*Tloc**(0.180_pr)*&
    exp(-(8.871e+03_pr)/(8.314_pr*Tloc))

  k(rnog198) = (2.10000000e+09_pr)*Tloc**(-0.690_pr)*&
    exp(-(1.193e+04_pr)/(8.314_pr*Tloc))

  k(rnog199) = (2.00000000e+01_pr)*Tloc**(2.000_pr)*&
    exp(-(8.369e+03_pr)/(8.314_pr*Tloc))

  k(rnog200) = (2.85700000e+02_pr)*Tloc**(1.100_pr)*&
    exp(-(8.536e+04_pr)/(8.314_pr*Tloc))

  k(r201f) = (1.50000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(2.511e+03_pr)/(8.314_pr*Tloc))

  k(r202f) = (3.75000000e+08_pr)*Tloc**(-1.720_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog203f) = (5.00000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog204f) = (3.30000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog205) = (2.50000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog206) = (5.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog207f) = (7.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog208f) = (2.00000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(0.000e+00_pr)/(8.314_pr*Tloc))

  k(rnog209f) = (1.30000000e+08_pr)*Tloc**(-0.110_pr)*&
    exp(-(2.084e+04_pr)/(8.314_pr*Tloc))

  k(rnog210f) = (2.00000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(8.812e+04_pr)/(8.314_pr*Tloc))

  k(rnog211f) = (1.40000000e+06_pr)*Tloc**(0.000_pr)*&
    exp(-(4.523e+04_pr)/(8.314_pr*Tloc))

  knog212f_0 = (6.20000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(2.347e+05_pr)/(8.314_pr*Tloc))

  knog212f_inf = (1.30000000e+11_pr)*Tloc**(0.000_pr)*&
    exp(-(2.495e+05_pr)/(8.314_pr*Tloc))

  FCnog212f =  + (1.000e+00_pr)*&
    exp(-(0.000e+00_pr)/Tloc)

  k(rnog212f) =&
    getlindratecoeff&
    (Tloc, knog212f_0, knog212f_inf, FCnog212f, M(mM28), Ploc )

  k(rnog213) = (2.90000000e+07_pr)*Tloc**(0.000_pr)*&
    exp(-(9.687e+04_pr)/(8.314_pr*Tloc))

  k(rnog214f) = (4.40000000e+08_pr)*Tloc**(0.000_pr)*&
    exp(-(7.900e+04_pr)/(8.314_pr*Tloc))

  k(r4b) = (3.02990191e-02_pr)*Tloc**(2.63_pr)*&
    exp(-(1.8444e+04_pr)/(8.314_pr*Tloc))

  k(r5b) = (7.45896518e+16_pr)*Tloc**(-1.79_pr)*&
    exp(-(4.9813e+05_pr)/(8.314_pr*Tloc))

  k(r6b) = (7.39481447e-01_pr)*Tloc**(2.32_pr)*&
    exp(-(6.3971e+04_pr)/(8.314_pr*Tloc))

  k(r7b) = (2.71126135e+03_pr)*Tloc**(1.39_pr)*&
    exp(-(7.9275e+04_pr)/(8.314_pr*Tloc))

  k8b_0 = (1.00720262e+18_pr)*Tloc**(-1.95_pr)*&
    exp(-(2.1134e+05_pr)/(8.314_pr*Tloc))

  k8b_inf = (3.24056494e+19_pr)*Tloc**(-1.42_pr)*&
    exp(-(2.1845e+05_pr)/(8.314_pr*Tloc))

  FC8b = (2.654e-01_pr)*&
    exp(-Tloc/(9.400e+01_pr)) + (7.346e-01_pr)*&
    exp(-Tloc/(1.756e+03_pr)) + (1.000e+00_pr)*&
    exp(-(5.182e+03_pr)/Tloc)

  k(r8b) =&
    getlindratecoeff&
    (Tloc, k8b_0, k8b_inf, FC8b, M(mM20), Ploc )

  k(r10b) = (4.99294622e+12_pr)*Tloc**(-0.90_pr)*&
    exp(-(2.0482e+05_pr)/(8.314_pr*Tloc))

  k(r11b) = (1.67263698e+13_pr)*Tloc**(-0.80_pr)*&
    exp(-(2.0482e+05_pr)/(8.314_pr*Tloc))

  k(r12b) = (5.34958523e+14_pr)*Tloc**(-1.76_pr)*&
    exp(-(2.0482e+05_pr)/(8.314_pr*Tloc))

  k(r13b) = (1.68492725e+05_pr)*Tloc**(0.43_pr)*&
    exp(-(-1.2281e+04_pr)/(8.314_pr*Tloc))

  k(r14b) = (5.51385118e+07_pr)*Tloc**(0.25_pr)*&
    exp(-(2.9122e+05_pr)/(8.314_pr*Tloc))

  k(r16b) = (1.83581102e+06_pr)*Tloc**(0.33_pr)*&
    exp(-(2.2051e+05_pr)/(8.314_pr*Tloc))

  k(r19b) = (4.24128486e+06_pr)*Tloc**(0.37_pr)*&
    exp(-(2.3285e+05_pr)/(8.314_pr*Tloc))

  k(r20b) = (2.49692694e+04_pr)*Tloc**(0.77_pr)*&
    exp(-(1.5057e+05_pr)/(8.314_pr*Tloc))

  k(r21b) = (2.40987128e+07_pr)*Tloc**(0.49_pr)*&
    exp(-(1.7176e+05_pr)/(8.314_pr*Tloc))

  k(r24b) = (4.00528655e-02_pr)*Tloc**(2.61_pr)*&
    exp(-(8.8594e+04_pr)/(8.314_pr*Tloc))

  k(r28b) = (1.74591685e+03_pr)*Tloc**(1.50_pr)*&
    exp(-(-4.3657e+03_pr)/(8.314_pr*Tloc))

  k(r30b) = (5.05555578e+07_pr)*Tloc**(0.25_pr)*&
    exp(-(9.7325e+04_pr)/(8.314_pr*Tloc))

  k(r39b) = (8.99332189e+00_pr)*Tloc**(2.17_pr)*&
    exp(-(8.8828e+04_pr)/(8.314_pr*Tloc))

  k(r40b) = (2.59168353e+02_pr)*Tloc**(1.46_pr)*&
    exp(-(6.1349e+04_pr)/(8.314_pr*Tloc))

  k(r43b) = (1.33512910e+06_pr)*Tloc**(0.23_pr)*&
    exp(-(4.8634e+04_pr)/(8.314_pr*Tloc))

  k(r46b) = (2.10571310e+07_pr)*Tloc**(-0.06_pr)*&
    exp(-(3.7280e+04_pr)/(8.314_pr*Tloc))

  k49b_0 = (3.26343613e+39_pr)*Tloc**(-7.65_pr)*&
    exp(-(4.0879e+05_pr)/(8.314_pr*Tloc))

  k49b_inf = (2.41736010e+20_pr)*Tloc**(-1.35_pr)*&
    exp(-(3.9582e+05_pr)/(8.314_pr*Tloc))

  FC49b = (8.493e-01_pr)*&
    exp(-Tloc/(1.340e+02_pr)) + (1.507e-01_pr)*&
    exp(-Tloc/(2.383e+03_pr)) + (1.000e+00_pr)*&
    exp(-(7.265e+03_pr)/Tloc)

  k(r49b) =&
    getlindratecoeff&
    (Tloc, k49b_0, k49b_inf, FC49b, M(mM24), Ploc )

  k(r51b) = (2.54675958e+10_pr)*Tloc**(-0.60_pr)*&
    exp(-(6.8380e+04_pr)/(8.314_pr*Tloc))

  k(r54b) = (8.07196807e+11_pr)*Tloc**(-1.08_pr)*&
    exp(-(7.5370e+03_pr)/(8.314_pr*Tloc))

  k(r55b) = (8.62862141e+05_pr)*Tloc**(0.48_pr)*&
    exp(-(-3.4551e+03_pr)/(8.314_pr*Tloc))

  k(r56b) = (2.13924431e-01_pr)*Tloc**(2.51_pr)*&
    exp(-(9.7852e+04_pr)/(8.314_pr*Tloc))

  k(r58b) = (1.35610617e+00_pr)*Tloc**(2.02_pr)*&
    exp(-(5.6505e+04_pr)/(8.314_pr*Tloc))

  k60b_0 = (4.90122083e+52_pr)*Tloc**(-11.11_pr)*&
    exp(-(4.1110e+05_pr)/(8.314_pr*Tloc))

  k60b_inf = (5.87038879e+24_pr)*Tloc**(-2.41_pr)*&
    exp(-(3.8767e+05_pr)/(8.314_pr*Tloc))

  FC60b = (4.675e-01_pr)*&
    exp(-Tloc/(1.510e+02_pr)) + (5.325e-01_pr)*&
    exp(-Tloc/(1.038e+03_pr)) + (1.000e+00_pr)*&
    exp(-(4.970e+03_pr)/Tloc)

  k(r60b) =&
    getlindratecoeff&
    (Tloc, k60b_0, k60b_inf, FC60b, M(mM25), Ploc )

  k(r61b) = (5.04117282e+09_pr)*Tloc**(-0.49_pr)*&
    exp(-(5.8616e+03_pr)/(8.314_pr*Tloc))

  k63b_0 = (1.76486038e+30_pr)*Tloc**(-5.00_pr)*&
    exp(-(4.5275e+05_pr)/(8.314_pr*Tloc))

  k63b_inf = (9.04873914e+18_pr)*Tloc**(-0.87_pr)*&
    exp(-(4.4415e+05_pr)/(8.314_pr*Tloc))

  FC63b = (2.170e-01_pr)*&
    exp(-Tloc/(7.400e+01_pr)) + (7.830e-01_pr)*&
    exp(-Tloc/(2.941e+03_pr)) + (1.000e+00_pr)*&
    exp(-(6.964e+03_pr)/Tloc)

  k(r63b) =&
    getlindratecoeff&
    (Tloc, k63b_0, k63b_inf, FC63b, M(mM8), Ploc )

  k66b_0 = (1.12590783e+38_pr)*Tloc**(-7.18_pr)*&
    exp(-(4.0534e+05_pr)/(8.314_pr*Tloc))

  k66b_inf = (2.62711827e+19_pr)*Tloc**(-0.88_pr)*&
    exp(-(3.9237e+05_pr)/(8.314_pr*Tloc))

  FC66b = (7.895e-01_pr)*&
    exp(-Tloc/(8.350e+01_pr)) + (2.105e-01_pr)*&
    exp(-Tloc/(5.398e+03_pr)) + (1.000e+00_pr)*&
    exp(-(8.370e+03_pr)/Tloc)

  k(r66b) =&
    getlindratecoeff&
    (Tloc, k66b_0, k66b_inf, FC66b, M(mM21), Ploc )

  k(r69b) = (4.83393707e-01_pr)*Tloc**(2.03_pr)*&
    exp(-(5.6362e+04_pr)/(8.314_pr*Tloc))

  k(r70b) = (2.50206078e-01_pr)*Tloc**(2.19_pr)*&
    exp(-(3.6023e+04_pr)/(8.314_pr*Tloc))

  k(r71b) = (4.75851619e-01_pr)*Tloc**(2.05_pr)*&
    exp(-(6.8647e+04_pr)/(8.314_pr*Tloc))

  k(r72b) = (2.34321780e-01_pr)*Tloc**(2.03_pr)*&
    exp(-(1.8777e+04_pr)/(8.314_pr*Tloc))

  k(r73b) = (2.20680425e+06_pr)*Tloc**(-0.03_pr)*&
    exp(-(5.6657e+04_pr)/(8.314_pr*Tloc))

  k75b_0 = (1.21476956e+29_pr)*Tloc**(-5.18_pr)*&
    exp(-(3.2077e+05_pr)/(8.314_pr*Tloc))

  k75b_inf = (2.25793598e+20_pr)*Tloc**(-1.44_pr)*&
    exp(-(3.1266e+05_pr)/(8.314_pr*Tloc))

  FC75b = (4.243e-01_pr)*&
    exp(-Tloc/(2.370e+02_pr)) + (5.757e-01_pr)*&
    exp(-Tloc/(1.652e+03_pr)) + (1.000e+00_pr)*&
    exp(-(5.069e+03_pr)/Tloc)

  k(r75b) =&
    getlindratecoeff&
    (Tloc, k75b_0, k75b_inf, FC75b, M(mM22), Ploc )

  k(r76b) = (2.61671053e+08_pr)*Tloc**(-0.05_pr)*&
    exp(-(1.0977e+05_pr)/(8.314_pr*Tloc))

  k(r77b) = (2.78992031e+10_pr)*Tloc**(-0.84_pr)*&
    exp(-(2.3689e+05_pr)/(8.314_pr*Tloc))

  k(r79b) = (6.31713929e+06_pr)*Tloc**(-0.06_pr)*&
    exp(-(3.7280e+04_pr)/(8.314_pr*Tloc))

  k(r83b) = (2.90963701e+04_pr)*Tloc**(-0.74_pr)*&
    exp(-(5.2387e+03_pr)/(8.314_pr*Tloc))

  k(r85b) = (3.49156441e+05_pr)*Tloc**(-0.74_pr)*&
    exp(-(5.2387e+03_pr)/(8.314_pr*Tloc))

  k(r90b) = (9.08518312e+05_pr)*Tloc**(0.10_pr)*&
    exp(-(2.3851e+03_pr)/(8.314_pr*Tloc))

  k(r91b) = (3.16519836e+01_pr)*Tloc**(1.53_pr)*&
    exp(-(7.7070e+04_pr)/(8.314_pr*Tloc))

  k93b_0 = (2.47624170e+26_pr)*Tloc**(-5.15_pr)*&
    exp(-(1.1766e+05_pr)/(8.314_pr*Tloc))

  k93b_inf = (6.07804782e+13_pr)*Tloc**(0.10_pr)*&
    exp(-(1.0528e+05_pr)/(8.314_pr*Tloc))

  FC93b = (2.420e-01_pr)*&
    exp(-Tloc/(9.400e+01_pr)) + (7.580e-01_pr)*&
    exp(-Tloc/(1.555e+03_pr)) + (1.000e+00_pr)*&
    exp(-(4.200e+03_pr)/Tloc)

  k(r93b) =&
    getlindratecoeff&
    (Tloc, k93b_0, k93b_inf, FC93b, M(mM11), Ploc )

  k(r100b) = (5.94624729e+00_pr)*Tloc**(1.40_pr)*&
    exp(-(3.8592e+04_pr)/(8.314_pr*Tloc))

  k(r102b) = (3.44703140e+02_pr)*Tloc**(0.93_pr)*&
    exp(-(4.2047e+04_pr)/(8.314_pr*Tloc))

  k(r105b) = (2.52553401e-01_pr)*Tloc**(2.38_pr)*&
    exp(-(1.9170e+04_pr)/(8.314_pr*Tloc))

  k(r106b) = (4.75512690e+00_pr)*Tloc**(2.16_pr)*&
    exp(-(6.9991e+04_pr)/(8.314_pr*Tloc))

  k(r107b) = (1.58617102e+03_pr)*Tloc**(1.22_pr)*&
    exp(-(4.9717e+04_pr)/(8.314_pr*Tloc))

  k(r108b) = (4.91333056e+06_pr)*Tloc**(-0.06_pr)*&
    exp(-(3.7280e+04_pr)/(8.314_pr*Tloc))

  k(r112b) = (2.62808926e+01_pr)*Tloc**(1.84_pr)*&
    exp(-(8.9632e+04_pr)/(8.314_pr*Tloc))

  k113b_0 = (1.08961270e+34_pr)*Tloc**(-7.13_pr)*&
    exp(-(1.7718e+05_pr)/(8.314_pr*Tloc))

  k113b_inf = (1.60574503e+12_pr)*Tloc**(0.14_pr)*&
    exp(-(1.5701e+05_pr)/(8.314_pr*Tloc))

  FC113b = (2.493e-01_pr)*&
    exp(-Tloc/(9.850e+01_pr)) + (7.507e-01_pr)*&
    exp(-Tloc/(1.302e+03_pr)) + (1.000e+00_pr)*&
    exp(-(4.167e+03_pr)/Tloc)

  k(r113b) =&
    getlindratecoeff&
    (Tloc, k113b_0, k113b_inf, FC113b, M(mM15), Ploc )

  k(r119b) = (4.61169889e-04_pr)*Tloc**(3.04_pr)*&
    exp(-(1.7677e+04_pr)/(8.314_pr*Tloc))

  k(r120b) = (2.08409256e-01_pr)*Tloc**(1.94_pr)*&
    exp(-(1.4294e+04_pr)/(8.314_pr*Tloc))

  k(r121b) = (1.57276993e-02_pr)*Tloc**(2.39_pr)*&
    exp(-(4.1841e+04_pr)/(8.314_pr*Tloc))

  k124b_0 = (2.77381746e+36_pr)*Tloc**(-7.77_pr)*&
    exp(-(1.8065e+05_pr)/(8.314_pr*Tloc))

  k124b_inf = (2.49643571e+12_pr)*Tloc**(0.30_pr)*&
    exp(-(1.5910e+05_pr)/(8.314_pr*Tloc))

  FC124b = (2.470e-02_pr)*&
    exp(-Tloc/(2.100e+02_pr)) + (9.753e-01_pr)*&
    exp(-Tloc/(9.840e+02_pr)) + (1.000e+00_pr)*&
    exp(-(4.374e+03_pr)/Tloc)

  k(r124b) =&
    getlindratecoeff&
    (Tloc, k124b_0, k124b_inf, FC124b, M(mM17), Ploc )

  k(r125b) = (6.48009707e+05_pr)*Tloc**(0.11_pr)*&
    exp(-(6.9556e+04_pr)/(8.314_pr*Tloc))

  k(r129b) = (7.01143717e-03_pr)*Tloc**(2.58_pr)*&
    exp(-(7.9874e+04_pr)/(8.314_pr*Tloc))

  k(r131b) = (1.81461290e-02_pr)*Tloc**(2.48_pr)*&
    exp(-(4.2820e+04_pr)/(8.314_pr*Tloc))

  k(r132b) = (2.55564546e+00_pr)*Tloc**(1.76_pr)*&
    exp(-(6.4377e+04_pr)/(8.314_pr*Tloc))

  k(r134b) = (1.34398568e+02_pr)*Tloc**(1.54_pr)*&
    exp(-(7.1907e+04_pr)/(8.314_pr*Tloc))

  k(rnog139b) = (2.61279923e+05_pr)*Tloc**(0.09_pr)*&
    exp(-(1.5847e+05_pr)/(8.314_pr*Tloc))

  k(rnog140b) = (3.56154790e+09_pr)*Tloc**(-0.34_pr)*&
    exp(-(2.0897e+05_pr)/(8.314_pr*Tloc))

  k(rnog142b) = (4.44335908e+04_pr)*Tloc**(1.19_pr)*&
    exp(-(1.6654e+05_pr)/(8.314_pr*Tloc))

  k(rnog143b) = (5.66387633e+07_pr)*Tloc**(0.12_pr)*&
    exp(-(1.0300e+05_pr)/(8.314_pr*Tloc))

  k(rnog144b) = (2.60465051e+09_pr)*Tloc**(-0.26_pr)*&
    exp(-(2.9802e+05_pr)/(8.314_pr*Tloc))

  k(rnog145b) = (1.11382787e+01_pr)*Tloc**(1.67_pr)*&
    exp(-(3.1133e+04_pr)/(8.314_pr*Tloc))

  k(rnog146b) = (1.89638478e+10_pr)*Tloc**(-0.64_pr)*&
    exp(-(6.9550e+04_pr)/(8.314_pr*Tloc))

  k(rnog147b) = (2.38036794e+11_pr)*Tloc**(-0.76_pr)*&
    exp(-(7.6524e+04_pr)/(8.314_pr*Tloc))

  k(rnog149b) = (2.58062893e+06_pr)*Tloc**(0.30_pr)*&
    exp(-(6.6027e+04_pr)/(8.314_pr*Tloc))

  k(rnog150b) = (2.73666839e+05_pr)*Tloc**(0.26_pr)*&
    exp(-(4.2881e+04_pr)/(8.314_pr*Tloc))

  k(rnog151b) = (7.28829112e+01_pr)*Tloc**(1.68_pr)*&
    exp(-(1.1376e+05_pr)/(8.314_pr*Tloc))

  k(rnog152b) = (2.14040553e+10_pr)*Tloc**(-0.50_pr)*&
    exp(-(1.1941e+05_pr)/(8.314_pr*Tloc))

  k(rnog155b) = (3.64575666e+08_pr)*Tloc**(-0.07_pr)*&
    exp(-(2.0908e+05_pr)/(8.314_pr*Tloc))

  k(rnog157b) = (6.84553877e+07_pr)*Tloc**(-0.25_pr)*&
    exp(-(2.8561e+04_pr)/(8.314_pr*Tloc))

  k(rnog158b) = (2.49835133e+15_pr)*Tloc**(-1.68_pr)*&
    exp(-(1.5318e+05_pr)/(8.314_pr*Tloc))

  k(rnog161b) = (4.38640543e+14_pr)*Tloc**(-1.97_pr)*&
    exp(-(1.3960e+05_pr)/(8.314_pr*Tloc))

  k(rnog162b) = (5.66511261e+07_pr)*Tloc**(0.12_pr)*&
    exp(-(3.1560e+05_pr)/(8.314_pr*Tloc))

  k(rnog163b) = (3.02083386e+18_pr)*Tloc**(-2.13_pr)*&
    exp(-(3.0798e+05_pr)/(8.314_pr*Tloc))

  k(rnog164b) = (3.34699074e+15_pr)*Tloc**(-1.52_pr)*&
    exp(-(2.0693e+05_pr)/(8.314_pr*Tloc))

  k(rnog167b) = (6.24929213e+14_pr)*Tloc**(-1.92_pr)*&
    exp(-(1.0232e+05_pr)/(8.314_pr*Tloc))

  k(rnog170b) = (3.74987338e+07_pr)*Tloc**(-0.03_pr)*&
    exp(-(4.0796e+05_pr)/(8.314_pr*Tloc))

  k(rnog171b) = (3.25026900e+03_pr)*Tloc**(1.26_pr)*&
    exp(-(2.3214e+05_pr)/(8.314_pr*Tloc))

  k(rnog172b) = (4.76834183e+05_pr)*Tloc**(0.16_pr)*&
    exp(-(5.5391e+04_pr)/(8.314_pr*Tloc))

  k(rnog173b) = (1.09422181e+05_pr)*Tloc**(0.50_pr)*&
    exp(-(2.2150e+05_pr)/(8.314_pr*Tloc))

  k(rnog174b) = (1.17860363e+00_pr)*Tloc**(2.31_pr)*&
    exp(-(2.9033e+05_pr)/(8.314_pr*Tloc))

  k(rnog175b) = (7.58140660e+02_pr)*Tloc**(1.01_pr)*&
    exp(-(1.1885e+05_pr)/(8.314_pr*Tloc))

  k(rnog176b) = (1.10341124e+04_pr)*Tloc**(0.58_pr)*&
    exp(-(1.8893e+05_pr)/(8.314_pr*Tloc))

  k(rnog178b) = (4.51227723e+00_pr)*Tloc**(2.03_pr)*&
    exp(-(5.2660e+04_pr)/(8.314_pr*Tloc))

  k(rnog180b) = (4.13866508e+03_pr)*Tloc**(1.35_pr)*&
    exp(-(2.2391e+04_pr)/(8.314_pr*Tloc))

  k(rnog183b) = (7.84160846e-01_pr)*Tloc**(0.67_pr)*&
    exp(-(-3.2017e+04_pr)/(8.314_pr*Tloc))

  k(rnog186b) = (7.34329077e+01_pr)*Tloc**(1.39_pr)*&
    exp(-(9.8672e+04_pr)/(8.314_pr*Tloc))

  k(rnog189b) = (2.31353700e+06_pr)*Tloc**(0.26_pr)*&
    exp(-(1.5159e+05_pr)/(8.314_pr*Tloc))

  k(rnog191b) = (7.51856937e+05_pr)*Tloc**(0.33_pr)*&
    exp(-(5.9122e+04_pr)/(8.314_pr*Tloc))

  k(rnog192b) = (7.65253513e-04_pr)*Tloc**(1.51_pr)*&
    exp(-(-1.4496e+04_pr)/(8.314_pr*Tloc))

  k(rnog193b) = (1.71729883e-02_pr)*Tloc**(2.52_pr)*&
    exp(-(5.3616e+03_pr)/(8.314_pr*Tloc))

  k(rnog194b) = (1.35255186e-03_pr)*Tloc**(2.95_pr)*&
    exp(-(2.1187e+04_pr)/(8.314_pr*Tloc))

  k(rnog195b) = (6.10911836e-06_pr)*Tloc**(3.24_pr)*&
    exp(-(2.9353e+04_pr)/(8.314_pr*Tloc))

  k(r201b) = (1.05285655e+07_pr)*Tloc**(-0.06_pr)*&
    exp(-(3.9791e+04_pr)/(8.314_pr*Tloc))

  k(r202b) = (6.68698154e+14_pr)*Tloc**(-1.76_pr)*&
    exp(-(2.0482e+05_pr)/(8.314_pr*Tloc))

  k(rnog203b) = (2.21166842e+06_pr)*Tloc**(0.27_pr)*&
    exp(-(2.3589e+05_pr)/(8.314_pr*Tloc))

  k(rnog204b) = (8.18587477e+01_pr)*Tloc**(0.31_pr)*&
    exp(-(3.1064e+04_pr)/(8.314_pr*Tloc))

  k(rnog207b) = (1.63713004e+06_pr)*Tloc**(0.40_pr)*&
    exp(-(4.8434e+04_pr)/(8.314_pr*Tloc))

  k(rnog208b) = (1.68204283e+07_pr)*Tloc**(0.52_pr)*&
    exp(-(5.2919e+05_pr)/(8.314_pr*Tloc))

  k(rnog209b) = (3.22473855e+01_pr)*Tloc**(0.20_pr)*&
    exp(-(5.1904e+04_pr)/(8.314_pr*Tloc))

  k(rnog210b) = (3.10264175e+03_pr)*Tloc**(0.67_pr)*&
    exp(-(1.9499e+05_pr)/(8.314_pr*Tloc))

  k(rnog211b) = (1.99355236e+02_pr)*Tloc**(1.00_pr)*&
    exp(-(3.7260e+05_pr)/(8.314_pr*Tloc))

  knog212b_0 = (1.09495817e-03_pr)*Tloc**(1.14_pr)*&
    exp(-(6.4153e+04_pr)/(8.314_pr*Tloc))

  knog212b_inf = (2.29588004e-01_pr)*Tloc**(1.14_pr)*&
    exp(-(7.8953e+04_pr)/(8.314_pr*Tloc))

  FCnog212b =  + (1.000e+00_pr)*&
    exp(-(0.000e+00_pr)/Tloc)

  k(rnog212b) =&
    getlindratecoeff&
    (Tloc, knog212b_0, knog212b_inf, FCnog212b, M(mM28), Ploc )

  k(rnog214b) = (1.27190698e+02_pr)*Tloc**(1.43_pr)*&
    exp(-(3.3378e+05_pr)/(8.314_pr*Tloc))


END SUBROUTINE get_rate_coefficients


!--------------------------------------------------------------------------------------------------
!     SUBROUTINE get_reaction_rates
!>    @details Subroutine for calculating the reaction rates.
!
!!    @authors T. Jaravel
!!    @date    15-07-2015
!
!     Input:
!            k        Reaction coefficients
!            m        Third-body Concentrations
!            c        Species Concentrations
!            cqss     QSS species Concentrations
!
!     Output:
!            cdot     Species Productions rates (mol/m3/s)
!
!--------------------------------------------------------------------------------------------------
SUBROUTINE get_reaction_rates ( w,k,m,c,cqss )

  IMPLICIT NONE

  REAL(pr), DIMENSION(nspec) :: c
  REAL(pr), DIMENSION(nqss) :: cqss
  REAL(pr), DIMENSION(nreac) :: w,k
  REAL(pr), DIMENSION(31) :: m


  w(r1) = k(r1)  * c(sH)**2_pr  * m(mM38)
  w(r2) = k(r2)  * c(sH)**2_pr  * m(mM5)
  w(r3) = k(r3)  * c(sO)**2_pr  * m(mM1)
  w(r4f) = k(r4f)  * c(sO) * c(sH2)
  w(r5f) = k(r5f)  * c(sH) * c(sOH) * m(mM6)
  w(r6f) = k(r6f)  * c(sOH)**2_pr
  w(r7f) = k(r7f)  * c(sOH) * c(sH2)
  w(r8f) = k(r8f)  * c(sOH)**2_pr
  w(r9) = k(r9)  * c(sH)**2_pr  * c(sH2O)
  w(r10f) = k(r10f)  * c(sH) * c(sO2) * m(mM4)
  w(r11f) = k(r11f)  * c(sH) * c(sO2) * c(sH2O)
  w(r12f) = k(r12f)  * c(sH) * c(sO2) * m(mM37)
  w(r13f) = k(r13f)  * c(sH) * c(sO2)
  w(r14f) = k(r14f)  * c(sOH) * c(sHO2)
  w(r15) = k(r15)  * c(sH) * c(sHO2)
  w(r16f) = k(r16f)  * c(sO) * c(sHO2)
  w(r17) = k(r17)  * c(sHO2)**2_pr
  w(r18) = k(r18)  * c(sHO2)**2_pr
  w(r19f) = k(r19f)  * c(sH) * c(sHO2)
  w(r20f) = k(r20f)  * c(sH) * c(sHO2)
  w(r21f) = k(r21f)  * c(sOH) * c(sH2O2)
  w(r22) = k(r22)  * c(sOH) * c(sH2O2)
  w(r23) = k(r23)  * c(sO) * c(sH2O2)
  w(r24f) = k(r24f)  * c(sH) * c(sH2O2)
  w(r25) = k(r25)  * c(sH) * c(sH2O2)
  w(r26) = k(r26)  * cqss(sC-nspec) * c(sO2)
  w(r27) = k(r27)  * c(sOH) * cqss(sC-nspec)
  w(r28f) = k(r28f)  * cqss(sCH-nspec) * c(sH2)
  w(r29) = k(r29)  * c(sO) * cqss(sCH-nspec)
  w(r30f) = k(r30f)  * c(sH) * cqss(sCH-nspec)
  w(r31) = k(r31)  * cqss(sCH-nspec) * c(sO2)
  w(r32) = k(r32)  * c(sOH) * cqss(sCH-nspec)
  w(r33) = k(r33)  * cqss(sCH-nspec) * c(sH2O)
  w(r36) = k(r36)  * c(sHO2) * cqss(sCH2-nspec)
  w(r37) = k(r37)  * c(sOH) * cqss(sCH2-nspec)
  w(r38) = k(r38)  * c(sO) * cqss(sCH2-nspec)
  w(r39f) = k(r39f)  * c(sOH) * cqss(sCH2-nspec)
  w(r40f) = k(r40f)  * cqss(sCH2-nspec) * c(sH2)
  w(r41) = k(r41)  * c(sH) * cqss(sCH2-nspec)
  w(r42) = k(r42)  * cqss(sCH2-nspec) * c(sO2)
  w(r43f) = k(r43f)  * c(sH) * cqss(s1XCH2-nspec)
  w(r44) = k(r44)  * cqss(s1XCH2-nspec) * c(sO2)
  w(r45) = k(r45)  * c(sOH) * cqss(s1XCH2-nspec)
  w(r46f) = k(r46f)  * cqss(s1XCH2-nspec) * c(sH2O)
  w(r47) = k(r47)  * c(sO) * cqss(s1XCH2-nspec)
  w(r48) = k(r48)  * c(sO) * cqss(s1XCH2-nspec)
  w(r49f) = k(r49f)  * cqss(s1XCH2-nspec) * c(sH2O)
  w(r50) = k(r50)  * cqss(s1XCH2-nspec) * c(sO2)
  w(r51f) = k(r51f)  * cqss(s1XCH2-nspec) * c(sH2)
  w(r52) = k(r52)  * c(sHO2) * c(sCH3)
  w(r53) = k(r53)  * cqss(sC-nspec) * c(sCH3)
  w(r54f) = k(r54f)  * c(sCH3)**2_pr
  w(r55f) = k(r55f)  * c(sOH) * c(sCH3)
  w(r56f) = k(r56f)  * c(sCH3) * c(sH2O2)
  w(r57) = k(r57)  * cqss(sCH-nspec) * c(sCH3)
  w(r58f) = k(r58f)  * c(sOH) * c(sCH3)
  w(r59) = k(r59)  * c(sO) * c(sCH3)
  w(r60f) = k(r60f)  * c(sCH3)**2_pr
  w(r61f) = k(r61f)  * c(sCH3) * c(sO2)
  w(r62) = k(r62)  * c(sCH3) * c(sO2)
  w(r63f) = k(r63f)  * c(sH) * c(sCH3)
  w(r64) = k(r64)  * cqss(sCH2-nspec) * c(sCH3)
  w(r65) = k(r65)  * cqss(s1XCH2-nspec) * c(sCH3)
  w(r66f) = k(r66f)  * c(sOH) * c(sCH3)
  w(r67) = k(r67)  * c(sHO2) * c(sCH3)
  w(r68) = k(r68)  * cqss(sCH-nspec) * c(sCH4)
  w(r69f) = k(r69f)  * cqss(sCH2-nspec) * c(sCH4)
  w(r70f) = k(r70f)  * c(sH) * c(sCH4)
  w(r71f) = k(r71f)  * c(sOH) * c(sCH4)
  w(r72f) = k(r72f)  * c(sO) * c(sCH4)
  w(r73f) = k(r73f)  * cqss(s1XCH2-nspec) * c(sCH4)
  w(r74) = k(r74)  * c(sHO2) * c(sCO)
  w(r75f) = k(r75f)  * cqss(sCH-nspec) * c(sCO)
  w(r76f) = k(r76f)  * c(sOH) * c(sCO)
  w(r77f) = k(r77f)  * c(sO2) * c(sCO)
  w(r78) = k(r78)  * c(sO) * c(sCO) * m(mM3)
  w(r79f) = k(r79f)  * cqss(s1XCH2-nspec) * c(sCO)
  w(r80) = k(r80)  * c(sO) * cqss(sHCO-nspec)
  w(r81) = k(r81)  * c(sH) * cqss(sHCO-nspec)
  w(r82) = k(r82)  * c(sO) * cqss(sHCO-nspec)
  w(r83f) = k(r83f)  * cqss(sHCO-nspec) * m(mM26)
  w(r84) = k(r84)  * c(sOH) * cqss(sHCO-nspec)
  w(r85f) = k(r85f)  * cqss(sHCO-nspec) * c(sH2O)
  w(r86) = k(r86)  * cqss(sHCO-nspec) * c(sO2)
  w(r87) = k(r87)  * c(sCH3) * cqss(sHCO-nspec)
  w(r88) = k(r88)  * c(sHO2) * c(sCH2O)
  w(r89) = k(r89)  * c(sOH) * c(sCH2O)
  w(r90f) = k(r90f)  * c(sO2) * c(sCH2O)
  w(r91f) = k(r91f)  * c(sH) * c(sCH2O)
  w(r92) = k(r92)  * c(sO) * c(sCH2O)
  w(r93f) = k(r93f)  * c(sH) * c(sCH2O)
  w(r94) = k(r94)  * c(sCH2O)
  w(r95) = k(r95)  * c(sCH3) * c(sCH2O)
  w(r96) = k(r96)  * c(sCH2O)
  w(r97) = k(r97)  * c(sH) * cqss(sCH3O-nspec)
  w(r98) = k(r98)  * c(sH) * cqss(sCH3O-nspec)
  w(r99) = k(r99)  * c(sOH) * cqss(sCH3O-nspec)
  w(r100f) = k(r100f)  * c(sH) * cqss(sCH3O-nspec)
  w(r101) = k(r101)  * cqss(sCH3O-nspec) * c(sO2)
  w(r102f) = k(r102f)  * c(sH) * cqss(sCH3O-nspec)
  w(r103) = k(r103)  * c(sO) * cqss(sCH3O-nspec)
  w(r104) = k(r104)  * c(sO) * c(sCH3OH)
  w(r105f) = k(r105f)  * c(sH) * c(sCH3OH)
  w(r106f) = k(r106f)  * c(sOH) * c(sCH3OH)
  w(r107f) = k(r107f)  * c(sCH3) * c(sCH3OH)
  w(r108f) = k(r108f)  * cqss(s1XCH2-nspec) * c(sCO2)
  w(r109) = k(r109)  * cqss(sCH-nspec) * c(sCO2)
  w(r110) = k(r110)  * cqss(s1XCH2-nspec) * c(sCO2)
  w(r111) = k(r111)  * c(sOH) * c(sC2H2)
  w(r112f) = k(r112f)  * c(sO) * c(sC2H2)
  w(r113f) = k(r113f)  * c(sH) * c(sC2H2)
  w(r114) = k(r114)  * c(sO) * c(sC2H2)
  w(r115) = k(r115)  * cqss(sC2H3-nspec) * c(sO2)
  w(r116) = k(r116)  * c(sH) * cqss(sC2H3-nspec)
  w(r117) = k(r117)  * c(sOH) * cqss(sC2H3-nspec)
  w(r118) = k(r118)  * c(sH) * cqss(sC2H3-nspec)
  w(r119f) = k(r119f)  * c(sH) * c(sC2H4)
  w(r120f) = k(r120f)  * c(sCH3) * c(sC2H4)
  w(r121f) = k(r121f)  * c(sOH) * c(sC2H4)
  w(r122) = k(r122)  * c(sC2H4)
  w(r123) = k(r123)  * c(sO) * c(sC2H4)
  w(r124f) = k(r124f)  * c(sH) * c(sC2H4)
  w(r125f) = k(r125f)  * cqss(sC2H5-nspec) * c(sO2)
  w(r126) = k(r126)  * c(sH) * cqss(sC2H5-nspec)
  w(r127) = k(r127)  * c(sH) * cqss(sC2H5-nspec)
  w(r128) = k(r128)  * c(sO) * cqss(sC2H5-nspec)
  w(r129f) = k(r129f)  * c(sOH) * c(sC2H6)
  w(r130) = k(r130)  * c(sO) * c(sC2H6)
  w(r131f) = k(r131f)  * c(sH) * c(sC2H6)
  w(r132f) = k(r132f)  * c(sCH3) * c(sC2H6)
  w(r133) = k(r133)  * cqss(s1XCH2-nspec) * c(sC2H6)
  w(r134f) = k(r134f)  * c(sH) * cqss(sHCCO-nspec)
  w(r135) = k(r135)  * cqss(sHCCO-nspec) * c(sO2)
  w(r138) = k(r138)  * c(sO) * cqss(sHCCO-nspec)
  w(rnog139f) = k(rnog139f)  * cqss(sN-nspec) * c(sO2)
  w(rnog140f) = k(rnog140f)  * cqss(sN-nspec) * c(sOH)
  w(rnog141) = k(rnog141)  * c(sCH3) * cqss(sN-nspec)
  w(rnog142f) = k(rnog142f)  * cqss(sNH-nspec) * c(sOH)
  w(rnog143f) = k(rnog143f)  * cqss(sNH-nspec) * c(sH)
  w(rnog144f) = k(rnog144f)  * cqss(sNH-nspec) * c(sO)
  w(rnog145f) = k(rnog145f)  * cqss(sNH-nspec) * c(sO2)
  w(rnog146f) = k(rnog146f)  * cqss(sNH-nspec) * c(sH2O)
  w(rnog147f) = k(rnog147f)  * cqss(sNH-nspec) * c(sOH)
  w(rnog148) = k(rnog148)  * cqss(sNH-nspec) * c(sO2)
  w(rnog149f) = k(rnog149f)  * cqss(sNH2-nspec) * c(sH)
  w(rnog150f) = k(rnog150f)  * cqss(sNH2-nspec) * c(sO)
  w(rnog151f) = k(rnog151f)  * cqss(sNH2-nspec) * c(sOH)
  w(rnog152f) = k(rnog152f)  * cqss(sNH2-nspec) * c(sO)
  w(rnog153) = k(rnog153)  * cqss(sCH-nspec) * c(sNO)
  w(rnog154) = k(rnog154)  * cqss(sCH2-nspec) * c(sNO)
  w(rnog155f) = k(rnog155f)  * cqss(sHCCO-nspec) * c(sNO)
  w(rnog156) = k(rnog156)  * cqss(s1XCH2-nspec) * c(sNO)
  w(rnog157f) = k(rnog157f)  * c(sHO2) * c(sNO)
  w(rnog158f) = k(rnog158f)  * cqss(sNH-nspec) * c(sNO)
  w(rnog159) = k(rnog159)  * cqss(sCH-nspec) * c(sNO)
  w(rnog160) = k(rnog160)  * cqss(sCH-nspec) * c(sNO)
  w(rnog161f) = k(rnog161f)  * cqss(s1XCH2-nspec) * c(sNO)
  w(rnog162f) = k(rnog162f)  * cqss(sN-nspec) * c(sNO)
  w(rnog163f) = k(rnog163f)  * c(sNO) * c(sO) * m(mM29)
  w(rnog164f) = k(rnog164f)  * c(sH) * c(sNO) * m(mM31)
  w(rnog165) = k(rnog165)  * cqss(sC-nspec) * c(sNO)
  w(rnog166) = k(rnog166)  * cqss(sCH2-nspec) * c(sNO)
  w(rnog167f) = k(rnog167f)  * cqss(sCH2-nspec) * c(sNO)
  w(rnog168) = k(rnog168)  * c(sCH3) * c(sNO)
  w(rnog169) = k(rnog169)  * cqss(s1XCH2-nspec) * c(sNO)
  w(rnog170f) = k(rnog170f)  * cqss(sNH-nspec) * c(sNO)
  w(rnog171f) = k(rnog171f)  * cqss(sHNO-nspec) * c(sH)
  w(rnog172f) = k(rnog172f)  * cqss(sHNO-nspec) * c(sO2)
  w(rnog173f) = k(rnog173f)  * cqss(sHNO-nspec) * c(sO)
  w(rnog174f) = k(rnog174f)  * cqss(sHNO-nspec) * c(sOH)
  w(rnog175f) = k(rnog175f)  * c(sNO2) * c(sH)
  w(rnog176f) = k(rnog176f)  * c(sNO2) * c(sO)
  w(rnog177) = k(rnog177)  * c(sHCN) * c(sOH)
  w(rnog178f) = k(rnog178f)  * c(sHCN) * c(sO)
  w(rnog179) = k(rnog179)  * c(sHCN) * c(sOH)
  w(rnog180f) = k(rnog180f)  * c(sHCN) * c(sOH)
  w(rnog181) = k(rnog181)  * c(sHCN) * c(sO)
  w(rnog182) = k(rnog182)  * cqss(sNCO-nspec) * c(sO2)
  w(rnog183f) = k(rnog183f)  * cqss(sNCO-nspec) * m(mM32)
  w(rnog184) = k(rnog184)  * cqss(sNCO-nspec) * c(sO)
  w(rnog185) = k(rnog185)  * cqss(sNCO-nspec) * c(sNO)
  w(rnog186f) = k(rnog186f)  * cqss(sNCO-nspec) * c(sH)
  w(rnog187) = k(rnog187)  * cqss(sNCO-nspec) * c(sOH)
  w(rnog188) = k(rnog188)  * cqss(sNCO-nspec) * c(sNO)
  w(rnog189f) = k(rnog189f)  * cqss(sHNCO-nspec) * c(sOH)
  w(rnog190) = k(rnog190)  * cqss(sHNCO-nspec) * c(sO)
  w(rnog191f) = k(rnog191f)  * cqss(sHNCO-nspec) * c(sOH)
  w(rnog192f) = k(rnog192f)  * cqss(sHNCO-nspec) * m(mM36)
  w(rnog193f) = k(rnog193f)  * cqss(sHNCO-nspec) * c(sO)
  w(rnog194f) = k(rnog194f)  * cqss(sHNCO-nspec) * c(sH)
  w(rnog195f) = k(rnog195f)  * cqss(sHNCO-nspec) * c(sH)
  w(rnog196) = k(rnog196)  * cqss(sHCNO-nspec) * c(sH)
  w(rnog197) = k(rnog197)  * cqss(sHCNO-nspec) * c(sH)
  w(rnog198) = k(rnog198)  * cqss(sHCNO-nspec) * c(sH)
  w(rnog199) = k(rnog199)  * cqss(sHOCN-nspec) * c(sH)
  w(rnog200) = k(rnog200)  * cqss(sCH-nspec) * c(sN2)
  w(r201f) = k(r201f)  * cqss(s1XCH2-nspec) * c(sN2)
  w(r202f) = k(r202f)  * c(sH) * c(sO2) * c(sN2)
  w(rnog203f) = k(rnog203f)  * cqss(sNNH-nspec) * c(sO2)
  w(rnog204f) = k(rnog204f)  * cqss(sNNH-nspec)
  w(rnog205) = k(rnog205)  * cqss(sNNH-nspec) * c(sO)
  w(rnog206) = k(rnog206)  * cqss(sNNH-nspec) * c(sH)
  w(rnog207f) = k(rnog207f)  * cqss(sNNH-nspec) * c(sO)
  w(rnog208f) = k(rnog208f)  * cqss(sNNH-nspec) * c(sOH)
  w(rnog209f) = k(rnog209f)  * cqss(sNNH-nspec) * m(mM30)
  w(rnog210f) = k(rnog210f)  * c(sN2O) * c(sOH)
  w(rnog211f) = k(rnog211f)  * c(sN2O) * c(sO)
  w(rnog212f) = k(rnog212f)  * c(sN2O)
  w(rnog213) = k(rnog213)  * c(sN2O) * c(sO)
  w(rnog214f) = k(rnog214f)  * c(sN2O) * c(sH)
  w(r4b) = k(r4b)  * c(sH) * c(sOH)
  w(r5b) = k(r5b)  * c(sH2O) * m(mM6)
  w(r6b) = k(r6b)  * c(sO) * c(sH2O)
  w(r7b) = k(r7b)  * c(sH) * c(sH2O)
  w(r8b) = k(r8b)  * c(sH2O2)
  w(r10b) = k(r10b)  * c(sHO2) * m(mM4)
  w(r11b) = k(r11b)  * c(sHO2) * c(sH2O)
  w(r12b) = k(r12b)  * c(sHO2) * m(mM37)
  w(r13b) = k(r13b)  * c(sO) * c(sOH)
  w(r14b) = k(r14b)  * c(sO2) * c(sH2O)
  w(r16b) = k(r16b)  * c(sOH) * c(sO2)
  w(r19b) = k(r19b)  * c(sO2) * c(sH2)
  w(r20b) = k(r20b)  * c(sOH)**2_pr
  w(r21b) = k(r21b)  * c(sHO2) * c(sH2O)
  w(r24b) = k(r24b)  * c(sHO2) * c(sH2)
  w(r28b) = k(r28b)  * c(sH) * cqss(sCH2-nspec)
  w(r30b) = k(r30b)  * cqss(sC-nspec) * c(sH2)
  w(r39b) = k(r39b)  * cqss(sCH-nspec) * c(sH2O)
  w(r40b) = k(r40b)  * c(sH) * c(sCH3)
  w(r43b) = k(r43b)  * cqss(sCH-nspec) * c(sH2)
  w(r46b) = k(r46b)  * cqss(sCH2-nspec) * c(sH2O)
  w(r49b) = k(r49b)  * c(sCH3OH)
  w(r51b) = k(r51b)  * c(sCH3) * c(sH)
  w(r54b) = k(r54b)  * c(sH) * cqss(sC2H5-nspec)
  w(r55b) = k(r55b)  * cqss(s1XCH2-nspec) * c(sH2O)
  w(r56b) = k(r56b)  * c(sHO2) * c(sCH4)
  w(r58b) = k(r58b)  * cqss(sCH2-nspec) * c(sH2O)
  w(r60b) = k(r60b)  * c(sC2H6)
  w(r61b) = k(r61b)  * c(sO) * cqss(sCH3O-nspec)
  w(r63b) = k(r63b)  * c(sCH4)
  w(r66b) = k(r66b)  * c(sCH3OH)
  w(r69b) = k(r69b)  * c(sCH3)**2_pr
  w(r70b) = k(r70b)  * c(sCH3) * c(sH2)
  w(r71b) = k(r71b)  * c(sCH3) * c(sH2O)
  w(r72b) = k(r72b)  * c(sOH) * c(sCH3)
  w(r73b) = k(r73b)  * c(sCH3)**2_pr
  w(r75b) = k(r75b)  * cqss(sHCCO-nspec)
  w(r76b) = k(r76b)  * c(sH) * c(sCO2)
  w(r77b) = k(r77b)  * c(sO) * c(sCO2)
  w(r79b) = k(r79b)  * cqss(sCH2-nspec) * c(sCO)
  w(r83b) = k(r83b)  * c(sH) * c(sCO) * m(mM26)
  w(r85b) = k(r85b)  * c(sH) * c(sCO) * c(sH2O)
  w(r90b) = k(r90b)  * c(sHO2) * cqss(sHCO-nspec)
  w(r91b) = k(r91b)  * cqss(sHCO-nspec) * c(sH2)
  w(r93b) = k(r93b)  * cqss(sCH3O-nspec)
  w(r100b) = k(r100b)  * cqss(s1XCH2-nspec) * c(sH2O)
  w(r102b) = k(r102b)  * c(sOH) * c(sCH3)
  w(r105b) = k(r105b)  * cqss(sCH3O-nspec) * c(sH2)
  w(r106b) = k(r106b)  * cqss(sCH3O-nspec) * c(sH2O)
  w(r107b) = k(r107b)  * cqss(sCH3O-nspec) * c(sCH4)
  w(r108b) = k(r108b)  * cqss(sCH2-nspec) * c(sCO2)
  w(r112b) = k(r112b)  * c(sH) * cqss(sHCCO-nspec)
  w(r113b) = k(r113b)  * cqss(sC2H3-nspec)
  w(r119b) = k(r119b)  * cqss(sC2H3-nspec) * c(sH2)
  w(r120b) = k(r120b)  * cqss(sC2H3-nspec) * c(sCH4)
  w(r121b) = k(r121b)  * cqss(sC2H3-nspec) * c(sH2O)
  w(r124b) = k(r124b)  * cqss(sC2H5-nspec)
  w(r125b) = k(r125b)  * c(sHO2) * c(sC2H4)
  w(r129b) = k(r129b)  * cqss(sC2H5-nspec) * c(sH2O)
  w(r131b) = k(r131b)  * cqss(sC2H5-nspec) * c(sH2)
  w(r132b) = k(r132b)  * cqss(sC2H5-nspec) * c(sCH4)
  w(r134b) = k(r134b)  * cqss(s1XCH2-nspec) * c(sCO)
  w(rnog139b) = k(rnog139b)  * c(sNO) * c(sO)
  w(rnog140b) = k(rnog140b)  * c(sNO) * c(sH)
  w(rnog142b) = k(rnog142b)  * cqss(sN-nspec) * c(sH2O)
  w(rnog143b) = k(rnog143b)  * cqss(sN-nspec) * c(sH2)
  w(rnog144b) = k(rnog144b)  * c(sNO) * c(sH)
  w(rnog145b) = k(rnog145b)  * cqss(sHNO-nspec) * c(sO)
  w(rnog146b) = k(rnog146b)  * cqss(sHNO-nspec) * c(sH2)
  w(rnog147b) = k(rnog147b)  * cqss(sHNO-nspec) * c(sH)
  w(rnog149b) = k(rnog149b)  * cqss(sNH-nspec) * c(sH2)
  w(rnog150b) = k(rnog150b)  * c(sOH) * cqss(sNH-nspec)
  w(rnog151b) = k(rnog151b)  * cqss(sNH-nspec) * c(sH2O)
  w(rnog152b) = k(rnog152b)  * c(sH) * cqss(sHNO-nspec)
  w(rnog155b) = k(rnog155b)  * cqss(sHCNO-nspec) * c(sCO)
  w(rnog157b) = k(rnog157b)  * c(sNO2) * c(sOH)
  w(rnog158b) = k(rnog158b)  * c(sN2O) * c(sH)
  w(rnog161b) = k(rnog161b)  * c(sH) * cqss(sHCNO-nspec)
  w(rnog162b) = k(rnog162b)  * c(sN2) * c(sO)
  w(rnog163b) = k(rnog163b)  * c(sNO2) * m(mM29)
  w(rnog164b) = k(rnog164b)  * cqss(sHNO-nspec) * m(mM31)
  w(rnog167b) = k(rnog167b)  * c(sH) * cqss(sHCNO-nspec)
  w(rnog170b) = k(rnog170b)  * c(sN2) * c(sOH)
  w(rnog171b) = k(rnog171b)  * c(sH2) * c(sNO)
  w(rnog172b) = k(rnog172b)  * c(sHO2) * c(sNO)
  w(rnog173b) = k(rnog173b)  * c(sNO) * c(sOH)
  w(rnog174b) = k(rnog174b)  * c(sNO) * c(sH2O)
  w(rnog175b) = k(rnog175b)  * c(sNO) * c(sOH)
  w(rnog176b) = k(rnog176b)  * c(sNO) * c(sO2)
  w(rnog178b) = k(rnog178b)  * cqss(sNCO-nspec) * c(sH)
  w(rnog180b) = k(rnog180b)  * cqss(sHOCN-nspec) * c(sH)
  w(rnog183b) = k(rnog183b)  * cqss(sN-nspec) * c(sCO) * m(mM32)
  w(rnog186b) = k(rnog186b)  * cqss(sNH-nspec) * c(sCO)
  w(rnog189b) = k(rnog189b)  * cqss(sNH2-nspec) * c(sCO2)
  w(rnog191b) = k(rnog191b)  * cqss(sNCO-nspec) * c(sH2O)
  w(rnog192b) = k(rnog192b)  * cqss(sNH-nspec) * c(sCO) * m(mM36)
  w(rnog193b) = k(rnog193b)  * cqss(sNCO-nspec) * c(sOH)
  w(rnog194b) = k(rnog194b)  * c(sH2) * cqss(sNCO-nspec)
  w(rnog195b) = k(rnog195b)  * cqss(sNH2-nspec) * c(sCO)
  w(r201b) = k(r201b)  * cqss(sCH2-nspec) * c(sN2)
  w(r202b) = k(r202b)  * c(sHO2) * c(sN2)
  w(rnog203b) = k(rnog203b)  * c(sHO2) * c(sN2)
  w(rnog204b) = k(rnog204b)  * c(sN2) * c(sH)
  w(rnog207b) = k(rnog207b)  * cqss(sNH-nspec) * c(sNO)
  w(rnog208b) = k(rnog208b)  * c(sH2O) * c(sN2)
  w(rnog209b) = k(rnog209b)  * c(sN2) * c(sH) * m(mM30)
  w(rnog210b) = k(rnog210b)  * c(sN2) * c(sHO2)
  w(rnog211b) = k(rnog211b)  * c(sN2) * c(sO2)
  w(rnog212b) = k(rnog212b)  * c(sN2) * c(sO)
  w(rnog214b) = k(rnog214b)  * c(sN2) * c(sOH)


END SUBROUTINE get_reaction_rates


!--------------------------------------------------------------------------------------------------
!     SUBROUTINE get_production_rates
!>    @details Subroutine for calculating the final production rates for the
!              transported species.
!
!!    @authors T. Jaravel
!!    @date    15-07-2015
!
!     Input:
!            w        Reaction rates (mol/m3/s)
!
!     Output:
!            cdot     Species Productions rates (mol/m3/s)
!
!--------------------------------------------------------------------------------------------------
SUBROUTINE get_production_rates ( cdot,w )

  IMPLICIT NONE

  REAL(pr), DIMENSION(nspec) :: cdot
  REAL(pr), DIMENSION(nreac) :: w


  cdot(sN2) = 0.0_pr +&
   w(rnog162f) +&
   w(rnog170f) +&
   w(rnog188) -&
   w(rnog200) -&
   w(r201f) +&
   w(r201f) -&
   w(r202f) +&
   w(r202f) +&
   w(rnog203f) +&
   w(rnog204f) +&
   w(rnog205) +&
   w(rnog206) +&
   w(rnog208f) +&
   w(rnog209f) +&
   w(rnog210f) +&
   w(rnog211f) +&
   w(rnog212f) +&
   w(rnog214f) -&
   w(rnog162b) -&
   w(rnog170b) -&
   w(r201b) +&
   w(r201b) -&
   w(r202b) +&
   w(r202b) -&
   w(rnog203b) -&
   w(rnog204b) -&
   w(rnog208b) -&
   w(rnog209b) -&
   w(rnog210b) -&
   w(rnog211b) -&
   w(rnog212b) -&
   w(rnog214b)


  cdot(sH) = 0.0_pr - 2_pr *&
   w(r1) - 2_pr *&
   w(r2) +&
   w(r4f) -&
   w(r5f) +&
   w(r7f) - 2_pr *&
   w(r9) -&
   w(r10f) -&
   w(r11f) -&
   w(r12f) -&
   w(r13f) -&
   w(r15) -&
   w(r19f) -&
   w(r20f) -&
   w(r24f) -&
   w(r25) +&
   w(r27) +&
   w(r28f) +&
   w(r29) -&
   w(r30f) +&
   w(r32) +&
   w(r33) +&
   w(r37) +&
   w(r38) +&
   w(r40f) -&
   w(r41) -&
   w(r43f) +&
   w(r45) +&
   w(r47) +&
   w(r50) +&
   w(r51f) +&
   w(r53) +&
   w(r54f) +&
   w(r57) +&
   w(r59) -&
   w(r63f) +&
   w(r64) +&
   w(r65) +&
   w(r68) -&
   w(r70f) +&
   w(r76f) -&
   w(r81) +&
   w(r82) +&
   w(r83f) +&
   w(r85f) -&
   w(r91f) -&
   w(r93f) +&
   w(r94) -&
   w(r97) -&
   w(r98) -&
   w(r100f)
  cdot(sH) = cdot(sH) -&
       w(r102f) -&
       w(r105f) +&
       w(r112f) -&
       w(r113f) -&
       w(r116) -&
       w(r118) -&
       w(r119f) -&
       w(r124f) -&
       w(r126) -&
       w(r127) -&
       w(r131f) -&
       w(r134f) +&
       w(r138) +&
       w(rnog140f) -&
       w(rnog143f) +&
       w(rnog144f) +&
       w(rnog147f) -&
       w(rnog149f) +&
       w(rnog152f) +&
       w(rnog153) +&
       w(rnog158f) +&
       w(rnog161f) -&
       w(rnog164f) +&
       w(rnog166) +&
       w(rnog167f) +&
       w(rnog169) -&
       w(rnog171f) -&
       w(rnog175f) +&
       w(rnog178f) +&
       w(rnog179) +&
       w(rnog180f) -&
       w(rnog186f) +&
       w(rnog187) -&
       w(rnog194f) -&
       w(rnog195f) -&
       w(rnog196) -&
       w(rnog197) -&
       w(rnog198) +&
       w(rnog198) -&
       w(rnog199) +&
       w(rnog199) -&
       w(r202f) +&
       w(rnog204f) -&
       w(rnog206) +&
       w(rnog209f) -&
       w(rnog214f) -&
       w(r4b) +&
       w(r5b) -&
       w(r7b) +&
       w(r10b)
  cdot(sH) = cdot(sH) +&
       w(r11b) +&
       w(r12b) +&
       w(r13b) +&
       w(r19b) +&
       w(r20b) +&
       w(r24b) -&
       w(r28b) +&
       w(r30b) -&
       w(r40b) +&
       w(r43b) -&
       w(r51b) -&
       w(r54b) +&
       w(r63b) +&
       w(r70b) -&
       w(r76b) -&
       w(r83b) -&
       w(r85b) +&
       w(r91b) +&
       w(r93b) +&
       w(r100b) +&
       w(r102b) +&
       w(r105b) -&
       w(r112b) +&
       w(r113b) +&
       w(r119b) +&
       w(r124b) +&
       w(r131b) +&
       w(r134b) -&
       w(rnog140b) +&
       w(rnog143b) -&
       w(rnog144b) -&
       w(rnog147b) +&
       w(rnog149b) -&
       w(rnog152b) -&
       w(rnog158b) -&
       w(rnog161b) +&
       w(rnog164b) -&
       w(rnog167b) +&
       w(rnog171b) +&
       w(rnog175b) -&
       w(rnog178b) -&
       w(rnog180b) +&
       w(rnog186b) +&
       w(rnog194b) +&
       w(rnog195b) +&
       w(r202b) -&
       w(rnog204b) -&
       w(rnog209b) +&
       w(rnog214b)


  cdot(sH2) = 0.0_pr +&
   w(r1) +&
   w(r2) -&
   w(r4f) -&
   w(r7f) +&
   w(r9) +&
   w(r19f) +&
   w(r24f) -&
   w(r28f) +&
   w(r30f) -&
   w(r40f) +&
   w(r43f) +&
   w(r48) -&
   w(r51f) +&
   w(r70f) +&
   w(r81) +&
   w(r91f) +&
   w(r96) +&
   w(r97) +&
   w(r105f) +&
   w(r118) +&
   w(r119f) +&
   w(r122) +&
   w(r126) +&
   w(r131f) +&
   w(rnog141) +&
   w(rnog143f) +&
   w(rnog146f) +&
   w(rnog149f) +&
   w(rnog171f) +&
   w(rnog194f) +&
   w(rnog206) +&
   w(r4b) +&
   w(r7b) -&
   w(r19b) -&
   w(r24b) +&
   w(r28b) -&
   w(r30b) +&
   w(r40b) -&
   w(r43b) +&
   w(r51b) -&
   w(r70b) -&
   w(r91b) -&
   w(r105b) -&
   w(r119b) -&
   w(r131b) -&
   w(rnog143b) -&
   w(rnog146b) -&
   w(rnog149b) -&
   w(rnog171b) -&
   w(rnog194b)
  cdot(sH2) = cdot(sH2)


  cdot(sO) = 0.0_pr - 2_pr *&
   w(r3) -&
   w(r4f) +&
   w(r6f) +&
   w(r13f) +&
   w(r15) -&
   w(r16f) -&
   w(r23) +&
   w(r26) -&
   w(r29) +&
   w(r31) -&
   w(r38) -&
   w(r47) -&
   w(r48) -&
   w(r59) +&
   w(r61f) -&
   w(r72f) +&
   w(r77f) -&
   w(r78) -&
   w(r80) -&
   w(r82) -&
   w(r92) -&
   w(r103) -&
   w(r104) -&
   w(r112f) -&
   w(r114) -&
   w(r123) -&
   w(r128) -&
   w(r130) -&
   w(r138) +&
   w(rnog139f) -&
   w(rnog144f) +&
   w(rnog145f) -&
   w(rnog150f) -&
   w(rnog152f) +&
   w(rnog159) +&
   w(rnog162f) -&
   w(rnog163f) -&
   w(rnog173f) -&
   w(rnog176f) -&
   w(rnog178f) -&
   w(rnog181) -&
   w(rnog184) -&
   w(rnog190) -&
   w(rnog193f) -&
   w(rnog205) -&
   w(rnog207f) -&
   w(rnog211f) +&
   w(rnog212f) -&
   w(rnog213) +&
   w(r4b)
  cdot(sO) = cdot(sO) -&
       w(r6b) -&
       w(r13b) +&
       w(r16b) -&
       w(r61b) +&
       w(r72b) -&
       w(r77b) +&
       w(r112b) -&
       w(rnog139b) +&
       w(rnog144b) -&
       w(rnog145b) +&
       w(rnog150b) +&
       w(rnog152b) -&
       w(rnog162b) +&
       w(rnog163b) +&
       w(rnog173b) +&
       w(rnog176b) +&
       w(rnog178b) +&
       w(rnog193b) +&
       w(rnog207b) +&
       w(rnog211b) -&
       w(rnog212b)


  cdot(sO2) = 0.0_pr +&
   w(r3) -&
   w(r10f) -&
   w(r11f) -&
   w(r12f) -&
   w(r13f) +&
   w(r14f) +&
   w(r16f) +&
   w(r17) +&
   w(r18) +&
   w(r19f) -&
   w(r26) -&
   w(r31) -&
   w(r42) -&
   w(r44) -&
   w(r50) -&
   w(r61f) -&
   w(r62) +&
   w(r67) -&
   w(r77f) -&
   w(r86) -&
   w(r90f) -&
   w(r101) -&
   w(r115) -&
   w(r125f) -&
   w(r135) -&
   w(rnog139f) -&
   w(rnog145f) -&
   w(rnog148) -&
   w(rnog172f) +&
   w(rnog176f) -&
   w(rnog182) -&
   w(r202f) -&
   w(rnog203f) +&
   w(rnog211f) +&
   w(r10b) +&
   w(r11b) +&
   w(r12b) +&
   w(r13b) -&
   w(r14b) -&
   w(r16b) -&
   w(r19b) +&
   w(r61b) +&
   w(r77b) +&
   w(r90b) +&
   w(r125b) +&
   w(rnog139b) +&
   w(rnog145b) +&
   w(rnog172b) -&
   w(rnog176b) +&
   w(r202b)
  cdot(sO2) = cdot(sO2) +&
       w(rnog203b) -&
       w(rnog211b)


  cdot(sOH) = 0.0_pr +&
   w(r4f) -&
   w(r5f) - 2_pr *&
   w(r6f) -&
   w(r7f) - 2_pr *&
   w(r8f) +&
   w(r13f) -&
   w(r14f) +&
   w(r16f) + 2_pr *&
   w(r20f) -&
   w(r21f) -&
   w(r22) +&
   w(r23) +&
   w(r25) -&
   w(r27) -&
   w(r32) +&
   w(r36) -&
   w(r37) -&
   w(r39f) +&
   w(r42) -&
   w(r45) +&
   w(r50) +&
   w(r52) -&
   w(r55f) -&
   w(r58f) +&
   w(r62) -&
   w(r66f) -&
   w(r71f) +&
   w(r72f) +&
   w(r74) -&
   w(r76f) +&
   w(r80) -&
   w(r84) -&
   w(r89) +&
   w(r92) -&
   w(r99) +&
   w(r102f) +&
   w(r103) +&
   w(r104) -&
   w(r106f) -&
   w(r111) -&
   w(r117) -&
   w(r121f) -&
   w(r129f) +&
   w(r130) +&
   w(r135) -&
   w(rnog140f) -&
   w(rnog142f) -&
   w(rnog147f) +&
   w(rnog148) +&
   w(rnog150f)
  cdot(sOH) = cdot(sOH) -&
       w(rnog151f) +&
       w(rnog154) +&
       w(rnog156) +&
       w(rnog157f) +&
       w(rnog170f) +&
       w(rnog173f) -&
       w(rnog174f) +&
       w(rnog175f) -&
       w(rnog177) -&
       w(rnog179) -&
       w(rnog180f) -&
       w(rnog187) -&
       w(rnog189f) -&
       w(rnog191f) +&
       w(rnog193f) +&
       w(rnog197) +&
       w(rnog205) -&
       w(rnog208f) -&
       w(rnog210f) +&
       w(rnog214f) -&
       w(r4b) +&
       w(r5b) + 2_pr *&
       w(r6b) +&
       w(r7b) + 2_pr *&
       w(r8b) -&
       w(r13b) +&
       w(r14b) -&
       w(r16b) - 2_pr *&
       w(r20b) +&
       w(r21b) +&
       w(r39b) +&
       w(r55b) +&
       w(r58b) +&
       w(r66b) +&
       w(r71b) -&
       w(r72b) +&
       w(r76b) -&
       w(r102b) +&
       w(r106b) +&
       w(r121b) +&
       w(r129b) +&
       w(rnog140b) +&
       w(rnog142b) +&
       w(rnog147b) -&
       w(rnog150b) +&
       w(rnog151b) -&
       w(rnog157b) -&
       w(rnog170b) -&
       w(rnog173b) +&
       w(rnog174b)
  cdot(sOH) = cdot(sOH) -&
       w(rnog175b) +&
       w(rnog180b) +&
       w(rnog189b) +&
       w(rnog191b) -&
       w(rnog193b) +&
       w(rnog208b) +&
       w(rnog210b) -&
       w(rnog214b)


  cdot(sH2O) = 0.0_pr +&
   w(r5f) +&
   w(r6f) +&
   w(r7f) -&
   w(r9) +&
   w(r9) -&
   w(r11f) +&
   w(r11f) +&
   w(r14f) +&
   w(r15) +&
   w(r21f) +&
   w(r22) +&
   w(r25) -&
   w(r33) +&
   w(r39f) +&
   w(r44) -&
   w(r46f) +&
   w(r46f) -&
   w(r49f) +&
   w(r55f) +&
   w(r58f) +&
   w(r71f) +&
   w(r84) -&
   w(r85f) +&
   w(r85f) +&
   w(r89) +&
   w(r99) +&
   w(r100f) +&
   w(r106f) +&
   w(r117) +&
   w(r121f) +&
   w(r129f) +&
   w(rnog142f) -&
   w(rnog146f) +&
   w(rnog151f) +&
   w(rnog168) +&
   w(rnog174f) +&
   w(rnog191f) +&
   w(rnog208f) -&
   w(r5b) -&
   w(r6b) -&
   w(r7b) -&
   w(r11b) +&
   w(r11b) -&
   w(r14b) -&
   w(r21b) -&
   w(r39b) -&
   w(r46b) +&
   w(r46b) +&
   w(r49b) -&
   w(r55b)
  cdot(sH2O) = cdot(sH2O) -&
       w(r58b) -&
       w(r71b) -&
       w(r85b) +&
       w(r85b) -&
       w(r100b) -&
       w(r106b) -&
       w(r121b) -&
       w(r129b) -&
       w(rnog142b) +&
       w(rnog146b) -&
       w(rnog151b) -&
       w(rnog174b) -&
       w(rnog191b) -&
       w(rnog208b)


  cdot(sH2O2) = 0.0_pr +&
   w(r8f) +&
   w(r17) +&
   w(r18) -&
   w(r21f) -&
   w(r22) -&
   w(r23) -&
   w(r24f) -&
   w(r25) -&
   w(r56f) +&
   w(r88) -&
   w(r8b) +&
   w(r21b) +&
   w(r24b) +&
   w(r56b)


  cdot(sHO2) = 0.0_pr +&
   w(r10f) +&
   w(r11f) +&
   w(r12f) -&
   w(r14f) -&
   w(r15) -&
   w(r16f) - 2_pr *&
   w(r17) - 2_pr *&
   w(r18) -&
   w(r19f) -&
   w(r20f) +&
   w(r21f) +&
   w(r22) +&
   w(r23) +&
   w(r24f) -&
   w(r36) -&
   w(r52) +&
   w(r56f) -&
   w(r67) -&
   w(r74) +&
   w(r86) -&
   w(r88) +&
   w(r90f) +&
   w(r101) +&
   w(r125f) -&
   w(rnog157f) +&
   w(rnog172f) +&
   w(r202f) +&
   w(rnog203f) +&
   w(rnog210f) -&
   w(r10b) -&
   w(r11b) -&
   w(r12b) +&
   w(r14b) +&
   w(r16b) +&
   w(r19b) +&
   w(r20b) -&
   w(r21b) -&
   w(r24b) -&
   w(r56b) -&
   w(r90b) -&
   w(r125b) +&
   w(rnog157b) -&
   w(rnog172b) -&
   w(r202b) -&
   w(rnog203b) -&
   w(rnog210b)

!cdot(sC) = 0.0_pr


  cdot(sCO) = 0.0_pr +&
   w(r26) +&
   w(r27) +&
   w(r29) +&
   w(r44) +&
   w(r48) +&
   w(r50) -&
   w(r74) -&
   w(r75f) -&
   w(r76f) -&
   w(r77f) -&
   w(r78) -&
   w(r79f) +&
   w(r79f) +&
   w(r80) +&
   w(r81) +&
   w(r83f) +&
   w(r84) +&
   w(r85f) +&
   w(r86) +&
   w(r87) +&
   w(r96) +&
   w(r109) +&
   w(r110) +&
   w(r111) +&
   w(r114) +&
   w(r134f) + 2_pr *&
   w(r135) + 2_pr *&
   w(r138) +&
   w(rnog155f) +&
   w(rnog165) +&
   w(rnog177) +&
   w(rnog181) +&
   w(rnog183f) +&
   w(rnog184) +&
   w(rnog185) +&
   w(rnog186f) +&
   w(rnog187) +&
   w(rnog192f) +&
   w(rnog195f) +&
   w(rnog196) +&
   w(r75b) +&
   w(r76b) +&
   w(r77b) -&
   w(r79b) +&
   w(r79b) -&
   w(r83b) -&
   w(r85b) -&
   w(r134b) -&
   w(rnog155b) -&
   w(rnog183b)
  cdot(sCO) = cdot(sCO) -&
       w(rnog186b) -&
       w(rnog192b) -&
       w(rnog195b)

!cdot(sCH) = 0.0_pr

!cdot(sCH2) = 0.0_pr

!cdot(sHCO) = 0.0_pr


  cdot(sCH2O) = 0.0_pr +&
   w(r33) +&
   w(r36) +&
   w(r37) +&
   w(r45) +&
   w(r59) +&
   w(r62) -&
   w(r88) -&
   w(r89) -&
   w(r90f) -&
   w(r91f) -&
   w(r92) -&
   w(r93f) -&
   w(r94) -&
   w(r95) -&
   w(r96) +&
   w(r97) +&
   w(r99) +&
   w(r101) +&
   w(r103) +&
   w(r110) +&
   w(r115) +&
   w(r128) +&
   w(r90b) +&
   w(r91b) +&
   w(r93b)


  cdot(sCH3) = 0.0_pr +&
   w(r40f) +&
   w(r41) +&
   w(r51f) -&
   w(r52) -&
   w(r53) - 2_pr *&
   w(r54f) -&
   w(r55f) -&
   w(r56f) -&
   w(r57) -&
   w(r58f) -&
   w(r59) - 2_pr *&
   w(r60f) -&
   w(r61f) -&
   w(r62) -&
   w(r63f) -&
   w(r64) -&
   w(r65) -&
   w(r66f) -&
   w(r67) + 2_pr *&
   w(r69f) +&
   w(r70f) +&
   w(r71f) +&
   w(r72f) + 2_pr *&
   w(r73f) -&
   w(r87) -&
   w(r95) +&
   w(r102f) -&
   w(r107f) +&
   w(r111) -&
   w(r120f) +&
   w(r123) +&
   w(r128) -&
   w(r132f) +&
   w(r133) -&
   w(rnog141) -&
   w(rnog168) -&
   w(r40b) -&
   w(r51b) + 2_pr *&
   w(r54b) +&
   w(r55b) +&
   w(r56b) +&
   w(r58b) + 2_pr *&
   w(r60b) +&
   w(r61b) +&
   w(r63b) +&
   w(r66b) - 2_pr *&
   w(r69b) -&
   w(r70b) -&
   w(r71b) -&
   w(r72b)
  cdot(sCH3) = cdot(sCH3) - 2_pr *&
       w(r73b) -&
       w(r102b) +&
       w(r107b) +&
       w(r120b) +&
       w(r132b)

!cdot(s1XCH2) = 0.0_pr


  cdot(sCH3OH) = 0.0_pr +&
   w(r49f) +&
   w(r66f) +&
   w(r98) -&
   w(r104) -&
   w(r105f) -&
   w(r106f) -&
   w(r107f) -&
   w(r49b) -&
   w(r66b) +&
   w(r105b) +&
   w(r106b) +&
   w(r107b)

!cdot(sCH3O) = 0.0_pr


  cdot(sC2H2) = 0.0_pr +&
   w(r53) -&
   w(r111) -&
   w(r112f) -&
   w(r113f) -&
   w(r114) +&
   w(r117) +&
   w(r118) +&
   w(r122) +&
   w(r112b) +&
   w(r113b)

!cdot(sC2H5) = 0.0_pr


  cdot(sCH4) = 0.0_pr +&
   w(r56f) +&
   w(r63f) +&
   w(r67) -&
   w(r68) -&
   w(r69f) -&
   w(r70f) -&
   w(r71f) -&
   w(r72f) -&
   w(r73f) +&
   w(r87) +&
   w(r95) +&
   w(r107f) +&
   w(r120f) +&
   w(r132f) -&
   w(r56b) -&
   w(r63b) +&
   w(r69b) +&
   w(r70b) +&
   w(r71b) +&
   w(r72b) +&
   w(r73b) -&
   w(r107b) -&
   w(r120b) -&
   w(r132b)

!cdot(sC2H3) = 0.0_pr


  cdot(sC2H6) = 0.0_pr +&
   w(r60f) +&
   w(r127) -&
   w(r129f) -&
   w(r130) -&
   w(r131f) -&
   w(r132f) -&
   w(r133) -&
   w(r60b) +&
   w(r129b) +&
   w(r131b) +&
   w(r132b)


  cdot(sC2H4) = 0.0_pr +&
   w(r64) +&
   w(r65) +&
   w(r68) +&
   w(r116) -&
   w(r119f) -&
   w(r120f) -&
   w(r121f) -&
   w(r122) -&
   w(r123) -&
   w(r124f) +&
   w(r125f) +&
   w(r126) +&
   w(r119b) +&
   w(r120b) +&
   w(r121b) +&
   w(r124b) -&
   w(r125b)


  cdot(sCO2) = 0.0_pr +&
   w(r74) +&
   w(r76f) +&
   w(r77f) +&
   w(r78) +&
   w(r82) -&
   w(r108f) +&
   w(r108f) -&
   w(r109) -&
   w(r110) +&
   w(rnog182) +&
   w(rnog188) +&
   w(rnog189f) +&
   w(rnog190) -&
   w(r76b) -&
   w(r77b) -&
   w(r108b) +&
   w(r108b) -&
   w(rnog189b)

!cdot(sHCCO) = 0.0_pr

!cdot(sN) = 0.0_pr


  cdot(sNO) = 0.0_pr +&
   w(rnog139f) +&
   w(rnog140f) +&
   w(rnog144f) +&
   w(rnog148) -&
   w(rnog153) -&
   w(rnog154) -&
   w(rnog155f) -&
   w(rnog156) -&
   w(rnog157f) -&
   w(rnog158f) -&
   w(rnog159) -&
   w(rnog160) -&
   w(rnog161f) -&
   w(rnog162f) -&
   w(rnog163f) -&
   w(rnog164f) -&
   w(rnog165) -&
   w(rnog166) -&
   w(rnog167f) -&
   w(rnog168) -&
   w(rnog169) -&
   w(rnog170f) +&
   w(rnog171f) +&
   w(rnog172f) +&
   w(rnog173f) +&
   w(rnog174f) +&
   w(rnog175f) +&
   w(rnog176f) +&
   w(rnog182) +&
   w(rnog184) -&
   w(rnog185) +&
   w(rnog187) -&
   w(rnog188) +&
   w(rnog207f) + 2_pr *&
   w(rnog213) -&
   w(rnog139b) -&
   w(rnog140b) -&
   w(rnog144b) +&
   w(rnog155b) +&
   w(rnog157b) +&
   w(rnog158b) +&
   w(rnog161b) +&
   w(rnog162b) +&
   w(rnog163b) +&
   w(rnog164b) +&
   w(rnog167b) +&
   w(rnog170b) -&
   w(rnog171b) -&
   w(rnog172b) -&
   w(rnog173b)
  cdot(sNO) = cdot(sNO) -&
       w(rnog174b) -&
       w(rnog175b) -&
       w(rnog176b) -&
       w(rnog207b)


  cdot(sHCN) = 0.0_pr +&
   w(rnog141) +&
   w(rnog154) +&
   w(rnog156) +&
   w(rnog159) +&
   w(rnog168) -&
   w(rnog177) -&
   w(rnog178f) -&
   w(rnog179) -&
   w(rnog180f) -&
   w(rnog181) +&
   w(rnog197) +&
   w(rnog200) +&
   w(rnog178b) +&
   w(rnog180b)

!cdot(sNH) = 0.0_pr

!cdot(sHNO) = 0.0_pr

!cdot(sNH2) = 0.0_pr

!cdot(sNCO) = 0.0_pr

!cdot(sHCNO) = 0.0_pr


  cdot(sNO2) = 0.0_pr +&
   w(rnog157f) +&
   w(rnog163f) -&
   w(rnog175f) -&
   w(rnog176f) -&
   w(rnog157b) -&
   w(rnog163b) +&
   w(rnog175b) +&
   w(rnog176b)


  cdot(sN2O) = 0.0_pr +&
   w(rnog158f) +&
   w(rnog185) -&
   w(rnog210f) -&
   w(rnog211f) -&
   w(rnog212f) -&
   w(rnog213) -&
   w(rnog214f) -&
   w(rnog158b) +&
   w(rnog210b) +&
   w(rnog211b) +&
   w(rnog212b) +&
   w(rnog214b)

!cdot(sHNCO) = 0.0_pr

!cdot(sHOCN) = 0.0_pr

!cdot(sNNH) = 0.0_pr


END SUBROUTINE get_production_rates


! --- Actual reactions --- (postproc) !
SUBROUTINE reaction_expressions

  IMPLICIT NONE


  reacexp(1) = '2 H + M38 -> H2 + M38'
  reacexp(2) = '2 H + M5 -> H2 + M5'
  reacexp(3) = '2 O + M1 -> O2 + M1'
  reacexp(4) = 'O + H2 -> H + OH'
  reacexp(5) = 'H + OH + M6 -> H2O + M6'
  reacexp(6) = '2 OH -> O + H2O'
  reacexp(7) = 'OH + H2 -> H + H2O'
  reacexp(8) = '2 OH + M20 -> H2O2 + M20'
  reacexp(9) = '2 H + H2O -> H2 + H2O'
  reacexp(10) = 'H + O2 + M4 -> HO2 + M4'
  reacexp(11) = 'H + O2 + H2O -> HO2 + H2O'
  reacexp(12) = 'H + O2 + M37 -> HO2 + M37'
  reacexp(13) = 'H + O2 -> O + OH'
  reacexp(14) = 'OH + HO2 -> O2 + H2O'
  reacexp(15) = 'H + HO2 -> O + H2O'
  reacexp(16) = 'O + HO2 -> OH + O2'
  reacexp(17) = '2 HO2 -> O2 + H2O2'
  reacexp(18) = '2 HO2 -> O2 + H2O2'
  reacexp(19) = 'H + HO2 -> O2 + H2'
  reacexp(20) = 'H + HO2 -> 2 OH'
  reacexp(21) = 'OH + H2O2 -> HO2 + H2O'
  reacexp(22) = 'OH + H2O2 -> HO2 + H2O'
  reacexp(23) = 'O + H2O2 -> OH + HO2'
  reacexp(24) = 'H + H2O2 -> HO2 + H2'
  reacexp(25) = 'H + H2O2 -> OH + H2O'
  reacexp(26) = 'C + O2 -> O + CO'
  reacexp(27) = 'OH + C -> H + CO'
  reacexp(28) = 'CH + H2 -> H + CH2'
  reacexp(29) = 'O + CH -> H + CO'
  reacexp(30) = 'H + CH -> C + H2'
  reacexp(31) = 'CH + O2 -> O + HCO'
  reacexp(32) = 'OH + CH -> H + HCO'
  reacexp(33) = 'CH + H2O -> H + CH2O'
  reacexp(34) = 'HO2 + CH2 -> OH + CH2O'
  reacexp(35) = 'OH + CH2 -> H + CH2O'
  reacexp(36) = 'O + CH2 -> H + HCO'
  reacexp(37) = 'OH + CH2 -> CH + H2O'
  reacexp(38) = 'CH2 + H2 -> H + CH3'
  reacexp(39) = 'H + CH2 + M7 -> CH3 + M7'
  reacexp(40) = 'CH2 + O2 -> OH + HCO'
  reacexp(41) = 'H + 1-CH2 -> CH + H2'
  reacexp(42) = '1-CH2 + O2 -> CO + H2O'
  reacexp(43) = 'OH + 1-CH2 -> H + CH2O'
  reacexp(44) = '1-CH2 + H2O -> CH2 + H2O'
  reacexp(45) = 'O + 1-CH2 -> H + HCO'
  reacexp(46) = 'O + 1-CH2 -> H2 + CO'
  reacexp(47) = '1-CH2 + H2O + M24 -> CH3OH + M24'
  reacexp(48) = '1-CH2 + O2 -> H + OH + CO'
  reacexp(49) = '1-CH2 + H2 -> CH3 + H'
  reacexp(50) = 'HO2 + CH3 -> OH + CH3O'
  reacexp(51) = 'C + CH3 -> H + C2H2'
  reacexp(52) = '2 CH3 -> H + C2H5'
  reacexp(53) = 'OH + CH3 -> 1-CH2 + H2O'
  reacexp(54) = 'CH3 + H2O2 -> HO2 + CH4'
  reacexp(55) = 'CH + CH3 -> H + C2H3'
  reacexp(56) = 'OH + CH3 -> CH2 + H2O'
  reacexp(57) = 'O + CH3 -> H + CH2O'
  reacexp(58) = '2 CH3 + M25 -> C2H6 + M25'
  reacexp(59) = 'CH3 + O2 -> O + CH3O'
  reacexp(60) = 'CH3 + O2 -> OH + CH2O'
  reacexp(61) = 'H + CH3 + M8 -> CH4 + M8'
  reacexp(62) = 'CH2 + CH3 -> H + C2H4'
  reacexp(63) = '1-CH2 + CH3 -> H + C2H4'
  reacexp(64) = 'OH + CH3 + M21 -> CH3OH + M21'
  reacexp(65) = 'HO2 + CH3 -> O2 + CH4'
  reacexp(66) = 'CH + CH4 -> H + C2H4'
  reacexp(67) = 'CH2 + CH4 -> 2 CH3'
  reacexp(68) = 'H + CH4 -> CH3 + H2'
  reacexp(69) = 'OH + CH4 -> CH3 + H2O'
  reacexp(70) = 'O + CH4 -> OH + CH3'
  reacexp(71) = '1-CH2 + CH4 -> 2 CH3'
  reacexp(72) = 'HO2 + CO -> OH + CO2'
  reacexp(73) = 'CH + CO + M22 -> HCCO + M22'
  reacexp(74) = 'OH + CO -> H + CO2'
  reacexp(75) = 'O2 + CO -> O + CO2'
  reacexp(76) = 'O + CO + M3 -> CO2 + M3'
  reacexp(77) = '1-CH2 + CO -> CH2 + CO'
  reacexp(78) = 'O + HCO -> OH + CO'
  reacexp(79) = 'H + HCO -> H2 + CO'
  reacexp(80) = 'O + HCO -> H + CO2'
  reacexp(81) = 'HCO + M26 -> H + CO + M26'
  reacexp(82) = 'OH + HCO -> H2O + CO'
  reacexp(83) = 'HCO + H2O -> H + CO + H2O'
  reacexp(84) = 'HCO + O2 -> HO2 + CO'
  reacexp(85) = 'CH3 + HCO -> CH4 + CO'
  reacexp(86) = 'HO2 + CH2O -> HCO + H2O2'
  reacexp(87) = 'OH + CH2O -> HCO + H2O'
  reacexp(88) = 'O2 + CH2O -> HO2 + HCO'
  reacexp(89) = 'H + CH2O -> HCO + H2'
  reacexp(90) = 'O + CH2O -> OH + HCO'
  reacexp(91) = 'H + CH2O + M11 -> CH3O + M11'
  reacexp(92) = 'CH2O + M9 -> HCO + H + M9'
  reacexp(93) = 'CH3 + CH2O -> HCO + CH4'
  reacexp(94) = 'CH2O + M19 -> CO + H2 + M19'
  reacexp(95) = 'H + CH3O -> H2 + CH2O'
  reacexp(96) = 'H + CH3O + M13 -> CH3OH + M13'
  reacexp(97) = 'OH + CH3O -> H2O + CH2O'
  reacexp(98) = 'H + CH3O -> 1-CH2 + H2O'
  reacexp(99) = 'CH3O + O2 -> HO2 + CH2O'
  reacexp(100) = 'H + CH3O -> OH + CH3'
  reacexp(101) = 'O + CH3O -> OH + CH2O'
  reacexp(102) = 'O + CH3OH -> OH + CH3O'
  reacexp(103) = 'H + CH3OH -> CH3O + H2'
  reacexp(104) = 'OH + CH3OH -> CH3O + H2O'
  reacexp(105) = 'CH3 + CH3OH -> CH3O + CH4'
  reacexp(106) = '1-CH2 + CO2 -> CH2 + CO2'
  reacexp(107) = 'CH + CO2 -> HCO + CO'
  reacexp(108) = '1-CH2 + CO2 -> CO + CH2O'
  reacexp(109) = 'OH + C2H2 -> CH3 + CO'
  reacexp(110) = 'O + C2H2 -> H + HCCO'
  reacexp(111) = 'H + C2H2 + M15 -> C2H3 + M15'
  reacexp(112) = 'O + C2H2 -> CO + CH2'
  reacexp(113) = 'C2H3 + O2 -> HCO + CH2O'
  reacexp(114) = 'H + C2H3 + M16 -> C2H4 + M16'
  reacexp(115) = 'OH + C2H3 -> H2O + C2H2'
  reacexp(116) = 'H + C2H3 -> H2 + C2H2'
  reacexp(117) = 'H + C2H4 -> C2H3 + H2'
  reacexp(118) = 'CH3 + C2H4 -> C2H3 + CH4'
  reacexp(119) = 'OH + C2H4 -> C2H3 + H2O'
  reacexp(120) = 'C2H4 + M27 -> H2 + C2H2 + M27'
  reacexp(121) = 'O + C2H4 -> CH3 + HCO'
  reacexp(122) = 'H + C2H4 + M17 -> C2H5 + M17'
  reacexp(123) = 'C2H5 + O2 -> HO2 + C2H4'
  reacexp(124) = 'H + C2H5 -> H2 + C2H4'
  reacexp(125) = 'H + C2H5 + M18 -> C2H6 + M18'
  reacexp(126) = 'O + C2H5 -> CH3 + CH2O'
  reacexp(127) = 'OH + C2H6 -> C2H5 + H2O'
  reacexp(128) = 'O + C2H6 -> OH + C2H5'
  reacexp(129) = 'H + C2H6 -> C2H5 + H2'
  reacexp(130) = 'CH3 + C2H6 -> C2H5 + CH4'
  reacexp(131) = '1-CH2 + C2H6 -> CH3 + C2H5'
  reacexp(132) = 'H + HCCO -> 1-CH2 + CO'
  reacexp(133) = 'HCCO + O2 -> OH + 2 CO'
  reacexp(134) = 'O + HCCO -> H + 2 CO'
  reacexp(135) = 'N + O2 -> NO + O'
  reacexp(136) = 'N + OH -> NO + H'
  reacexp(137) = 'CH3 + N -> HCN + H2'
  reacexp(138) = 'NH + OH -> N + H2O'
  reacexp(139) = 'NH + H -> N + H2'
  reacexp(140) = 'NH + O -> NO + H'
  reacexp(141) = 'NH + O2 -> HNO + O'
  reacexp(142) = 'NH + H2O -> HNO + H2'
  reacexp(143) = 'NH + OH -> HNO + H'
  reacexp(144) = 'NH + O2 -> NO + OH'
  reacexp(145) = 'NH2 + H -> NH + H2'
  reacexp(146) = 'NH2 + O -> OH + NH'
  reacexp(147) = 'NH2 + OH -> NH + H2O'
  reacexp(148) = 'NH2 + O -> H + HNO'
  reacexp(149) = 'CH + NO -> H + NCO'
  reacexp(150) = 'CH2 + NO -> OH + HCN'
  reacexp(151) = 'HCCO + NO -> HCNO + CO'
  reacexp(152) = '1-CH2 + NO -> OH + HCN'
  reacexp(153) = 'HO2 + NO -> NO2 + OH'
  reacexp(154) = 'NH + NO -> N2O + H'
  reacexp(155) = 'CH + NO -> HCN + O'
  reacexp(156) = 'CH + NO -> N + HCO'
  reacexp(157) = '1-CH2 + NO -> H + HCNO'
  reacexp(158) = 'N + NO -> N2 + O'
  reacexp(159) = 'NO + O + M29 -> NO2 + M29'
  reacexp(160) = 'H + NO + M31 -> HNO + M31'
  reacexp(161) = 'C + NO -> CO + N'
  reacexp(162) = 'CH2 + NO -> H + HNCO'
  reacexp(163) = 'CH2 + NO -> H + HCNO'
  reacexp(164) = 'CH3 + NO -> HCN + H2O'
  reacexp(165) = '1-CH2 + NO -> H + HNCO'
  reacexp(166) = 'NH + NO -> N2 + OH'
  reacexp(167) = 'HNO + H -> H2 + NO'
  reacexp(168) = 'HNO + O2 -> HO2 + NO'
  reacexp(169) = 'HNO + O -> NO + OH'
  reacexp(170) = 'HNO + OH -> NO + H2O'
  reacexp(171) = 'NO2 + H -> NO + OH'
  reacexp(172) = 'NO2 + O -> NO + O2'
  reacexp(173) = 'HCN + OH -> NH2 + CO'
  reacexp(174) = 'HCN + O -> NCO + H'
  reacexp(175) = 'HCN + OH -> HNCO + H'
  reacexp(176) = 'HCN + OH -> HOCN + H'
  reacexp(177) = 'HCN + O -> NH + CO'
  reacexp(178) = 'NCO + O2 -> NO + CO2'
  reacexp(179) = 'NCO + M32 -> N + CO + M32'
  reacexp(180) = 'NCO + O -> NO + CO'
  reacexp(181) = 'NCO + NO -> N2O + CO'
  reacexp(182) = 'NCO + H -> NH + CO'
  reacexp(183) = 'NCO + OH -> NO + H + CO'
  reacexp(184) = 'NCO + NO -> N2 + CO2'
  reacexp(185) = 'HNCO + OH -> NH2 + CO2'
  reacexp(186) = 'HNCO + O -> NH + CO2'
  reacexp(187) = 'HNCO + OH -> NCO + H2O'
  reacexp(188) = 'HNCO + M36 -> NH + CO + M36'
  reacexp(189) = 'HNCO + O -> NCO + OH'
  reacexp(190) = 'HNCO + H -> H2 + NCO'
  reacexp(191) = 'HNCO + H -> NH2 + CO'
  reacexp(192) = 'HCNO + H -> NH2 + CO'
  reacexp(193) = 'HCNO + H -> OH + HCN'
  reacexp(194) = 'HCNO + H -> H + HNCO'
  reacexp(195) = 'HOCN + H -> H + HNCO'
  reacexp(196) = 'CH + N2 -> HCN + N'
  reacexp(197) = '1-CH2 + N2 -> CH2 + N2'
  reacexp(198) = 'H + O2 + N2 -> HO2 + N2'
  reacexp(199) = 'NNH + O2 -> HO2 + N2'
  reacexp(200) = 'NNH -> N2 + H'
  reacexp(201) = 'NNH + O -> OH + N2'
  reacexp(202) = 'NNH + H -> H2 + N2'
  reacexp(203) = 'NNH + O -> NH + NO'
  reacexp(204) = 'NNH + OH -> H2O + N2'
  reacexp(205) = 'NNH + M30 -> N2 + H + M30'
  reacexp(206) = 'N2O + OH -> N2 + HO2'
  reacexp(207) = 'N2O + O -> N2 + O2'
  reacexp(208) = 'N2O + M28 -> N2 + O + M28'
  reacexp(209) = 'N2O + O -> 2 NO'
  reacexp(210) = 'N2O + H -> N2 + OH'
  reacexp(211) = 'Reverse of O + H2 -> H + OH'
  reacexp(212) = 'Reverse of H + OH + M6 -> H2O + M6'
  reacexp(213) = 'Reverse of 2 OH -> O + H2O'
  reacexp(214) = 'Reverse of OH + H2 -> H + H2O'
  reacexp(215) = 'Reverse of 2 OH + M20 -> H2O2 + M20'
  reacexp(216) = 'Reverse of H + O2 + M4 -> HO2 + M4'
  reacexp(217) = 'Reverse of H + O2 + H2O -> HO2 + H2O'
  reacexp(218) = 'Reverse of H + O2 + M37 -> HO2 + M37'
  reacexp(219) = 'Reverse of H + O2 -> O + OH'
  reacexp(220) = 'Reverse of OH + HO2 -> O2 + H2O'
  reacexp(221) = 'Reverse of O + HO2 -> OH + O2'
  reacexp(222) = 'Reverse of H + HO2 -> O2 + H2'
  reacexp(223) = 'Reverse of H + HO2 -> 2 OH'
  reacexp(224) = 'Reverse of OH + H2O2 -> HO2 + H2O'
  reacexp(225) = 'Reverse of H + H2O2 -> HO2 + H2'
  reacexp(226) = 'Reverse of CH + H2 -> H + CH2'
  reacexp(227) = 'Reverse of H + CH -> C + H2'
  reacexp(228) = 'Reverse of OH + CH2 -> CH + H2O'
  reacexp(229) = 'Reverse of CH2 + H2 -> H + CH3'
  reacexp(230) = 'Reverse of H + 1-CH2 -> CH + H2'
  reacexp(231) = 'Reverse of 1-CH2 + H2O -> CH2 + H2O'
  reacexp(232) = 'Reverse of 1-CH2 + H2O + M24 -> CH3OH + M24'
  reacexp(233) = 'Reverse of 1-CH2 + H2 -> CH3 + H'
  reacexp(234) = 'Reverse of 2 CH3 -> H + C2H5'
  reacexp(235) = 'Reverse of OH + CH3 -> 1-CH2 + H2O'
  reacexp(236) = 'Reverse of CH3 + H2O2 -> HO2 + CH4'
  reacexp(237) = 'Reverse of OH + CH3 -> CH2 + H2O'
  reacexp(238) = 'Reverse of 2 CH3 + M25 -> C2H6 + M25'
  reacexp(239) = 'Reverse of CH3 + O2 -> O + CH3O'
  reacexp(240) = 'Reverse of H + CH3 + M8 -> CH4 + M8'
  reacexp(241) = 'Reverse of OH + CH3 + M21 -> CH3OH + M21'
  reacexp(242) = 'Reverse of CH2 + CH4 -> 2 CH3'
  reacexp(243) = 'Reverse of H + CH4 -> CH3 + H2'
  reacexp(244) = 'Reverse of OH + CH4 -> CH3 + H2O'
  reacexp(245) = 'Reverse of O + CH4 -> OH + CH3'
  reacexp(246) = 'Reverse of 1-CH2 + CH4 -> 2 CH3'
  reacexp(247) = 'Reverse of CH + CO + M22 -> HCCO + M22'
  reacexp(248) = 'Reverse of OH + CO -> H + CO2'
  reacexp(249) = 'Reverse of O2 + CO -> O + CO2'
  reacexp(250) = 'Reverse of 1-CH2 + CO -> CH2 + CO'
  reacexp(251) = 'Reverse of HCO + M26 -> H + CO + M26'
  reacexp(252) = 'Reverse of HCO + H2O -> H + CO + H2O'
  reacexp(253) = 'Reverse of O2 + CH2O -> HO2 + HCO'
  reacexp(254) = 'Reverse of H + CH2O -> HCO + H2'
  reacexp(255) = 'Reverse of H + CH2O + M11 -> CH3O + M11'
  reacexp(256) = 'Reverse of H + CH3O -> 1-CH2 + H2O'
  reacexp(257) = 'Reverse of H + CH3O -> OH + CH3'
  reacexp(258) = 'Reverse of H + CH3OH -> CH3O + H2'
  reacexp(259) = 'Reverse of OH + CH3OH -> CH3O + H2O'
  reacexp(260) = 'Reverse of CH3 + CH3OH -> CH3O + CH4'
  reacexp(261) = 'Reverse of 1-CH2 + CO2 -> CH2 + CO2'
  reacexp(262) = 'Reverse of O + C2H2 -> H + HCCO'
  reacexp(263) = 'Reverse of H + C2H2 + M15 -> C2H3 + M15'
  reacexp(264) = 'Reverse of H + C2H4 -> C2H3 + H2'
  reacexp(265) = 'Reverse of CH3 + C2H4 -> C2H3 + CH4'
  reacexp(266) = 'Reverse of OH + C2H4 -> C2H3 + H2O'
  reacexp(267) = 'Reverse of H + C2H4 + M17 -> C2H5 + M17'
  reacexp(268) = 'Reverse of C2H5 + O2 -> HO2 + C2H4'
  reacexp(269) = 'Reverse of OH + C2H6 -> C2H5 + H2O'
  reacexp(270) = 'Reverse of H + C2H6 -> C2H5 + H2'
  reacexp(271) = 'Reverse of CH3 + C2H6 -> C2H5 + CH4'
  reacexp(272) = 'Reverse of H + HCCO -> 1-CH2 + CO'
  reacexp(273) = 'Reverse of N + O2 -> NO + O'
  reacexp(274) = 'Reverse of N + OH -> NO + H'
  reacexp(275) = 'Reverse of NH + OH -> N + H2O'
  reacexp(276) = 'Reverse of NH + H -> N + H2'
  reacexp(277) = 'Reverse of NH + O -> NO + H'
  reacexp(278) = 'Reverse of NH + O2 -> HNO + O'
  reacexp(279) = 'Reverse of NH + H2O -> HNO + H2'
  reacexp(280) = 'Reverse of NH + OH -> HNO + H'
  reacexp(281) = 'Reverse of NH2 + H -> NH + H2'
  reacexp(282) = 'Reverse of NH2 + O -> OH + NH'
  reacexp(283) = 'Reverse of NH2 + OH -> NH + H2O'
  reacexp(284) = 'Reverse of NH2 + O -> H + HNO'
  reacexp(285) = 'Reverse of HCCO + NO -> HCNO + CO'
  reacexp(286) = 'Reverse of HO2 + NO -> NO2 + OH'
  reacexp(287) = 'Reverse of NH + NO -> N2O + H'
  reacexp(288) = 'Reverse of 1-CH2 + NO -> H + HCNO'
  reacexp(289) = 'Reverse of N + NO -> N2 + O'
  reacexp(290) = 'Reverse of NO + O + M29 -> NO2 + M29'
  reacexp(291) = 'Reverse of H + NO + M31 -> HNO + M31'
  reacexp(292) = 'Reverse of CH2 + NO -> H + HCNO'
  reacexp(293) = 'Reverse of NH + NO -> N2 + OH'
  reacexp(294) = 'Reverse of HNO + H -> H2 + NO'
  reacexp(295) = 'Reverse of HNO + O2 -> HO2 + NO'
  reacexp(296) = 'Reverse of HNO + O -> NO + OH'
  reacexp(297) = 'Reverse of HNO + OH -> NO + H2O'
  reacexp(298) = 'Reverse of NO2 + H -> NO + OH'
  reacexp(299) = 'Reverse of NO2 + O -> NO + O2'
  reacexp(300) = 'Reverse of HCN + O -> NCO + H'
  reacexp(301) = 'Reverse of HCN + OH -> HOCN + H'
  reacexp(302) = 'Reverse of NCO + M32 -> N + CO + M32'
  reacexp(303) = 'Reverse of NCO + H -> NH + CO'
  reacexp(304) = 'Reverse of HNCO + OH -> NH2 + CO2'
  reacexp(305) = 'Reverse of HNCO + OH -> NCO + H2O'
  reacexp(306) = 'Reverse of HNCO + M36 -> NH + CO + M36'
  reacexp(307) = 'Reverse of HNCO + O -> NCO + OH'
  reacexp(308) = 'Reverse of HNCO + H -> H2 + NCO'
  reacexp(309) = 'Reverse of HNCO + H -> NH2 + CO'
  reacexp(310) = 'Reverse of 1-CH2 + N2 -> CH2 + N2'
  reacexp(311) = 'Reverse of H + O2 + N2 -> HO2 + N2'
  reacexp(312) = 'Reverse of NNH + O2 -> HO2 + N2'
  reacexp(313) = 'Reverse of NNH -> N2 + H'
  reacexp(314) = 'Reverse of NNH + O -> NH + NO'
  reacexp(315) = 'Reverse of NNH + OH -> H2O + N2'
  reacexp(316) = 'Reverse of NNH + M30 -> N2 + H + M30'
  reacexp(317) = 'Reverse of N2O + OH -> N2 + HO2'
  reacexp(318) = 'Reverse of N2O + O -> N2 + O2'
  reacexp(319) = 'Reverse of N2O + M28 -> N2 + O + M28'
  reacexp(320) = 'Reverse of N2O + H -> N2 + OH'


END SUBROUTINE reaction_expressions


! --- Forward/Backward link --- ! (postproc)
SUBROUTINE reverse_reactions

  IMPLICIT NONE


  fofb = 0

! Attach corresponding forward reaction to each backward reaction
  fofb(211) = 4
  fofb(212) = 5
  fofb(213) = 6
  fofb(214) = 7
  fofb(215) = 8
  fofb(216) = 10
  fofb(217) = 11
  fofb(218) = 12
  fofb(219) = 13
  fofb(220) = 14
  fofb(221) = 16
  fofb(222) = 19
  fofb(223) = 20
  fofb(224) = 21
  fofb(225) = 24
  fofb(226) = 28
  fofb(227) = 30
  fofb(228) = 37
  fofb(229) = 38
  fofb(230) = 41
  fofb(231) = 44
  fofb(232) = 47
  fofb(233) = 49
  fofb(234) = 52
  fofb(235) = 53
  fofb(236) = 54
  fofb(237) = 56
  fofb(238) = 58
  fofb(239) = 59
  fofb(240) = 61
  fofb(241) = 64
  fofb(242) = 67
  fofb(243) = 68
  fofb(244) = 69
  fofb(245) = 70
  fofb(246) = 71
  fofb(247) = 73
  fofb(248) = 74
  fofb(249) = 75
  fofb(250) = 77
  fofb(251) = 81
  fofb(252) = 83
  fofb(253) = 88
  fofb(254) = 89
  fofb(255) = 91
  fofb(256) = 98
  fofb(257) = 100
  fofb(258) = 103
  fofb(259) = 104
  fofb(260) = 105
  fofb(261) = 106
  fofb(262) = 110
  fofb(263) = 111
  fofb(264) = 117
  fofb(265) = 118
  fofb(266) = 119
  fofb(267) = 122
  fofb(268) = 123
  fofb(269) = 127
  fofb(270) = 129
  fofb(271) = 130
  fofb(272) = 132
  fofb(273) = 135
  fofb(274) = 136
  fofb(275) = 138
  fofb(276) = 139
  fofb(277) = 140
  fofb(278) = 141
  fofb(279) = 142
  fofb(280) = 143
  fofb(281) = 145
  fofb(282) = 146
  fofb(283) = 147
  fofb(284) = 148
  fofb(285) = 151
  fofb(286) = 153
  fofb(287) = 154
  fofb(288) = 157
  fofb(289) = 158
  fofb(290) = 159
  fofb(291) = 160
  fofb(292) = 163
  fofb(293) = 166
  fofb(294) = 167
  fofb(295) = 168
  fofb(296) = 169
  fofb(297) = 170
  fofb(298) = 171
  fofb(299) = 172
  fofb(300) = 174
  fofb(301) = 176
  fofb(302) = 179
  fofb(303) = 182
  fofb(304) = 185
  fofb(305) = 187
  fofb(306) = 188
  fofb(307) = 189
  fofb(308) = 190
  fofb(309) = 191
  fofb(310) = 197
  fofb(311) = 198
  fofb(312) = 199
  fofb(313) = 200
  fofb(314) = 203
  fofb(315) = 204
  fofb(316) = 205
  fofb(317) = 206
  fofb(318) = 207
  fofb(319) = 208
  fofb(320) = 210


END SUBROUTINE reverse_reactions


!--------------------------------------------------------------------------------------------------
!     SUBROUTINE get_QSS
!>    @details Subroutine for solving the QSS species concentrations
!
!!    @authors T. Jaravel
!!    @date    15-07-2015
!
!     Input:
!            c        Species concentrations
!            k        Reactions coefficients
!            M        Third-body concentrations
!
!     Output:
!            cqss     QSS species oncentrations
!
!--------------------------------------------------------------------------------------------------
SUBROUTINE get_QSS ( cqss,c,k,M )

  IMPLICIT NONE

  REAL(pr), DIMENSION(nqss) :: cqss
  REAL(pr), DIMENSION(nspec) :: c
  REAL(pr), DIMENSION(nreac) :: k
  REAL(pr), DIMENSION(31) :: M

  REAL(pr) :: X1XCH2_denom1&
     , X1XCH2_ct1&
     , X1XCH2_denom2&
     , X1XCH2_ct2&
     , X1XCH2_CH&
     , X1XCH2_HCNO&
     , X1XCH2_CH3O&
     , X1XCH2_HCCO&
     , X1XCH2_C&
     , X1XCH2_CH_coeff&
     , X1XCH2_HCNO_coeff&
     , X1XCH2_CH3O_coeff&
     , X1XCH2_HCCO_coeff&
     , X1XCH2_C_coeff
  REAL(pr) :: NH_denom1&
     , NH_ct1&
     , NH_denom2&
     , NH_ct2&
     , NH_NCO&
     , NH_HNCO&
     , NH_NH2&
     , NH_HNO&
     , NH_NNH&
     , NH_NCO_coeff&
     , NH_HNCO_coeff&
     , NH_NH2_coeff&
     , NH_HNO_coeff&
     , NH_NNH_coeff
  REAL(pr) :: NCO_denom1&
     , NCO_ct1&
     , NCO_denom2&
     , NCO_ct2&
     , NCO_HNCO&
     , NCO_NH2&
     , NCO_HNO&
     , NCO_NNH&
     , NCO_HNCO_coeff&
     , NCO_NH2_coeff&
     , NCO_HNO_coeff&
     , NCO_NNH_coeff
  REAL(pr) :: N_denom1&
     , N_ct1&
     , N_denom2&
     , N_ct2&
     , N_NH&
     , N_NCO&
     , N_HNCO&
     , N_NH2&
     , N_HNO&
     , N_NNH&
     , N_NH_coeff&
     , N_NCO_coeff&
     , N_HNCO_coeff&
     , N_NH2_coeff&
     , N_HNO_coeff&
     , N_NNH_coeff
  REAL(pr) :: HNO_denom1&
     , HNO_ct1&
     , HNO_denom2&
     , HNO_ct2&
     , HNO_NNH&
     , HNO_NNH_coeff
  REAL(pr) :: NNH_denom1&
     , NNH_ct1&
     , NNH_denom2&
     , NNH_ct2
  REAL(pr) :: CH3O_denom1&
     , CH3O_ct1&
     , CH3O_denom2&
     , CH3O_ct2&
     , CH3O_HCCO&
     , CH3O_C&
     , CH3O_HCCO_coeff&
     , CH3O_C_coeff
  REAL(pr) :: HCNO_denom1&
     , HCNO_ct1&
     , HCNO_denom2&
     , HCNO_ct2&
     , HCNO_CH3O&
     , HCNO_HCCO&
     , HCNO_C&
     , HCNO_CH3O_coeff&
     , HCNO_HCCO_coeff&
     , HCNO_C_coeff
  REAL(pr) :: CH_denom1&
     , CH_ct1&
     , CH_denom2&
     , CH_ct2&
     , CH_HCNO&
     , CH_CH3O&
     , CH_HCCO&
     , CH_C&
     , CH_HCNO_coeff&
     , CH_CH3O_coeff&
     , CH_HCCO_coeff&
     , CH_C_coeff
  REAL(pr) :: HNCO_denom1&
     , HNCO_ct1&
     , HNCO_denom2&
     , HNCO_ct2&
     , HNCO_NH2&
     , HNCO_HNO&
     , HNCO_NNH&
     , HNCO_NH2_coeff&
     , HNCO_HNO_coeff&
     , HNCO_NNH_coeff
  REAL(pr) :: CH2_denom1&
     , CH2_ct1&
     , CH2_denom2&
     , CH2_ct2&
     , CH2_X1XCH2&
     , CH2_CH&
     , CH2_HCNO&
     , CH2_CH3O&
     , CH2_HCCO&
     , CH2_C&
     , CH2_X1XCH2_coeff&
     , CH2_CH_coeff&
     , CH2_HCNO_coeff&
     , CH2_CH3O_coeff&
     , CH2_HCCO_coeff&
     , CH2_C_coeff
  REAL(pr) :: C_denom1&
     , C_ct1&
     , C_denom2&
     , C_ct2
  REAL(pr) :: NH2_denom1&
     , NH2_ct1&
     , NH2_denom2&
     , NH2_ct2&
     , NH2_HNO&
     , NH2_NNH&
     , NH2_HNO_coeff&
     , NH2_NNH_coeff
  REAL(pr) :: HCCO_denom1&
     , HCCO_ct1&
     , HCCO_denom2&
     , HCCO_ct2&
     , HCCO_C&
     , HCCO_C_coeff


! c(sCH2) c(s1XCH2) c(sCH) c(sHCNO) c(sCH3O) c(sHCCO) c(sC) (coupled)  --------------------

! Primary denominators-----------------------

  CH2_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(r28b) *  c(sH)&
         + k(r36) *  c(sHO2)&
         + k(r37) *  c(sOH)&
         + k(r38) *  c(sO)&
         + k(r39f) *  c(sOH)&
         + k(r40f) *  c(sH2)&
         + k(r41) *  c(sH)&
         + k(r42) *  c(sO2)&
         + k(r46b) *  c(sH2O)&
         + k(r58b) *  c(sH2O)&
         + k(r64) *  c(sCH3)&
         + k(r69f) *  c(sCH4)&
         + k(r79b) *  c(sCO)&
         + k(r108b) *  c(sCO2)&
         + k(rnog154) *  c(sNO)&
         + k(rnog166) *  c(sNO)&
         + k(rnog167f) *  c(sNO)&
         + k(r201b) *  c(sN2)&
         )

  X1XCH2_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(r43f) *  c(sH)&
         + k(r44) *  c(sO2)&
         + k(r45) *  c(sOH)&
         + k(r46f) *  c(sH2O)&
         + k(r47) *  c(sO)&
         + k(r48) *  c(sO)&
         + k(r49f) *  c(sH2O)&
         + k(r50) *  c(sO2)&
         + k(r51f) *  c(sH2)&
         + k(r55b) *  c(sH2O)&
         + k(r65) *  c(sCH3)&
         + k(r73f) *  c(sCH4)&
         + k(r79f) *  c(sCO)&
         + k(r100b) *  c(sH2O)&
         + k(r108f) *  c(sCO2)&
         + k(r110) *  c(sCO2)&
         + k(r133) *  c(sC2H6)&
         + k(r134b) *  c(sCO)&
         + k(rnog156) *  c(sNO)&
         + k(rnog161f) *  c(sNO)&
         + k(rnog169) *  c(sNO)&
         + k(r201f) *  c(sN2)&
         )

  CH_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(r28f) *  c(sH2)&
         + k(r29) *  c(sO)&
         + k(r30f) *  c(sH)&
         + k(r31) *  c(sO2)&
         + k(r32) *  c(sOH)&
         + k(r33) *  c(sH2O)&
         + k(r39b) *  c(sH2O)&
         + k(r43b) *  c(sH2)&
         + k(r57) *  c(sCH3)&
         + k(r68) *  c(sCH4)&
         + k(r75f) *  c(sCO)&
         + k(r109) *  c(sCO2)&
         + k(rnog153) *  c(sNO)&
         + k(rnog159) *  c(sNO)&
         + k(rnog160) *  c(sNO)&
         + k(rnog200) *  c(sN2)&
         )

  HCNO_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(rnog155b) *  c(sCO)&
         + k(rnog161b) *  c(sH)&
         + k(rnog167b) *  c(sH)&
         + k(rnog196) *  c(sH)&
         + k(rnog197) *  c(sH)&
         + k(rnog198) *  c(sH)&
         )

  CH3O_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(r61b) *  c(sO)&
         + k(r93b)&
         + k(r97) *  c(sH)&
         + k(r98) *  c(sH)&
         + k(r99) *  c(sOH)&
         + k(r100f) *  c(sH)&
         + k(r101) *  c(sO2)&
         + k(r102f) *  c(sH)&
         + k(r103) *  c(sO)&
         + k(r105b) *  c(sH2)&
         + k(r106b) *  c(sH2O)&
         + k(r107b) *  c(sCH4)&
         )

  HCCO_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(r75b)&
         + k(r112b) *  c(sH)&
         + k(r134f) *  c(sH)&
         + k(r135) *  c(sO2)&
         + k(r138) *  c(sO)&
         + k(rnog155f) *  c(sNO)&
         )

  C_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(r26) *  c(sO2)&
         + k(r27) *  c(sOH)&
         + k(r30b) *  c(sH2)&
         + k(r53) *  c(sCH3)&
         + k(rnog165) *  c(sNO)&
         )


! Primary constant parts -----------------------

  CH2_ct1 = ( 0.0_pr&
          + k(r40b) * c(sCH3) * c(sH)&
          + k(r58f) * c(sOH) * c(sCH3)&
          + k(r69b) * c(sCH3) * c(sCH3)&
          + k(r114) * c(sO) * c(sC2H2)                )

  X1XCH2_ct1 = ( 0.0_pr&
          + k(r49b) * c(sCH3OH)&
          + k(r51b) * c(sH) * c(sCH3)&
          + k(r55f) * c(sOH) * c(sCH3)&
          + k(r73b) * c(sCH3) * c(sCH3)                )

  CH_ct1 = ( 0.0_pr                )

  HCNO_ct1 = ( 0.0_pr                )

  CH3O_ct1 = ( 0.0_pr&
          + k(r52) * c(sHO2) * c(sCH3)&
          + k(r61f) * c(sCH3) * c(sO2)&
          + k(r93f) * c(sH) * c(sCH2O)&
          + k(r102b) * c(sCH3) * c(sOH)&
          + k(r104) * c(sO) * c(sCH3OH)&
          + k(r105f) * c(sH) * c(sCH3OH)&
          + k(r106f) * c(sOH) * c(sCH3OH)&
          + k(r107f) * c(sCH3) * c(sCH3OH)                )

  HCCO_ct1 = ( 0.0_pr&
          + k(r112f) * c(sO) * c(sC2H2)                )

  C_ct1 = ( 0.0_pr                )


! CH2 ---------------------------------------

  CH2_denom2 = tiny(1.0_pr) + ( CH2_denom1                 )

  CH2_ct2 = ( CH2_ct1&
          ) / CH2_denom2

  CH2_X1XCH2 = ( 0.0_pr&
          + k(r46f)  * c(sH2O)+   k(r79f)  * c(sCO)+   k(r108f)  * c(sCO2)+   k(r201f)  * c(sN2)&
          ) / CH2_denom2

  CH2_CH = ( 0.0_pr&
          + k(r28f)  * c(sH2)+   k(r39b) * c(sH2O)&
          ) / CH2_denom2

  CH2_HCNO = ( 0.0_pr&
          + k(rnog167b)  * c(sH)&
          ) / CH2_denom2

  CH2_CH3O = ( 0.0_pr&
          ) / CH2_denom2

  CH2_HCCO = ( 0.0_pr&
          ) / CH2_denom2

  CH2_C = ( 0.0_pr&
          ) / CH2_denom2



  CH2_X1XCH2_coeff = ( 0.0_pr&
       + k(r46b) * c(sH2O) +   k(r79b) * c(sCO) +   k(r108b) * c(sCO2) +   k(r201b) * c(sN2)&
       )

  CH2_CH_coeff = ( 0.0_pr&
       + k(r28b)  * c(sH)+   k(r39f) * c(sOH)&
       )

  CH2_HCNO_coeff = ( 0.0_pr&
       + k(rnog167f)  * c(sNO)&
       )

  CH2_CH3O_coeff = ( 0.0_pr&
       )

  CH2_HCCO_coeff = ( 0.0_pr&
       )

  CH2_C_coeff = ( 0.0_pr&
       )


! X1XCH2 ---------------------------------------

  X1XCH2_denom2 = tiny(1.0_pr) + ( X1XCH2_denom1&
          - CH2_X1XCH2_coeff * CH2_X1XCH2                )

  X1XCH2_ct2 = ( X1XCH2_ct1&
          + CH2_X1XCH2_coeff * CH2_ct2&
          ) / X1XCH2_denom2

  X1XCH2_CH = ( 0.0_pr&
          + k(r43b) * c(sH2)&
          + CH2_X1XCH2_coeff * CH2_CH&
          ) / X1XCH2_denom2

  X1XCH2_HCNO = ( 0.0_pr&
          + k(rnog161b)  * c(sH)&
          + CH2_X1XCH2_coeff * CH2_HCNO&
          ) / X1XCH2_denom2

  X1XCH2_CH3O = ( 0.0_pr&
          + k(r100f) * c(sH)&
          + CH2_X1XCH2_coeff * CH2_CH3O&
          ) / X1XCH2_denom2

  X1XCH2_HCCO = ( 0.0_pr&
          + k(r134f) * c(sH)&
          + CH2_X1XCH2_coeff * CH2_HCCO&
          ) / X1XCH2_denom2

  X1XCH2_C = ( 0.0_pr&
          + CH2_X1XCH2_coeff * CH2_C&
          ) / X1XCH2_denom2



  X1XCH2_CH_coeff = ( 0.0_pr&
       + k(r43f) * c(sH)&
       + CH2_CH_coeff * CH2_X1XCH2&
       )

  X1XCH2_HCNO_coeff = ( 0.0_pr&
       + k(rnog161f)  * c(sNO)&
       + CH2_HCNO_coeff * CH2_X1XCH2&
       )

  X1XCH2_CH3O_coeff = ( 0.0_pr&
       + k(r100b) * c(sH2O)&
       + CH2_CH3O_coeff * CH2_X1XCH2&
       )

  X1XCH2_HCCO_coeff = ( 0.0_pr&
       + k(r134b) * c(sCO)&
       + CH2_HCCO_coeff * CH2_X1XCH2&
       )

  X1XCH2_C_coeff = ( 0.0_pr&
       + CH2_C_coeff * CH2_X1XCH2&
       )


! CH ---------------------------------------

  CH_denom2 = tiny(1.0_pr) + ( CH_denom1&
          - CH2_CH_coeff * CH2_CH&
          - X1XCH2_CH_coeff * X1XCH2_CH                )

  CH_ct2 = ( CH_ct1&
          + CH2_CH_coeff * CH2_ct2&
          + X1XCH2_CH_coeff * X1XCH2_ct2&
          ) / CH_denom2

  CH_HCNO = ( 0.0_pr&
          + CH2_CH_coeff * CH2_HCNO&
          + X1XCH2_CH_coeff * X1XCH2_HCNO&
          ) / CH_denom2

  CH_CH3O = ( 0.0_pr&
          + CH2_CH_coeff * CH2_CH3O&
          + X1XCH2_CH_coeff * X1XCH2_CH3O&
          ) / CH_denom2

  CH_HCCO = ( 0.0_pr&
          + k(r75b)&
          + CH2_CH_coeff * CH2_HCCO&
          + X1XCH2_CH_coeff * X1XCH2_HCCO&
          ) / CH_denom2

  CH_C = ( 0.0_pr&
          + k(r30b) * c(sH2)&
          + CH2_CH_coeff * CH2_C&
          + X1XCH2_CH_coeff * X1XCH2_C&
          ) / CH_denom2



  CH_HCNO_coeff = ( 0.0_pr&
       + CH2_HCNO_coeff * CH2_CH&
       + X1XCH2_HCNO_coeff * X1XCH2_CH&
       )

  CH_CH3O_coeff = ( 0.0_pr&
       + CH2_CH3O_coeff * CH2_CH&
       + X1XCH2_CH3O_coeff * X1XCH2_CH&
       )

  CH_HCCO_coeff = ( 0.0_pr&
       + k(r75f)  * c(sCO)&
       + CH2_HCCO_coeff * CH2_CH&
       + X1XCH2_HCCO_coeff * X1XCH2_CH&
       )

  CH_C_coeff = ( 0.0_pr&
       + k(r30f) * c(sH)&
       + CH2_C_coeff * CH2_CH&
       + X1XCH2_C_coeff * X1XCH2_CH&
       )


! HCNO ---------------------------------------

  HCNO_denom2 = tiny(1.0_pr) + ( HCNO_denom1&
          - CH2_HCNO_coeff * CH2_HCNO&
          - X1XCH2_HCNO_coeff * X1XCH2_HCNO&
          - CH_HCNO_coeff * CH_HCNO                )

  HCNO_ct2 = ( HCNO_ct1&
          + CH2_HCNO_coeff * CH2_ct2&
          + X1XCH2_HCNO_coeff * X1XCH2_ct2&
          + CH_HCNO_coeff * CH_ct2&
          ) / HCNO_denom2

  HCNO_CH3O = ( 0.0_pr&
          + CH2_HCNO_coeff * CH2_CH3O&
          + X1XCH2_HCNO_coeff * X1XCH2_CH3O&
          + CH_HCNO_coeff * CH_CH3O&
          ) / HCNO_denom2

  HCNO_HCCO = ( 0.0_pr&
          + k(rnog155f)  * c(sNO)&
          + CH2_HCNO_coeff * CH2_HCCO&
          + X1XCH2_HCNO_coeff * X1XCH2_HCCO&
          + CH_HCNO_coeff * CH_HCCO&
          ) / HCNO_denom2

  HCNO_C = ( 0.0_pr&
          + CH2_HCNO_coeff * CH2_C&
          + X1XCH2_HCNO_coeff * X1XCH2_C&
          + CH_HCNO_coeff * CH_C&
          ) / HCNO_denom2



  HCNO_CH3O_coeff = ( 0.0_pr&
       + CH2_CH3O_coeff * CH2_HCNO&
       + X1XCH2_CH3O_coeff * X1XCH2_HCNO&
       + CH_CH3O_coeff * CH_HCNO&
       )

  HCNO_HCCO_coeff = ( 0.0_pr&
       + k(rnog155b) * c(sCO)&
       + CH2_HCCO_coeff * CH2_HCNO&
       + X1XCH2_HCCO_coeff * X1XCH2_HCNO&
       + CH_HCCO_coeff * CH_HCNO&
       )

  HCNO_C_coeff = ( 0.0_pr&
       + CH2_C_coeff * CH2_HCNO&
       + X1XCH2_C_coeff * X1XCH2_HCNO&
       + CH_C_coeff * CH_HCNO&
       )


! CH3O ---------------------------------------

  CH3O_denom2 = tiny(1.0_pr) + ( CH3O_denom1&
          - CH2_CH3O_coeff * CH2_CH3O&
          - X1XCH2_CH3O_coeff * X1XCH2_CH3O&
          - CH_CH3O_coeff * CH_CH3O&
          - HCNO_CH3O_coeff * HCNO_CH3O                )

  CH3O_ct2 = ( CH3O_ct1&
          + CH2_CH3O_coeff * CH2_ct2&
          + X1XCH2_CH3O_coeff * X1XCH2_ct2&
          + CH_CH3O_coeff * CH_ct2&
          + HCNO_CH3O_coeff * HCNO_ct2&
          ) / CH3O_denom2

  CH3O_HCCO = ( 0.0_pr&
          + CH2_CH3O_coeff * CH2_HCCO&
          + X1XCH2_CH3O_coeff * X1XCH2_HCCO&
          + CH_CH3O_coeff * CH_HCCO&
          + HCNO_CH3O_coeff * HCNO_HCCO&
          ) / CH3O_denom2

  CH3O_C = ( 0.0_pr&
          + CH2_CH3O_coeff * CH2_C&
          + X1XCH2_CH3O_coeff * X1XCH2_C&
          + CH_CH3O_coeff * CH_C&
          + HCNO_CH3O_coeff * HCNO_C&
          ) / CH3O_denom2



  CH3O_HCCO_coeff = ( 0.0_pr&
       + CH2_HCCO_coeff * CH2_CH3O&
       + X1XCH2_HCCO_coeff * X1XCH2_CH3O&
       + CH_HCCO_coeff * CH_CH3O&
       + HCNO_HCCO_coeff * HCNO_CH3O&
       )

  CH3O_C_coeff = ( 0.0_pr&
       + CH2_C_coeff * CH2_CH3O&
       + X1XCH2_C_coeff * X1XCH2_CH3O&
       + CH_C_coeff * CH_CH3O&
       + HCNO_C_coeff * HCNO_CH3O&
       )


! HCCO ---------------------------------------

  HCCO_denom2 = tiny(1.0_pr) + ( HCCO_denom1&
          - CH2_HCCO_coeff * CH2_HCCO&
          - X1XCH2_HCCO_coeff * X1XCH2_HCCO&
          - CH_HCCO_coeff * CH_HCCO&
          - HCNO_HCCO_coeff * HCNO_HCCO&
          - CH3O_HCCO_coeff * CH3O_HCCO                )

  HCCO_ct2 = ( HCCO_ct1&
          + CH2_HCCO_coeff * CH2_ct2&
          + X1XCH2_HCCO_coeff * X1XCH2_ct2&
          + CH_HCCO_coeff * CH_ct2&
          + HCNO_HCCO_coeff * HCNO_ct2&
          + CH3O_HCCO_coeff * CH3O_ct2&
          ) / HCCO_denom2

  HCCO_C = ( 0.0_pr&
          + CH2_HCCO_coeff * CH2_C&
          + X1XCH2_HCCO_coeff * X1XCH2_C&
          + CH_HCCO_coeff * CH_C&
          + HCNO_HCCO_coeff * HCNO_C&
          + CH3O_HCCO_coeff * CH3O_C&
          ) / HCCO_denom2



  HCCO_C_coeff = ( 0.0_pr&
       + CH2_C_coeff * CH2_HCCO&
       + X1XCH2_C_coeff * X1XCH2_HCCO&
       + CH_C_coeff * CH_HCCO&
       + HCNO_C_coeff * HCNO_HCCO&
       + CH3O_C_coeff * CH3O_HCCO&
       )


! C ---------------------------------------

  C_denom2 = tiny(1.0_pr) + ( C_denom1&
          - CH2_C_coeff * CH2_C&
          - X1XCH2_C_coeff * X1XCH2_C&
          - CH_C_coeff * CH_C&
          - HCNO_C_coeff * HCNO_C&
          - CH3O_C_coeff * CH3O_C&
          - HCCO_C_coeff * HCCO_C                )

  C_ct2 = ( C_ct1&
          + CH2_C_coeff * CH2_ct2&
          + X1XCH2_C_coeff * X1XCH2_ct2&
          + CH_C_coeff * CH_ct2&
          + HCNO_C_coeff * HCNO_ct2&
          + CH3O_C_coeff * CH3O_ct2&
          + HCCO_C_coeff * HCCO_ct2&
          ) / C_denom2




! Reconstruction ------------------------------------

  cqss(sC-nspec) = ( C_ct2                 )

  cqss(sHCCO-nspec) = ( HCCO_ct2&
          + HCCO_C * cqss(sC-nspec)                )

  cqss(sCH3O-nspec) = ( CH3O_ct2&
          + CH3O_HCCO * cqss(sHCCO-nspec)&
          + CH3O_C * cqss(sC-nspec)                )

  cqss(sHCNO-nspec) = ( HCNO_ct2&
          + HCNO_CH3O * cqss(sCH3O-nspec)&
          + HCNO_HCCO * cqss(sHCCO-nspec)&
          + HCNO_C * cqss(sC-nspec)                )

  cqss(sCH-nspec) = ( CH_ct2&
          + CH_HCNO * cqss(sHCNO-nspec)&
          + CH_CH3O * cqss(sCH3O-nspec)&
          + CH_HCCO * cqss(sHCCO-nspec)&
          + CH_C * cqss(sC-nspec)                )

  cqss(s1XCH2-nspec) = ( X1XCH2_ct2&
          + X1XCH2_CH * cqss(sCH-nspec)&
          + X1XCH2_HCNO * cqss(sHCNO-nspec)&
          + X1XCH2_CH3O * cqss(sCH3O-nspec)&
          + X1XCH2_HCCO * cqss(sHCCO-nspec)&
          + X1XCH2_C * cqss(sC-nspec)                )

  cqss(sCH2-nspec) = ( CH2_ct2&
          + CH2_X1XCH2 * cqss(s1XCH2-nspec)&
          + CH2_CH * cqss(sCH-nspec)&
          + CH2_HCNO * cqss(sHCNO-nspec)&
          + CH2_CH3O * cqss(sCH3O-nspec)&
          + CH2_HCCO * cqss(sHCCO-nspec)&
          + CH2_C * cqss(sC-nspec)                )

! cqss(sC2H3) (uncoupled) --------------------

  cqss(sC2H3-nspec) = ( 0.0_pr&
          + k(r57) * cqss(sCH-nspec) *c(sCH3)&
          + k(r113f) * c(sH) * c(sC2H2)&
          + k(r119f) * c(sH) * c(sC2H4)&
          + k(r120f) * c(sCH3) * c(sC2H4)&
          + k(r121f) * c(sOH) * c(sC2H4)&
          ) / ( tiny(1.0_pr) + (&
          + k(r113b)&
          + k(r115) *  c(sO2)&
          + k(r116) *  c(sH)&
          + k(r117) *  c(sOH)&
          + k(r118) *  c(sH)&
          + k(r119b) *  c(sH2)&
          + k(r120b) *  c(sCH4)&
          + k(r121b) *  c(sH2O)                 ) )


! cqss(sC2H5) (uncoupled) --------------------

  cqss(sC2H5-nspec) = ( 0.0_pr&
          + k(r54f) * c(sCH3) * c(sCH3)&
          + k(r124f) * c(sH) * c(sC2H4)&
          + k(r125b) * c(sC2H4) * c(sHO2)&
          + k(r129f) * c(sOH) * c(sC2H6)&
          + k(r130) * c(sO) * c(sC2H6)&
          + k(r131f) * c(sH) * c(sC2H6)&
          + k(r132f) * c(sCH3) * c(sC2H6)&
          + k(r133) * cqss(s1XCH2-nspec) *c(sC2H6)&
          ) / ( tiny(1.0_pr) + (&
          + k(r54b) *  c(sH)&
          + k(r124b)&
          + k(r125f) *  c(sO2)&
          + k(r126) *  c(sH)&
          + k(r127) *  c(sH)&
          + k(r128) *  c(sO)&
          + k(r129b) *  c(sH2O)&
          + k(r131b) *  c(sH2)&
          + k(r132b) *  c(sCH4)                 ) )


! cqss(sHOCN) (uncoupled) --------------------

  cqss(sHOCN-nspec) = ( 0.0_pr&
          + k(rnog180f) * c(sHCN) * c(sOH)&
          ) / ( tiny(1.0_pr) + (&
          + k(rnog180b) *  c(sH)&
          + k(rnog199) *  c(sH)                 ) )


! c(sN) c(sNH) c(sNCO) c(sHNCO) c(sNH2) c(sHNO) c(sNNH) (coupled)  --------------------

! Primary denominators-----------------------

  N_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(rnog139f) *  c(sO2)&
         + k(rnog140f) *  c(sOH)&
         + k(rnog141) *  c(sCH3)&
         + k(rnog142b) *  c(sH2O)&
         + k(rnog143b) *  c(sH2)&
         + k(rnog162f) *  c(sNO)&
         + k(rnog183b) *  c(sCO) * M(mM32)&
         )

  NH_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(rnog142f) *  c(sOH)&
         + k(rnog143f) *  c(sH)&
         + k(rnog144f) *  c(sO)&
         + k(rnog145f) *  c(sO2)&
         + k(rnog146f) *  c(sH2O)&
         + k(rnog147f) *  c(sOH)&
         + k(rnog148) *  c(sO2)&
         + k(rnog149b) *  c(sH2)&
         + k(rnog150b) *  c(sOH)&
         + k(rnog151b) *  c(sH2O)&
         + k(rnog158f) *  c(sNO)&
         + k(rnog170f) *  c(sNO)&
         + k(rnog186b) *  c(sCO)&
         + k(rnog192b) *  c(sCO) * M(mM36)&
         + k(rnog207b) *  c(sNO)&
         )

  NCO_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(rnog178b) *  c(sH)&
         + k(rnog182) *  c(sO2)&
         + k(rnog183f) * M(mM32)&
         + k(rnog184) *  c(sO)&
         + k(rnog185) *  c(sNO)&
         + k(rnog186f) *  c(sH)&
         + k(rnog187) *  c(sOH)&
         + k(rnog188) *  c(sNO)&
         + k(rnog191b) *  c(sH2O)&
         + k(rnog193b) *  c(sOH)&
         + k(rnog194b) *  c(sH2)&
         )

  HNCO_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(rnog189f) *  c(sOH)&
         + k(rnog190) *  c(sO)&
         + k(rnog191f) *  c(sOH)&
         + k(rnog192f) * M(mM36)&
         + k(rnog193f) *  c(sO)&
         + k(rnog194f) *  c(sH)&
         + k(rnog195f) *  c(sH)&
         )

  NH2_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(rnog149f) *  c(sH)&
         + k(rnog150f) *  c(sO)&
         + k(rnog151f) *  c(sOH)&
         + k(rnog152f) *  c(sO)&
         + k(rnog189b) *  c(sCO2)&
         + k(rnog195b) *  c(sCO)&
         )

  HNO_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(rnog145b) *  c(sO)&
         + k(rnog146b) *  c(sH2)&
         + k(rnog147b) *  c(sH)&
         + k(rnog152b) *  c(sH)&
         + k(rnog164b) * M(mM31)&
         + k(rnog171f) *  c(sH)&
         + k(rnog172f) *  c(sO2)&
         + k(rnog173f) *  c(sO)&
         + k(rnog174f) *  c(sOH)&
         )

  NNH_denom1 = tiny(1.0_pr) + ( 0.0_pr&
         + k(rnog203f) *  c(sO2)&
         + k(rnog204f)&
         + k(rnog205) *  c(sO)&
         + k(rnog206) *  c(sH)&
         + k(rnog207f) *  c(sO)&
         + k(rnog208f) *  c(sOH)&
         + k(rnog209f) * M(mM30)&
         )


! Primary constant parts -----------------------

  N_ct1 = ( 0.0_pr&
          + k(rnog139b) * c(sO) * c(sNO)&
          + k(rnog140b) * c(sH) * c(sNO)&
          + k(rnog160) * cqss(sCH-nspec) *c(sNO)&
          + k(rnog162b) * c(sO) * c(sN2)&
          + k(rnog165) * cqss(sC-nspec) *c(sNO)&
          + k(rnog200) * cqss(sCH-nspec) *c(sN2)                )

  NH_ct1 = ( 0.0_pr&
          + k(rnog144b) * c(sH) * c(sNO)&
          + k(rnog158b) * c(sH) * c(sN2O)&
          + k(rnog170b) * c(sOH) * c(sN2)&
          + k(rnog181) * c(sHCN) * c(sO)                )

  NCO_ct1 = ( 0.0_pr&
          + k(rnog153) * cqss(sCH-nspec) *c(sNO)&
          + k(rnog178f) * c(sHCN) * c(sO)                )

  HNCO_ct1 = ( 0.0_pr&
          + k(rnog166) * cqss(sCH2-nspec) *c(sNO)&
          + k(rnog169) * cqss(s1XCH2-nspec) *c(sNO)&
          + k(rnog179) * c(sHCN) * c(sOH)&
          + k(rnog198) * cqss(sHCNO-nspec) *c(sH)&
          + k(rnog199) * cqss(sHOCN-nspec) *c(sH)                )

  NH2_ct1 = ( 0.0_pr&
          + k(rnog177) * c(sHCN) * c(sOH)&
          + k(rnog196) * cqss(sHCNO-nspec) *c(sH)                )

  HNO_ct1 = ( 0.0_pr&
          + k(rnog164f) * c(sH) * c(sNO) * M(mM31)&
          + k(rnog171b) * c(sNO) * c(sH2)&
          + k(rnog172b) * c(sNO) * c(sHO2)&
          + k(rnog173b) * c(sOH) * c(sNO)&
          + k(rnog174b) * c(sH2O) * c(sNO)                )

  NNH_ct1 = ( 0.0_pr&
          + k(rnog203b) * c(sN2) * c(sHO2)&
          + k(rnog204b) * c(sH) * c(sN2)&
          + k(rnog208b) * c(sN2) * c(sH2O)&
          + k(rnog209b) * c(sH) * c(sN2) * M(mM30)                )


! N ---------------------------------------

  N_denom2 = tiny(1.0_pr) + ( N_denom1                 )

  N_ct2 = ( N_ct1&
          ) / N_denom2

  N_NH = ( 0.0_pr&
          + k(rnog142f)  * c(sOH)+   k(rnog143f)  * c(sH)&
          ) / N_denom2

  N_NCO = ( 0.0_pr&
          + k(rnog183f)  * M(mM32)&
          ) / N_denom2

  N_HNCO = ( 0.0_pr&
          ) / N_denom2

  N_NH2 = ( 0.0_pr&
          ) / N_denom2

  N_HNO = ( 0.0_pr&
          ) / N_denom2

  N_NNH = ( 0.0_pr&
          ) / N_denom2



  N_NH_coeff = ( 0.0_pr&
       + k(rnog142b) * c(sH2O) +   k(rnog143b) * c(sH2)&
       )

  N_NCO_coeff = ( 0.0_pr&
       + k(rnog183b) * c(sCO)  * M(mM32)&
       )

  N_HNCO_coeff = ( 0.0_pr&
       )

  N_NH2_coeff = ( 0.0_pr&
       )

  N_HNO_coeff = ( 0.0_pr&
       )

  N_NNH_coeff = ( 0.0_pr&
       )


! NH ---------------------------------------

  NH_denom2 = tiny(1.0_pr) + ( NH_denom1&
          - N_NH_coeff * N_NH                )

  NH_ct2 = ( NH_ct1&
          + N_NH_coeff * N_ct2&
          ) / NH_denom2

  NH_NCO = ( 0.0_pr&
          + k(rnog186f)  * c(sH)&
          + N_NH_coeff * N_NCO&
          ) / NH_denom2

  NH_HNCO = ( 0.0_pr&
          + k(rnog190)  * c(sO)+   k(rnog192f)  * M(mM36)&
          + N_NH_coeff * N_HNCO&
          ) / NH_denom2

  NH_NH2 = ( 0.0_pr&
          + k(rnog149f)  * c(sH)+   k(rnog150f)  * c(sO)+   k(rnog151f)  * c(sOH)&
          + N_NH_coeff * N_NH2&
          ) / NH_denom2

  NH_HNO = ( 0.0_pr&
          + k(rnog145b) * c(sO) +   k(rnog146b) * c(sH2) +   k(rnog147b) * c(sH)&
          + N_NH_coeff * N_HNO&
          ) / NH_denom2

  NH_NNH = ( 0.0_pr&
          + k(rnog207f)  * c(sO)&
          + N_NH_coeff * N_NNH&
          ) / NH_denom2



  NH_NCO_coeff = ( 0.0_pr&
       + k(rnog186b) * c(sCO)&
       + N_NCO_coeff * N_NH&
       )

  NH_HNCO_coeff = ( 0.0_pr&
       + k(rnog192b) * c(sCO)  * M(mM36)&
       + N_HNCO_coeff * N_NH&
       )

  NH_NH2_coeff = ( 0.0_pr&
       + k(rnog149b) * c(sH2) +   k(rnog150b)  * c(sOH)+   k(rnog151b) * c(sH2O)&
       + N_NH2_coeff * N_NH&
       )

  NH_HNO_coeff = ( 0.0_pr&
       + k(rnog145f)  * c(sO2)+   k(rnog146f)  * c(sH2O)+   k(rnog147f)  * c(sOH)&
       + N_HNO_coeff * N_NH&
       )

  NH_NNH_coeff = ( 0.0_pr&
       + k(rnog207b) * c(sNO)&
       + N_NNH_coeff * N_NH&
       )


! NCO ---------------------------------------

  NCO_denom2 = tiny(1.0_pr) + ( NCO_denom1&
          - N_NCO_coeff * N_NCO&
          - NH_NCO_coeff * NH_NCO                )

  NCO_ct2 = ( NCO_ct1&
          + N_NCO_coeff * N_ct2&
          + NH_NCO_coeff * NH_ct2&
          ) / NCO_denom2

  NCO_HNCO = ( 0.0_pr&
          + k(rnog191f)  * c(sOH)+   k(rnog193f)  * c(sO)+   k(rnog194f)  * c(sH)&
          + N_NCO_coeff * N_HNCO&
          + NH_NCO_coeff * NH_HNCO&
          ) / NCO_denom2

  NCO_NH2 = ( 0.0_pr&
          + N_NCO_coeff * N_NH2&
          + NH_NCO_coeff * NH_NH2&
          ) / NCO_denom2

  NCO_HNO = ( 0.0_pr&
          + N_NCO_coeff * N_HNO&
          + NH_NCO_coeff * NH_HNO&
          ) / NCO_denom2

  NCO_NNH = ( 0.0_pr&
          + N_NCO_coeff * N_NNH&
          + NH_NCO_coeff * NH_NNH&
          ) / NCO_denom2



  NCO_HNCO_coeff = ( 0.0_pr&
       + k(rnog191b) * c(sH2O) +   k(rnog193b) * c(sOH) +   k(rnog194b)  * c(sH2)&
       + N_HNCO_coeff * N_NCO&
       + NH_HNCO_coeff * NH_NCO&
       )

  NCO_NH2_coeff = ( 0.0_pr&
       + N_NH2_coeff * N_NCO&
       + NH_NH2_coeff * NH_NCO&
       )

  NCO_HNO_coeff = ( 0.0_pr&
       + N_HNO_coeff * N_NCO&
       + NH_HNO_coeff * NH_NCO&
       )

  NCO_NNH_coeff = ( 0.0_pr&
       + N_NNH_coeff * N_NCO&
       + NH_NNH_coeff * NH_NCO&
       )


! HNCO ---------------------------------------

  HNCO_denom2 = tiny(1.0_pr) + ( HNCO_denom1&
          - N_HNCO_coeff * N_HNCO&
          - NH_HNCO_coeff * NH_HNCO&
          - NCO_HNCO_coeff * NCO_HNCO                )

  HNCO_ct2 = ( HNCO_ct1&
          + N_HNCO_coeff * N_ct2&
          + NH_HNCO_coeff * NH_ct2&
          + NCO_HNCO_coeff * NCO_ct2&
          ) / HNCO_denom2

  HNCO_NH2 = ( 0.0_pr&
          + k(rnog189b) * c(sCO2) +   k(rnog195b) * c(sCO)&
          + N_HNCO_coeff * N_NH2&
          + NH_HNCO_coeff * NH_NH2&
          + NCO_HNCO_coeff * NCO_NH2&
          ) / HNCO_denom2

  HNCO_HNO = ( 0.0_pr&
          + N_HNCO_coeff * N_HNO&
          + NH_HNCO_coeff * NH_HNO&
          + NCO_HNCO_coeff * NCO_HNO&
          ) / HNCO_denom2

  HNCO_NNH = ( 0.0_pr&
          + N_HNCO_coeff * N_NNH&
          + NH_HNCO_coeff * NH_NNH&
          + NCO_HNCO_coeff * NCO_NNH&
          ) / HNCO_denom2



  HNCO_NH2_coeff = ( 0.0_pr&
       + k(rnog189f)  * c(sOH)+   k(rnog195f)  * c(sH)&
       + N_NH2_coeff * N_HNCO&
       + NH_NH2_coeff * NH_HNCO&
       + NCO_NH2_coeff * NCO_HNCO&
       )

  HNCO_HNO_coeff = ( 0.0_pr&
       + N_HNO_coeff * N_HNCO&
       + NH_HNO_coeff * NH_HNCO&
       + NCO_HNO_coeff * NCO_HNCO&
       )

  HNCO_NNH_coeff = ( 0.0_pr&
       + N_NNH_coeff * N_HNCO&
       + NH_NNH_coeff * NH_HNCO&
       + NCO_NNH_coeff * NCO_HNCO&
       )


! NH2 ---------------------------------------

  NH2_denom2 = tiny(1.0_pr) + ( NH2_denom1&
          - N_NH2_coeff * N_NH2&
          - NH_NH2_coeff * NH_NH2&
          - NCO_NH2_coeff * NCO_NH2&
          - HNCO_NH2_coeff * HNCO_NH2                )

  NH2_ct2 = ( NH2_ct1&
          + N_NH2_coeff * N_ct2&
          + NH_NH2_coeff * NH_ct2&
          + NCO_NH2_coeff * NCO_ct2&
          + HNCO_NH2_coeff * HNCO_ct2&
          ) / NH2_denom2

  NH2_HNO = ( 0.0_pr&
          + k(rnog152b)  * c(sH)&
          + N_NH2_coeff * N_HNO&
          + NH_NH2_coeff * NH_HNO&
          + NCO_NH2_coeff * NCO_HNO&
          + HNCO_NH2_coeff * HNCO_HNO&
          ) / NH2_denom2

  NH2_NNH = ( 0.0_pr&
          + N_NH2_coeff * N_NNH&
          + NH_NH2_coeff * NH_NNH&
          + NCO_NH2_coeff * NCO_NNH&
          + HNCO_NH2_coeff * HNCO_NNH&
          ) / NH2_denom2



  NH2_HNO_coeff = ( 0.0_pr&
       + k(rnog152f)  * c(sO)&
       + N_HNO_coeff * N_NH2&
       + NH_HNO_coeff * NH_NH2&
       + NCO_HNO_coeff * NCO_NH2&
       + HNCO_HNO_coeff * HNCO_NH2&
       )

  NH2_NNH_coeff = ( 0.0_pr&
       + N_NNH_coeff * N_NH2&
       + NH_NNH_coeff * NH_NH2&
       + NCO_NNH_coeff * NCO_NH2&
       + HNCO_NNH_coeff * HNCO_NH2&
       )


! HNO ---------------------------------------

  HNO_denom2 = tiny(1.0_pr) + ( HNO_denom1&
          - N_HNO_coeff * N_HNO&
          - NH_HNO_coeff * NH_HNO&
          - NCO_HNO_coeff * NCO_HNO&
          - HNCO_HNO_coeff * HNCO_HNO&
          - NH2_HNO_coeff * NH2_HNO                )

  HNO_ct2 = ( HNO_ct1&
          + N_HNO_coeff * N_ct2&
          + NH_HNO_coeff * NH_ct2&
          + NCO_HNO_coeff * NCO_ct2&
          + HNCO_HNO_coeff * HNCO_ct2&
          + NH2_HNO_coeff * NH2_ct2&
          ) / HNO_denom2

  HNO_NNH = ( 0.0_pr&
          + N_HNO_coeff * N_NNH&
          + NH_HNO_coeff * NH_NNH&
          + NCO_HNO_coeff * NCO_NNH&
          + HNCO_HNO_coeff * HNCO_NNH&
          + NH2_HNO_coeff * NH2_NNH&
          ) / HNO_denom2



  HNO_NNH_coeff = ( 0.0_pr&
       + N_NNH_coeff * N_HNO&
       + NH_NNH_coeff * NH_HNO&
       + NCO_NNH_coeff * NCO_HNO&
       + HNCO_NNH_coeff * HNCO_HNO&
       + NH2_NNH_coeff * NH2_HNO&
       )


! NNH ---------------------------------------

  NNH_denom2 = tiny(1.0_pr) + ( NNH_denom1&
          - N_NNH_coeff * N_NNH&
          - NH_NNH_coeff * NH_NNH&
          - NCO_NNH_coeff * NCO_NNH&
          - HNCO_NNH_coeff * HNCO_NNH&
          - NH2_NNH_coeff * NH2_NNH&
          - HNO_NNH_coeff * HNO_NNH                )

  NNH_ct2 = ( NNH_ct1&
          + N_NNH_coeff * N_ct2&
          + NH_NNH_coeff * NH_ct2&
          + NCO_NNH_coeff * NCO_ct2&
          + HNCO_NNH_coeff * HNCO_ct2&
          + NH2_NNH_coeff * NH2_ct2&
          + HNO_NNH_coeff * HNO_ct2&
          ) / NNH_denom2




! Reconstruction ------------------------------------

  cqss(sNNH-nspec) = ( NNH_ct2                 )

  cqss(sHNO-nspec) = ( HNO_ct2&
          + HNO_NNH * cqss(sNNH-nspec)                )

  cqss(sNH2-nspec) = ( NH2_ct2&
          + NH2_HNO * cqss(sHNO-nspec)&
          + NH2_NNH * cqss(sNNH-nspec)                )

  cqss(sHNCO-nspec) = ( HNCO_ct2&
          + HNCO_NH2 * cqss(sNH2-nspec)&
          + HNCO_HNO * cqss(sHNO-nspec)&
          + HNCO_NNH * cqss(sNNH-nspec)                )

  cqss(sNCO-nspec) = ( NCO_ct2&
          + NCO_HNCO * cqss(sHNCO-nspec)&
          + NCO_NH2 * cqss(sNH2-nspec)&
          + NCO_HNO * cqss(sHNO-nspec)&
          + NCO_NNH * cqss(sNNH-nspec)                )

  cqss(sNH-nspec) = ( NH_ct2&
          + NH_NCO * cqss(sNCO-nspec)&
          + NH_HNCO * cqss(sHNCO-nspec)&
          + NH_NH2 * cqss(sNH2-nspec)&
          + NH_HNO * cqss(sHNO-nspec)&
          + NH_NNH * cqss(sNNH-nspec)                )

  cqss(sN-nspec) = ( N_ct2&
          + N_NH * cqss(sNH-nspec)&
          + N_NCO * cqss(sNCO-nspec)&
          + N_HNCO * cqss(sHNCO-nspec)&
          + N_NH2 * cqss(sNH2-nspec)&
          + N_HNO * cqss(sHNO-nspec)&
          + N_NNH * cqss(sNNH-nspec)                )

! cqss(sHCO) (uncoupled) --------------------

  cqss(sHCO-nspec) = ( 0.0_pr&
          + k(r31) * cqss(sCH-nspec) *c(sO2)&
          + k(r32) * c(sOH) * cqss(sCH-nspec)&
          + k(r38) * c(sO) * cqss(sCH2-nspec)&
          + k(r42) * cqss(sCH2-nspec) *c(sO2)&
          + k(r47) * c(sO) * cqss(s1XCH2-nspec)&
          + k(r83b) * c(sCO) * c(sH) * M(mM26)&
          + k(r85b) * c(sH2O) * c(sCO) * c(sH)&
          + k(r88) * c(sHO2) * c(sCH2O)&
          + k(r89) * c(sOH) * c(sCH2O)&
          + k(r90f) * c(sO2) * c(sCH2O)&
          + k(r91f) * c(sH) * c(sCH2O)&
          + k(r92) * c(sO) * c(sCH2O)&
          + k(r94) * c(sCH2O)&
          + k(r95) * c(sCH3) * c(sCH2O)&
          + k(r109) * cqss(sCH-nspec) *c(sCO2)&
          + k(r115) * cqss(sC2H3-nspec) *c(sO2)&
          + k(r123) * c(sO) * c(sC2H4)&
          + k(rnog160) * cqss(sCH-nspec) *c(sNO)&
          ) / ( tiny(1.0_pr) + (&
          + k(r80) *  c(sO)&
          + k(r81) *  c(sH)&
          + k(r82) *  c(sO)&
          + k(r83f) * M(mM26)&
          + k(r84) *  c(sOH)&
          + k(r85f) *  c(sH2O)&
          + k(r86) *  c(sO2)&
          + k(r87) *  c(sCH3)&
          + k(r90b) *  c(sHO2)&
          + k(r91b) *  c(sH2)                 ) )


END SUBROUTINE get_QSS


END MODULE mod_CH4_NOX_22_320_18_TJ



!--------------------------------------------------------------------------------------------------
!     SUBROUTINE CH4_NOX_22_320_18_TJ
!>    @details Subroutine for calculating the analytical source terms for the CH4_NOX_22_320_18_TJ scheme.
!!    @authors T. Jaravel
!!    @date    15-07-2015
!!    @param [in]    nnode        Dimension of the table (the routine is either called at cells or nodes)
!!    @param [in]    neqs         Number of species
!!    @param [in]    rhoinv       Inverse of density vector
!!    @param [in]    press        Pressure vector
!!    @param [in]    tempe        Temperature vector
!!    @param [in]    w_spec       RhoYk vector
!!    @param [in]    wmol         Molar masses
!!    @param [out]   source_spec  The source term vector
!--------------------------------------------------------------------------------------------------
SUBROUTINE CH4_NOX_22_320_18_TJ ( nnode,neqs,rhoinv,press,tempe,w_spec,wmol,source_spec )

  USE mod_param_defs
  USE mod_CH4_NOX_22_320_18_TJ, ONLY: INTERNALAVBP

  IMPLICIT NONE

! IN/OUT
  INTEGER, INTENT(IN) :: nnode, neqs
  REAL(pr), DIMENSION(1:neqs), INTENT(IN) :: wmol
  REAL(pr), DIMENSION(1:nnode), INTENT(IN) :: rhoinv,press,tempe
  REAL(pr), DIMENSION(1:neqs,1:nnode), INTENT(IN) :: w_spec
  REAL(pr), DIMENSION(1:neqs,1:nnode), INTENT(OUT) ::source_spec

! LOCAL
  REAL(pr), DIMENSION(1:neqs) :: C                                      !< Activity concentrations of the species
  REAL(pr), DIMENSION(1:neqs) :: source_spec_buf
  REAL(pr) :: P                                                         !< Pressure
  REAL(pr) :: T                                                         !< Temperature
  INTEGER :: n,k


  DO n=1,nnode
    P = press(n)
    T = tempe(n)

!   Activity concentrations
    DO k=1,neqs
      C(k) = MAX( w_spec(k,n), zero )
      C(k) = MIN( C(k), one/rhoinv(n) )
      C(k) = C(k) / wmol(k)
    END DO

!   The internal YARC routine is called
    CALL INTERNALAVBP ( P, T, C, source_spec_buf )

!   Conversion from mol/m3/s to kg/m3/s
    DO k=1,neqs
      source_spec(k,n) = source_spec_buf(k) * wmol(k)
    END DO

  END DO


END SUBROUTINE CH4_NOX_22_320_18_TJ
