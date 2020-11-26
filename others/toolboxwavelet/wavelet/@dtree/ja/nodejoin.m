% NODEJOIN   ノードの組み替え
%
% T = NODEJOIN(T,N) は、ノ－ド N の再構成に対応するツリ－構造 T を出力します。 
%
% ノ－ドは、左から右、上から下へ番号付けされています。
% ル－トインデックスは0です。
%
% T = NODEJOIN(T) は、T = NODEJOIN(T,0) と等価です。
%
% このメソッドは、NTREE に多重定義されており、多重定義された MERGE を
% コールします。
%
%   参考 MERGE, NODESPLT.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 15-Oct-96.
%   Last Revision: 23-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
