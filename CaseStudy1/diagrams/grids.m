r = 0.1;
t = 0:0.01:2*pi;

xc = 0; 
yc = 0;
dz = 0.8;
dt = 0.5;
for ii = 1: 5
    for kk = 1:10
        x=  func(xc+ii*dt,r);
        y = func(ys+kk*dz,r);
        plot(x,y)
        
    end
end
        
        