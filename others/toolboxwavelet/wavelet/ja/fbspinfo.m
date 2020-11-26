% FBSPINFO   複素周波数B-スプラインウェーブレットの情報
%
%   複素周波数B-スプラインウェーブレット
%
%   定義: 複素周波数B-スプラインウェーブレット
%       fbsp(x) = Fb^{0.5}*(sinc(Fb*x/M))^M *exp(2*i*pi*Fc*x)
%   は、3つのパラメータに依存します:
%           M は、整数の次数パラメータです (>=1)。
%           Fb は、帯域幅パラメータです。
%           Fc は、ウェーブレットの中心周波数です。
%
%   M = 1 に対して、条件 Fc > Fb/2 は、周波数のサポート区間でゼロに
%   ならないという保証を満たします。
%
%   ファミリ              Complex Frequency B-Spline
%   略称                  fbsp
%
%   ウェーブレット名      fbsp"M"-"Fb"-"Fc"
%
%   直交性                なし
%   双直交性              なし
%   コンパクトサポート    なし
%   DWT                   なし
%   複素数 CWT            可
%
%   サポート長            無限
%
%   参考文献: A. Teolis, 
%   Computational signal processing with wavelets, 
%   Birkhauser, 1998, 63.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 18-Jun-99.
%   Last Revision: 05-Jun-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
