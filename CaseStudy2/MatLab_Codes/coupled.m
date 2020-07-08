close all
clear
clc

%Physical Parameters
Pe = 1;
He = 1;
Te = 1;
De = 1; %Ratio of Diffusivities
Ve = -1.1; %Ratio of velocities
alpha2 = 1; %ratio of the squares of the length and width

%Length of simulation
Tend = 5; %total time to be simulated measured in the time units used for non-dimensionalisation

%Numerical parameters
ny = 20; save('nyCoupled.mat','ny')
nx = ceil(ny/sqrt(alpha2)); save('nxCoupled.mat','nx')
ndelt = 100; %Number of time steps per unit time
nt = Tend*ndelt; %number of total time steps

%Resulting constants
dx = 1/nx;
dy = 1/ny;
dt = 1/ndelt;
beta2 = (dy/dx)^2;

%Variables to store results
Results = zeros(2*(nx+1)*(ny+1),nt+1);

%System constants
delta = -dt/(4*dx);
gamma = Pe*dt/(2*dy^2);
mu = delta*Ve;
lambda = gamma*De;

%System Matrices
%D0 and D1
D0 = zeros(nx*(ny+1),nx*(ny+1));
D0(1:ny+1,ny+2:2*ny+2) = eye(ny+1);
for kk = 2:nx-1
    D0((kk-1)*(ny+1)+1:kk*(ny+1),(kk-2)*(ny+1)+1:(kk-1)*(ny+1)) = -eye(ny+1);
    D0((kk-1)*(ny+1)+1:kk*(ny+1), kk   *(ny+1)+1:(kk+1)*(ny+1)) = eye(ny+1);
end
D1 = D0;
D0(end-ny:end,end-ny:end) =  4*dx*eye(ny+1)/dt;
D1(end-ny:end,end-ny:end) = -4*dx*eye(ny+1)/dt;
%A
A = zeros(nx*(ny+1),nx*(ny+1));
Adiag = -2*eye(ny+1)+diag(ones(1,ny),-1)+diag(ones(1,ny),1);
Adiag(1,2) = 2;
Adiag(end,end-1) = 2;
Adiag(end,end) = Adiag(end,end)-2*dy*He;
for kk = 1:nx
    A((kk-1)*(ny+1)+1:kk*(ny+1),(kk-1)*(ny+1)+1:kk*(ny+1)) = Adiag;
end
% B0 and B1
B0 = zeros(nx*(ny+1),nx*(ny+1));
B0(1:ny+1,1:ny+1) = -2*eye(ny+1);
B0(1:ny+1,ny+2:2*ny+2) = eye(ny+1);
for kk = 2:nx-1
    B0((kk-1)*(ny+1)+1:kk*(ny+1),(kk-2)*(ny+1)+1:(kk-1)*(ny+1)) = eye(ny+1);
    B0((kk-1)*(ny+1)+1:kk*(ny+1),(kk-1)*(ny+1)+1:(kk  )*(ny+1)) = -2*eye(ny+1);
    B0((kk-1)*(ny+1)+1:kk*(ny+1),(kk  )*(ny+1)+1:(kk+1)*(ny+1)) = eye(ny+1);
end
B0(end-ny:end,end-(2*ny+2)+1:end-(ny+1)) = 2*eye(ny+1);
B1 = B0;
B0(end-ny:end,end-ny:end) = (-2+4*dx/dt)*eye(ny+1);
B1(end-ny:end,end-ny:end) = (-2-4*dx/dt)*eye(ny+1);


%Matrix E0 and E1
E0 = zeros(nx*(ny+1),nx*(ny+1));
for kk = 2:nx-1
    E0((kk-1)*(ny+1)+1:kk*(ny+1),(kk-2)*(ny+1)+1:(kk-1)*(ny+1)) = -eye(ny+1);
    E0((kk-1)*(ny+1)+1:kk*(ny+1), kk   *(ny+1)+1:(kk+1)*(ny+1)) = eye(ny+1);
end
E0(end-ny:end,end-2*(ny+1)+1:end-(ny+1)) = -eye(ny+1);
E1 = E0;
E1(1:ny+1,1:ny+1) = -4*dx/(dt*Ve)*eye(ny+1);
E0(1:ny+1,1:ny+1) =  4*dx/(dt*Ve)*eye(ny+1);
%Matrix F
Fdiag = -2*diag(ones(ny+1,1))+diag(ones(ny,1),-1)+diag(ones(ny,1),1);
Fdiag(1,2) = 2;
Fdiag(end,end-1) = 2;
Fdiag(1,1) = Fdiag(1,1)-2*dy*He/De;
for kk = 1:nx
    F((kk-1)*(ny+1)+1:kk*(ny+1),(kk-1)*(ny+1)+1:kk*(ny+1)) = Fdiag;
