% Part I simple model. 
close all
clear
clc
load('Results.mat')
load('nx.mat')
load('ny.mat')
dy = 1/ny;
y =(0:dy:1);
%[~,ind]=min(abs(y-1/8));

[~,ind]=min(abs(y-7/8));
begin=Results(ind,:);

finish = Results(nx*(ny+1)+ind,:);
plot(begin)
hold on
plot(finish,'--')
%title('Test: Polluntant concentration at far end from the membrane')
title('Test: Polluntant concentration close to the membrane')
xlabel('Change of Time t') % x-axis label
ylabel('Pollutant concentration') % y-axis label
legend('Pollutant concentration at x=0','Pollutant concentration at x = 1','Location','southeast');