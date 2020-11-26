% BESTLEVT   ウェーブレットパケットツリーの最適レベル
%
% BESTLEVT は、エントロピータイプの基準を考慮した初期ツリーの最適な
% すべてのサブツリーを計算します。結果のすべてのツリーは、初期のものよりも
% 浅くなります。
%
% T = BESTLEVT(T) は、最適なレベルのツリー分解に対応する、修正された
% ツリー T を計算します。
%
% [T,E] = BESTLEVT(T) は、最適なツリー T に加え、最適なエントロピー値 E を
% 出力します。
% インデックス j-1 のノードの最適なエントロピーは、E(j) です。
%
%   参考 BESTTREE, WENTROPY, WPDEC, WPDEC2.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 23-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
