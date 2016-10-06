%Drug transport 

%Parameters ================================================
p = 5.0;      % (mm) radius of the vessel
L = 12;      % (mm)length of the cylinder 
t = 30;     % (s) incubation period 
dt = 0.01;      % (s) time step
dx = 0.012;      % (mm) length of endoltheial cell ?????
Da = 2700;      %Damkohler number 
W = 0.01;         % mean wall thickness (mm)

% Parameters for Zotarolimus  
K_d = 0.0326;   % (mmol/L)
L_p = 0.083;    % permeation depth 
B_m = 0.356;    % (mmol/L) Net tissue Binding capacity 

%===============================================================
%Solve for the rest of the parameters

Deff = 3.65e-6;   %(mm^2/s) Effective Diffusivity of healthy tissue
D_t = (1 + B_m/K_d)*Deff;

k_a =(D_t*Da)/(B_m*W^2);        % association rate constant 
k_d = k_a*K_d;                  % dissociation rate constant
%===============================================================
%Initialize
%volume-averaged molar concentration of free drug 
cf = zeros(60);
cf(10:40,10:40) = 0.4;
cfu = cf;

%volume-averaged molar concentration of bound drug
cb = zeros(60);
cbu = cb;
%===============================================================

[X,Y] = meshgrid(1:60);
toto = pcolor(X,Y,cf);
shading interp
colorbar
%view(2);
axis equal;
drawnow
film(1) = getframe;

for n=1:50
    cfu = cf;
    cbu = cb;
    
    cb=dt*(k_a*cfu.*(B_m - cbu)-k_d*cbu) +...
        cbu;
    cf=dt*(D_t*...
        (((-circshift(cfu,2,2)+ 16*circshift(cfu,1,2) - 30*cfu + ...
        16*circshift(cfu,-1,2) - circshift(cfu,-2,2))/(12*dx^2)) + ...
        ((-circshift(cfu,2,1) + 16*circshift(cfu,1,1) - 30*cfu + ...
        +16*circshift(cfu,-1,1) - circshift(cfu,-2,1))/(12*dx^2)))...
        +((cb-cbu)/dt))+ cfu;
    
    cf(1,:) = 0;
    cb(1,:) = 0;
    cf(:,end) = 0;
    cb(:,end) = 0;
    
    set(toto,'Xdata',X,'Ydata',Y,'Cdata',cf)
    %---------------------
    drawnow
    %---------------------
    film(n) = getframe; 

end


% Notes for code 10/04
%check units on outputs
%check cell length?? - is this the right assumption? 
