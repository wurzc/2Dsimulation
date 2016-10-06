% Pressure solver 

function dr = P_solver(P,d0,E)
r0 = d0/2;   % (mm) radius of blood vessel

dr = P*r0 / E;
end