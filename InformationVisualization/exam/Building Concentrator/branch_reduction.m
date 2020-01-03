function [branch] = branch_reduction(branch, net_idx)

% branch.first.A = [branch.first.A_mesh(1:net_idx-1,1);branch.first.A_mesh(net_idx+1:end,1)];
% branch.first.B = [branch.first.B_mesh(1:net_idx-1,1);branch.first.B_mesh(net_idx+1:end,1)];
% branch.first.C = [branch.first.C_mesh(1:net_idx-1,1);branch.first.C_mesh(net_idx+1:end,1)];
% 
% branch.end.A = [branch.end.A_mesh(1:net_idx-1,1);branch.end.A_mesh(net_idx+1:end,1)];
% branch.end.B = [branch.end.B_mesh(1:net_idx-1,1);branch.end.B_mesh(net_idx+1:end,1)];
% branch.end.C = [branch.end.C_mesh(1:net_idx-1,1);branch.end.C_mesh(net_idx+1:end,1)];
% 
% branch.type.A = [branch.type.A_mesh(1:net_idx-1,1);branch.type.A_mesh(net_idx+1:end,1)];
% branch.type.B = [branch.type.B_mesh(1:net_idx-1,1);branch.type.B_mesh(net_idx+1:end,1)];
% branch.type.C = [branch.type.C_mesh(1:net_idx-1,1);branch.type.C_mesh(net_idx+1:end,1)];
% 
% branch.R.A = [branch.R.A_mesh(1:net_idx-1,1);branch.R.A_mesh(net_idx+1:end,1)];
% branch.R.B = [branch.R.B_mesh(1:net_idx-1,1);branch.R.B_mesh(net_idx+1:end,1)];
% branch.R.C = [branch.R.C_mesh(1:net_idx-1,1);branch.R.C_mesh(net_idx+1:end,1)];
% 
% branch.X.A = [branch.X.A_mesh(1:net_idx-1,1);branch.X.A_mesh(net_idx+1:end,1)];
% branch.X.B = [branch.X.B_mesh(1:net_idx-1,1);branch.X.B_mesh(net_idx+1:end,1)];
% branch.X.C = [branch.X.C_mesh(1:net_idx-1,1);branch.X.C_mesh(net_idx+1:end,1)];

branch.first.A_mesh = branch.first.A;
branch.first.B_mesh = branch.first.B;
branch.first.C_mesh = branch.first.C;
branch.end.A_mesh = branch.end.A;
branch.end.B_mesh = branch.end.B;
branch.end.C_mesh = branch.end.C;

branch.first.A(net_idx:12,1) = flipud(branch.end.A_mesh(net_idx:12,1));
branch.first.B(net_idx:12,1) = flipud(branch.end.B_mesh(net_idx:12,1));
branch.first.C(net_idx:12,1) = flipud(branch.end.C_mesh(net_idx:12,1));

branch.end.A(net_idx:12,1) = flipud(branch.first.A_mesh(net_idx:12,1));
branch.end.B(net_idx:12,1) = flipud(branch.first.B_mesh(net_idx:12,1));
branch.end.C(net_idx:12,1) = flipud(branch.first.C_mesh(net_idx:12,1));
