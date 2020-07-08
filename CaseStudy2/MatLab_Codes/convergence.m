close all
clear
clc


for ny = 2.^[2:6];
    %Physical Parameters
    Pe = 1; %Peclet number
    He = 1;
    Te = 1;
    alpha2 = 1; save('alpha2.mat','alpha2')%ratio of the squares of the length and width

    %Length of simulation
    Tend = 4; save('Tend.mat','Tend')

    %Numerical parameters
  %   ny = 40; save('ny.mat','ny') %number of intervals in the y direction
    nx = ceil(ny/sqrt(alpha2));% save('nx.mat','nx') %number of intervals in the x direction
    ndelt = ny;
    nt = round(Tend*ndelt);

    %Resulting discretisation
    dx = 1/nx;
    dy = 1/ny;
    dt = 1/ndelt;
    beta2 = (dy/dx)^2;

    %Variables to store results
    Results = zeros((nx+1)*(ny+1),nt+1);

    %System constants
    delta = -dt/(4*dx);
    gamma = Pe*dt/(2*dy^2);

    %System Matrices
    %D0 and D1
    D0 = zeros(nx*(ny+1),nx*(ny+1));
    D0(1:ny+1,ny+2:2*(ny+1)) = eye(ny+1);
    for kk = 2:nx-1
        D0((kk-1)*(ny+1)+1:kk*(ny+1),(kk-2)*(ny+1)+1:(kk-1)*(ny+1)) = -eye(ny+1);
        D0((kk-1)*(ny+1)+1:kk*(ny+1), kk   *(ny+1)+1:(kk+1)*(ny+1)) = eye(ny+1);
    end
    D1 = D0;
    D0(end-ny:end,end-ny:end) =  4*dx*eye(ny+1)/dt;
    D1(end-ny:end,end-ny:end) = -4*dx*eye(ny+1)/dt;
    %A
    A = zeros(nx*(ny+1),nx*(ny+1));
    Adiag = -2*eye(ny+1)+diag(ones(1,ny),-1)+diag(ones(1,ny),1);
    Adiag(1,2) = 2;
    Adiag(end,end-1) = 2;
    Adiag(end,end) = Adiag(end,end)-2*dy*He;
    for kk = 1:nx
        A((kk-1)*(ny+1)+1:kk*(ny+1),(kk-1)*(ny+1)+1:kk*(ny+1)) = Adiag;
    end
    % B0 and B1
    B0 = zeros(nx*(ny+1),nx*(ny+1));
    B0(1:ny+1,1:ny+1) = -2*eye(ny+1);
    B0(1:ny+1,ny+2:2*(ny+1)) = eye(ny+1);
    for kk = 2:nx-1
        B0((kk-1)*(ny+1)+1:kk*(ny+1),(kk-2)*(ny+1)+1:(kk-1)*(ny+1)) = eye(ny+1);
        B0((kk-1)*(ny+1)+1:kk*(ny+1),(kk-1)*(ny+1)+1:(kk  )*(ny+1)) = -2*eye(ny+1);
        B0((kk-1)*(ny+1)+1:kk*(ny+1),(kk  )*(ny+1)+1:(kk+1)*(ny+1)) = eye(ny+1);
    end
    B0(end-ny:end,end-(2*ny+2)+1:end-(ny+1)) = 2*eye(ny+1);
    B1 = B0;
    B0(end-ny:end,end-ny:end) = (-2+4*dx/dt)*eye(ny+1);
    B1(end-ny:end,end-ny:end) = (-2-4*dx/dt)*eye(ny+1);
    %Matrices C1 and C0 (to solve system)
    C1 = eye(nx*(ny+1))-delta*D1-gamma*A-gamma*alpha2*beta2*B1;
    C0 = eye(nx*(ny+1))+delta*D0+gamma*A+gamma*alpha2*beta2*B0;
    M = inv(C1);
    N = M*C0;

    %Dirichlet boundary data
    phiLeft = zeros(ny+1,nt+1);
    for ll = 1:nt+1
        phiLeft(:,ll) = (1-exp(-(ll-1)*dt/Te))*ones(ny+1,1);%(sin(pi*(ll-1)*dt/Te))*ones(ny+1,1);%
    end
    Results(1:ny+1,:) = phiLeft;
    %Variables at each time step
    phi = zeros(nx*(ny+1),1);

    %Solving temporal evolution
    for ll = 1:nt
        phi  = N*phi+(-delta+gamma*alpha2*beta2)*M*([phiLeft(:,ll);zeros((nx-1)*(ny+1),1)]+[phiLeft(:,ll+1);zeros((nx-1)*(ny+1),1)]);
        Results(ny+2:end,ll+1) = phi;
    end
    save(['ResultsN',num2str(ny),'.mat'],'Results')
end













        
