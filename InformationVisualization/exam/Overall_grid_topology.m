function[branch] = Overall_grid_topology(Base)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  MV grid

Zb1 = (Base.MV.V^2)/Base.MV.S;

% branch_first_MV = [1,2,3,4,5,6,7, 1,8, 9,10,11,12, 2, 3, 4, 6, 7,13, 11,  9,  8];
% branch_end_MV =   [2,3,4,5,6,7,13,8,9,10,11,12,13,14,31,47,63,79,95,112,128,145];
branch_first_MV = [1,2,3,4,5,6,1, 13,12,11,10, 9, 2, 3, 4, 6, 9,10, 11, 12, 13];
branch_end_MV =   [2,3,4,5,6,7,13,12,11,10, 9, 8,14,31,47,63,79,95,112,128,145];
branch_type_MV = [ones(1,12), 2*ones(1,9)];
branch_length_MV = [1*ones(1,12), 1*ones(1,9)];
R_MV = [0.993*ones(1,12), 0.012*ones(1,9)];         % valore preso da cavo alluminio 35 mm e per il trafo preso da ABB_CabineMtBt per trafo da 400kVA
X_MV = [0.205*ones(1,12), 0.0106*ones(1,9)];         % valore preso da cavo alluminio 35 mm e per il trafo preso da ABB_CabineMtBt per trafo da 400kVA
branch_R_MV = branch_length_MV.*R_MV;
branch_X_MV = branch_length_MV.*X_MV;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  LV grid

Zb2 = (Base.LV.V^2)/Base.LV.S;

branch_R_MV(1,1:12) = branch_R_MV(1,1:12)/Zb1;
branch_X_MV(1,1:12) = branch_X_MV(1,1:12)/Zb1;
branch_R_MV(13:21) = branch_R_MV(13:21)/Zb2;
branch_X_MV(13:21) = branch_X_MV(13:21)/Zb2;


branch_first_LV2 = [1,2,3, 1,5,6, 1,8, 9,  1,11,12,13,  1,15,16]+13;
branch_end_LV2 =   [2,3,4, 5,6,7, 8,9,10, 11,12,13,14, 15,16,17]+13;
branch_conc_LV2 = [{'LV_211'}; {'LV_212'}; {'LV_213'}; ...
                   {'LV_221'}; {'LV_222'}; {'LV_223'}; ...
                   {'LV_231'}; {'LV_232'}; {'LV_233'}; ...
                   {'LV_241'}; {'LV_242'}; {'LV_243'}; {'LV_244'}; ...
                   {'LV_251'}; {'LV_252'}; {'LV_253'}];
branch_subst_LV2 = cell(16,1);
branch_subst_LV2(:,1) = {'LV_002'};

branch_first_LV3 = [1,2,3, 1,5,6, 1,8, 9,  1,11,12,  1,14,15]+30;
branch_end_LV3 =   [2,3,4, 5,6,7, 8,9,10, 11,12,13, 14,15,16]+30;
branch_conc_LV3 = [{}; {'LV_311'}; {'LV_312'}; {'LV_313'}; ...
                   {'LV_321'}; {'LV_322'}; {'LV_323'}; ...
                   {'LV_331'}; {'LV_332'}; {'LV_333'}; ...
                   {'LV_341'}; {'LV_342'}; {'LV_343'}; ...
                   {'LV_351'}; {'LV_352'}; {'LV_353'}];
branch_subst_LV3 = cell(15,1);
branch_subst_LV3(:,1) = {'LV_003'};

branch_first_LV4 = [1,2,3, 1,5,6,7, 1, 9,10,  1,12,  1,14,15]+46;
branch_end_LV4 =   [2,3,4, 5,6,7,8, 9,10,11, 12,13, 14,15,16]+46;
branch_conc_LV4 = [{}; {'LV_411'}; {'LV_412'}; {'LV_413'}; ...
                   {'LV_421'}; {'LV_422'}; {'LV_423'}; {'LV_424'};...
                   {'LV_431'}; {'LV_432'}; {'LV_433'}; ...
                   {'LV_441'}; {'LV_442'}; ...
                   {'LV_451'}; {'LV_452'}; {'LV_453'}];
branch_subst_LV4 = cell(15,1);
branch_subst_LV4(:,1) = {'LV_004'};

