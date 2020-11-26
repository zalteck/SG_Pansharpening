function x = ihlwt2(a,h,v,d,~)
%IHLWT2 Haar (Integer) Wavelet reconstruction 2-D using lifting.
%   IHLWT2 performs performs the 2-D lifting Haar wavelet reconstruction.
%
%   X = IHLWT2(CA,CH,CV,CD) computes the reconstructed matrix X
%   using the approximation coefficients vector CA and detail 
%   coefficients vectors CH, CV, CD obtained by the Haar lifting  
%   wavelet decomposition.
%
%   X = IHLWT2(CA,CH,CV,CD,INTFLAG) computes the reconstructed 
%   matrix X, using the integer scheme.
%
%   See also HLWT2, HLWT, IHLWT.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 28-Jan-2000.
%   Last Revision 12-Apr-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
%   $Revision: 1.1.6.4 $ $Date: 2012/05/04 00:20:50 $ 

% Test for integer transform.
notInteger = nargin<5;

% Test for odd input.
odd_Col = size(d,2)<size(a,2);
if odd_Col , d(:,end+1,:) = 0; v(:,end+1,:) = 0; end
odd_Row = size(d,1)<size(a,1);
if odd_Row , d(end+1,:,:) = 0; h(end+1,:,:) = 0; end

% Reverse Lifting.
if notInteger
    % Normalization.
    d = 4*d;
    v = 2*v;
    h = 2*h;
    v = (v-d/2);      % Reverse primal lifting.
else
    v = (v-fix(d/2)); % Reverse primal lifting.
end
d = v+d;   % Reverse dual lifting.

% Merging.
nbR = size(d,1)+size(v,1);
nbC = size(d,2);
H = zeros(nbR,nbC);
H(2:2:end,:) = v;
H(1:2:end,:) = d;

% Reverse Lifting.
if notInteger
    a = (a-h/2);      % Reverse primal lifting.
else
    a = (a-fix(h/2)); % Reverse primal lifting.
end
h = a+h;   % Reverse dual lifting.

% Merging.
L = zeros(nbR,nbC);
L(2:2:end,:) = a;
L(1:2:end,:) = h;

% Reverse Lifting.
if notInteger
    L = (L-H/2);      % Reverse primal lifting.
else
    L = (L-fix(H/2)); % Reverse primal lifting.
end
H = L+H;   % Reverse dual lifting.

% Merging.
nbC = size(L,2)+size(H,2);
nbR = size(L,1);
x = zeros(nbR,nbC);
x(:,2:2:end,:) = L;
x(:,1:2:end,:) = H;

% Test for odd output.
if odd_Col , x(:,end,:) = []; end
if odd_Row , x(end,:,:) = []; end
