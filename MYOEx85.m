/ufunction MYOEx85
% MYOEx85  Head loss problem of Example 8.5 in Munson, Young and Okiishi
% --- Define constants for the system and its components
L = 4;          %  Pipe length (m)
D = 0.4;         %  Pipe diameter (m)
A = 0.25*pi*D.^2; %  Cross sectional area
e = 0.0015e-3;
rho = 1000;
g = 9.81;
mu = 1e-6;
nu = mu/rho;
V = 4;
%  Roughness for drawn tubing
%  Density of air (kg/m^3) at 20 degrees C
%  Acceleration of gravity (m^2/s)
%  Dynamic viscosity (kg/m/s) at 20 degrees C
%  Kinematic viscosity (m^2/s)
%  Air velocity (m/s)
 % --- Laminar solution
 Re = V*D/nu;
 flam = 64/Re;
 dplam = flam * 0.5*(L/D)*rho*V^2;
 % --- Turbulent solution
 f = moody(e/D,Re);
 dp = f*(L/D)*0.5*rho*V^2;
 % --- Print summary of losses
 fprintf('\nMYO Example 8.5:  Re = %12.3e\n\n',Re);
 fprintf('\tLaminar flow:   ');
 fprintf('flam = %8.5f;   Dp = %7.0f (Pa)\n',flam,dplam)
 fprintf('\tTurbulent flow: ');
 fprintf('f    = %8.5f;   Dp = %7.0f (Pa)\n',f,dp);