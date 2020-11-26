% SHANWAVF   複素 Shannon ウェーブレット
%
% [PSI,X] = SHANWAVF(LB,UB,N,FB,FC) は、帯域幅パラメータ FB、ウェーブレットの
% 中心周波数 FC で定義される複素 Shannon ウェーブレットを出力します。
% FB と FC は、FC > 0 と FB > 0 でなければなりません。
%
% 関数 PSI は、区間 [LB,UB] の N点の等間隔なグリッドで明確につぎの式:
%   PSI(X) = (FB^0.5)*(sinc(FB*X).*exp(2*i*pi*FC*X))
% を使って計算されます。
%
% 出力引数は、グリッド X で計算されたウェーブレット関数 PSI です。
%
%   参考 WAVEINFO.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 09-Jun-99.
%   Last Revision: 14-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
