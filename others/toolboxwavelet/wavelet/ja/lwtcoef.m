% LWTCOEF   1-D LWTのウェーブレット係数の抽出または再構成
%
% Y = LWTCOEF(TYPE,XDEC,LS,LEVEL,LEVEXT) は、リフティングスキーム LS から
% 得られるレベル LEVEL でのLWT分解の XDEC から抽出される係数、または、
% レベル LEVEXT の再構成された係数を出力します。
% TYPE の有効な値はつぎのようになります:
%      - 'a'  approximation
%      - 'd'  detail
%      - 'ca' approximationの係数
%      - 'cd' detailの係数
%
% Y = LWTCOEF(TYPE,XDEC,W,LEVEL,LEVEXT) は、"リフティングされたウェーブレット" の
% 名前である W を使用して同じ出力を返します。
%
%   参考 ILWT, LWT.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 03-Feb-2000.
%   Last Revision: 30-Jun-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
