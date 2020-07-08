%first simulation in Class
close all
clear
clc

t = 0:.001:.01;
Temp1 = 100*(1-exp(-t/1000));
Temp2 = 40*(1-exp(-100*t));
figure
exact = plot(t,Temp1+Temp2,'b','LineWidth',12)%Exact value
hold on
fast = plot(t,Temp2,'g','LineWidth',4)%Short time approximation
slow = plot(t,Temp1,'color',[.8 .8 .8],'LineWidth',4)%Error in the short time approximation
legend([exact,fast,slow],'Exact Function','Short Time Approx','Error in Approx','location','NorthWest')
grid on
set(gca,'FontSize',16,'xlim',[0 .01])

%%
t = 0:10:1000;
Temp3 = 100*(1-exp(-t/1000));
Temp4 = 40*(1-exp(-100*t));
figure
exact = plot(t,Temp3+Temp4,'b','LineWidth',12)%Exact value
hold on
slow = plot(t,Temp3+40,'color',[.8 .8 .8],'LineWidth',4)%Long time approximation
fast = plot(t,Temp4-40,'g','LineWidth',4)%Error in the approximation
legend([exact,slow,fast],'Exact Function','Long Time Approx','Error in Approx','location','NorthWest')
grid on
set(gca,'FontSize',16,'xlim',[10 1000])


