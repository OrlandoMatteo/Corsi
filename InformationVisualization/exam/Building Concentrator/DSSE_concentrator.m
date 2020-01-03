function[Vcomplex, I, num_iter, val, unc] = DSSE_concentrator(Y, zdata, adj_ind_matrix, numincidences)

num_nodes = length(numincidences);
num_branches = num_nodes-1;
branch_first = ones(num_branches,1);
branch_end = [2:1:num_nodes]';

type = zdata(:,1);
z = zdata(:,2);
fbus = zdata(:,4);
tbus = zdata(:,5);
dev_std = zdata(:,6);
sigma2 = dev_std.^2;
sigma2(sigma2<10^-12) = 10^-12;
vii = (type == 1);
pii = (type == 2);
qii = (type == 3);
pfi = (type == 4);
qfi = (type == 5);
ifi = (type == 6);  

vi = find(vii);                                                            % Index of voltage magnitude measurements..
pidx = find(pii);                                                            % Index of real power injection measurements..
qidx = find(qii);                                                            % Index of reactive power injection measurements..
pf = find(pfi);                                                            % Index of real powerflow measurements..
qf = find(qfi);                                                            % Index of reactive powerflow measurements..
iampf = find(ifi);                                                         % Index of current amplitude measurements..

nvi = length(vi);                                                          % Number of Voltage amplitude measurements..
busvi = fbus(vi);                                                          % Nodes of Voltage amplitude measurements..
npi = length(pidx);                                                          % Number of Real Power Injection measurements..
busppi = fbus(pidx);                                                         % Nodes of Real Power Injection measurements..
npf = length(pf);                                                          % Number of Real Power Flow measurements..
fbuspf = fbus(pf);                                                         % Start Nodes of Real Power Flow measurements..
tbuspf = tbus(pf);                                                         % End Nodes of Real Power Flow measurements..
niampf = length(iampf);                                                    % Number of Current measurements..
fbusiampf = fbus(iampf);                                                   % Start Nodes of Current amplitude measurements..
tbusiampf = tbus(iampf);                                                   % End Nodes of Current amplitude measurements..

G = real(Y);                                                               % parte reale matrice di ammettenza
B = imag(Y);                                                               % parte immaginaria matrice di ammettenza
Yabs = abs(Y);
Yphase = angle(Y);

Vr = ones(num_nodes,1);                                                  % calcolo componente reale e immaginaria del vettore delle tensioni nodali 
Vx = zeros(num_nodes,1);
Vcomplex = Vr;
V_abs = Vr;

br_sign = sign(zdata(:,3));     br_sign(br_sign==0) = 1;
z = z.*br_sign;

P_inj = zdata(pii,2);
Q_inj = zdata(qii,2);
P_br = zdata(pfi,2).*br_sign(pfi,1);
Q_br = zdata(qfi,2).*br_sign(qfi,1);
br_sign = br_sign(pf);

hidx = 1 : length(sigma2);                                                 % indice colonna per la definizione della matrice sparsa della covarianza
vidx = 1 : length(sigma2);                                                 % indice riga per la definizione della matrice sparsa della covarianza
covariances = sigma2;
offset = num_nodes-1;

%%% Definizione sottomatrici Jacobiane costanti

% 2-3) Power Injection Measurements
H2 = zeros(npi,2*num_nodes-1);
H3 = zeros(npi,2*num_nodes-1);
for i = 1:npi
    m = busppi(i);
    kindices = adj_ind_matrix(m,1:numincidences(m));
    H2(i,m) = -G(m,m);
    H2(i,m + offset) = B(m,m);
    H3(i,m) = -B(m,m);
    H3(i,m + offset) = -G(m,m);
    H2(i,kindices) = -G(m,kindices);
    H3(i,kindices) = -B(m,kindices);
    for k = kindices
       if (k == 1)
          continue;
       end
       H2(i,k + offset) = B(m,k);
       H3(i,k + offset) = -G(m,k);
    end
end

%%% 4-5) Power Flow Measurements
H4 = zeros(npf,2*num_nodes-1);
H5 = zeros(npf,2*num_nodes-1);
for i=1:npf
    if br_sign(i) > 0
        m = fbuspf(i);
        n = tbuspf(i);
    else
        m = tbuspf(i);
        n = fbuspf(i);
    end
    H4(i,m) = -G(m,n);
    H4(i,n) = G(m,n);
    H5(i,m) = -B(m,n);
    H5(i,n) = B(m,n);
    H4(i,n + offset) = -B(m,n);
    H5(i,n + offset) = G(m,n);
    if (m > 1)
        H4(i,m + offset) = B(m,n);
        H5(i,m + offset) = -G(m,n);
    end
end

W = sparse(hidx, vidx, covariances);                                       % definizione della matrice sparsa della covarianza tramite assegnazione di indice di colonna, riga, e relativo valore
iW = W\eye(size(W));                                                       % inverso matrice covarianza = matrice dei pesi
iW = sparse(iW);
State = [Vr; Vx(2:end)];

num_iter = 0;
epsilonV = 5;

