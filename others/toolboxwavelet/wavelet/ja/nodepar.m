% NODEPAR   ノードの親ノードを出力
%
% F = NODEPAR(T,N) は、ツリー構造 T の中でノード N の"親"となるインデックスを
% 出力します。N はノードのインデックスを含んだ列ベクトル、または、ノードの
% 深さと位置を含んだ行列のいずれかです。後者の場合、N(i,1) は、i 番目の深さで、
% N(i,2) は、i 番目の位置です。
%
% F = NODEPAR(T,N,'deppos') は、出力されるノードの深さと位置を含んだ行列です。
% F(i,1) は、i 番目の深さ、F(i,2) は、i 番目の位置です。
%
% ノードは、左から右、上から下へと番号付けされています。
% ルートインデックスは 0 です。
%
% 注意 : 
% NODEPAR(T,0)、または、NODEPAR(T,[0 0]) は、-1 を出力し、NODEPAR(T,0,'deppos')、
% または、NODEPAR(T,[0 0],'deppos') は、[-1 0] を出力します。
%
%   参考 NODEASC, NODEDESC, WTREEMGR.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
