function [V, I, num_iter, val, unc] = DSSE_call_concentrator(Y, zdata, adj_ind_matrix, numincidences,j,Base)

[V_A, I_A, num_iter_A, val_A, unc_A] = DSSE_concentrator(Y{j,1}, zdata.A, adj_ind_matrix{j,1}, numincidences{j,1});
[V_B, I_B, num_iter_B, val_B, unc_B] = DSSE_concentrator(Y{j,2}, zdata.B, adj_ind_matrix{j,2}, numincidences{j,2});
[V_C, I_C, num_iter_C, val_C, unc_C] = DSSE_concentrator(Y{j,3}, zdata.C, adj_ind_matrix{j,3}, numincidences{j,3});

V = [V_A; V_B; V_C];
I = [I_A; I_B; I_C];
num_iter = [num_iter_A; num_iter_B; num_iter_C]; 

Base_vect = [Base.LV.V, Base.LV.S/1000, Base.LV.S/1000];

val1 = [val_A.*Base_vect; val_B.*Base_vect; val_C.*Base_vect];
unc1 = [unc_A.*Base_vect; unc_B.*Base_vect; unc_C.*Base_vect];
val = reshape(val1,1,9);
unc = reshape(unc1,1,9);

