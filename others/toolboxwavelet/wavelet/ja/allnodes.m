% ALLNODES   ツリーノード
%
% ALLNODES は、2種類のノード記述法(インデックスをベースにしたもの、深さと
% 位置をベースにしたもの)のいずれか1つの表現法を使って出力します。
% ツリーノードは、左から右、上から下へ順番付けされています。
% また、ルートのインデックスは0です。
%
% N = ALLNODES(T) は、ツリー構造 T を構成するすべてのノードのインデックスを
% 列ベクトル N に出力します。
%
% N = ALLNODES(T,'deppos') は、すべてのノードの深さと位置を行列 N に
% 出力します。N(i,1) は、ノード i の深さで、N(i,2) はノード i の位置を
% 示しています。


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
