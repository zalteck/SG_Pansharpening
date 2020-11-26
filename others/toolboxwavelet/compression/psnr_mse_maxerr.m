function [psnr,mse,maxerr,L2rat] = psnr_mse_maxerr(X,Xapp)
%PSNR_MSE_MAXERR Peak signal to noise ratio and ...
%   [PSNR,MSE,MAXERR,L2_RAT] = PSNR_MSE_MAXERR(X,XAPP)

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 31-May-2004.
%   Last Revision 20-Mar-2008.
%   Copyright 1995-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $  $Date: 2008/05/12 21:39:12 $ 

X    = double(X);
Xapp = double(Xapp);
absD = abs(X-Xapp);
A    = absD.^2;
mse  = sum(A(:))/numel(X);
psnr = 10*log10(255*255/mse);
maxerr = round(max(absD(:)));
A = X.*X;
B = Xapp.*Xapp;
L2rat = sqrt(sum(B(:))/sum(A(:)));
