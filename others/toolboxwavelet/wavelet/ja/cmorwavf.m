% CMORWAVF   複素数Morletウェーブレット
%
% [PSI,X] = CMORWAVF(LB,UB,N,FB,FC) は、正の帯域幅のパラメータ FB、
% ウェーブレットの中心周波数 FC、区間 [LB,UB] の N点の等間隔のグリッド上で、
% つぎの式
%
%   PSI(X) = ((pi*FB)^(-0.5))*exp(2*i*pi*FC*X)*exp(-(X^2)/FB)
%
% で定義される複素数Morletウェーブレットの値を出力します。
%
% 出力引数は、グリッド X で計算されたウェーブレット関数 PSI です。
%
%   参考 WAVEINFO.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 09-Jun-99.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
