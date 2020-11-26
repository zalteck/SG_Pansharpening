% PAT2CWAV   パターンから構成されるウェーブレットの作成
%
% [PSI,XVAL,NC] = PAT2CWAV(YPAT,METHOD,POLDEGREE,REGULARITY) は、
% ベクトル YPAT によって定義され、ノルムが 1 に等しいパターンに適合された
% (XVAL と PSI で与えられた) CWT に対するアドミッシブルなウェーブレットを
% 計算します。構成される x-値のパターンは以下に設定されます:
%             xpat = linespace(0,1,length(YPAT))
%   
% NC*PSI となるような定数 NC は、つぎの条件を使って最小二乗法で近似する
% ことにより、区間 [0,1] の YPAT を近似します:
% 	  - METHOD が 'polynomial' に等しい場合は、単位 POLDEGREE の多項式を使います。
% 	  - METHOD が 'orthconst' に等しい場合は、双直交の関数の空間を定数に投影します。
% 	
% REGULARITY パラメータは、0 と 1 の点で境界の制約を定義します。
% 可能な値は、'continuous', 'differentiable', 'none' です。
% 	
% METHOD が 'polynomial' に等しい場合:
%     - REGULARITY が 'continuous' の場合、POLDEGREE は 3 より大きくなければなりません。
%     - REGULARITY が 'differentiable' の場合、POLDEGREE は 5 より大きくなければなりません。


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 21-Mar-2003.
%   Last Revision: 11-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
