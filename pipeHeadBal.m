function h = pipeHeadBal(Q,L,A,Dh,e,KL,Am,nu,dz,pc)

% The pipeHeadBal function evaluates the energy equation and returns the head 
% imbalance. When the correct flow rate and pipe diameter are supplied, the head imbalance is zero.


% pipeHeadBal  Head imbalance in energy equation for a single pipe with a pump
%              This equations is of the form f(Q) = 0 for use with a
%              standard root-finding routine for flow rate problems or
%              system balance point problems

% Input:    Q = flow rate through the system (m"3/s)
%             L = vector of pipe lengths
%             A = vector of cross-sectional areas of ducts. A(1) is area of
%                 pipe with length L(1) and hydraulic diameter Dh (1)
%             Dh = vector of pipe diameters
%             e = vector of pipe roughnesses
%             KL = vector of minor loss coefficients
%             Am = vector of areas associated with minor loss coefficients.
%                  For a flow rate, Q, through minor loss element 1, the area,
%                 Am (1) gives the appropriate velocity from V = Q/Am (1).
%                 Thus, different minor loss elements will have different velocities for the same flow rate.
%                 For a sudden expansion the characteristic velocity is the upstream velocity, so Am for that element is the area of the upstream duct.
%             nu = kinematic viscosity of the fluid
%             dz = change in elevation, z_out - 2_in; dz>0 if outlet is above
%                 the inlet; dz = 0 for closed loop
%             pc = vector of polynomial coefficients defining the pump curve.
%                 Note that the polynomial is defined in decreasing power of Q: hs (Q) = pc (1)Q°n + pc (2)*Q- (n-1) + ...
%                  + pc(n) *Q + pc (n+1)
% Output:  h = imbalance in head in energy equation;  h = 0 when
 %              energy equation is satisfied

 if isempty(pc)
hs=0; % nopumpcurvedata->nopump
 else
   hs = polyval(pc,Q);   %  evaluate polynomial model of pump curve at Q
 end
 h = hs - dz - pipeLoss(Q,L,A,Dh,e,nu,KL,Am);