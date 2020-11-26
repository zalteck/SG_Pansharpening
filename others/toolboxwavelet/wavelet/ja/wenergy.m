% WENERGY   1次元ウェーブレット分解に対するエネルギー
%
% 1次元ウェーブレット分解 [C,L] に対して(WAVEDEC を参照)、
% [Ea,Ed] = WENERGY(C,L) は、approximation に対応するエネルギーの
% パーセンテージ Ea と、detail に対応するエネルギーのパーセンテージ Ed
% を出力します。
%
% 例題:
%     load noisbump
%     [C,L] = wavedec(noisbump,4,'sym4');
%     [Ea,Ed] = wenergy(C,L)


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