branch_first_LV6 = [1,2,3, 1,5,6,7, 1, 9,10,11,  1,13,14,15]+62;
branch_end_LV6 =   [2,3,4, 5,6,7,8, 9,10,11,12, 13,14,15,16]+62;
branch_conc_LV6 = [{}; {'LV_611'}; {'LV_612'}; {'LV_613'}; ...
                   {'LV_621'}; {'LV_622'}; {'LV_623'}; {'LV_624'};...
                   {'LV_631'}; {'LV_632'}; {'LV_633'}; {'LV_634'};...
                   {'LV_641'}; {'LV_642'}; {'LV_643'}; {'LV_644'};];
branch_subst_LV6 = cell(15,1);
branch_subst_LV6(:,1) = {'LV_006'};

branch_first_LV9 = [1,2,3, 1,5,6, 1,8, 9,  1,11,12,  1,14,15]+78;
branch_end_LV9 =   [2,3,4, 5,6,7, 8,9,10, 11,12,13, 14,15,16]+78;
branch_conc_LV9 = [{}; {'LV_911'}; {'LV_912'}; {'LV_913'}; ...
                   {'LV_921'}; {'LV_922'}; {'LV_923'}; ...
                   {'LV_931'}; {'LV_932'}; {'LV_933'}; ...
                   {'LV_941'}; {'LV_942'}; {'LV_943'}; ...
                   {'LV_951'}; {'LV_952'}; {'LV_953'}];
branch_subst_LV9 = cell(15,1);
branch_subst_LV9(:,1) = {'LV_009'};

branch_first_LV10 = [1,2, 1,4,5, 1,7,8,  1,10,  1,12,13,  1,15,16]+94;
branch_end_LV10 =   [2,3, 4,5,6, 7,8,9, 10,11, 12,13,14, 15,16,17]+94;
branch_conc_LV10 = [{}; {'LV_1011'}; {'LV_1012'}; ...
                   {'LV_1021'}; {'LV_1022'}; {'LV_1023'}; ...
                   {'LV_1031'}; {'LV_1032'}; {'LV_1033'}; ...
                   {'LV_1041'}; {'LV_1042'}; ...
                   {'LV_1051'}; {'LV_1052'}; {'LV_1053'}; ...
                   {'LV_1061'}; {'LV_1062'}; {'LV_1063'}];
branch_subst_LV10 = cell(16,1);
branch_subst_LV10(:,1) = {'LV_010'};

branch_first_LV11 = [1,2,3, 1,5,6, 1,8, 9,  1,11,12,  1,14,15]+111;
branch_end_LV11 =   [2,3,4, 5,6,7, 8,9,10, 11,12,13, 14,15,16]+111;
branch_conc_LV11 = [{}; {'LV_1111'}; {'LV_1112'}; {'LV_1113'}; ...
                   {'LV_1121'}; {'LV_1122'}; {'LV_1123'}; ...
                   {'LV_1131'}; {'LV_1132'}; {'LV_1133'}; ...
                   {'LV_1141'}; {'LV_1142'}; {'LV_1143'}; ...
                   {'LV_1151'}; {'LV_1152'}; {'LV_1153'}];
branch_subst_LV11 = cell(15,1);
branch_subst_LV11(:,1) = {'LV_011'};

branch_first_LV12 = [1,2,3,4, 1,6,7, 1, 9,10,  1,12,13,14,  1,16]+127;
branch_end_LV12 =   [2,3,4,5, 6,7,8, 9,10,11, 12,13,14,15, 16,17]+127;
branch_conc_LV12 = [{}; {'LV_1211'}; {'LV_1212'}; {'LV_1213'}; {'LV_1214'}; ...
                   {'LV_1221'}; {'LV_1222'}; {'LV_1223'}; ...
                   {'LV_1231'}; {'LV_1232'}; {'LV_1233'}; ...
                   {'LV_1241'}; {'LV_1242'}; {'LV_1243'}; {'LV_1244'}; ...
                   {'LV_1251'}; {'LV_1252'}];
branch_subst_LV12 = cell(16,1);
branch_subst_LV12(:,1) = {'LV_012'};

