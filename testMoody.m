v = 12*0.3; % meter
lIn = 5; % inch
l = lIn * 0.0254; % meter
A = l^2;
P = 4*l;
% laminar if Re < 2300
% transient for 2300 < Re < 4000
% turbulent if Re > 4000
D_h = 4*A/P;

D = D_h;

rho = 1000; % kg/m^3
mu = 1.0016e-3; % at 20C for water, mPa*s to 10e-3 Pas

Re = rho*v*D_h/mu % reynolds number

epsilon = 0.0015/1000 % glass mm to m

ed = epsilon/D;

f = moody(ed,Re)