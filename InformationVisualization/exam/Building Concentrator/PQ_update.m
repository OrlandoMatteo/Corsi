function[pseudomeas] = PQ_update(P,Q,min,Base,Pgen,Qgen,Pind,Qind,Pind2,Qind2)

P_MV = zeros(1,21);
Q_MV = zeros(1,21);

P_MV(1,4) = Pind2(min,1);
Q_MV(1,4) = Qind2(min,1);

P_MV(1,6) = Pind(min,1);
Q_MV(1,6) = Qind(min,1);

P_MV(1,7) = Pgen(min,1);
Q_MV(1,7) = Qgen(min,1);

P_LV = zeros(1,140);
Q_LV = zeros(1,140);

P_LV_conc_A = double(P.P_A.P2(:,min));
Q_LV_conc_A = double(Q.Q_A.Q2(:,min));

P_LV_conc_B = double(P.P_B.P2(:,min));
Q_LV_conc_B = double(Q.Q_B.Q2(:,min));

P_LV_conc_C = double(P.P_C.P2(:,min));
Q_LV_conc_C = double(Q.Q_C.Q2(:,min));

pseudomeas.P.A = [P_MV'; P_LV'; P_LV_conc_A/Base.LV.S];
pseudomeas.P.B = [P_MV'; P_LV'; P_LV_conc_B/Base.LV.S];
pseudomeas.P.C = [P_MV'; P_LV'; P_LV_conc_C/Base.LV.S];

pseudomeas.Q.A = [Q_MV'; Q_LV'; Q_LV_conc_A/Base.LV.S];
pseudomeas.Q.B = [Q_MV'; Q_LV'; Q_LV_conc_B/Base.LV.S];
pseudomeas.Q.C = [Q_MV'; Q_LV'; Q_LV_conc_C/Base.LV.S];