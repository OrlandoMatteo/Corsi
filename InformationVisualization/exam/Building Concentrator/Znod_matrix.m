function [Znod] = Znod_matrix(branch)

branch.R.Tot = [branch.R.A; branch.R.B; branch.R.C];
branch.X.Tot = [branch.X.A; branch.X.B; branch.X.C];
Z = complex(branch.R.Tot,branch.X.Tot); 

idxA = find(branch.type.A == 2);
idxA_min = min(idxA);
idxA_max = max(idxA);
idxB = find(branch.type.B == 2);
idxB_min = min(idxB);
idxB_max = max(idxB);
idxC = find(branch.type.B == 2);
idxC_min = min(idxC);
idxC_max = max(idxC);

Znod = zeros(branch.num.Tot+3,branch.num.Tot);      % creation of a matrix of impedances, where, for each row i, there is the set of impedances in the path between slack bus and node i+1. 
Znod(1,1) = 1;
Znod(2+branch.num.A,2) = 1;
Znod(3+branch.num.A+branch.num.B,3) = 1;

%% part associated to the MV grid
for i = 1:idxA_min-1
    end_node = branch.end.A(i,1);
    start_node = branch.first.A(i,1);
    Znod(end_node,:) = Znod(start_node,:);
    Znod(end_node,i+3) = -Z(i);
end
for i = 1:idxB_min-1
    end_node = branch.end.B(i,1) + branch.num.A + 1;
    start_node = branch.first.B(i,1) + branch.num.A + 1;
    Znod(end_node,:) = Znod(start_node,:);
    Znod(end_node,i+3+branch.num.A) = -Z(i+branch.num.A);
end
for i = 1:idxC_min-1
    end_node = branch.end.C(i,1) + branch.num.A + branch.num.B + 2;
    start_node = branch.first.C(i,1) + branch.num.A + branch.num.B + 2;
    Znod(end_node,:) = Znod(start_node,:);
    Znod(end_node,i+3+branch.num.A+branch.num.B) = -Z(i+branch.num.A+branch.num.B);
end

%% part associated to the MV/LV substations
for i = idxA_min:idxA_max
    end_node = branch.end.A(i,1);
    start_node = branch.first.A(i,1);
    Znod(end_node,:) = Znod(start_node,:) - Znod(start_node+branch.num.A+branch.num.B+2,:);
    Znod(end_node,i+3) = -Z(i);
end
for i = idxB_min:idxB_max
    end_node = branch.end.B(i,1) + branch.num.A + 1;
    start_node = branch.first.B(i,1) + branch.num.A + 1;
    Znod(end_node,:) = Znod(start_node,:) - Znod(start_node-branch.num.A-1,:);
    Znod(end_node,i+3+branch.num.A) = -Z(i+branch.num.A);
end
for i = idxC_min:idxC_max
    end_node = branch.end.C(i,1) + branch.num.A + branch.num.B + 2;
    start_node = branch.first.C(i,1) + branch.num.A + branch.num.B + 2;
    Znod(end_node,:) = Znod(start_node,:) - Znod(start_node-branch.num.B-1,:);
    Znod(end_node,i+3+branch.num.A+branch.num.B) = -Z(i+branch.num.A+branch.num.B);
end

%% part associated to the LV grid
for i = idxA_max+1:branch.num.A
    end_node = branch.end.A(i,1);
    start_node = branch.first.A(i,1);
    Znod(end_node,:) = Znod(start_node,:);
    Znod(end_node,i+3) = -Z(i);
end
for i = idxB_max+1:branch.num.B
    end_node = branch.end.B(i,1) + branch.num.A + 1;
    start_node = branch.first.B(i,1) + branch.num.A + 1;
    Znod(end_node,:) = Znod(start_node,:);
    Znod(end_node,i+3+branch.num.A) = -Z(i+branch.num.A);
end
for i = idxC_max+1:branch.num.C
    end_node = branch.end.C(i,1) + branch.num.A + branch.num.B + 2;
    start_node = branch.first.C(i,1) + branch.num.A + branch.num.B + 2;
    Znod(end_node,:) = Znod(start_node,:);
    Znod(end_node,i+3+branch.num.A+branch.num.B) = -Z(i+branch.num.A+branch.num.B);
end
