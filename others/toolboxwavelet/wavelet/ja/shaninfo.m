% SHANINFO   複素数Shannonウェーブレットに関する情報
%
%   複素数Shannonウェーブレット
%
%   定義: 複素数Shannonウェーブレット
%           shan(x) = Fb^{0.5}*sinc(Fb*x)*exp(2*i*pi*Fc*x)
%   は、2つのパラメータに依存します:
%           Fb は、帯域幅パラメータです。
%           Fc は、ウェーブレットの中心周波数です。
%
%   条件 Fc > Fb/2 は、周波数のサポート区間にゼロがないことの保証することを
%   満たします。
%
%   ファミリ                Complex Shannon
%   略称                    shan
%
%   ウェーブレット名        shan"Fb"-"Fc"
%
%   直交性                  なし
%   双直交性                なし
%   コンパクトサポート      なし
%   DWT                     なし
%   複素数 CWT              可
%
%   サポート長              無限
%
%   参考文献: A. Teolis, 
%   Computational signal processing with wavelets, 
%   Birkhauser, 1998, 62.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 18-Jun-99.
%   Last Revision: 05-Jun-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