branch_first_LV13 = [1,2,3, 1,5,6,7, 1, 9,10,  1,12,13,14,  1,16,17]+144;
branch_end_LV13 =   [2,3,4, 5,6,7,8, 9,10,11, 12,13,14,15, 16,17,18]+144;
branch_conc_LV13 = [{}; {'LV_1311'}; {'LV_1312'}; {'LV_1313'}; ...
                   {'LV_1321'}; {'LV_1322'}; {'LV_1323'}; {'LV_1324'}; ...
                   {'LV_1331'}; {'LV_1332'}; {'LV_1333'}; ...
                   {'LV_1341'}; {'LV_1342'}; {'LV_1343'}; {'LV_1344'}; ...
                   {'LV_1351'}; {'LV_1352'}; {'LV_1353'}];
branch_subst_LV13 = cell(17,1);
branch_subst_LV13(:,1) = {'LV_013'};

branch_type_LV = ones(1,140);
branch_length_LV = 0.2*ones(1,140);
R_LV = 0.483*ones(1,140);           % valore preso da cavo 3x50 IDE4L
X_LV = 0.0779*ones(1,140);          % valore preso da cavo 3x50 IDE4L             
branch_R_LV = branch_length_LV.*R_LV/Zb2;
branch_X_LV = branch_length_LV.*X_LV/Zb2;

branch.string.building.conc = [branch_conc_LV2; branch_conc_LV3; branch_conc_LV4; branch_conc_LV6; branch_conc_LV9; ...
                               branch_conc_LV10; branch_conc_LV11; branch_conc_LV12; branch_conc_LV13];
branch.string.building.subst = [branch_subst_LV2; branch_subst_LV3; branch_subst_LV4; branch_subst_LV6; branch_subst_LV9; ...
                               branch_subst_LV10; branch_subst_LV11; branch_subst_LV12; branch_subst_LV13];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Phase A concentrators

branch_first_LV2_conc_A = [15*ones(1,7), 16*ones(1,9), 17*ones(1,6), ...
                           18*ones(1,8), 19*ones(1,8), 20*ones(1,7), ...
                           21*ones(1,9), 22*ones(1,8), 23*ones(1,6), ...
                           24*ones(1,7), 25*ones(1,7), 26*ones(1,9), 27*ones(1,5)...
                           28*ones(1,6), 29*ones(1,6), 30*ones(1,8)];
                       
branch_end_LV2_conc_A = [163:1:278];

branch_first_LV3_conc_A = [32*ones(1,7), 33*ones(1,6), 34*ones(1,7), ...
                           35*ones(1,8), 36*ones(1,9), 37*ones(1,5), ...
                           38*ones(1,5), 39*ones(1,9), 40*ones(1,6), ...
                           41*ones(1,8), 42*ones(1,8), 43*ones(1,7), ...
                           44*ones(1,9), 45*ones(1,6), 46*ones(1,11)];

branch_end_LV3_conc_A = [279:1:389];

branch_first_LV4_conc_A = [48*ones(1,9), 49*ones(1,9), 50*ones(1,8),...
                           51*ones(1,7), 52*ones(1,8), 53*ones(1,7), 54*ones(1,5), ...
                           55*ones(1,7), 56*ones(1,5), 57*ones(1,6), ...
                           58*ones(1,9), 59*ones(1,9), ...
                           60*ones(1,8), 61*ones(1,10), 62*ones(1,9)];

branch_end_LV4_conc_A = [390:1:505];

branch_first_LV6_conc_A = [64*ones(1,8), 65*ones(1,8), 66*ones(1,6), ...
                           67*ones(1,9), 68*ones(1,6), 69*ones(1,7), 70*ones(1,6), ...
                           71*ones(1,7), 72*ones(1,7), 73*ones(1,6), 74*ones(1,5), ...
                           75*ones(1,7), 76*ones(1,9), 77*ones(1,6), 78*ones(1,5)];
                       
branch_end_LV6_conc_A = [506:1:607];

branch_first_LV9_conc_A = [80*ones(1,7), 81*ones(1,8), 82*ones(1,8), ...
                           83*ones(1,6), 84*ones(1,8), 85*ones(1,4), ...
                           86*ones(1,7), 87*ones(1,9), 88*ones(1,6), ...
                           89*ones(1,7), 90*ones(1,6), 91*ones(1,9), ...
                           92*ones(1,8), 93*ones(1,5), 94*ones(1,6)];
                       
branch_end_LV9_conc_A = [608:1:711];

