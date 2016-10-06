% 2-D Balloon expansion 
clear all;

disp('Running Balloon expansion');

%Parameters
imgsz = 900;
R_Bf = 5.0/2;     % (mm) final diameter of balloon
nstep = 5;     % time step (0.01s)

R_outer = 5.5/2;  % (mm) Outer radius blood vessel 
R_inner = 5.0/2;  % (mm) Inner radius blood vessel
R_Bi = 1.0;     % (mm) initial diameter of the balloon
R_step = (R_Bf - R_Bi)/nstep;

E = 1.5;  %(MPa)=(N/mm^2)  Young's Modulus Blood Vessel
P = 1.2159; %(MPa) Pressure exerted by Balloon 
d0 = 5.0;    %(mm) initial diameter of blood vessel 


D = simul_bal_expan(imgsz,R_outer,R_Bi);
[rr, cc] = meshgrid(1:imgsz);

disp('Initializing...');
figure(1);
rectangle('Position',[0 0 imgsz imgsz],'linewidth',2)
axis equal
axis([0 imgsz 0 imgsz])
hold on

% first time step 
t = 1;
toto = pcolor(rr,cc,D);
shading interp
colorbar
%surf(rr,cc,D, 'EdgeColor', 'None',...
 %   'facecolor', 'interp');
view(2);
colorbar
axis equal;
axis off;
drawnow
film(1) = getframe;

disp('Starting Film')
% time to 0.1 s (balloon expansion)
for t = 2:nstep
    D = simul_bal_expan(imgsz,R_outer,R_Bi+(t*R_step));
    set(toto,'Xdata',rr,'Ydata',cc,'Cdata',D)
    %---------------------
    drawnow
    %---------------------
    film(t) = getframe; 
end

nstep2 = 5;
dl = P_solver(P,d0,E);
disp(dl)
dlstep = dl/nstep2;

for t=nstep:nstep+nstep2
    D = simul_bal_expan(imgsz,R_outer+((t-nstep)*dlstep),...
        R_Bf+((t-nstep)*dlstep));
    set(toto,'Xdata',rr,'Ydata',cc,'Cdata',D)
    drawnow
    %---------------------
    film(t) = getframe; 
end