while (epsilonV > 10^-7 && num_iter <= 100)
    
    Ir_inj = (P_inj.*Vr(busppi)+Q_inj.*Vx(busppi))./(V_abs(busppi).^2);
    Ix_inj = (P_inj.*Vx(busppi)-Q_inj.*Vr(busppi))./(V_abs(busppi).^2);
    z(pidx,1) = Ir_inj;                                                    
    z(qidx,1) = Ix_inj;                                                     
    
    Ir_br = (P_br.*Vr(fbuspf)+Q_br.*Vx(fbuspf))./(V_abs(fbuspf).^2);
    Ix_br = (P_br.*Vx(fbuspf)-Q_br.*Vr(fbuspf))./(V_abs(fbuspf).^2);
    z(pf,1) = Ir_br;
    z(qf,1) = Ix_br;
    
    %%% 1) Voltage Magnitude Measurements
    h1 = V_abs(busvi);
    Vmag_complex = Vcomplex(busvi);
    phi_Vmag = angle(Vmag_complex);
    H1 = zeros(nvi,2*num_nodes-1);
    for i = 1:nvi
        index = busvi(i);
        H1(i, index) = cos(phi_Vmag(i));
        if index > 1
            H1(i, index + offset) = sin(phi_Vmag(i));
        end
    end
    
    %%% 2-3) Power Injection Measurements
    h2 = H2*State;
    h3 = H3*State;
    
    %%% 4-5) Power Flow Measurements
    h4 = H4*State;          
    h5 = H5*State; 
    
    %%% 6) Current Magnitude Measurements
    h6_re = zeros(niampf,1);
    h6_im = zeros(niampf,1);
    h6 = zeros(niampf,1);
    H6 = zeros(niampf,2*num_nodes-1);
    for i = 1:niampf
        m = fbusiampf(i);
        n = tbusiampf(i);
        h6_re(i,1) = Yabs(m,n)*((Vr(n)-Vr(m))*cos(Yphase(m,n)) +  (Vx(m)-Vx(n))*sin(Yphase(m,n)));
        h6_im(i,1) = Yabs(m,n)*((Vr(n)-Vr(m))*sin(Yphase(m,n)) +  (Vx(n)-Vx(m))*cos(Yphase(m,n)));
        h6(i,1) = sqrt(h6_re(i,1)^2 + h6_im(i,1)^2);
        H6(i,m) = - Yabs(m,n)*(cos(Yphase(m,n))*h6_re(i,1)+sin(Yphase(m,n))*h6_im(i,1))/h6(i,1);
        H6(i,n) = - H6(i,m);
        H6(i,n + offset) = Yabs(m,n)*(cos(Yphase(m,n))*h6_im(i,1)-sin(Yphase(m,n))*h6_re(i,1))/h6(i,1);
        if (m > 1)
            H6(i,m + offset) = - H6(i,n + offset);
        end
    end
    
    %%%  fine misure
    
    H = [H1; H2; H3; H4; H5; H6];
    H = sparse(H);
    h = [h1; h2; h3; h4; h5; h6];
    r = z-h;
    g = H'*iW*r;
    Gm = H'*iW*H;    
    iGm = Gm\eye(size(Gm));
    
    Delta_X = iGm*g;
    State = State + Delta_X;
    Vr = State(1:num_nodes);
    Vx(2:end) = State(num_nodes+1:end);
    Vcomplex = complex(Vr,Vx);
    V_abs = abs(Vcomplex);
    num_iter = num_iter + 1;
    epsilonV = max(abs(Delta_X));
end

I = zeros(num_branches,1);
for i = 1:num_branches
    m = branch_first(i);
    n = branch_end(i);
    I(i,1) = -(Vcomplex(m) - Vcomplex(n))*(Y(m,n));
end

%%%%%%%%%%

idx = branch_first == 1;
Iinj = sum(I(idx));
Sinj = Vcomplex(1,1)*conj(Iinj);
Pinj = real(Sinj);    Qinj = imag(Sinj);

val = [V_abs(1,1), Pinj, Qinj];

%%% Calculation uncertainties

G1 = G(1,:);
B1 = B(1,:);

derV = zeros(1,size(iGm,1));
derP = zeros(1,size(iGm,1)+1);
derQ = zeros(1,size(iGm,1)+1);

derV(1,1) = 1;
derP(1,1:num_nodes) = Vr(1,1)*G1;
derP(1,num_nodes+1:end) = - Vr(1,1)*B1;
derQ(1,1:num_nodes) = derP(1,num_nodes+1:end);
derQ(1,num_nodes+1:end) = - derP(1,1:num_nodes);
derP(1,1) = G1(1,1)*Vr(1,1) + G1*Vr - B1*Vx;
derQ(1,1) = - B1(1,1)*Vr(1,1) - B1*Vr - G1*Vx;

derP(:,num_nodes+1) = [];
derQ(:,num_nodes+1) = [];

% Vr_diag = diag(Vr);     Vx_diag = diag(Vx);
% 
% A1 = Vr_diag*G;      A2 = Vx_diag*B;      A3 = -Vr_diag*B;      A4 = Vx_diag*G;
% derP_Vr = A1+A2;
% derP_Vx = A3+A4;
% derP_Vradd = G*Vr - B*Vx;    derP_Vradd_diag = diag(derP_Vradd);
% derP_Vxadd = G*Vx + B*Vr;    derP_Vxadd_diag = diag(derP_Vxadd);
% derP_Vr = derP_Vr + derP_Vradd_diag;
% derP_Vx = derP_Vx + derP_Vxadd_diag;    derP_Vx(:,1) = [];
% derP2 = [derP_Vr, derP_Vx];
% 
% derQ_Vr = A3+A4;
% derQ_Vx = -A1-A2;
% derQ_Vradd = - B*Vr - G*Vx;    derQ_Vradd_diag = diag(derQ_Vradd);
% derQ_Vxadd = - B*Vx + G*Vr;    derQ_Vxadd_diag = diag(derQ_Vxadd);
% derQ_Vr = derQ_Vr + derQ_Vradd_diag;
% derQ_Vx = derQ_Vx + derQ_Vxadd_diag;    derQ_Vx(:,1) = [];
% derQ2 = [derQ_Vr, derQ_Vx];

der = [derV; derP; derQ];
cov = der*iGm*der';
var = diag(cov);
unc = sqrt(var)*3;
unc = unc';

