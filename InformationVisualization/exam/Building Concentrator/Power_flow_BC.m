function [V, I, S, num_iter] = Power_flow_BC(branch, pseudomeas)    % vale solo per reti radiali e trifasi così come scritte in questo papero (SEGAN)
  
branch.num.Tot = branch.num.A + branch.num.B + branch.num.C;
State = zeros(2*branch.num.Tot,1);

z = zeros(2*branch.num.Tot,1);
h = zeros(2*branch.num.Tot,1);
H = zeros(2*branch.num.Tot);

Znod = Znod_matrix(branch);
Znod = sparse(Znod);

for i = 2:branch.num.A+1
    j = 2*(i-2)+1;
    to = find(branch.end.A == i);
    from = find(branch.first.A == i);
    H(j, to) = 1;
    H(j+1, to + branch.num.Tot) = 1;
    for ii = 1:length(from)
        k = from(ii);
        if branch.type.A(k) == 1
            H(j, k) = -1;
            H(j+1, k + branch.num.Tot) = -1;
        else
            H(j, k) = -1;
            H(j+1, k + branch.num.Tot) = -1;
            H(j, k + branch.num.A) = 1;
            H(j+1, k + branch.num.Tot + branch.num.A) = 1;
        end
    end
end

for i = 2:branch.num.B+1
    j = 2*(i-2)+1 + 2*branch.num.A;
    to = find(branch.end.B == i);
    from = find(branch.first.B == i);
    H(j, to + branch.num.A) = 1;
    H(j+1, to+branch.num.Tot + branch.num.A) = 1;
    for ii = 1:length(from)
        k = from(ii);
        if branch.type.B(k) == 1
            H(j, k + branch.num.A) = -1;
            H(j+1, k + branch.num.Tot + branch.num.A) = -1;
        else
            H(j, k + branch.num.A) = -1;
            H(j+1, k + branch.num.Tot + branch.num.A) = -1;
            H(j, k + branch.num.A + branch.num.B) = 1;
            H(j+1, k + branch.num.Tot + branch.num.A + branch.num.B) = 1;
        end
    end
end

for i = 2:branch.num.C+1
    j = 2*(i-2)+1 + 2*(branch.num.A + branch.num.B);
    to = find(branch.end.C == i);
    from = find(branch.first.C == i);
    H(j, to + branch.num.A + branch.num.B) = 1;
    H(j+1, to+branch.num.Tot + branch.num.A + branch.num.B) = 1;
    for ii = 1:length(from)
        k = from(ii);
        if branch.type.C(k) == 1
            H(j, k + branch.num.A + branch.num.B) = -1;
            H(j+1, k + branch.num.Tot + branch.num.A + branch.num.B) = -1;
        else
            H(j, k + branch.num.A + branch.num.B) = -1;
            H(j+1, k + branch.num.Tot + branch.num.A + branch.num.B) = -1;
            H(j, k) = 1;
            H(j+1, k + branch.num.Tot) = 1;
        end
    end
end

H = sparse(H);
iH = H\eye(size(H));
iH = sparse(iH);

VabsA = 1*ones(branch.num.A+1,1);
VabsB = 1*ones(branch.num.B+1,1);
VabsC = 1*ones(branch.num.C+1,1);
VabsA(1:13,1) = VabsA(1:13,1)/sqrt(3);
VabsB(1:13,1) = VabsB(1:13,1)/sqrt(3);
VabsC(1:13,1) = VabsC(1:13,1)/sqrt(3);
Vabs = [VabsA; VabsB; VabsC];

idxA = find(branch.type.A == 2);
idxA = min(idxA);
idxB = find(branch.type.B == 2);
idxB = min(idxB);
idxC = find(branch.type.C == 2);
idxC = min(idxC);
Vtheta = [zeros(idxA,1); -(pi/6)*ones(branch.num.A-idxA+1,1); -(2*pi/3)*ones(idxB,1); -((2*pi/3)+pi/6)*ones(branch.num.B-idxB+1,1); (2*pi/3)*ones(idxC,1); (2*pi/3-pi/6)*ones(branch.num.C-idxC+1,1);];
Vrx = Vabs.*exp(Vtheta*1i);
Vr = real(Vrx);
Vx = imag(Vrx);

epsilon = 5;
num_iter = 0;

