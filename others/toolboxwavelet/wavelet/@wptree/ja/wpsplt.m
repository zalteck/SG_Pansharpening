% WPSPLT   ウェーブレットパケットの分解(分離)
%
% WPSPLT は、ノードの分解後にウェーブレットパケットツリーを更新します。
%
% T = WPSPLT(T,N) は、ノード N の分解に対応する修正されたツリー T を出力します。
%
% 1次元の分解に対して、CA をノード N の approximation、CD を detail として、
% [T,CA,CD] = WPSPLT(T,N) となります。
%
% 2次元の分解に対して、CA をノード N の approximation、CH、CV、CD を
% それぞれ水平、垂直、対角の detail として、[T,CA,CH,CV,CD] = WPSPLT(T,N) と
% なります。
%
%   参考 WAVEDEC, WAVEDEC2, WPDEC, WPDEC2, WPJOIN.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
