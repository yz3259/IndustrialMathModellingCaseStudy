close all
clear
clc

nyVec = 2.^(2:6);
compareCell = cell(1,length(nyVec));%Storing the resulting matrices
count = 0;
for ny = nyVec
    count = count+1;
    load(['ResultsN',num2str(ny),'.mat'],'Results')
    xVec = 0:1/ny:1;
    yVec = 0:1/ny:1;
    tVec = 0:1/ny:4;
    CompareMat = zeros(nyVec(1)^2,4*nyVec(1));
    for kk = 1:4*nyVec(1)
        [~,indexT] = min(abs(tVec-kk/(4*nyVec(1))));
        for jj = 1:nyVec(1)
            [~,indexX] = min(abs(xVec-jj/nyVec(1)));
            for ii = 1:nyVec(1)
                [~,indexY] = min(abs(yVec-ii/nyVec(1)));
                CompareMat((jj-1)*nyVec(1)+ii,kk) = ...
                    Results((indexX-1)*(ny+1)+indexY,indexT);
            end
        end
    end
    compareCell{count} = CompareMat;
end

error = zeros(1,length(nyVec)-1);
for pp = 1:length(nyVec)-1
    error(pp) = norm(compareCell{pp}-compareCell{length(nyVec)},1);
end

plot(log(nyVec(1:end-1)),log(error),'LineWidth',4)
m = polyfit(log(nyVec(1:end-1)),log(error),1);
hold on
plot(log(nyVec(1:end-1)),m(1)*log(nyVec(1:end-1))+m(2))
grid on
    