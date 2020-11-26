%WSCALOGRAM  連続ウェーブレット変換のスカログラム
%
%   SC = WSCALOGRAM(TYPEPLOT,COEFS) は、スカログラム SC (係数ごとのエネルギーの
%   割合) を計算します。COEFS は、連続ウェーブレット係数の行列です (CWT を参照)。
%   スカログラムは以下の計算により得られます。
%       S = abs(coefs.*coefs); SC = 100*S./sum(S(:))
%
%   TYPEPLOT が 'image' の場合、スカログラムのスケーリングされたイメージが表示され、
%   TYPEPLOT が 'contour' の場合、スカログラムの等高線図が表示されます。
%   そうでない場合は、スカログラムの値がプロット表示せずに返されます。
%
%   SC = WSCALOGRAM(...,'PropNAME',PropVAL,...)
%   'PropNAME' で利用可能な値は以下のとおりです。
%       - 'scales': CWT で使用するスケール
%       - 'ydata':  CWT で使用する信号
%       - 'xdata':  信号に対応する x 値
%       - 'power':  (正の) 実数値
%
%   'power' のデフォルト値は 0 です。power>0 の場合、係数は正規化されます。
%       coefs(k,:) = coefs(k,:)/(scales(k)^power)
%   そして、スカログラムは上述のように計算されます。
%
%   使用例:
%     wname = 'mexh';
%     scales = (1:128);
%     load cuspamax
%     signal = cuspamax;
%     coefs = cwt(signal,scales,wname);
%     figure; SCimg = wscalogram('image',coefs);
%     figure; SCcnt = wscalogram('contour',coefs);
%     figure; SCimg = wscalogram('image',coefs,'scales',scales,'ydata',signal);
%     figure; SCcnt = wscalogram('contour',coefs,'scales',scales,'ydata',signal);
%
%   参考 CWT.


%   Copyright 1995-2008 The MathWorks, Inc.
