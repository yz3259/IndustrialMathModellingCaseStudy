% Part I simple model. 
close all
clear
clc
load('ResultsCoupled.mat')
%load('nxCoupled.mat');
%load('nyCoupled.mat');
dy = 1/20;
y =(0:dy:1);
%[~,ind]=min(abs(y-1/8));

[~,ind]=min(abs(y-7/8));
begin=ResultsCoupled(ind,:);

finish = ResultsCoupled(20*(20+1)+ind,:);
plot(begin)
hold on
plot(finish,'--')
%title('Test: Polluntant concentration at far end from the membrane')
title('Test: Polluntant concentration close to the membrane')
xlabel('Change of Time t') % x-axis label
ylabel('Pollutant concentration') % y-axis label
legend('Pollutant concentration at x=0','Pollutant concentration at x = 1','Location','southeast');