%This file initilizes the arrays for our 2-D simulation of a 
% balloon angioplasty 

disp('Running Balloon expansion');

disp('Gathering Parameters')
%Parameters
imgsz = 900;
R_Bf = 4.5/2;     % (mm) final diameter of balloon
nstep = 5;     % time step (0.01s)

R_outer = 5.5/2;  % (mm) Outer radius blood vessel 
R_inner = 4.5/2;  % (mm) Inner radius blood vessel
R_Bi = 1.0;     % (mm) initial diameter of the balloon
R_step = (R_Bf - R_Bi)/nstep;

E = 1.5;  %(MPa)=(N/mm^2)  Young's Modulus Blood Vessel
P = 1.2159; %(MPa) Pressure exerted by Balloon 
d0 = 5.0;    %(mm) initial diameter of blood vessel 

D1 = simul_bal_expan(imgsz,R_outer,R_Bi);

disp('Initializing.')
disp('Initializing..')
disp('Initializing...')
for t = 2:nstep
    var = strcat('D',int2str(t),'=D;');
    D = simul_bal_expan(imgsz,R_outer,R_Bi+(t*R_step));
    eval(var)
end

disp('Initializing.')
disp('Initializing..')
disp('Initializing...')
nstep2 = 5;
dl = P_solver(P,d0,E);
disp(dl)
dlstep = dl/nstep2;

for t=nstep:nstep+nstep2
    var = strcat('D',int2str(t),'=D;');
    D = simul_bal_expan(imgsz,R_outer+((t-nstep)*dlstep),...
        R_Bf+((t-nstep)*dlstep));
    eval(var)
end

save('data_balloon_Ex','D1','D2','D3','D4','D5','D6','D7',...
    'D8','D9','D10', 'imgsz','nstep','nstep2')

fprintf('\n\n')
disp('Solution saved in file: data_euler_flow.mat')
disp('Use function graph_flow_euler.m to make a video')