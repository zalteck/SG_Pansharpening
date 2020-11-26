% MSWCMPSCR  1 次元複数信号のウェーブレット圧縮スコア
%
%   [THR,L2SCR,N0SCR,IDXSORT] = MSWCMPSCR(DEC) は、4 つの行列を計算します。
%   スレッシュホールド THR、圧縮スコア L2SCR と N0SCR とインデックス IDXSORT。
%   分解 DEC は、detail と (オプションとして) approximation 係数の連結で
%   得られるウェーブレット係数 CFS の行列に対応します。
%       CFS = [cd{DEC.LEV} , ... , cd{1}] または
%       CFS = [ca , cd{DEC.LEV} , ... , cd{1}]
%   連結は、DEC.dirDec が 'r' (または 'c') の場合、行方向 (または列方向) 
%   に行なわれます。
%
%   オリジナル信号の数 NbSIG と各信号に対する係数の数 NbCFS を (すべて、
%   または detail 係数のみ) 与えると、CFS は NbSIG 行 NbCFS 列の行列に
%   なります。
%	そして:
%     - THR, L2SCR, N0SCR は、NbSIG 行 (NbCFS+1) 列の行列です。
%     - IDXSORT は NbSIG 行 NbCFS 列の行列です。
%   かつ:
%     - THR(:,2:end) は、絶対値に対して昇順の行で格納された CFS と等しく
%       なります。
%       また、THR(:,1) = 0 です。
%     i 番目の信号に対して、
%     - L2SCR(i,j) は、CFS(i,j-1) に等しいスレッシュホールドに対応する
%       保存されたエネルギー (L2-ノルム) の割合です 
%       (2 <= j <= NbCFS)。また、L2SCR(:,1) = 100 です。
%     - N0SCR(i,j) は、CFS(i,j-1) に等しいスレッシュホールドに対応する
%       0 の割合です (2 <= j <= NbCFS)。また、N0SCR(:,1) = 0 です。
%
%   さらに 3 つのオプション入力を使用できます。
%     [...] = MSWCMPSCR(...,S_or_H,KEEPAPP,IDXSIG)
%       - S_or_H  ('s' または 'h') は、ソフト、またはハードスレッシュ
%         ホールド化という意味です (詳細については MSWTHRESH を参照)。
%       - KEEPAPP (true または false)。KEEPAPP が true に等しい場合、
%         approximation 係数は保持されます。
%       - IDXSIG は、初期信号のインデックスを含むベクトル、または
%         文字列 'all' です。
%   デフォルトは、それぞれつぎのようになります: 'h', false, 'all'.
%
%   参考 mdwtdec, mdwtrec, ddencmp, wdencmp


%   Copyright 1995-2007 The MathWorks, Inc.