while epsilon > 10^-7
    for i = 2:branch.num.A+1
        j = 2*(i-2)+1;
        z(j) = (pseudomeas.P.A(i-1,1)*Vr(i) + pseudomeas.Q.A(i-1,1)*Vx(i))/(Vabs(i)^2);
        z(j+1) = (pseudomeas.P.A(i-1,1)*Vx(i) - pseudomeas.Q.A(i-1,1)*Vr(i))/(Vabs(i)^2);
    end
    for i = 2:branch.num.B+1
        j = 2*(i-2)+1 + 2*branch.num.A;
        k = i + branch.num.A + 1;
        z(j) = (pseudomeas.P.B(i-1,1)*Vr(k) + pseudomeas.Q.B(i-1,1)*Vx(k))/(Vabs(k)^2);
        z(j+1) = (pseudomeas.P.B(i-1,1)*Vx(k) - pseudomeas.Q.B(i-1,1)*Vr(k))/(Vabs(k)^2);
    end
    for i = 2:branch.num.C+1
        j = 2*(i-2)+1 + 2*(branch.num.A + branch.num.B);
        k = i + 2 + branch.num.A + branch.num.B;
        z(j) = (pseudomeas.P.C(i-1,1)*Vr(k) + pseudomeas.Q.C(i-1,1)*Vx(k))/(Vabs(k)^2);
        z(j+1) = (pseudomeas.P.C(i-1,1)*Vx(k) - pseudomeas.Q.C(i-1,1)*Vr(k))/(Vabs(k)^2);
    end
    
    h = H*State;
    r = z-h;
    Delta_State = iH*r;
    State = State + Delta_State;
    epsilon = max(abs(Delta_State));
    
    IrA = State(1 : branch.num.A);
    IrB = State(branch.num.A+1 : branch.num.A+branch.num.B);
    IrC = State(branch.num.A+branch.num.B+1 : branch.num.Tot);
    IxA = State(branch.num.Tot+1 : branch.num.Tot+branch.num.A);
    IxB = State(branch.num.Tot+branch.num.A+1 : branch.num.Tot+branch.num.A+branch.num.B);
    IxC = State(branch.num.Tot+branch.num.A+branch.num.B+1 : end);
    
    IrxA = complex(IrA,IxA);
    IrxB = complex(IrB,IxB);
    IrxC = complex(IrC,IxC);
    Irx = [IrxA; IrxB; IrxC];
    
    Extended_State = [Vrx(1,1); Vrx(branch.num.A+2,1); Vrx(branch.num.A+branch.num.B+3,1); Irx];
    Vrx = Znod*Extended_State;
        
    Vabs = abs(Vrx);
    Vtheta = angle(Vrx);
    Vr = real(Vrx);
    Vx = imag(Vrx);
    
    num_iter = num_iter + 1;
    
end


V.complex.true_val.A = Vrx(1:branch.num.A+1,1);
V.complex.true_val.B = Vrx(branch.num.A+2:branch.num.A+branch.num.B+2,1);
V.complex.true_val.C = Vrx(branch.num.A+branch.num.B+3:end,1);
V.mag.true_val.A = Vabs(1:branch.num.A+1,1);
V.mag.true_val.B = Vabs(branch.num.A+2:branch.num.A+branch.num.B+2,1);
V.mag.true_val.C = Vabs(branch.num.A+branch.num.B+3:end,1);
V.phase.true_val.A = Vtheta(1:branch.num.A+1,1);
V.phase.true_val.B = Vtheta(branch.num.A+2:branch.num.A+branch.num.B+2,1);
V.phase.true_val.C = Vtheta(branch.num.A+branch.num.B+3:end,1);
V.real.true_val.A = Vr(1:branch.num.A+1,1);
V.real.true_val.B = Vr(branch.num.A+2:branch.num.A+branch.num.B+2,1);
V.real.true_val.C = Vr(branch.num.A+branch.num.B+3:end,1);
V.imag.true_val.A = Vx(1:branch.num.A+1,1);
V.imag.true_val.B = Vx(branch.num.A+2:branch.num.A+branch.num.B+2,1);
V.imag.true_val.C = Vx(branch.num.A+branch.num.B+3:end,1);

I.br1.complex.true_val.A = Irx(1:branch.num.A,1);
I.br1.complex.true_val.B = Irx(branch.num.A+1:branch.num.A+branch.num.B,1);
I.br1.complex.true_val.C = Irx(branch.num.A+branch.num.B+1:end,1);
I.br1.mag.true_val.A = abs(I.br1.complex.true_val.A);
I.br1.mag.true_val.B = abs(I.br1.complex.true_val.B);
I.br1.mag.true_val.C = abs(I.br1.complex.true_val.C);
I.br1.phase.true_val.A = angle(I.br1.complex.true_val.A);
I.br1.phase.true_val.B = angle(I.br1.complex.true_val.B);
I.br1.phase.true_val.C = angle(I.br1.complex.true_val.C);
I.br1.real.true_val.A = real(I.br1.complex.true_val.A);
I.br1.real.true_val.B = real(I.br1.complex.true_val.B);
I.br1.real.true_val.C = real(I.br1.complex.true_val.C);
I.br1.imag.true_val.A = imag(I.br1.complex.true_val.A);
I.br1.imag.true_val.B = imag(I.br1.complex.true_val.B);
I.br1.imag.true_val.C = imag(I.br1.complex.true_val.C);

