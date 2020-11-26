%CWT  実数または複素数の連続 1 次元ウェーブレット係数
%
%   COEFS = CWT(S,SCALES,'wname') は、引数 'wname' で設定したウェーブレットを
%   使って、実数で正の SCALES に対する入力ベクトル S の連続ウェーブレット係数を
%   計算します。
%   信号 S は実数で、ウェーブレットは実数でも複素数でも構いません。
%
%   COEFS = CWT(S,SCALES,'wname','plot') は、連続ウェーブレット変換係数を
%   計算し、さらにプロット表示します。
%
%   COEFS = CWT(S,SCALES,'wname',PLOTMODE) は、連続ウェーブレット変換係数を
%   計算し、さらにプロット表示します。
%   係数は、以下のいずれかの PLOTMODE を使って色付けされます。
%   PLOTMODE = 'lvl' (スケール毎)
%   PLOTMODE = 'glb' (すべてのスケール)
%   PLOTMODE = 'abslvl' または 'lvlabs' (絶対値およびスケール毎)
%   PLOTMODE = 'absglb' または 'glbabs' (絶対値およびすべてのスケール)
%
%   CWT(...,'plot') は、CWT(...,'absglb') と等価です。
%
%   '3D' の後に、PLOTMODE パラメータに対して上記にリストされた同じキーワード
%   を使って 3 次元プロット (サーフェス) をプロットすることができます。
%   たとえば、COEFS = CWT(...,'3Dplot') または COEFS = CWT(...,'3Dlvl')
%
%   COEFS = CWT(S,SCALES,'WNAME',PLOTMODE,XLIM) は、連続ウェーブレット変換
%   係数を計算し、プロット表示します。係数は、PLOTMODE と以下の範囲の XLIM を
%   使って色付けされます。1 <= x1 < x2 <= length(S) の範囲の XLIM = [x1 x2]。
%
%   COEFS = CWT(...,'scal'), [COEFS,SC] = CWT(...,'scal'), 
%   COEFS = CWT(...,'scalCNT') または [COEFS,SC] = CWT(...,'scalCNT') は、
%   連続ウェーブレット変換係数と対応するスカログラム (係数毎のエネルギーの割合) を
%   計算します。
%   PLOTMODE が 'scal' の場合、スカログラムのスケーリングされたイメージが表示され、
%   PLOTMODE が 'scalCNT' の場合、スカログラムの等高線図が表示されます。
%
%   a = SCALES(i) の場合、b = 1 から ls = length(S) の範囲でウェーブレット
%   係数 C(a,b) が計算され、与えられた SCALE ベクトルの順番で COEFS(i,:) に
%   記憶されます。
%   出力引数 COEFS は、la 行 ls 列の行列で、ここで、la は SCALES の長さを
%   指しています。COEFS は、ウェーブレットタイプに依存して実数または複素数
%   行列になります。
%
%   使用例:
%     t = linspace(-1,1,512);
%     s = 1-abs(t);
%     c = cwt(s,1:32,'cgau4');
%     c = cwt(s,[64 32 16:-2:2],'morl');
%     c = cwt(s,[3 18 12.9 7 1.5],'db2');
%     c = cwt(s,1:32,'sym2','lvl');
%     c = cwt(s,1:64,'sym4','abslvl',[100 400]);
%     [c,Sc] = cwt(s,1:64,'sym4','scal');
%     [c,Sc] = cwt(s,1:64,'sym4','scalCNT');
%
%   参考 WAVEDEC, WAVEFUN, WAVEINFO, WCODEMAT.


%   Copyright 1995-2008 The MathWorks, Inc.
