% 2-D Balloon expansion 
clear all;

disp('Running Balloon expansion 2-D Simulation');

load('data_balloon_Ex','D1','D2','D3','D4','D5','D6','D7',...
    'D8','D9','D10', 'imgsz','nstep','nstep2')

E = 1.5;     %(MPa)=(N/mm^2)  Young's Modulus Blood Vessel
P = 1.2159;  %(MPa) Pressure exerted by Balloon 
d0 = 5.0;    %(mm) initial diameter of blood vessel 

[rr, cc] = meshgrid(1:imgsz);

figure(1);
rectangle('Position',[0 0 imgsz imgsz],'linewidth',2)
axis equal
axis([0 imgsz 0 imgsz])
hold on

% first time step 
t = 1;
toto = pcolor(rr,cc,D1);
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
    D = eval(strcat('D',int2str(t)));
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
    D = eval(strcat('D',int2str(t)));
    set(toto,'Xdata',rr,'Ydata',cc,'Cdata',D)
    drawnow
    %---------------------
    film(t) = getframe; 
end






