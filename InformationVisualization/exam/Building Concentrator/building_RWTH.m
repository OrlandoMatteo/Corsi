clc
clear all
close all

%% load data



javaaddpath('/home/matteo/Projects/3SMA/SE_files/Building Concentrator/JSON/JSON.jar')

%%% Here I load the power data for the houses and MV nodes
P.P_A = load('P_A.mat');        % active power consumption for the residential loads (Phase A)
P.P_B = load('P_B.mat');        % active power consumption for the residential loads (Phase B)
P.P_C = load('P_C.mat');        % active power consumption for the residential loads (Phase C)
Q.Q_A = load('Q_A.mat');        % reactive power consumption for the residential loads (Phase A)
Q.Q_B = load('Q_B.mat');        % reactive power consumption for the residential loads (Phase B)
Q.Q_C = load('Q_C.mat');        % reactive power consumption for the residential loads (Phase C)
load('P_Gen.mat');              % active power of the generation node in the MV grid
load('Q_Gen.mat');              % reactive power of the generation node in the MV grid
load('P_Ind.mat');              % active power of the industrial load in the MV grid
load('Q_Ind.mat');              % active power of the industrial load in the MV grid
load('P_Ind2.mat');              % active power of the industrial load in the MV grid
load('Q_Ind2.mat');              % active power of the industrial load in the MV grid
Pgen = - P_Gen/10;              % divided by 10 to have the per unit value (Sbase = 10kVA)
Qgen = - Q_Gen/10;              % divided by 10 to have the per unit value (Sbase = 10kVA)
Pind = P_Ind/10;                % divided by 10 to have the per unit value (Sbase = 10kVA)
Qind = Q_Ind/10;                % divided by 10 to have the per unit value (Sbase = 10kVA)
Pind2 = P_Ind2/10;                % divided by 10 to have the per unit value (Sbase = 10kVA)
Qind2 = Q_Ind2/10;                % divided by 10 to have the per unit value (Sbase = 10kVA)

%%% NB:the implementation as it is right now works only with constant value
%%% of per unit current! Don't change base values!!!!
Base.MV.V = 15e3;
Base.MV.S = 10e3;
Base.LV.V = 230;
Base.LV.S = 10e3;

%%% Part associated to network data;
[branch] = Overall_grid_topology(Base);                       % function with the network data
save branch_conc.txt branch.string.building.conc -ascii
%% Setting concentrator data - creation of admittance matrices for the grid behind each concentrator (to be used within the concentrator SE)
Y = cell(162-15+1,3);
adj_matrix = cell(162-15+1,3);
num_incidences = cell(162-15+1,3);

for i = 14:162
    j = i-14;
    
    if i == 14 | i == 31 | i == 47 | i == 63 | i == 79 | i == 95 | i == 112 | i == 128 | i == 145
        continue
    end
    
    cod = 1;
    idx = find(branch.first.A == i);
    index = branch.end.A(idx,1);
    idx = idx(index>162);
    [YA] = Ymatrix(branch,idx,cod);
    [adj_ind_matrixA, numincidencesA] = Adjacencies(idx);
    Y{j,1} = YA;
    adj_matrix{j,1} = adj_ind_matrixA;
    num_incidences{j,1} = numincidencesA;
    
    cod = 2;
    idx = find(branch.first.B == i);
    index = branch.end.B(idx,1);
    idx = idx(index>162);
    [YB] = Ymatrix(branch,idx,cod);
    [adj_ind_matrixB, numincidencesB] = Adjacencies(idx);
    Y{j,2} = YB;
    adj_matrix{j,2} = adj_ind_matrixB;
    num_incidences{j,2} = numincidencesB;
    
    cod = 3;
    idx = find(branch.first.C == i);
    index = branch.end.C(idx,1);
    idx = idx(index>162);
    [YC] = Ymatrix(branch,idx,cod);
    [adj_ind_matrixC, numincidencesC] = Adjacencies(idx);
    Y{j,3} = YC;
    adj_matrix{j,3} = adj_ind_matrixC;
    num_incidences{j,3} = numincidencesC;
    
