% This function creates a matrix that represents the intial
% conditions for a 2-D balloon angioplasty simulation 
% in an ideal blood vessel

function D = simul_bal_expan(imgsz,R_v,R_b)
% Parameters
E_b = 1;    % Balloon elasticity
E_v = 1.5;     % (MPa) Young's Modulus (Vessel elasticity)


R_inner = R_v - 0.5;


Wall = circlemat(100*R_v,imgsz,E_v);
inner = circlemat(100*R_inner, imgsz,E_v);
Wall = Wall - inner;

balloon = circlemat(100*R_b, imgsz,E_b);

D = Wall + balloon;
end 
