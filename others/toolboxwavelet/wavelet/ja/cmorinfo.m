% CMORINFO   複素数Morlet ウェーブレットに関する情報
%
%   複素数Morletウェーブレット
%
%   定義: 複素数Morletウェーブレット
%       cmor(x) = (pi*Fb)^{-0.5}*exp(2*i*pi*Fc*x)*exp(-(x^2)/Fb)
%   は、2つのパラメータに依存します:
%       Fb は、帯域幅パラメータです。
%       Fc は、ウェーブレットの中心周波数です。
%
%   ファミリ                Complex Morlet
%   略称                    cmor
%
%   ウェーブレット名        cmor"Fb"-"Fc"
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
%   Birkhauser, 1998, 65.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 18-Jun-99.
%   Last Revision: 08-Jul-1999.
%   Copyright 1995-2004 The MathWorks, Inc.