end

%% Luca's part - data initialization for the quantities to be sent via MQTT
b = struct;

b.electricity = struct;
b.electricity.power = struct;
b.electricity.power.active = struct;

b.electricity.power.active.estimation = struct;
b.electricity.power.active.estimation.l1 = zeros(1,1);
b.electricity.power.active.estimation.l2 = zeros(1,1);
b.electricity.power.active.estimation.l3 = zeros(1,1);
b.electricity.power.active.uncertainty =struct;
b.electricity.power.active.uncertainty.l1 = zeros(1,1);
b.electricity.power.active.uncertainty.l2 = zeros(1,1);
b.electricity.power.active.uncertainty.l3 = zeros(1,1);

b.electricity.power.reactive.estimation = struct;
b.electricity.power.reactive.estimation.l1 = zeros(1,1);
b.electricity.power.reactive.estimation.l2 = zeros(1,1);
b.electricity.power.reactive.estimation.l3 = zeros(1,1);
b.electricity.power.reactive.uncertainty = struct;
b.electricity.power.reactive.uncertainty.l1 = zeros(1,1);
b.electricity.power.reactive.uncertainty.l2 = zeros(1,1);
b.electricity.power.reactive.uncertainty.l3 = zeros(1,1);

b.electricity.instantaneous = struct;
b.electricity.instantaneous.rms = struct;
b.electricity.instantaneous.rms.voltage = struct;

b.electricity.instantaneous.rms.voltage.estimation = struct;
b.electricity.instantaneous.rms.voltage.estimation.l1 = zeros(1,1);
b.electricity.instantaneous.rms.voltage.estimation.l2 = zeros(1,1);
b.electricity.instantaneous.rms.voltage.estimation.l3 = zeros(1,1);

b.electricity.instantaneous.rms.voltage.uncertainty = struct;
b.electricity.instantaneous.rms.voltage.uncertainty.l1 = zeros(1,1);
b.electricity.instantaneous.rms.voltage.uncertainty.l2 = zeros(1,1);
b.electricity.instantaneous.rms.voltage.uncertainty.l3 = zeros(1,1);

b.hardwareIds = cell(1,2);

% connection of Matlab to node.js - the code moves from here only after
% running node.js and once the connection to it is established
%host = 'localhost';
%port = 5001;
%s = server(host,port);
%s.receive();

Year = 2017;
Mon = 04;
Day = 17;
hour = 0;
minut = 0;
sec = 0;

unc.V = 1;
unc.P = 1;
unc.Q = 2;

%% messo for per fare un'intera giornata anzich� la temporizzazione

min_min = 1;
max_min = 1440;

values=cell(1440,1);
stats=struct()
for time_min = min_min:max_min
    %stats(time_min)=getrusage();
    tic
    time_min
    % Among the data of the whole day, I take only those related to the time step I will be simulating here
    [pseudomeas] = PQ_update(P,Q,time_min,Base,Pgen,Qgen,Pind,Qind,Pind2,Qind2); 
    
    % Power flow for the whole grid to get the true electrical quantities
    [V, I, S, num_iter2] = Power_flow_BC(branch, pseudomeas);

    Conc_val = cell(162-15+1,1);
    Conc_unc = cell(162-15+1,1);

    %% Concentrators
    for i = 14:162
        j = i-14;

        if i == 14 | i == 31 | i == 47 | i == 63 | i == 79 | i == 95 | i == 112 | i == 128 | i == 145
            continue
        end

        idxA = find(branch.first.A == i);
        indexA = branch.end.A(idxA,1);
        indexA = indexA(indexA>162)-1;
        idxB = find(branch.first.B == i);
        indexB = branch.end.B(idxB,1);
        indexB = indexB(indexB>162)-1;
        idxC = find(branch.first.C == i);
        indexC = branch.end.C(idxC,1);
        indexC = indexC(indexC>162)-1;
        Vtemp.A = V.mag.true_val.A(indexA+1,1);  Vtemp.B = V.mag.true_val.B(indexB+1,1);  Vtemp.C = V.mag.true_val.C(indexC+1,1);
        Ptemp.A = pseudomeas.P.A(indexA,1);      Ptemp.B = pseudomeas.P.B(indexB,1);      Ptemp.C = pseudomeas.P.C(indexC,1);
        Qtemp.A = pseudomeas.Q.A(indexA,1);      Qtemp.B = pseudomeas.Q.B(indexB,1);      Qtemp.C = pseudomeas.Q.C(indexC,1);
        % In the following function I create the measurements for the estimator, starting from the true values
        [zdata] = zdata_creator(Vtemp,Ptemp,Qtemp,unc);
        
        % Here I call the DSSE function (state estimator)
        [Vest, Iest, num_iter, val_est, unc_est] = DSSE_call_concentrator(Y, zdata, adj_matrix, num_incidences,j,Base);
        Conc_val{j,1} = val_est;
        Conc_unc{j,1} = unc_est;
    end
    toc
    values{time_min,1}=Conc_val;
