% IND2DEPO   ノードのインデックスをノードの深さと位置に変換
%
% 次数 ORD のツリーに対して、[D,P] = IND2DEPO(ORD,N) は、インデックス N を
% もつノードの深さ D 及び(深さ D における)位置 P を計算します。ノードは、
% 左から右へ、上から下へと番号が設定されています。ルートインデックスは 0 です。
%
% D、P、N、は、列ベクトルです。これらの値には、つぎの制約が課されています。
%    D = 深さ、0 < =  D < =  dmax
%    P = 深さ D における位置、0 < =  P < =  次数^D-1
%    N = インデックス、0 < =  N < ((次数^(dmax+1))-1)/(次数-1)
%
% 注意: 
% [D,P] = IND2DEPO(ORD,[D P]).
%
%   参考 DEPO2IND.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 25-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