from = find(branch.first.A(1:13,1) == 1);
I.inj.real.true_val.A(1,1) = -sum(I.br1.real.true_val.A(from,1));
I.inj.real.true_val.B(1,1) = -sum(I.br1.real.true_val.B(from,1));
I.inj.real.true_val.C(1,1) = -sum(I.br1.real.true_val.C(from,1));
I.inj.imag.true_val.A(1,1) = -sum(I.br1.imag.true_val.A(from,1));
I.inj.imag.true_val.B(1,1) = -sum(I.br1.imag.true_val.B(from,1));
I.inj.imag.true_val.C(1,1) = -sum(I.br1.imag.true_val.C(from,1));
h2 = reshape(h,2,branch.num.Tot);
h2 = h2';
I.inj.real.true_val.A(2:branch.num.A+1,1) = h2(1:branch.num.A,1);
I.inj.imag.true_val.A(2:branch.num.A+1,1) = h2(1:branch.num.A,2);
I.inj.real.true_val.B(2:branch.num.B+1,1) = h2(branch.num.A+1:branch.num.A+branch.num.B,1);
I.inj.imag.true_val.B(2:branch.num.B+1,1) = h2(branch.num.A+1:branch.num.A+branch.num.B,2);
I.inj.real.true_val.C(2:branch.num.C+1,1) = h2(branch.num.A+branch.num.B+1:end,1);
I.inj.imag.true_val.C(2:branch.num.C+1,1) = h2(branch.num.A+branch.num.B+1:end,2);

I.inj.complex.true_val.A = complex(I.inj.real.true_val.A, I.inj.imag.true_val.A);
I.inj.complex.true_val.B = complex(I.inj.real.true_val.B, I.inj.imag.true_val.B);
I.inj.complex.true_val.C = complex(I.inj.real.true_val.C, I.inj.imag.true_val.C);

S.inj.true_val.A = V.complex.true_val.A .* conj(I.inj.complex.true_val.A);
S.inj.true_val.B = V.complex.true_val.B .* conj(I.inj.complex.true_val.B);
S.inj.true_val.C = V.complex.true_val.C .* conj(I.inj.complex.true_val.C);

S.br1.true_val.A = V.complex.true_val.A(branch.first.A) .* conj(I.br1.complex.true_val.A);
S.br1.true_val.B = V.complex.true_val.B(branch.first.B) .* conj(I.br1.complex.true_val.B);
S.br1.true_val.C = V.complex.true_val.C(branch.first.C) .* conj(I.br1.complex.true_val.C);
S.br2.true_val.A = V.complex.true_val.A(branch.end.A) .* conj(-I.br1.complex.true_val.A);
S.br2.true_val.B = V.complex.true_val.B(branch.end.B) .* conj(-I.br1.complex.true_val.B);
S.br2.true_val.C = V.complex.true_val.C(branch.end.C) .* conj(-I.br1.complex.true_val.C);

for i = 13:21
    S.br1.true_val.A(i,1) = V.complex.true_val.A(branch.first.A(i,1)) * conj(I.br1.complex.true_val.A(i,1) - I.br1.complex.true_val.B(i,1));
    S.br1.true_val.B(i,1) = V.complex.true_val.B(branch.first.B(i,1)) * conj(I.br1.complex.true_val.B(i,1) - I.br1.complex.true_val.C(i,1));
    S.br1.true_val.C(i,1) = V.complex.true_val.C(branch.first.C(i,1)) * conj(I.br1.complex.true_val.C(i,1) - I.br1.complex.true_val.A(i,1));
end

% part to calculate the equivalent pwr injections seen from the MV grid
S.inj.MV.A = zeros(13,1);
S.inj.MV.B = zeros(13,1);
S.inj.MV.C = zeros(13,1);
for i = 1:13
    to  = find(branch.end.A(1:12,1) == i);
    from = find(branch.first.A(1:12,1) == i);
    S.inj.MV.A(i,1) = - sum(S.br2.true_val.A(to,1)) - sum(S.br1.true_val.A(from,1));
    S.inj.MV.B(i,1) = - sum(S.br2.true_val.B(to,1)) - sum(S.br1.true_val.B(from,1));
    S.inj.MV.C(i,1) = - sum(S.br2.true_val.C(to,1)) - sum(S.br1.true_val.C(from,1));
end

