 function c = makePumpCurve(Q,h,n);
 % makePumpCurve  Find polynomial model for pump curve
 %
 % Synopsis:  c = makePumpCurve(Q,h,n)
 %
 % Input:  Q = pump flow rate;  (Both Q and h must be given)
% h = pump head
 %         n = (optional) degree of polynomial curve fit;  Default: n=3
 if nargin<3;   n = 3;   end
 c = polyfit(Q,h,n);
 fprintf('\nCoefficients of the polynomial fit to the pump curve:\n');
 fprintf('       (in DECREASING powers of Q)\n');
 for k=1:length(c)
    fprintf(' Q^%d   %18.10e\n',n+1-k,c(k));
 end
 % --- evaluate the fit and plot along with orignal data
 Qfit = linspace(min(Q),max(Q));
 hfit = polyval(c,Qfit);
 plot(Q,h,'o',Qfit,hfit,'-');
 xlabel('Flow rate');   ylabel('pump head');