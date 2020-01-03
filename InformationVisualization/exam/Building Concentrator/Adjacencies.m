function [adj_ind_matrix, numincidences] = Adjacencies(idx)

num_branches = length(idx);
num_nodes = num_branches+1;
fbus = ones(num_branches,1);
tbus = [2:1:num_nodes];
adj_ind_matrix = zeros(num_nodes, 20);

for i=1:num_nodes
    adji = (fbus == i);
    adj1 = tbus(adji);
    adji = (tbus == i);
    adj2 = fbus(adji);
    adj3 = [adj1; adj2];
    adj4 = sort(adj3);
    adj = adj4';
    idx = length(adj);
    adj_ind_matrix (i, 1:idx) = adj;
end

numincidences = zeros(num_nodes,1);
for i=1:num_nodes
    var = (adj_ind_matrix(i,:) ~= 0);
    var2 = find(var);
    numincidences(i) = length(var2);
end
m = max(numincidences);
adj_ind_matrix(:,m+1:end) = [];
end


    

