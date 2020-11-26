% WDCBM2　　 Birge-Massart法を使って、ウェーブレット2次元雑音除去または
%            圧縮に対するスレッシュホールド
%
% [THR,NKEEP] = WDCBM2(C,S,ALPHA,M) は、Birge-Massart 法を用いたウェーブレット
% 係数の選択則によって得られる雑音除去、または圧縮に関して、レベルに
% 依存にするスレッシュホールド値 THR と保持される係数の数 NKEEP を出力します。
%
% [C,S] は、レベル J0 = size(S,1)-2 において雑音除去または圧縮されたイメージの
% ウェーブレット分解構造です。ALPHA は1より大きい実数でなければなりません。
% 典型的には、圧縮の場合 ALPHA = 1.5で、雑音除去の場合は ALPHA = 3となります。
% M は正の整数で、典型的には、レベル J0+1 の Detail 係数の長さ 
% M = 3*prod(S(1,:))/4 になります。
%
% THR は 3 行 J0 列の行列です。THR(:,I) は、レベル I に対する3つの方向、
% 水平、対角、垂直成分で得られるレベル依存のスレッシュホールド値です。
% NKEEP は、長さ J0 のベクトルです。NKEEP(:,I) は、レベル I で保持される係数の数です。
%
% Birge-Massart の論文を参照すると、J0 は J0+1 となっています。J0、M、
% ALPHA が、この手法を定義付けることになります。:
%   - レベル J0+1(及びより粗いレベル)では、すべてのものが保持されます。
%   - 1から J0 までの範囲にあるレベル J において、より大きい係数である 
%     nj は、nj= M/(J0+1-j)^ALPHA に保たれます。M は調整パラメータ
%     (デフォルト値を参照)です。
%
% WDCBM2(C,L,ALPHA) は、WDCBM2(C,L,ALPHA,3*PROD(S(1,:))/4) と等価です。
%
%   参考 WDENCMP, WPDENCMP.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 25-Apr-98.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