branch_first_LV10_conc_A = [96*ones(1,7), 97*ones(1,10), ...
                           98*ones(1,7), 99*ones(1,8), 100*ones(1,6), ...
                           101*ones(1,6), 102*ones(1,7), 103*ones(1,7), ...
                           104*ones(1,7), 105*ones(1,9), ...
                           106*ones(1,8), 107*ones(1,5), 108*ones(1,8), ...
                           109*ones(1,7), 110*ones(1,8), 111*ones(1,7)];

branch_end_LV10_conc_A = [712:1:828];

branch_first_LV11_conc_A = [113*ones(1,9), 114*ones(1,7), 115*ones(1,6), ...
                           116*ones(1,6), 117*ones(1,7), 118*ones(1,5), ...
                           119*ones(1,8), 120*ones(1,9), 121*ones(1,7), ...
                           122*ones(1,7), 123*ones(1,6), 124*ones(1,9), ...
                           125*ones(1,6), 126*ones(1,5), 127*ones(1,6)];
                       
branch_end_LV11_conc_A = [829:1:931];

branch_first_LV12_conc_A = [129*ones(1,7), 130*ones(1,9), 131*ones(1,8), 132*ones(1,7), ...
                            133*ones(1,7), 134*ones(1,10), 135*ones(1,9), ...
                            136*ones(1,7), 137*ones(1,6), 138*ones(1,7), ...
                            139*ones(1,6), 140*ones(1,8), 141*ones(1,5), 142*ones(1,6), ...
                            143*ones(1,7), 144*ones(1,5)];

branch_end_LV12_conc_A = [932:1:1045];

branch_first_LV13_conc_A = [146*ones(1,8), 147*ones(1,8), 148*ones(1,7), ...
                            149*ones(1,7), 150*ones(1,6), 151*ones(1,8), 152*ones(1,5), ...
                            153*ones(1,7), 154*ones(1,8), 155*ones(1,6), ...
                            156*ones(1,8), 157*ones(1,5), 158*ones(1,9), 159*ones(1,5), ...
                            160*ones(1,6), 161*ones(1,6), 162*ones(1,8)];

branch_end_LV13_conc_A = [1046:1:1162];

branch_type_LV_conc_A = ones(1,1000);
branch_length_LV_conc_A = 0.1*ones(1,1000);
R_LV_conc_A = 0.907*ones(1,1000);           % valore preso da cavo 3x25 IDE4L
X_LV_conc_A = 0.0813*ones(1,1000);          % valore preso da cavo 3x25 IDE4L
branch_R_LV_conc_A = branch_length_LV_conc_A.*R_LV_conc_A/Zb2;
branch_X_LV_conc_A = branch_length_LV_conc_A.*X_LV_conc_A/Zb2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Phase B concentrators

branch_first_LV2_conc_B = [15*ones(1,5), 16*ones(1,10), 17*ones(1,8), ...
                           18*ones(1,5), 19*ones(1,9), 20*ones(1,8), ...
                           21*ones(1,9), 22*ones(1,8), 23*ones(1,7), ...
                           24*ones(1,6), 25*ones(1,7), 26*ones(1,7), 27*ones(1,8)...
                           28*ones(1,7), 29*ones(1,5), 30*ones(1,7)];
                       
branch_end_LV2_conc_B = [163:1:278];

branch_first_LV3_conc_B = [32*ones(1,6), 33*ones(1,8), 34*ones(1,7), ...
                           35*ones(1,7), 36*ones(1,8), 37*ones(1,7), ...
                           38*ones(1,8), 39*ones(1,7), 40*ones(1,7), ...
                           41*ones(1,6), 42*ones(1,8), 43*ones(1,9), ...
                           44*ones(1,8), 45*ones(1,8), 46*ones(1,8)];

branch_end_LV3_conc_B = [279:1:390];

branch_first_LV4_conc_B = [48*ones(1,7), 49*ones(1,9), 50*ones(1,10),...
                           51*ones(1,6), 52*ones(1,6), 53*ones(1,8), 54*ones(1,7), ...
                           55*ones(1,7), 56*ones(1,7), 57*ones(1,5), ...
                           58*ones(1,8), 59*ones(1,8), ...
                           60*ones(1,9), 61*ones(1,8), 62*ones(1,10)];

branch_end_LV4_conc_B = [391:1:505];

