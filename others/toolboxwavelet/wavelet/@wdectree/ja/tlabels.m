% TLABELS   ウェーブレットパケットツリーのノード用のラベル付け
%
% LABELS = TLABELS(T,TYPE,N) は、ツリー T のノード N に対するラベルを
% 出力します。
% TYPE で設定できる内容は以下のとおりです:
%       'i'  または 1 --> インデックス
%       'p'  または 2 --> 深さ-位置
%       'e'  または 3 --> エントロピー
%       'eo' または 4 --> 最適なエントロピー
%       's'  または 5 --> サイズ
%       'n'  または 6 --> なし
%       't'  または 7 --> タイプ
%   
% LABELS = TLABELS(T,TYPE) は、T のすべてのノードに対するラベルを出力します。


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi  12-Feb-2003.
%   Last Revision: 11-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
