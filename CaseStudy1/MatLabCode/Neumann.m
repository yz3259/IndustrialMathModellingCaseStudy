% Neumann conditions

close all
clear
clc

dz = .01;
dt = .01;
Fo = 0.8266; %Fourier Number

%%
alpha = dt*Fo/(2*dz^2);

zVec = 0:dz:1;
tVec = 0:dt:40;

nz = length(zVec)-1;
nt = length(tVec)-1;

PhiMat = zeros(nz+1,nt+1);%Matrix where we record the results

% Neumann-Neumann
B = diag(-2*ones(1,nz+1))+diag(ones(1,nz),-1)+diag(ones(1,nz),1);
B(1,2) = 2;
B(end,end-1) = 2;
B1 = (eye(nz+1)-alpha*B)^(-1);
B2 = B1*(eye(nz+1)+alpha*B);
B1 = 2*dz*alpha*B1;

gb = 2*(1-exp(-tVec(1:end)));
gt = -2*(1-exp(-tVec(1:end)));

for kk = 1:nt
    kk/nt
    PhiMat(:,kk+1) = B2*PhiMat(:,kk)+B1*...
        [gb(kk)+gb(kk+1);zeros(nz-1,1);gt(kk)+gt(kk+1)];
end
figure
surf(tVec,zVec,PhiMat,'LineStyle','none','FaceColor','interp')
set(gca,'FontSize',16)
ylabel('$z/L$','interpreter','Latex','FontSize',24)
xlabel('$t/\tau$','interpreter','Latex','FontSize',24)


figure
contour(tVec,zVec,PhiMat)
