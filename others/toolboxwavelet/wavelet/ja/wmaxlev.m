% WMAXLEV   最大ウェーブレット分割レベル
%
% WMAXLEV は、不必要に高いレベル値を避けるのに有効です。
%
% L = WMAXLEV(S,'wname') は、文字列 'wname' (WFILTERS 参照)で指定された
% ウェーブレットを使って、大きさ S の信号またはイメージを分割する
% 最大レベルを出力します。
%
% WMAXLEV は、分解の許される最大レベルを出力します。しかし、一般には、
% その値より小さい値を使ってください。1次元では通常5を、2次元の場合では、
% 通常3をそれぞれ使ってください。
%
%   参考 WAVEDEC, WAVEDEC2, WPDEC, WPDEC2.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
