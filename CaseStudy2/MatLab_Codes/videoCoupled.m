close all
clear
clc

load('ResultsCoupled.mat')
load('nxCoupled.mat')
load('nyCoupled.mat')

dx = 1/nx;
dy = 1/ny;
xvec = 0:dx:1;
yvec = 0:dy:1;

vidObj = VideoWriter('SolutionCoupled','MPEG-4');
open(vidObj);
for ll=1:size(Results,2)
    surf(xvec,yvec-1,reshape(Results(1:(nx+1)*(ny+1),ll),ny+1,nx+1),'LineStyle','none','FaceColor','interp')
    hold on
    surf(xvec,yvec,reshape(Results((nx+1)*(ny+1)+1:end,ll),ny+1,nx+1),'LineStyle','none','FaceColor','interp')
    set(gca,'zlim',[0 1])
    currFrame = getframe(gcf);
    writeVideo(vidObj,currFrame);
    hold off
%     pause
end
close(vidObj);
    