function demoSystemCurve
% demoSystemCurveGenerate the system curve for a single pipe system
% --- data for straight pipe sections
dsteel = 0.127;       %  diameter of commercial steel pipe used (m)
diron  = 0.102;       %  diameter of cast iron pipe used (m)
epsSteel = 0.045e-3;  %  roughness of steel pipe (m)
epsIron = 0.26e-3;    %  roughness of cast iron pipe (m)
L = [50; 10; 20; 25; 20];                     %  pipe lengths (m)
D = [dsteel; dsteel; dsteel; diron; dsteel];  %  pipe diameters (m)
A = 0.25*pi*D.^2;                             %  X-sectional areas (m^2)
e = [epsSteel; epsSteel; epsSteel; epsIron; epsSteel];  % roughness
% --- data for minor losses
kelbow = 0.3;
kvalve = 10;
Asteel = 0.25*pi*dsteel^2;
Airon = 0.25*pi*diron^2;
kcontract = contractionLoss(Asteel,Airon);
kexpand = (1 - Airon/Asteel)^2;
KL = [kelbow; kelbow; kvalve; kcontract; kexpand; kvalve];
Am = [Asteel; Asteel; Asteel; Airon;     Airon;   Asteel];
% --- overall elevation change
dz = L(2);           %  outlet is above inlet by this amount
% --- fluid properties
rho = 999.7;
mu = 1.307e-3;
nu = mu/rho;
%  density of water (kg/m^3) at 10 degrees C
%  dynamic viscosity (kg/m/s) at 10 degrees C
%  kinematic viscosity (m^2/s)
 % --- Create system curve for a range of flow rates
 Q = linspace(0,0.075,10);
 hL = zeros(size(Q));
 for k = 2:length(Q)       %  loop starts at 2 to avoid Q=0 calculation
   hL(k) = pipeLoss(Q(k),L,A,D,e,KL,Am,nu);
 end
 hsys1 = hL + dz;
 % --- Repeat analysis with gate valves instead of globe valves
 KL(3) = 0.15;   KL(6) = 0.15;   %  replace loss coefficients for valves
 for k = 2:length(Q)             %  loop starts at 2 to avoid Q=0 calculation
   hL(k) = pipeLoss(Q(k),L,A,D,e,KL,Am,nu);
 end
 hsys2 = hL + dz;
 % --- Plot both system curves and annotate
 plot(Q,hsys1,'o-',Q,hsys2,'s-');
 xlabel('Flow rate  (m^3/s)');   ylabel('Head  (m)');
 legend('globe valves','gate valves','Location','northwest');