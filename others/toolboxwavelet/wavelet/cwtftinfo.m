function cwtftinfo
%CWTFTINFO Information on wavelets for CWTFT
% CWTFTINFO provides information on the available wavelets for 
% Continuous Wavelet Transform using FFT.
%
%   PSI_HAT denotes in the sequel, the Fourier transform of 
%   the concerned wavelet.
%
%   Morlet: 
%     'morl':
%        PSI_HAT(s) = pi^(-1/4) * exp(-(s>0)*(s-s0).^2/2) * (s>0);
%        Parameter: s0, default s0 = 6.
%
%     'morlex': (without Heaviside function)
%        PSI_HAT(s) = pi^(-1/4) * exp(-(s-s0).^2/2);
%        Parameter: s0, default s0 = 6.
%
%     'morl0':  (with exact zero mean value)
%        PSI_HAT(s) = pi^(-1/4) * [exp(-(s-s0).^2/2) - exp(s0.^2/2)];
%        Parameter: s0, default s0 = 6.
%
%   DOG:  
%     'dog': m order Derivative Of Gaussian 
%        PSI_HAT(s) = (-1/sqrt(gamma(m+0.5)))*((i*s)^m).*exp((-s.^2)/2)
%        Parameter: m (order of derivation), default m = 2.
%                   m must be even.
%     'mexh':
%        PSI_HAT(s) = (1/gamma(2+0.5))*s^2 .* exp((-s.^2)/2)
%        (DOG wavelet with m = 2)
%
%   Paul:
%     'paul':
%        PSI_HAT(s) = K*s^m.*exp(-s)
%        Where K = (2^m)/sqrt(m*fact(2*m-1))
%        Parameter: m, default m = 4.
%
%   See also CWTFT, ICWTFT.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 04-Mar-2010.
%   Last Revision: 27-Sep-2010.
%   Copyright 1995-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $ $Date: 2010/10/11 14:55:00 $

help cwtftinfo
