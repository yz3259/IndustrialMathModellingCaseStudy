close all
clear
clc

load('PhiMatLength0.01.mat')
PhiMat1= PhiMat;
load('PhiMatLength0.1.mat')
PhiMat2= PhiMat;
load('PhiMatLength0.15.mat')
PhiMat3= PhiMat;
load('PhiMatLength0.2.mat')
PhiMat4= PhiMat;
load('PhiMatLength0.25.mat')
PhiMat5= PhiMat;

T1 = PhiMat1(end,:);
T2 = PhiMat2(end,:);
T3 = PhiMat3(end,:);
T4 = PhiMat4(end,:);
T5 = PhiMat5(end,:);
Tmax1 = PhiMat1(1,end);

tVec = 0:0.01:80;
figure
graph1 = plot(tVec,T1,'y',tVec,T2,'m--',tVec,T3,'c:',tVec, T4,'g-.',tVec,T5,'b');
hline = refline([0 Tmax1]);

set(graph1,'LineWidth',3);
set(hline,'LineWidth',1.5)
hline.Color = 'r';

xlabel('Time: t')
ylabel('Upper Boundary Temperature')
legend('Length: 1cm','Length: 10cm','Length: 15cm','Length 20 cm','Length 25 cm','Maximum Temperature')