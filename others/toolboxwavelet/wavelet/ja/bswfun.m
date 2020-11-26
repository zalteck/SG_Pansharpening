% BSWFUN   双直交スケーリングとウェーブレット関数
%
% [PHIS,PSIS,PHIA,PSIA,XVAL] = BSWFUN(LoD,HiD,LoR,HiR) は、(LoD,HiD), 
% (LoR,HiR) の2組のフィルタに関連する2組のスケーリング関数とウェーブレット
% (PHIA,PSIA) のグリッド XVAL での近似を出力します。
%
% BSWFUN(...,ITER) は、ITER の繰り返しを使用して、スケーリングと
% ウェーブレット関数の2つの組を計算します。
%
% BSWFUN(...,'plot') または BSWFUN(...,ITER,'plot') または
% BSWFUN(...,'plot',ITER) は、計算を行い、さらに関数をプロットします。
%
%   参考 WAVEFUN.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 24-Jun-2003.
%   Last Revision: 13-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
