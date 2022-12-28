%% B to C pressure Loss

%% User Control
in2m = 0.0254;

D_b_in = 15 % inches
D_c_in = 5;

V = 12; % m/s
g = 9.81;
rho = 1000; 
h = 0.5; % m

%% Automatic
D = D_b_in * in2m;
d = D_c_in * in2m;

% losses due to contraction

if d/D > 0.76
    K_L = (1-d^2/D^2)^2;
else 
    K_L = 0.42*(1-d^2/D^2)^2;
end

hm = K_L*V^2/2/g;

del_p_cont = hm*rho*g

% hydraulic loss

area = pi*D^2/4;

del_p_gravity = rho*g*h/area

del_p_total = del_p_cont+del_p_gravity
del_p_psi = del_p_total*0.000145038
