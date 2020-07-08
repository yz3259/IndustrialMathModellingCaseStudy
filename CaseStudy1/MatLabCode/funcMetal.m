% plotting all the four fluids effect together
close all
clear
clc

load('PhiMatBiMet0.07772.mat')
PhiMat1= PhiMat;
load('PhiMatBiMet0.14706.mat')
PhiMat2= PhiMat;
load('PhiMatBiMet0.41096.mat')
PhiMat3= PhiMat;



T1 = PhiMat1(end,:);
ck1 =  0.204;
T2 = PhiMat2(end,:);
ck2 = 0.386;
T3 = PhiMat3(end,:);
ck3 =0.073;
% UHF1=3*T1;
% UHF2=3*T2;
% UHF3=3*T3;

UHF1=ck1*(PhiMat1(end-1,:)-PhiMat1(end,:))/0.01;
UHF2=ck2*(PhiMat2(end-1,:)-PhiMat2(end,:))/0.01;
UHF3=ck3*(PhiMat3(end-1,:)-PhiMat3(end,:))/0.01;

LHF1 = ck1*(PhiMat1(1,:)-PhiMat1(2,:))/0.01;
LHF2 = ck2*(PhiMat2(1,:)-PhiMat2(2,:))/0.01;
LHF3 = ck3*(PhiMat3(1,:)-PhiMat3(3,:))/0.01;
tVec = 0:0.01:40;

%q1 upper surface heat flux
Q1UHF1 = ck1*(PhiMat1(25,:)-PhiMat1(26,:))/0.01;
Q1UHF2 = ck2*(PhiMat2(25,:)-PhiMat2(26,:))/0.01;
Q1UHF3 = ck3*(PhiMat3(25,:)-PhiMat3(26,:))/0.01;

%q2 upper surface heat flux
Q2UHF1 = ck1*(PhiMat1(50,:)-PhiMat1(51,:))/0.01;
Q2UHF2 = ck2*(PhiMat2(50,:)-PhiMat2(51,:))/0.01;
Q2UHF3 = ck3*(PhiMat3(50,:)-PhiMat3(51,:))/0.01;

%q3 upper surface heat flux
Q3UHF1 = ck1*(PhiMat1(75,:)-PhiMat1(76,:))/0.01;
Q3UHF2 = ck2*(PhiMat2(75,:)-PhiMat2(76,:))/0.01;
Q3UHF3 = ck3*(PhiMat3(75,:)-PhiMat3(76,:))/0.01;
nt = length(tVec);
figure
graph1 = plot(tVec,UHF1,'m',tVec,UHF2,'g--',tVec,UHF3,'b:');
set(graph1,'LineWidth',3);
xlabel('Time: t')
ylabel('Upper boundary Heat Flux')
legend('Aluminum','Copper','Iron')


figure 
graph1 = plot(tVec,PhiMat1(1,:),'m',tVec,PhiMat2(1,:),'g--',tVec,PhiMat3(1,:),'b:');
set(graph1,'LineWidth',3);
xlabel('Time: t')
ylabel('Lower boundary Temperature')
legend('Aluminum','Copper','Iron')

figure 
graph1 = plot(tVec,T1,'m',tVec,T2,'g--',tVec,T3,'b:');
set(graph1,'LineWidth',3);
xlabel('Time: t')
ylabel('Upper boundary Temperature')
legend('Aluminum','Copper','Iron')


figure 

graph1 = plot(tVec,-UHF1+LHF1,'m',tVec,-UHF2+LHF2,'g--',tVec,-UHF3+LHF3,'b:');
set(graph1,'LineWidth',3);
xlabel('Time: t')
ylabel('Average Heat Flux')
legend('Aluminum','Copper','Iron')

figure 

graph1 = plot(tVec,-UHF1+Q3UHF1,'m',tVec,-UHF2+Q3UHF2,'g--',tVec,-UHF3+Q3UHF3,'b:');
set(graph1,'LineWidth',3);
xlabel('Time: t')
ylabel('Average heat flux:q4')
legend('Aluminum','Copper','Iron')

figure 
dz1 = 0.01*100/4;
graph1 = plot(tVec,-Q1UHF1+LHF1,'m',tVec,-Q1UHF2+LHF2,'g--',tVec,-Q1UHF3+LHF3,'b:');
set(graph1,'LineWidth',3);
xlabel('Time: t')
ylabel('Average heat flux: q1')
legend('Aluminum','Copper','Iron')

figure 

graph1 = plot(tVec,-Q2UHF1+Q1UHF1,'m',tVec,-Q2UHF2+Q1UHF2,'g--',tVec,-Q2UHF3+Q1UHF3,'b:');
set(graph1,'LineWidth',3);
xlabel('Time: t')
ylabel('Average heat flux: q2')
legend('Aluminum','Copper','Iron')

figure 

graph1 = plot(tVec,-Q3UHF1+Q2UHF1,'m',tVec,-Q3UHF2+Q2UHF2,'g--',tVec,-Q3UHF3+Q2UHF3,'b:');
set(graph1,'LineWidth',3);
xlabel('Time: t')
ylabel('Average heat flux: q3')
legend('Aluminum','Copper','Iron')