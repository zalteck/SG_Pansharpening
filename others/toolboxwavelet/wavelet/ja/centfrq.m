% CENTFRQ   ウェーブレットの中心周波数
%
% FREQ = CENTFRQ('wname') は、ウェーブレット関数 'wname' のヘルツ単位の
% 中心周波数を出力します (WAVEFUN を参照)。
%
% FREQ = CENTFRQ('wname',ITER) に対して、ITER は、ウェーブレットを
% 計算するために WAVEFUN 関数で使われる繰り返し数です。
%
% [FREQ,XVAL,RECFREQ] = CENTFRQ('wname',ITER, 'plot') は、グリッド XVAL の
% 2^ITER 点でのapproximationである RECFREQ を基に、関連する中心周波数を
% 更に出力します。
%
%   参考 SCAL2FRQ, WAVEFUN, WFILTERS. 


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 04-Mar-98.
%   Last Revision: 25-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
