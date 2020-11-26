%GAUSWAVF  ガウスウェーブレット
%
%   [PSI,X] = GAUSWAVF(LB,UB,N,P) は、[LB,UB] の区間の N 点の等間隔の
%   グリッド上で、ガウス関数 F = Cp*exp(-x^2) の P 階の微分係数の値を返します。
%   ここで、Cp は、F = 1 のときの P 階の微分係数の 2 ノルムになります。
%   P は、1 から 8 までの整数値です。
%
%   出力引数は、グリッド X で計算されたウェーブレット関数 PSI です。
%   [PSI,X] = GAUSWAVF(LB,UB,N) は、[PSI,X] = GAUSWAVF(LB,UB,N,1) と等価です。
%
%   このウェーブレットの効果的なサポートの範囲は、[-5 5] です。
%
%   --------------------------------------
%   Symbolic Math Toolbox(TM) を使う場合、
%   P > 8 の値を指定することができます。
%   --------------------------------------
%
%   参考 CGAUSWAVF, WAVEINFO.


%   Copyright 1995-2009 The MathWorks, Inc.
