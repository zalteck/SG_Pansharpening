% LAURPOLY   クラス LAURPOLY に対するコストラクタ (Laurent多項式)
%
% P = LAURPOLY(C,d) は、Laurent多項式オブジェクトを出力します。
% C は、要素が多項式 P の係数ベクトルであり、d は P の単項式の最高次数です。
%
% m がベクトル C の長さの場合、P はつぎのLaurent多項式を表します:
%     P(z) = C(1)*z^d + C(2)*z^(d-1) + ... + C(m)*z^(d-m+1)
%
% P = LAURPOLY(C,'dmin',d) は、P の単項式の最高次ではなく、最低次を指定します。
% 対応する出力 P は、つぎのLaurent多項式を表します:
%     P(z) = C(1)*z^(d+m-1) + ... + C(m-1)*z^(d+1) + C(m)*z^d
%
% P = LAURPOLY(C,'dmax',d) は、P = LAURPOLY(C,d) と同じです。


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 19-Mar-2001.
%   Last Revision: 09-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
