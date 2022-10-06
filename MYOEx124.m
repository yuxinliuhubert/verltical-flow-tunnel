function MYOEx124
% MYOEx124  Find balance point for single pipe system in Example 12.4
%           of Munson, Young and Okiishi
%  pipe length (m)
%  true pipe diameter (m)
%  cross sectional area
%  roughness for cast iron
L = 200*0.3048;
D = (6/12)*0.3048;
A = 0.25*pi*D^2;
e = 0.26e-3;
KL = [0.5;  1.5;  1];  %  minor loss for entrance, elbow, and exit
Ah = [ A;    A;   A];  %  areas of pipe associated with minor loss
rho = 998.2;
mu = 1.002e-3;
nu = mu/rho;
dz = 10*0.3048;
%      coefficients are same as pipe area
%  density of water (kg/m^3) at 20 degrees C
%  dynamic viscosity (kg/m/s) at 20 degrees C
%  kinematic viscosity (m^2/s)
%  outlet is 10 ft above inlet
% --- Data for pump curve
Q = [ 0 400 800 1400 1800 2200 2300]*6.309e-5; % m^3/s 
h=[88 86 81 70 60 46 40]*0.3048; % m
n = 3;
pc = makePumpCurve(Q,h,n); % polynomial curve fit of degree n 
eta = 0.84; % pump efficiency
 % --- evaluate pump curve for balance point plot
 Qfit = linspace(min(Q),max(Q));
 hfit = polyval(pc,Qfit);
 % --- generate system curve
 Qs = linspace(min(Q),max(Q),10);
 hL = zeros(size(Qs));
 for k = 2:length(Qs)       %  loop starts at 2 to avoid Q=0 calculation
   hL(k) = pipeLoss(Qs(k),L,A,D,e,nu,KL,Ah);
 end
 % --- superimpose system curve and pump curve in new window
 %     to give graphical solution to balance point
 f = figure;
 plot(Q,h,'o',Qfit,hfit,'-',Qs,hL+dz,'v-');
 xlabel('Flow rate (m^3/s)');   ylabel('head  (m)');
 legend('pump data2','pump curve (fit)','system curve','Location','northwest');
 Q0 = [0.01  1.2];         %  initial guess brackets the flow rate (m^3/s)
 [Q,hL,hs] = pipeFlowSolve(Q0,L,A,D,e,KL,Ah,nu,dz,pc);  %  find balance point
 Wp = rho*9.81*Q*hs/eta;   %  pump power (W) with efficiency of eta
 hold on;
 plot([Q Q],[0 hL+dz],'--');   %  vertical line at balance pt.
 hold off;
 % --- convert to ancient system of units and print
 fprintf('\nFlow rate  = %6.1f  gpm\n',Q/6.309e-5);
 fprintf('Pump head  = %6.1f  ft\n',hs/0.3048);
 fprintf('Pump power = %6.1f  hp\n',Wp*1.341e-3);