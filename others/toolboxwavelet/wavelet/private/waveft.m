function wft = waveft(WAV,omega,scales,varargin)
%WAVEFT Wavelet Fourier transform.
%   WAVEFT computes the wavelet values in the frequency plane.
%   For a wavelet defined by WAV, WFT = WAVEFT(WAV,OMEGA,SCALES)
%   returns the wavelet Fourier transform WFT.
%
%   WAV can be a string, structure or a cell array.
%   If WAV is a string, it contains the name of the wavelet
%   used for the analysis.
%   If WAV is a structure, WAV.name and WAV.param are respectively
%   the name of the wavelet and, if necessary, an associated parameter.
%   If WAV is a cell array, WAV{1} and WAV{2} contain the name of
%   the wavelet and an optional parameter.
%   OMEGA is a vector which contains the frequencies at which the
%   transform was computed.
%   SCALES is a vector which contains the scales used for the
%   wavelet analysis.
%   WFT is a matrix of size (NbScales x Nbfreq).
%
%   Admissible wavelets are:
%    - MORLET wavelet (A) - 'morl':
%        PSI_HAT(s) = pi^(-1/4) * exp(-(s>0)*(s-s0).^2/2) * (s>0);
%        Parameter: s0, default s0 = 6.
%
%    - MORLET wavelet (B) - 'morlex': (without Heaviside function)
%        PSI_HAT(s) = pi^(-1/4) * exp(-(s-s0).^2/2);
%        Parameter: s0, default s0 = 6.
%
%    - MORLET wavelet (C) - 'morl0':  (with exact zero mean value)
%        PSI_HAT(s) = pi^(-1/4) * [exp(-(s-s0).^2/2) - exp(-s0.^2/2)];
%        Parameter: s0, default s0 = 6.
%
%    - MEXICAN wavelet - 'mexh':
%        PSI_HAT(s) = (1/gamma(2+0.5))*s^2 .* exp((-s.^2)/2)
%        (DOG wavelet with m = 2)
%
%    - DOG wavelet - 'dog': m order Derivative Of Gaussian 
%        PSI_HAT(s) = (-1/sqrt(gamma(m+0.5)))*((i*s)^m).*exp((-s.^2)/2)
%        Parameter: m (order of derivation), default m = 2.
%                   m must be even.
%
%    - PAUL wavelet - 'paul':
%        PSI_HAT(s) = K*s^m.*exp(-s)
%        The constant K is such that:
%               K = (2^m)/sqrt(m*fact(2*m-1))
%        Parameter: m, default m = 4.
%
%   PSI_HAT denotes the Fourier transform of PSI.
%
%   See also CWTFT, ICWTFT.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 04-Mar-2010.
%   Last Revision: 06-Feb-2011.
%   Copyright 1995-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $ $Date: 2011/04/12 20:46:20 $

param = [];
if isstruct(WAV)
    wname = WAV.name;
    param = WAV.param;
elseif iscell(WAV)
    wname = WAV{1};
    if length(WAV)>1 , param = WAV{2}; end
else
    wname = WAV;
end
StpFrq = omega(2);
NbFrq  = length(omega);
SqrtNbFrq = sqrt(NbFrq);
cfsNORM = sqrt(StpFrq)*SqrtNbFrq;
NbSc = length(scales);
wft = zeros(NbSc,NbFrq);
switch wname
    case 'morl'    % MORLET (A)
        if isempty(param) , gC = 6; else gC = param; end
        mul = (pi^(-0.25))*cfsNORM;
        for jj = 1:NbSc
            expnt = -(scales(jj).*omega - gC).^2/2.*(omega > 0);
            wft(jj,:) = mul*sqrt(scales(jj))*exp(expnt).*(omega > 0);
        end        
        
    case 'morlex'  % MORLET (B)
        if isempty(param) , gC = 6; else gC = param; end
        mul = (pi^(-0.25))*cfsNORM;
        for jj = 1:NbSc
            expnt = -(scales(jj).*omega - gC).^2/2;
            wft(jj,:) = mul*sqrt(scales(jj))*exp(expnt);
        end
        
    case 'morl0'   % MORLET (C)
        if isempty(param) , gC = pi*sqrt(2/log(2)); else gC = param; end
        mul = (pi^(-0.25))*cfsNORM;
        for jj = 1:NbSc
            expnt  = -(scales(jj).*omega - gC).^2/2;
            correct = -(gC^2 +(scales(jj).*omega).^2)/2;
            wft(jj,:) = mul*sqrt(scales(jj))*(exp(expnt)-exp(correct));
        end
                
    case 'mexh'
        mul = sqrt(scales/gamma(2+0.5))*cfsNORM;
        for jj = 1:NbSc
            scapowered = (scales(jj).*omega);
            expnt = -(scapowered.^2)/2;
            wft(jj,:) = mul(jj)*(scapowered.^2).*exp(expnt);
        end
        
    case 'dog'
        if isempty(param) , m = 2; else m = param; end
        mul = -((1i^m)/sqrt(gamma(m+0.5)))*sqrt(scales)*cfsNORM;
        for jj = 1:NbSc
            scapowered = (scales(jj).*omega);
            expnt = -(scapowered.^2)/2;
            wft(jj,:) = mul(jj).*(scapowered.^m).*exp(expnt);
        end

    case 'paul'
        if isempty(param) , m = 4; else m = param; end
        mul = sqrt(scales)*(2^m/sqrt(m*prod(2:(2*m-1))))*cfsNORM;
        for jj = 1:NbSc
            expnt = -(scales(jj).*omega).*(omega > 0);
            daughter = mul(jj)*((scales(jj).*omega).^m).*exp(expnt);
            wft(jj,:) = daughter.*(omega > 0);
        end
        
    otherwise
        error(message('Wavelet:FunctionInput:InvWavNam'));
end

end     % {function}
