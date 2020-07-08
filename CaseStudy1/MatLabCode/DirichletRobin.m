%Dirichlet and Robin

close all
clear
clc

 dz = .01;
 dt = .01;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Al
%   ck =  0.204 ; %thermal conductivity  KJ/(s mK), 1W = 0.001 KJ/s
%   cd =  2712; % density kg/(m^3) Al
%   cc = 0.91;% specific heat KJ/kgK

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Copper 
%  ck = 0.386;
%  cd =8940;
%  cc =0.39; 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Iron
%  ck =0.073;
%  cd = 7850;
%  cc =0.45;

 cl = 0.01;% m
 
 
   Fo = ck/(cd*cc*cl*cl); %Fourier Number
 %Fo = 1.1071;
 %Bi = 1.5;
 ch = 3; % take value of 0.01; 0.1; 3 ; 10
 Bi = ch * cl/ck;  %Biot Number


%%
alpha = dt*Fo/(2*dz^2);

zVec = 0:dz:1;
tVec = 0:dt:40;

nz = length(zVec)-1;
nt = length(tVec)-1;

PhiMat = zeros(nz+1,nt+1);%Matrix where we record the results

%Dirichlet-Robin 
C = diag(-2*ones(1,nz))+diag(ones(1,nz-1),-1)+diag(ones(1,nz-1),1);
C(end,end-1) = 2;
C(end,end) = -2*(1+dz*Bi);
C1 = (eye(nz)-alpha*C)^(-1);
C2 = C1*(eye(nz)+alpha*C);
C1 = alpha*C1;


PhiMat(1,2:end) = 2*(1-exp(-tVec(2:end)));

for kk = 1:nt
    kk/nt
    PhiMat(2:end,kk+1) = C2*PhiMat(2:end,kk)+C1*...
        [PhiMat(1,kk)+PhiMat(1,kk+1);zeros(nz-1,1)];
    %PhiMat(end,kk+1) = PhiMat(end-2,kk+1)/(1+2*dz*Bi);
end
figure
surf(tVec,zVec,PhiMat,'LineStyle','none','FaceColor','interp')
set(gca,'FontSize',16)
ylabel('$z/L$','interpreter','Latex','FontSize',24)
xlabel('$t/\tau$','interpreter','Latex','FontSize',24)
save(['PhiMatBiMet',num2str(Bi),'.mat'],'PhiMat')
%save(['PhiMatLength',num2str(cl),'.mat'],'PhiMat')