branch_first_LV6_conc_B = [64*ones(1,7), 65*ones(1,6), 66*ones(1,8), ...
                           67*ones(1,7), 68*ones(1,9), 69*ones(1,6), 70*ones(1,7), ...
                           71*ones(1,7), 72*ones(1,8), 73*ones(1,6), 74*ones(1,4), ...
                           75*ones(1,7), 76*ones(1,6), 77*ones(1,8), 78*ones(1,7)];
                       
branch_end_LV6_conc_B = [506:1:608];

branch_first_LV9_conc_B = [80*ones(1,7), 81*ones(1,6), 82*ones(1,6), ...
                           83*ones(1,7), 84*ones(1,6), 85*ones(1,8), ...
                           86*ones(1,7), 87*ones(1,7), 88*ones(1,8), ...
                           89*ones(1,6), 90*ones(1,6), 91*ones(1,7), ...
                           92*ones(1,8), 93*ones(1,7), 94*ones(1,7)];
                       
branch_end_LV9_conc_B = [609:1:711];

branch_first_LV10_conc_B = [96*ones(1,8), 97*ones(1,7), ...
                           98*ones(1,8), 99*ones(1,7), 100*ones(1,8), ...
                           101*ones(1,8), 102*ones(1,7), 103*ones(1,8), ...
                           104*ones(1,7), 105*ones(1,8), ...
                           106*ones(1,9), 107*ones(1,7), 108*ones(1,7), ...
                           109*ones(1,8), 110*ones(1,6), 111*ones(1,6)];

branch_end_LV10_conc_B = [712:1:830];

branch_first_LV11_conc_B = [113*ones(1,8), 114*ones(1,6), 115*ones(1,9), ...
                           116*ones(1,6), 117*ones(1,8), 118*ones(1,6), ...
                           119*ones(1,7), 120*ones(1,7), 121*ones(1,6), ...
                           122*ones(1,8), 123*ones(1,9), 124*ones(1,6), ...
                           125*ones(1,8), 126*ones(1,6), 127*ones(1,5)];
                       
branch_end_LV11_conc_B = [831:1:935];

branch_first_LV12_conc_B = [129*ones(1,6), 130*ones(1,8), 131*ones(1,7), 132*ones(1,8), ...
                            133*ones(1,8), 134*ones(1,8), 135*ones(1,8), ...
                            136*ones(1,8), 137*ones(1,8), 138*ones(1,6), ...
                            139*ones(1,7), 140*ones(1,7), 141*ones(1,6), 142*ones(1,7), ...
                            143*ones(1,6), 144*ones(1,6)];

branch_end_LV12_conc_B = [936:1:1049];

branch_first_LV13_conc_B = [146*ones(1,6), 147*ones(1,7), 148*ones(1,7), ...
                            149*ones(1,8), 150*ones(1,6), 151*ones(1,7), 152*ones(1,7), ...
                            153*ones(1,8), 154*ones(1,7), 155*ones(1,8), ...
                            156*ones(1,7), 157*ones(1,7), 158*ones(1,7), 159*ones(1,7), ...
                            160*ones(1,6), 161*ones(1,6), 162*ones(1,8)];

branch_end_LV13_conc_B = [1050:1:1168];

branch_type_LV_conc_B = ones(1,1006);
branch_length_LV_conc_B = 0.1*ones(1,1006);
R_LV_conc_B = 0.907*ones(1,1006);           % valore preso da cavo 3x25 IDE4L
X_LV_conc_B = 0.0813*ones(1,1006);          % valore preso da cavo 3x25 IDE4L
branch_R_LV_conc_B = branch_length_LV_conc_B.*R_LV_conc_B/Zb2;
branch_X_LV_conc_B = branch_length_LV_conc_B.*X_LV_conc_B/Zb2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Phase C concentrators

branch_first_LV2_conc_C = [15*ones(1,6), 16*ones(1,9), 17*ones(1,7), ...
                           18*ones(1,7), 19*ones(1,8), 20*ones(1,8), ...
                           21*ones(1,7), 22*ones(1,7), 23*ones(1,9), ...
                           24*ones(1,8), 25*ones(1,7), 26*ones(1,8), 27*ones(1,6)...
                           28*ones(1,7), 29*ones(1,8), 30*ones(1,6)];
                       
branch_end_LV2_conc_C = [163:1:280];

