function [zdata] = zdata_creator(V,P,Q,unc)

%%%%% Phase A %%%%%

num_nodesA = length(V.A)+1;
zA = [V.A; P.A; Q.A];
uncA = [unc.V*ones(num_nodesA-1,1); unc.P*ones(1*(num_nodesA-1),1); unc.Q*ones(1*(num_nodesA-1),1)];

rowsA = 3*(num_nodesA-1);
zdata.A = zeros(rowsA,6);
zdata.A(:,1) = [ones(num_nodesA-1,1); 2*ones(num_nodesA-1,1); 3*ones(num_nodesA-1,1)];
zdata.A(:,4) = [2:1:num_nodesA, 2:1:num_nodesA, 2:1:num_nodesA]';
zdata.A(:,6) = (uncA/300).*zA;
zdata.A(:,2) = zA + zdata.A(:,6).*randn(size(zA));

%%%%% Phase B %%%%%

num_nodesB = length(V.B)+1;
zB = [V.B; P.B; Q.B];
uncB = [unc.V*ones(num_nodesB-1,1); unc.P*ones(1*(num_nodesB-1),1); unc.Q*ones(1*(num_nodesB-1),1)];

rowsB = 3*(num_nodesB-1);
zdata.B = zeros(rowsB,6);
zdata.B(:,1) = [ones(num_nodesB-1,1); 2*ones(num_nodesB-1,1); 3*ones(num_nodesB-1,1)];
zdata.B(:,4) = [2:1:num_nodesB, 2:1:num_nodesB, 2:1:num_nodesB]';
zdata.B(:,6) = (uncB/300).*zB;
zdata.B(:,2) = zB + zdata.B(:,6).*randn(size(zB));

%%%%% Phase C %%%%%

num_nodesC = length(V.C)+1;
zC = [V.C; P.C; Q.C];
uncC = [unc.V*ones(num_nodesC-1,1); unc.P*ones(1*(num_nodesC-1),1); unc.Q*ones(1*(num_nodesC-1),1)];

rowsC = 3*(num_nodesC-1);
zdata.C = zeros(rowsC,6);
zdata.C(:,1) = [ones(num_nodesC-1,1); 2*ones(num_nodesC-1,1); 3*ones(num_nodesC-1,1)];
zdata.C(:,4) = [2:1:num_nodesC, 2:1:num_nodesC, 2:1:num_nodesC]';
zdata.C(:,6) = (uncC/300).*zC;
zdata.C(:,2) = zC + zdata.C(:,6).*randn(size(zC));

