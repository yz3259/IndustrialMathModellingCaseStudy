close all
clear
clc

load('Results.mat')
load('nx.mat')
load('ny.mat')

dx = 1/nx;
dy = 1/ny;
xvec = 0:dx:1;
yvec = 0:dy:1;

vidObj = VideoWriter('Solution','MPEG-4');
open(vidObj);
for ll=1:size(Results,2)
    surf(xvec,yvec-1,reshape(Results(:,ll),ny+1,nx+1),'LineStyle','none','FaceColor','interp')
    set(gca,'zlim',[0 1.2])
%     view([30+ll 60])
    currFrame = getframe(gcf);
    writeVideo(vidObj,currFrame);
%     pause
end
close(vidObj);
    