end
%Matrices G1 and G0
G0 = zeros(nx*(ny+1),nx*(ny+1));
for kk = 2:nx-1
    G0((kk-1)*(ny+1)+1:kk*(ny+1),(kk-2)*(ny+1)+1:(kk-1)*(ny+1)) = eye(ny+1);
    G0((kk-1)*(ny+1)+1:kk*(ny+1),(kk-1)*(ny+1)+1:(kk  )*(ny+1)) = -2*eye(ny+1);
    G0((kk-1)*(ny+1)+1:kk*(ny+1),(kk  )*(ny+1)+1:(kk+1)*(ny+1)) = eye(ny+1);
end
G0(end-ny:end,end-(2*ny+2)+1:end-(ny+1)) = eye(ny+1);
G0(end-ny:end,end-ny:end) = -2*eye(ny+1);
G0(1:ny+1,ny+2:2*ny+2) = 2*eye(ny+1);
G1 = G0;
G0(1:ny+1,1:ny+1) = (-2-4*dx/(dt*Ve))*eye(ny+1);
G1(1:ny+1,1:ny+1) = (-2+4*dx/(dt*Ve))*eye(ny+1);














%Matrices C1 and C0 (to solve system)
C0 = eye(nx*(ny+1))+delta*D0+gamma*A+gamma*alpha2*beta2*B0;
C1 = eye(nx*(ny+1))-delta*D1-gamma*A-gamma*alpha2*beta2*B1;
H0 = eye(nx*(ny+1))+mu*E0+lambda*F+lambda*alpha2*beta2*G0;
H1 = eye(nx*(ny+1))-mu*E1-lambda*F-lambda*alpha2*beta2*G1;
















%Coupling Matrices
%K matrix
K = zeros(nx*(ny+1),nx*(ny+1));
for kk = 1:nx-1
    K(kk*(ny+1),kk*(ny+1)+1) = 2*dy*gamma*He;
end
%L matrix
L = zeros(nx*(ny+1),nx*(ny+1));
for kk = 2:nx
    L((kk-1)*(ny+1)+1,(kk-1)*(ny+1)) = 2*dy*gamma*He; %which happens to be the same as 2*dy*lambda*He/De
end

%Block system matrices
M1 = [C1,-K;[-L,H1]];
M0 = [C0,K;[L,H0]];
M = inv(M1);
N = M*M0;

%Dirichlet boundary data
%PhiLeft
phiLeft = zeros(ny+1,nt+1);
for ll = 1:nt+1
    phiLeft(:,ll) = (1-exp(-(ll-1)*dt/Te))*ones(ny+1,1);
end
%PsiRight
psiRight = zeros(ny+1,nt+1);

%Initial values of variables
phi = zeros(nx*(ny+1),1);
psi = zeros(nx*(ny+1),1);

%Storing results
Results(1:ny+1,:) = phiLeft; %Dirichlet BC to the left
Results(end-ny:end,:) = psiRight; %Dirichlet BC to the right
Results(ny+2:(nx+1)*(ny+1),1) = phi;
Results((nx+1)*(ny+1)+1:(2*nx+1)*(ny+1),1) = psi;


%Solving temporal evolution
for ll = 1:nt
    vector = N*[phi;psi]+...
        M*[(-delta+gamma*alpha2*beta2)*(phiLeft(:,ll)+phiLeft(:,ll+1));zeros((nx-1)*(ny+1),1);...
        zeros((nx-1)*(ny+1),1);(mu+lambda*alpha2*beta2)*(psiRight(:,ll)+psiRight(:,ll+1))]+...
        2*dy*gamma*He*M*[zeros(nx*(ny+1)-1,1);(psiRight(1,ll)+psiRight(1,ll+1));...
        (phiLeft(ny+1,ll)+phiLeft(ny+1,ll+1));zeros(nx*(ny+1)-1,1)];
    phi = vector(1:nx*(ny+1),1);
    psi = vector(nx*(ny+1)+1:end,1);
    Results(ny+2:end-(ny+1),ll+1) = [phi;psi];
end
save('ResultsCoupled.mat','Results')













        
