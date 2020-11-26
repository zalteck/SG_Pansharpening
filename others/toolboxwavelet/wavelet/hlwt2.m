function [a,h,v,d] = hlwt2(x,~)
%HLWT2 Haar (Integer) Wavelet decomposition 2-D using lifting.
%	HLWT2 performs the 2-D lifting Haar wavelet decomposition.
%
%   [CA,CH,CV,CD] = HLWT2(X) computes the approximation
%   coefficients matrix CA and detail coefficients matrices
%   CH, CV and CD obtained by the haar lifting wavelet 
%   decomposition, of the matrix X.
%
%   [CA,CH,CV,CD] = HLWT2(X,INTFLAG) returns integer coefficients.
%
%   See also IHLWT2, HLWT, IHLWT.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 28-Jan-2000.
%   Last Revision 12-Apr-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $ $Date: 2012/05/04 00:20:48 $ 

% Test for integer transform.
notInteger = nargin<2;

% Test for matrix input.
if ~ismatrix(x) , x = double(x); end

% Test for odd input.
s = size(x);
odd_Col = rem(s(2),2);
if odd_Col , x(:,end+1,:) = x(:,end,:); end
odd_Row = rem(s(1),2);
if odd_Row , x(end+1,:,:) = x(end,:,:); end

% Splitting.
L = x(:,2:2:end,:);
H = x(:,1:2:end,:);

% Lifting.
H = H-L;        % Dual lifting.
if notInteger
    L = (L+H/2);      % Primal lifting.
else
    L = (L+fix(H/2)); % Primal lifting.
end

% Splitting.
a = L(2:2:end,:);
h = L(1:2:end,:);
clear L

% Lifting.
h = h-a;        % Dual lifting.
if notInteger
    a = (a+h/2);      % Primal lifting.
else
    a = (a+fix(h/2)); % Primal lifting.
end

% Splitting.
v = H(2:2:end,:);
d = H(1:2:end,:);

% Lifting.
d = d-v;         % Dual lifting.
if notInteger
    v = (v+d/2); % Primal lifting.
    % Normalization.
    h = h/2;
    v = v/2;
    d = d/4;
else
    v = (v+fix(d/2)); % Primal lifting.
end

if odd_Col ,  v(:,end,:) = []; d(:,end,:) = []; end
if odd_Row ,  h(end,:,:) = []; d(end,:,:) = []; end
