% BESTTREE   最適ウェーブレットパケットツリー
%
% BESTTREE は、エントロピータイプの基準を考慮した初期ツリーの最適となる
% サブツリーを計算します。結果のツリーは、初期のものよりも小さくなります。
%
% T = BESTTREE(T) は、最適なエントロピー値に対応する、修正されたツリー T を
% 計算します。
%
% [T,E] = BESTTREE(T) は、最適なツリー T に加え、最適なエントロピー値 E を
% 出力します。インデックス j-1 のノードの最適なエントロピーは、E(j) です。
%
% [T,E,N] = BESTTREE(T) は、最適なツリー T とエントロピー値 E に加え、
% 並び替えられたノードのインデックスを含むベクトル N を出力します。
% 
%   参考 BESTLEVT, WENTROPY, WPDEC, WPDEC2.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
