function x = ihlwt(a,d,~)
%IHLWT Haar (Integer) Wavelet reconstruction 1-D using lifting.
%   IHLWT performs performs the 1-D lifting Haar wavelet reconstruction.
%
%   X = IHLWT(CA,CD) computes the reconstructed vector X
%   using the approximation coefficients vector CA and detail
%   coefficients vector CD obtained by the Haar lifting wavelet 
%   decomposition.
%
%   X = IHLWT(CA,CD,INTFLAG) computes the reconstructed 
%   vector X, using the integer scheme.
%
%   See also HLWT, HLWT2, IHLWT2.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 28-Jan-2000.
%   Last Revision 12-Apr-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $ $Date: 2012/05/04 00:20:49 $ 

% Test for integer transform.
notInteger = nargin<3;

% Test for odd input.
odd = length(d)<length(a);
if odd , d(end+1) = 0; end

% Reverse Lifting.
if notInteger
    d = 2*d;          % Normalization.
    a = (a-d/2);      % Reverse primal lifting.
else
    a = (a-fix(d/2)); % Reverse primal lifting.
end
d = a+d;   % Reverse dual lifting.

% Merging.
x = [d;a];
x = x(:)';

% Test for odd output.
if odd , x(end) = []; end
