function [out1,out2,out3] = pipeLoss(Q,L,A,Dh,e,nu,KL,Am)
% pipeLoss  Viscous and minor head loss for a single pipe
%
% Synopsis:  hL = pipeLoss(Q,L,A,Dh,e,nu)
%            hL = pipeLoss(Q,L,A,Dh,e,nu,KL)
%            hL = pipeLoss(Q,L,A,Dh,e,nu,KL,Am)
%            [hL,f] = pipeLoss(...)
%            [hv,f,hm] = pipeLoss(...)
%
% Input:  Q  = flow rate through the system (m^3/s)
%         L  = vector of pipe lengths
%         A  = vector of cross-sectional areas of ducts.  A(1) is area of
%              pipe with length L(1) and hydraulic diameter Dh(1)
%         Dh = vector of pipe diameters
%         e  = vector of pipe roughnesses
%         nu = kinematic viscosity of the fluid
%         KL = minor loss coefficients. Default: KL = [], no minor losses
%         Am = areas associated with minor loss coefficients.
%              For a flow rate, Q, through minor loss element 1, the area,
%              Am(1) gives the appropriate velocity from V = Q/Am(1).  For
%              example, the characteristic velocity of a sudden expansion
%              is the upstream velocity, so Am for that element is the
%              area of the upstream duct.
%
% Output:  hL = (scalar) total head loss
%          hv = (optional,vector) head losses in straight sections of pipe
%          hm = (optional, vector) minor losses
%          f  = (optional, vector) friction factors for straight sections
if nargin<7, KL = []; Am = [];          end
if nargin<8, Am = A(1)*ones(size(KL));  end
if size(Am) ~= size(KL)
  error('size(Am) = [%d,%d] not equal size(KL) = [%d,%d]',size(Am),size(KL));
end
% --- Viscous losses in straight sections
g = 9.81;
if isempty(L)
  hv = 0;  f = [];
else
  V = Q./A;
  f = zeros(size(L));
  for k=1:length(f)
%  acceleration of gravity, SI units
%  no straight pipe sections
%  velocity in each straight section of pipe
%  initialize friction factor vector
  f(k) = moody(e(k)/Dh(k),V(k)*Dh(k)/nu);  %  friction factors
end
  hv = f.*(L./Dh).*(V.^2)/(2*g);     %  viscous losses in straight sections
end
% --- minor losses
if isempty(KL)
hm = 0;                              %  no minor lossess
else
  hm = KL.*((Q./Am).^2)/(2*g);       %  minor lossess
end
% --- optional return variables
if nargout==1
    out1 = sum(hv) + sum(hm); % return hL = total head loss
elseif nargout==2
    out1=hv; out2=f;            % return viscous losses and friction factors
elseif nargout==3
    out1=hv; out2=f;            % return viscous losses, friction factors
    out3 = hm;                % and minor losses
else

  error('Only 1, 2 or 3 return arguments are allowed');
end