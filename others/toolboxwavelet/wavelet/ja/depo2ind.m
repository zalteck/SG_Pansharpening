% DEPO2IND   ノードの深さ－位置をノードインデックスに変換
%
% 次数0のツリーに対して、N = DEPO2IND(O,[D P]) は、[D,P] で符号化された
% 深さと位置をもつノードのインデックス N を計算します。ノードは、左から右、
% 上から下へと順番を付けます。また、ルートのインデックスは0です。
%
% D,P,N は、列ベクトルです。
%    D = 深さ、0 < =  D < =  dmax
%    P = 深さ D での位置、0 < =  P < =  次数^D-1
%    N = インデックス、0 < =  N < ((次数^(dmax+1))-1)/(次数-1)
%
% 注意:
% 列ベクトル X に対して、DEPO2IND(O,X) = X となります。
%
%   参考 IND2DEPO.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 17-Dec-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
