% 1D code

close all
clear
clc


load('zVecDR.mat','zVec')
load('tVecDR.mat','tVec')
load('PhiMatDR.mat','PhiMat')
load('Fo.mat','Fo')
load('Bi.mat','Bi')

vidObj = VideoWriter('DRanimation','MPEG-4');
open(vidObj);

figure
for kk = 1:10:length(tVec)  
    kk/length(tVec);
    plot(PhiMat(:,kk),zVec,'LineWidth',4)
    set(gca,'FontSize',16,'xlim',[0 2.5],'ylim',[0 1])
    xlabel('$(\theta-\theta_{\infty})/D$','interpreter',...
        'Latex','FontSize',24)
    ylabel('$\frac{z}{L}\ \ \ $','interpreter','Latex',...
        'FontSize',32,'rotation',0)
    if round(tVec(kk)) == tVec(kk)
      title(['Dirichlet-Robin ($Fo = $',num2str(Fo),', $Bi = $',...
        num2str(Bi),')  $t/\tau$ = ',num2str(tVec(kk)),'.0'],...
        'interpreter','latex','FontSize',16)
    else
        title(['Dirichlet-Robin ($Fo = $',num2str(Fo),', $Bi = $',...
        num2str(Bi),')  $t/\tau$ = ',num2str(tVec(kk))],...
        'interpreter','latex','FontSize',16)
    end
    % Write each frame to the file.
    currFrame = getframe(gcf);
    writeVideo(vidObj,currFrame);
end
% Close the file.
close(vidObj);