% WPDEC   1次元ウェーブレットパケット分解
%
% [T,D] = WPDEC(X,N,'wname',E,P) は、特定のウェーブレット('wname'、WFILTERS参照)
% でレベル N に対するベクトル X のウェーブレットパケット分解を行ったときに
% 対応するツリー構造 T とデータ構造 D (MAKETREE参照)を出力します。
% 
% E は、エントロピーのタイプを示す文字列です(WENTROPY参照)。
%   E = 'shannon'、'threshold'、'norm'、'log energy'、'user'
% 
% P は、オプションパラメータです。
% E の値が
%  'shannon'、または、'log energy' のときは、P は用いられません。
%  'threshold'、または、'sure' のときは、P はスレッシュホールド値です(0 < =  P)。
%  'norm' のときは、P はべき数です(1 < =  P < 2)。
%  'user' のときは、P はユーザが定義した関数の名前を示す文字列です。
%
% [T,D] = WPDEC(X,N,'wname') は、[T,D] = WPDEC(X,N,'wname','shannon') と等価です。
%
%   参考 WAVEINFO, WENTROPY, WPDEC2, WPREC, WPREC2.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 21-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
