% CGAUINFO   複素数Gaussianウェーブレットの情報
%
%   複素数Gaussianウェーブレット
%
%   定義: 複素数Gaussian関数の微分
%
%   cgau(x) = Cn * diff(exp(-i*x)*exp(-x^2),n) 
%   ここで、diff はsymbolicの微分であることに注意してください。Cn は定数です。
%
%   ファミリ               Complex Gaussian
%   略称                   cgau
%
%   ウェーブレット名       cgau"n"
%
%   直交性                 なし
%   双直交性               なし
%   コンパクトサポート     なし
%   DWT                    なし
%   複素数 CWT             可
%
%   サポート長             無限
%   対称性                 あり
%                       n 奇数 ==> 対称
%                       n 偶数 ==> 非対称


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 01-Jul-99.
%   Last Revision: 05-Jul-1999.
%   Copyright 1995-2004 The MathWorks, Inc.
