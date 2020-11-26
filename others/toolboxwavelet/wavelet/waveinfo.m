function waveinfo(wav)
%WAVEINFO Information on wavelets.
%   WAVEINFO provides information for all the wavelets
%   within the toolbox.
%
%   WAVEINFO('wname') provides information for the wavelet
%   family whose short name is specified by the string 
%   'wname'.
%
%   Available family short names are:
%   'haar'   : Haar wavelet.
%   'db'     : Daubechies wavelets.
%   'sym'    : Symlets.
%   'coif'   : Coiflets.
%   'bior'   : Biorthogonal wavelets.
%   'rbio'   : Reverse biorthogonal wavelets.
%   'meyr'   : Meyer wavelet.
%   'dmey'   : Discrete Meyer wavelet.
%   'gaus'   : Gaussian wavelets.
%   'mexh'   : Mexican hat wavelet.
%   'morl'   : Morlet wavelet.
%   'cgau'   : Complex Gaussian wavelets.
%   'cmor'   : Complex Morlet wavelets.
%   'shan'   : Complex Shannon wavelets.
%   'fbsp'   : Complex Frequency B-spline wavelets.
%
%   or user-defined short names for their own wavelet
%   families (see WAVEMNGR).
%
%   WAVEINFO('wsys') provides information on wavelet packets.
%
%   See also WAVEMNGR.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision 08-May-2012.
%   Copyright 1995-2012 The MathWorks, Inc.
% $Revision: 1.13.4.2 $

if nargin==0
    infoName = 'infowave';
elseif strcmp(wav,'wsys')
    infoName = 'infowsys';
else
    ind = wavemngr('indf',wav);
    if isempty(ind)
        msg = getWavMSG('Wavelet:moreMSGRF:Invalid_WaveSName',wav);
        errargt(mfilename,msg,'msg');
    else
        infoName = [wav 'info'];
    end
end
S = help(infoName);
S(1:length(infoName)+1) = '';
disp(S)

