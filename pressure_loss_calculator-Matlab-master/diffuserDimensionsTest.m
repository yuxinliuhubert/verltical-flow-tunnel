%% VWT Diffuser for Section CD
% *Group: Hubert Liu, Dave Li*
% 
% *Author: Hubert Liu*

%% Theory and Method
% The test section CD is designed to be perpendicular to the ground. Water flows throgh the section against the gravity. Therefore, if the section is
% straight, then the pressure cannot stay constant. To ensure a constant pressure, we must make sure that dP, or
% the overall change of pressure, equals to 0
% 
% To achieve that, the section wall must be angled slightly. The purpose of
% this script is to calculate the angle that will keep dP = 0
% 
% Here is a graph that visualizes some of the constants and variables we are
% using in the following script:
%
% <</Users/hubert/Documents/GitHub/verltical-flow-tunnel/pressure_loss_calculator-Matlab-master/CDDrawing.jpeg>>
%
% We define *positive* pressure change to be the increase in pressure against the
% flow. In other words, positive pressure or pressure change require the
% pump to pump *harder*. The direction of l points downward, the same
% direction as the gravity.


%% Constants
v_c = 12; % m/s
d_c = 0.127; % m
V = d_c^2/4*v_c; % m^3
rho = 1000; % kg/m^3
h = 1.5; % m
g = 9.81; % N/Kg
T = 20; % C
epsilon = 1.50E-05; % absolute roughness

% Pressure
P_atm = 101320; % Pa
Pa2Bar = 1/100000;
P = (P_atm+4000)*Pa2Bar;

% Reynolds Number
Re = tReynolds(V*rho,d_c,T,P);

% get the friction factor f, assuming stainless steel
f = f_Moody(d_c,Re,epsilon);

%% Symbolic relationships

syms theta l
% The diameter, or the width of D point using point c width and height, which is
% known)
d_d = d_c-h*2*theta;
% d = d_d+2*l*tan(theta); % takes too long to calculate
d = d_d+2*l*theta; % small angle approximation, tan(theta) ~= theta. 
% We are ignoring displacement thickness since overall flow rate across a contour should be the same, so speed is only related to the size of the opening
v = d_c.^2.*v_c./d.^2;
v_d = d_c^2*v_c/d_d^2;

%% Pressure changes along dl
% We know that:
% 
% * major loss: $\frac{\Delta p_M}{L} = \frac{f}{2} \rho \frac{v^2}{D}$ 
% 
% * bernoulli pressure change without considering gravity: $p_2 - p_1 =
% \frac{1}{2} \rho ((v_1)^2-(v_2)^2)$
% 
% * gravity: $\rho g h$ 
%
% We take the derivative of each equation above with respect to l, and get
% the following new equations:

% major loss change, take negative derivative because dl is opposite to the actual flow of water
dP_M_dL = -diff(f/2*rho*l*v^2/d,l);
% bernoulli pressure change
dP_m_dL = diff(1/2*rho*(v_c^2-v^2),l);
% gravity pressure change, take negative derivative because dl is opposite to the actual flow of water
dP_h_dL = -rho*g;

%% Integration
% The idea is that all three pressure changes must add up to be 0 at any
% given point along CD. So if we take the integration from the origin (Point D) to the entire
% length of H, we should still get 0. 
dP_dl = dP_M_dL+dP_m_dL+dP_h_dL; % overall dP
f_integrate = int(dP_dl,l,0,h); % integrate and get symbolic representation

E = f_integrate == 0; % set up the equation to solve
S = solve(E,"Real",true); % solve for angle


%% Final result output

% angle
radian = double(S)
degree = double(S/pi*180)
% diameter of d
dd = d_c-h*2*radian
% velocity at d
v_dd = d_c^2*v_c/dd^2

%% Result validation
% Note that
lengthToWidthRatio = h/dd
%%
% Substitute the result into the following graph:
%
% <</Users/hubert/Documents/GitHub/verltical-flow-tunnel/pressure_loss_calculator-Matlab-master/diffuserValidation.png>>
% 
% $$2 \theta = degree \times 2$$
% 
% *As long as the point is in the "No stall" region, the design is valid!*

% Other eqns for checking pressures
1/2*rho*(v_c^2-v_dd^2);
gravity = rho*g*h;
