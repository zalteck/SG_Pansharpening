function [a,d] = hlwt(x,~)
%HLWT Haar (Integer) Wavelet decomposition 1-D using lifting.
%	HLWT performs the 1-D lifting Haar wavelet decomposition.
%
%   [CA,CD] = HLWT(X) computes the approximation coefficients
%	vector CA and detail coefficients vector CD, obtained
%	by the haar lifting wavelet decomposition, of the vector X.
%
%   [CA,CD] = HLWT(X,INTFLAG) returns integer coefficients.
%
%   See also IHLWT, HLWT2, IHLWT2.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 28-Jan-2000.
%   Last Revision 12-Apr-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $ $Date: 2012/05/04 00:20:47 $ 

% Test for integer transform.
notInteger = nargin<2;

% Test for odd input.
odd = rem(length(x),2);
if odd , x(end+1) = x(end); end

% Splitting.
a = x(2:2:end);
d = x(1:2:end);

% Lifting.
d = d-a;              % Dual lifting.
if notInteger
    a = (a+d/2);      % Primal lifting.
    d = d/2;          % Normalization.
else
    a = (a+fix(d/2)); % Primal lifting.
end

% Test for odd output.
if odd , d(end) = []; end
