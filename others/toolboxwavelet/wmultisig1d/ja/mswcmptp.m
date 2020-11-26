% MSWCMPTP  1 次元複数信号の圧縮のスレッシュホールドと性能
%
%   [THR_VAL,L2_Perf,N0_Perf] = MSWCMPTP(DEC,METH) または 
%   [THR_VAL,L2_Perf,N0_Perf] = MSWCMPTP(DEC,METH,PARAM) は、
%   METH 手法と、必要な場合 PARAM パラメータを使って、圧縮後に得られる
%   ベクトル THR_VAL, L2_Perf, N0_Perf を計算します (METH と PARAM の
%   より詳しい情報については MSWCMP を参照)。
%   i 番目の信号に対して、
%     - THR_VAL(i) は、ウェーブレット係数に適用するスレッシュホールドです。
%       レベル依存の手法に対して、THR_VAL(i,j) は、レベル j における 
%       detail 係数に適用するスレッシュホールドです。
%     - L2_Perf(i) は、圧縮後に保存されるエネルギー (L2-ノルム) の割合です。
%     - N0_Perf(i) は、圧縮後に得られる 0 の割合です。
%
%   さらに 3 つのオプション入力を使用できます。
%       [...] = MSWCMPTP(...,S_OR_H) または
%       [...] = MSWCMPTP(...,S_OR_H,KEEPAPP) または
%       [...] = MSWCMPTP(...,S_OR_H,KEEPAPP,IDXSIG)
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
