function[Y]=Ymatrix(branch,idx,cod)

switch cod
    case 1
        R = branch.R.A(idx,1);
        X = branch.X.A(idx,1);
    case 2
        R = branch.R.B(idx,1);
        X = branch.X.B(idx,1);
    case 3
        R = branch.R.C(idx,1);
        X = branch.X.C(idx,1);
end
        
num_branches = length(idx);
num_nodes = num_branches+1;
branch_first = ones(num_branches,1);
branch_end = [2:1:num_nodes]';

Y=zeros(num_nodes,num_nodes);
for L=1:num_branches             %%% computation of the terms outside the main diagonal
    i=branch_first(L);
    j=branch_end(L);
    a=R(L)/(R(L)^2+X(L)^2);
    b=-X(L)/(R(L)^2+X(L)^2);
    c=complex(a,b);
    Y(i,j)=-c;
    Y(j,i)=Y(i,j);
end

for m=1:num_nodes
    for n=1:num_nodes             %%% computation of the terms in the main diagonal
        if m~=n
            Y(m,m)=Y(m,m)-Y(m,n);
        end
    end
end
end
