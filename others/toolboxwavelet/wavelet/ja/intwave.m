% INTWAVE   ウェーブレット関数 psi の積分
%
% [INTEG,XVAL] = INTWAVE('wname',PREC) は、-inf から XVAL 値の範囲で、
% ウェーブレット関数 psi を積分した値 INTEG を出力します。関数psi は、
% 2^PREC 個のグリッド点 XVAL 上で近似されます。ここで、PREC は、正の整数です。
% また、'wname' は、ウェーブレット名を含む文字引数です(WFILTER を参照)。
%
% 双直交ウェーブレットについては、[INTDEC,XVAL,INTREC] = INTWAVE('wname',PREC) は、
% ウェーブレット分解関数 psi_dec を積分した値 INTDEC と、ウェーブレット再構成関数 
% psi_rec を積分した値 INTREC を出力します。
%
% INTWAVE('wname',PREC) は、INTWAVE('wname',PREC,0) と等価です。
% INTWAVE('wname') は、INTWAVE('wname',8) と等価です。
%
% 3つの引数を使って、INTWAVE('wname',IN2,IN3) とすると、PREC = MAX(IN2,IN3) と
% プロットが得られます。IN2 が、特殊な値0と等しい場合、INTWAVE('wname',0) は、
% INTWAVE('wname',8,IN3) と等価になります。INTWAVE('wname') も、
% INTWAVE('wname',8) と等価です。
%
%   参考 WAVEFUN.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 17-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