branch_first_LV3_conc_C = [32*ones(1,7), 33*ones(1,8), 34*ones(1,5), ...
                           35*ones(1,8), 36*ones(1,7), 37*ones(1,6), ...
                           38*ones(1,7), 39*ones(1,8), 40*ones(1,6), ...
                           41*ones(1,5), 42*ones(1,9), 43*ones(1,8), ...
                           44*ones(1,8), 45*ones(1,9), 46*ones(1,8)];

branch_end_LV3_conc_C = [281:1:389];

branch_first_LV4_conc_C = [48*ones(1,8), 49*ones(1,7), 50*ones(1,9),...
                           51*ones(1,8), 52*ones(1,6), 53*ones(1,6), 54*ones(1,8), ...
                           55*ones(1,8), 56*ones(1,6), 57*ones(1,5), ...
                           58*ones(1,7), 59*ones(1,9), ...
                           60*ones(1,9), 61*ones(1,8), 62*ones(1,9)];

branch_end_LV4_conc_C = [390:1:502];

branch_first_LV6_conc_C = [64*ones(1,6), 65*ones(1,8), 66*ones(1,8), ...
                           67*ones(1,8), 68*ones(1,6), 69*ones(1,6), 70*ones(1,8), ...
                           71*ones(1,8), 72*ones(1,6), 73*ones(1,5), 74*ones(1,7), ...
                           75*ones(1,8), 76*ones(1,8), 77*ones(1,6), 78*ones(1,6)];
                       
branch_end_LV6_conc_C = [503:1:606];

branch_first_LV9_conc_C = [80*ones(1,5), 81*ones(1,8), 82*ones(1,7), ...
                           83*ones(1,9), 84*ones(1,7), 85*ones(1,7), ...
                           86*ones(1,9), 87*ones(1,6), 88*ones(1,7), ...
                           89*ones(1,8), 90*ones(1,8), 91*ones(1,7), ...
                           92*ones(1,5), 93*ones(1,7), 94*ones(1,5)];
                       
branch_end_LV9_conc_C = [607:1:711];

branch_first_LV10_conc_C = [96*ones(1,8), 97*ones(1,8), ...
                           98*ones(1,6), 99*ones(1,8), 100*ones(1,7), ...
                           101*ones(1,8), 102*ones(1,8), 103*ones(1,6), ...
                           104*ones(1,7), 105*ones(1,9), ...
                           106*ones(1,7), 107*ones(1,8), 108*ones(1,7), ...
                           109*ones(1,7), 110*ones(1,7), 111*ones(1,8)];

branch_end_LV10_conc_C = [712:1:830];

branch_first_LV11_conc_C = [113*ones(1,7), 114*ones(1,8), 115*ones(1,7), ...
                           116*ones(1,9), 117*ones(1,5), 118*ones(1,6), ...
                           119*ones(1,8), 120*ones(1,6), 121*ones(1,5), ...
                           122*ones(1,9), 123*ones(1,8), 124*ones(1,7), ...
                           125*ones(1,7), 126*ones(1,8), 127*ones(1,6)];
                       
branch_end_LV11_conc_C = [831:1:936];

branch_first_LV12_conc_C = [129*ones(1,8), 130*ones(1,6), 131*ones(1,8), 132*ones(1,9), ...
                            133*ones(1,8), 134*ones(1,9), 135*ones(1,7), ...
                            136*ones(1,9), 137*ones(1,6), 138*ones(1,8), ...
                            139*ones(1,7), 140*ones(1,5), 141*ones(1,8), 142*ones(1,6), ...
                            143*ones(1,5), 144*ones(1,6)];

branch_end_LV12_conc_C = [937:1:1051];

branch_first_LV13_conc_C = [146*ones(1,7), 147*ones(1,6), 148*ones(1,9), ...
                            149*ones(1,7), 150*ones(1,7), 151*ones(1,6), 152*ones(1,7), ...
                            153*ones(1,6), 154*ones(1,7), 155*ones(1,8), ...
                            156*ones(1,7), 157*ones(1,8), 158*ones(1,6), 159*ones(1,6), ...
                            160*ones(1,7), 161*ones(1,7), 162*ones(1,6)];

branch_end_LV13_conc_C = [1052:1:1168];

branch_type_LV_conc_C = ones(1,1006);
branch_length_LV_conc_C = 0.1*ones(1,1006);
R_LV_conc_C = 0.907*ones(1,1006);           % valore preso da cavo 3x25 IDE4L
X_LV_conc_C = 0.0813*ones(1,1006);          % valore preso da cavo 3x25 IDE4L
branch_R_LV_conc_C = branch_length_LV_conc_C.*R_LV_conc_C/Zb2;
branch_X_LV_conc_C = branch_length_LV_conc_C.*X_LV_conc_C/Zb2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

