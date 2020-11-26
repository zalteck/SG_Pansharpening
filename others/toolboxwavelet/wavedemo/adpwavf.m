function [out1,out2] = adpwavf(~,~,~,NumWAW)
% Using adapted wavelet

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 01-Jun-2010.
%   Last Revision: 17-Jan-2011.
%   Copyright 1995-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $ $Date: 2011/02/15 01:33:30 $

if ischar(NumWAW)
    [~,NumWAW] = wavemngr('fam_num',NumWAW);
    NumWAW = wstr2num(NumWAW);
end

switch NumWAW
    case 7  , load WAV_eeg_3_01_ORTH_CONT_1024.mat
    case 8  , load WAV_eeg_3_01_ORTH_NONE_1024.mat
    case 9  , load WAV_eeg_3_01_Pol6_CONT_1024.mat
    case 10 , load WAV_eeg_3_01_Pol6_DIFF_1024.mat
end
out2 = X;    % wavelet support.
out1 = Y;    % wavelet values.

