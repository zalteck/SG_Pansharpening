% SWT   1 次元離散定常ウェーブレット変換
%
%   SWT は、特定の双直交ウェーブレット('wname'、詳しい情報については 
%   WFILTERS を参照) か、特定の分解フィルタ (Lo_R と Hi_R) のいずれかを
%   使って多重レベルの 1 次元定常ウェーブレット分解を実行します。
%
%   SWC = SWT(X,N,'wname') は、'wname' を使ってレベル N で信号 X の
%   定常ウェーブレット分解を計算します。N は厳密に正の整数でなければ
%   なりません (詳細は WMAXLEV を参照)。
%
%   SWC = SWT(X,N,Lo_D,Hi_D) は、入力として上述のこれらのフィルタを与えて
%   定常ウェーブレット分解を計算します:
%     Lo_D は、分解のローパスフィルタで、
%     Hi_D は、分解のハイパスフィルタです。
%     Lo_D と Hi_D は、同じ長さでなければなりません。
%
%   出力行列 SWC は、行方向に格納された係数のベクトルを含みます: 
%     1 <= i <= N に対して、SWC(i,:) は、レベル i のdetail係数を含み、
%     SWC(N+1,:) は、レベル N の approximation 係数を含みます。
%
%   [SWA,SWD] = SWT(...) は、approximation SWA と detail SWD で、
%   定常ウェーブレット係数を計算します。
%   係数ベクトルは行方向に格納されます: 
%   1 <= i <= N に対して、
%   SWA(i,:) は、レベル i の approximation 係数を含みます。
%   SWD(i,:) は、レベル i の detail 係数を含みます。
%
%   参考 DWT, WAVEDEC.


%   Copyright 1995-2007 The MathWorks, Inc.