%    values(time_min,1)(17,:)=[];
%    values(time_min,1)(33,:)=[];
%    values(time_min,1)(49,:)=[];
%    values(time_min,1)(65,:)=[];
%    values(time_min,1)(81,:)=[];
%    values(time_min,1)(98,:)=[];
%    values(time_min,1)(114,:)=[];
%    values(time_min,1(131,:)=[];
    %%% Luca's part - writing of the results in the json format to send them via MQTT
    %% ciclo che ogni minuto aggiorna v

    %inizio
    [Year, Mon, Day, hour, minut, sec] = produce_timestring(Year, Mon, Day, hour, minut, sec);
    timestamp = datestr([Year Mon Day hour minut sec],'yyyy-mm-ddTHH:MM:SS.FFF+02:00');
    j = 0;

    for i = 1:148

        if i == 17 | i == 33 | i == 49 | i == 65 | i == 81 | i == 98 | i == 114 | i == 131
           continue
        else 
            j = j + 1;
        end

        b.hardwareIds{1} = branch.string.building.conc{j,1};
        b.hardwareIds{2} = branch.string.building.subst{j,1};
        b.electricity.power.active.estimation.l1 = Conc_val{i,1}(1,4);
        b.electricity.power.active.estimation.l2 = Conc_val{i,1}(1,5);
        b.electricity.power.active.estimation.l3 = Conc_val{i,1}(1,6);
        b.electricity.power.active.uncertainty.l1 = Conc_unc{i,1}(1,4);
        b.electricity.power.active.uncertainty.l2 = Conc_unc{i,1}(1,5);
        b.electricity.power.active.uncertainty.l3 = Conc_unc{i,1}(1,6);
        b.electricity.power.reactive.estimation.l1 = Conc_val{i,1}(1,7);
        b.electricity.power.reactive.estimation.l2 = Conc_val{i,1}(1,8);
        b.electricity.power.reactive.estimation.l3 = Conc_val{i,1}(1,9);
        b.electricity.power.reactive.uncertainty.l1 = Conc_unc{i,1}(1,7);
        b.electricity.power.reactive.uncertainty.l2 = Conc_unc{i,1}(1,8);
        b.electricity.power.reactive.uncertainty.l3 = Conc_unc{i,1}(1,9);
        b.electricity.instantaneous.rms.voltage.estimation.l1 = Conc_val{i,1}(1,1);
        b.electricity.instantaneous.rms.voltage.estimation.l2 = Conc_val{i,1}(1,2);
        b.electricity.instantaneous.rms.voltage.estimation.l3 = Conc_val{i,1}(1,3);
        b.electricity.instantaneous.rms.voltage.uncertainty.l1 = Conc_unc{i,1}(1,1);
        b.electricity.instantaneous.rms.voltage.uncertainty.l2 = Conc_unc{i,1}(1,2);
        b.electricity.instantaneous.rms.voltage.uncertainty.l3 = Conc_unc{i,1}(1,3);


    end   

end
save values.mat values