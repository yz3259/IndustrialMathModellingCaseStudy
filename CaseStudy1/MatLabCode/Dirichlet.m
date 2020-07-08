%Dirichlet condition
close all
clear
clc

dz = .01;
dt = .01;
ck =  0.204 ; %thermal conductivity  KJ/(s mK), 1W = 0.001 KJ/s
cd =  2712; % density kg/(m^3)
cc = 0.91;% specific heat KJ/kgK
cl = 0.01;% m
Fo = ck/(cd*cc*cl*cl); %Fourier Number


%%
alpha = dt*Fo/(2*dz^2);

zVec = 0:dz:1;
tVec = 0:dt:40;

nz = length(zVec)-1;
nt = length(tVec)-1;

PhiMat = zeros(nz+1,nt+1);%Matrix where we record the results

%Dirichlet-Dirichlet 
A = diag(-2*ones(1,nz-1))+diag(ones(1,nz-2),-1)+diag(ones(1,nz-2),1);
A1 = (eye(nz-1)-alpha*A)^(-1);
A2 = eye(nz-1)+alpha*A;

PhiMat(1,2:end) = 2*(1-exp(-tVec(2:end)));
PhiMat(end,2:end) = (1-exp(-tVec(2:end)));

for kk = 1:nt
    kk/nt
    PhiMat(2:end-1,kk+1) = A1*A2*PhiMat(2:end-1,kk)+alpha*A1*...
        [PhiMat(1,kk)+PhiMat(1,kk+1);zeros(nz-3,1);...
        PhiMat(end,kk)+PhiMat(end,kk+1)];
end
figure
surf(tVec,zVec,PhiMat,'LineStyle','none','FaceColor','interp')
set(gca,'FontSize',16)
ylabel('$z/L$','interpreter','Latex','FontSize',24)
xlabel('$t/\tau$','interpreter','Latex','FontSize',24)

figure

contour(tVec,zVec,PhiMat)