branch_first_MV_LV = [branch_first_MV, branch_first_LV2, branch_first_LV3, branch_first_LV4, branch_first_LV6, branch_first_LV9, ...
                      branch_first_LV10, branch_first_LV11, branch_first_LV12, branch_first_LV13];
                  
branch.first.A = [branch_first_MV_LV, branch_first_LV2_conc_A, branch_first_LV3_conc_A, branch_first_LV4_conc_A, branch_first_LV6_conc_A, ...
                  branch_first_LV9_conc_A, branch_first_LV10_conc_A, branch_first_LV11_conc_A, branch_first_LV12_conc_A, branch_first_LV13_conc_A]';
              
branch.first.B = [branch_first_MV_LV, branch_first_LV2_conc_B, branch_first_LV3_conc_B, branch_first_LV4_conc_B, branch_first_LV6_conc_B, ...
                  branch_first_LV9_conc_B, branch_first_LV10_conc_B, branch_first_LV11_conc_B, branch_first_LV12_conc_B, branch_first_LV13_conc_B]';
              
branch.first.C = [branch_first_MV_LV, branch_first_LV2_conc_C, branch_first_LV3_conc_C, branch_first_LV4_conc_C, branch_first_LV6_conc_C, ...
                  branch_first_LV9_conc_C, branch_first_LV10_conc_C, branch_first_LV11_conc_C, branch_first_LV12_conc_C, branch_first_LV13_conc_C]';

              
branch_end_MV_LV = [branch_end_MV, branch_end_LV2, branch_end_LV3, branch_end_LV4, branch_end_LV6, branch_end_LV9, ...
                      branch_end_LV10, branch_end_LV11, branch_end_LV12, branch_end_LV13];
                  
branch.end.A = [branch_end_MV_LV, branch_end_LV2_conc_A, branch_end_LV3_conc_A, branch_end_LV4_conc_A, branch_end_LV6_conc_A, ...
                  branch_end_LV9_conc_A, branch_end_LV10_conc_A, branch_end_LV11_conc_A, branch_end_LV12_conc_A, branch_end_LV13_conc_A]';
              
branch.end.B = [branch_end_MV_LV, branch_end_LV2_conc_B, branch_end_LV3_conc_B, branch_end_LV4_conc_B, branch_end_LV6_conc_B, ...
                  branch_end_LV9_conc_B, branch_end_LV10_conc_B, branch_end_LV11_conc_B, branch_end_LV12_conc_B, branch_end_LV13_conc_B]';
              
branch.end.C = [branch_end_MV_LV, branch_end_LV2_conc_C, branch_end_LV3_conc_C, branch_end_LV4_conc_C, branch_end_LV6_conc_C, ...
                  branch_end_LV9_conc_C, branch_end_LV10_conc_C, branch_end_LV11_conc_C, branch_end_LV12_conc_C, branch_end_LV13_conc_C]';
              
              
branch.num.A = length(branch.first.A);
branch.num.B = length(branch.first.B);
branch.num.C = length(branch.first.C);
              
branch.cod.A = [1:1:branch.num.A]';
branch.cod.B = [1:1:branch.num.B]';
branch.cod.C = [1:1:branch.num.C]';

branch.type.A = [branch_type_MV, branch_type_LV, branch_type_LV_conc_A]';
branch.type.B = [branch_type_MV, branch_type_LV, branch_type_LV_conc_B]';
branch.type.C = [branch_type_MV, branch_type_LV, branch_type_LV_conc_C]';

branch.R.A = [branch_R_MV, branch_R_LV, branch_R_LV_conc_A]';
branch.R.B = [branch_R_MV, branch_R_LV, branch_R_LV_conc_B]';
branch.R.C = [branch_R_MV, branch_R_LV, branch_R_LV_conc_C]';

branch.X.A = [branch_X_MV, branch_X_LV, branch_X_LV_conc_A]';
branch.X.B = [branch_X_MV, branch_X_LV, branch_X_LV_conc_B]';
branch.X.C = [branch_X_MV, branch_X_LV, branch_X_LV_conc_C]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%