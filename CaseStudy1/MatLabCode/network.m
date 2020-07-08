n = 4;
A = delsq(numgrid('S',n+2));
G = graph(A,'OmitSelfLoops');
p = plot(G);