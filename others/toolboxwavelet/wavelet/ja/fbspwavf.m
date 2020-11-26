% FBSPWAVF   複素周波数 B-Spline ウェーブレット 
%
% [PSI,X] = FBSPWAVF(LB,UB,N,M,FB,FC) は、次数パラメータ M (M は1以上の整数です)、
% 帯域幅パラメータ FB、ウェーブレットの中心周波数 FC で定義された
% 複素周波数 B-Spline ウェーブレットを出力します。
%
% 関数 PSI は、区間 [LB,UB] の N点の等間隔のグリッド上で、明示的につぎの式:
%   PSI(X) = (FB^0.5)*((sinc(FB*X/M).^M).*exp(2*i*pi*FC*X))
% を使って計算されます。
%
% 出力引数は、グリッド X で計算されたウェーブレット関数 PSI です。
%
%   参考 WAVEINFO.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 09-Jun-99.
%   Last Revision: 05-Jun-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
