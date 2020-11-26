% NODEASC   設定したノードの上層のノードインデックスまたは深さ、位置を出力
%
% A = NODEASC(T,N) は、ツリー構造 T の中のノード N の上層すべてのインデックスを
% 出力します。N は、ノードの深さと位置、または、インデックスノードを設定します。
% A は、A(1) = ノード N のインデックスをもつ列ベクトルです。
%
% A = NODEASC(T,N,'deppos') は、ノード N の上層すべての深さと位置を含む行列です。
% A(i,1) は、i 番目の上層にあるノードの深さ、A(i,2) は、i 番目の上層にある
% ノードの位置を示します。
%
% ノードは、左から右、上から下へと順番が付けられています。ルートインデックスは
% 0です。
%
%   参考 NODEDESC, NODEPAR, WTREEMGR.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
