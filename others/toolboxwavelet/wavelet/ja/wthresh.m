% WTHRESH   ソフトスレッシュホールドまたはハードスレッシュホールド処理
%
% Y = WTHRESH(X,SORH,T) は、入力ベクトルまたは行列 X へソフト (SORH = 's')、
% または、ハード(SORH = 'h')スレッシュホールドを使ってスレッシュホールド値 T を
% 適用した結果 Y を出力します。
%
% Y = WTHRESH(X,'s',T) は、Y = SIGN(X).(|X|-T)+ を出力します。
% ソフトスレッシュホールド処理は、ウェーブレットをある範囲で減少させます。
%
% Y = WTHRESH(X,'h',T) は、Y = X.1_(|X|>T) を出力します。
% ハードスレッシュホールド処理は、よりはっきりとしています。
%
%   参考 WDEN, WDENCMP, WPDENCMP.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
