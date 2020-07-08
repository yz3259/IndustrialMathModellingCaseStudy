close all
clear
clc

load('PhiMatLength0.01.mat')
PhiMat1= PhiMat;
load('PhiMatLength0.02.mat')
PhiMat2= PhiMat;
load('PhiMatLength0.03.mat')
PhiMat3= PhiMat;
load('PhiMatLength0.04.mat')
PhiMat4= PhiMat;

T1 = PhiMat1(end,:);
T2 = PhiMat2(end,:);
T3 = PhiMat3(end,:);
T4 = PhiMat4(end,:);
Tmax = PhiMat1(1,end);
tVec = 0:0.01:80;
figure
graph1 = plot(tVec,T1,'y',tVec,T2,'m--',tVec,T3,'c:',tVec, T4,'b-.');
hline = refline([0 Tmax]);
set(graph1,'LineWidth',3);
set(hline,'LineWidth',1.5)
hline.Color = 'r';

xlabel('Time: t')
ylabel('Upper Boundary Temperature')
legend('Length: 1cm','Length: 2cm','Length: 3cm','Length 4 cm','Maximum Temperature')