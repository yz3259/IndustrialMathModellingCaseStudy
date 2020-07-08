% plotting all the four fluids effect together
close all
clear
clc

load('PhiMatBi0.0004902.mat')
PhiMat1= PhiMat;
load('PhiMatBi0.004902.mat')
PhiMat2= PhiMat;
load('PhiMatBi0.14706.mat')
PhiMat3= PhiMat;
load('PhiMatBi0.4902.mat')
PhiMat4= PhiMat;


T1 = PhiMat1(end,:);
T2 = PhiMat2(end,:);
T3 = PhiMat3(end,:);
T4 = PhiMat4(end,:);
Tmax = PhiMat1(1,end);
tVec = 0:0.01:30;
figure
graph1 = plot(tVec,T1,'y',tVec,T2,'m--',tVec,T3,'c:',tVec, T4,'b-.');
hline = refline([0 Tmax]);
set(graph1,'LineWidth',3);
set(hline,'LineWidth',1.5)
hline.Color = 'r';

xlabel('Time: t')
ylabel('Upper Boundary Temperature')
legend('slow air flow','fast air flow','water','other liquid','Maximum Temperature')


