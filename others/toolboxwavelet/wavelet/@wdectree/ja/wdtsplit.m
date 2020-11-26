% WDTSPLIT   (分解)ウェーブレットパケットの分離
%
% WDTSPLIT は、ノードの分解後にウェーブレットパケットツリーを更新します。
%
% T = WDTSPLIT(T,N) は、ノード N の分解に対応する修正したツリー T を
% 出力します。
%
% 1次元の分解に対して: [T,CA,CD] = WDTSPLIT(T,N) 
% ここで、ノード N の CA = approximation で CD = detail です。
%
% 2次元の分解に対して: [T,CA,CH,CV,CD] = WDTSPLIT(T,N)
% ここで、ノード N の CA = approximation で CH, CV, CD = (水平, 垂直, 
% 対角) の detail です。
%
%   参考 WAVEDEC, WAVEDEC2, WPDEC, WPDEC2, WPJOIN.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 13-Mar-2003.
%   Last Revision: 13-Mar-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
