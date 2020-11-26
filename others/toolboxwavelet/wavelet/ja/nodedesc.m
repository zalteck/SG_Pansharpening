% NODEDESC   設定したノードの下層のノードインデックスまたは深さ、位置を出力
%
% D = NODEDESC(T,N) は、ツリー構造 T の中のノード N の下層すべてのインデックスを
% 出力します。N は、ノードの深さと位置またはインデックスノードのいずれかです。D 
% は、D(1) = ノード N のインデックスをもつ列ベクトルです。
%
% D = NODEDESC(T,N,'deppos') は、ノード N の上層すべての深さと位置を含む行列です。
% D(i,1) は、i 番目の下層にあるノードの深さ、D(i,2) は、i 番目の下層にあるノード
% の位置を示します。
%
% ノードは左から右、上から下へと順番が付けられています。ルートインデックは0です。
%
%   参考 NODEASC, NODEPAR, WTREEMGR.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
