%CWTEXT  拡張パラメータを使った実数または複素数の連続 1 次元ウェーブレット係数
%
%   COEFS = CWTEXT(S,SCALES,'wname') は、引数 'wname' で設定したウェーブレット
%   を使って、実数で正の SCALES に対する入力ベクトル S の連続ウェーブレット
%   係数を計算します。
%   信号 S は実数で、ウェーブレットは実数でも複素数でも構いません。
%
%   COEFS = CWTEXT(S,SCALES,'wname',PropName1,PropVal1, ...) は、拡張
%   パラメータを使用して連続ウェーブレット変換係数を計算し、さらにプロット
%   表示します。PropName の有効な値は以下のとおりです。
%       'ExtMode' , 'ExtSide' , 'ExtLen' , 'PlotMode', 'xlim'
%
%   連続ウェーブレット変換係数は、以下の拡張パラメータを使用して計算されます。
%   'ExtMode', 'ExtSide', 'ExtLen'
%   EXTMODE の有効な値は、以下のとおりです。
%       'zpd' (ゼロパディング)
%       'sp0' (0 次の滑らかな拡張)
%       'sp1' (1 次の滑らかな拡張)
%       ...
%   EXTSIDE の有効な値は、以下のとおりです。
%       EXTSIDE = 'l' (または 'u') は、左 (上) 側の拡張。
%       EXTSIDE = 'r' (または 'd') は、右 (上) 側の拡張。
%       EXTSIDE = 'b' は、両側の拡張。
%       EXTSIDE = 'n' は、拡張しない。
%   EXTMODE と EXTSIDE の有効な値の計算リストについては、WEXTEND を参照して
%   ください。
%   EXTLEN は、拡張の長さです。
%   拡張パラメータのデフォルト値は 'zpd', 'b' です。また、EXTLEN は SCALES の
%   最大値を使って計算されます。
%   3 つのパラメータの代わりに、以下のシンタックスを使用することもできます。
%     EXTMODE = struct('Mode',ModeVAL,'Side',SideVAL,'Len',LenVAL);
%     EXTMODE = {ModeVAL,SideVAL,LenVAL};
%
%   COEFS = CWTEXT(...,'PlotMode',PLOTMODE) は、連続ウェーブレット変換係数を
%   計算し、さらにプロット表示します。
%   係数は、以下のいずれかの PLOTMODE を使って色付けされます。
%     PLOTMODE = 'lvl' (スケール毎)
%     PLOTMODE = 'glb' (すべてのスケール)
%     PLOTMODE = 'abslvl' または 'lvlabs' (絶対値およびスケール毎)
%     PLOTMODE = 'absglb' または 'glbabs' (絶対値およびすべてのスケール)
%   '3D' の後に、PLOTMODE パラメータに対して上記にリストされた同じキーワード
%   を使って 3 次元プロット (サーフェス) をプロットすることができます。
%   たとえば、PLOTMODE = '3Dlvl'.
%
%   PLOTMODE = 'scal' または 'scalCNT' の場合、連続ウェーブレット変換係数と
%   対応するスカログラム (係数毎のエネルギーの割合) が計算されます。
%   PLOTMODE が 'scal' の場合、スカログラムのスケーリングされたイメージが表示され、
%   PLOTMODE が 'scalCNT' の場合、スカログラムの等高線図が表示されます。
%
%   XLIM パラメータが与えられた場合、連続ウェーブレット変換係数は、PLOTMODE 
%   と以下の XLIM の範囲を使って色付けされます。
%   1 <= x1 < x2 <= length(S) の範囲の XLIM = [x1 x2]。
%
%   a = SCALES(i) の場合、b = 1 から ls = length(S) の範囲でウェーブレット
%   係数 C(a,b) が計算され、与えられた SCALE ベクトルの順番で COEFS(i,:) に
%   記憶されます。
%
%   出力引数 COEFS は、la 行 ls 列の行列で、ここで、la は SCALES の長さを
%   指しています。COEFS は、ウェーブレットタイプに依存して実数または複素数
%   行列になります。
%
%   使用例:
%     t = linspace(-1,1,512);
%     s = 1-abs(t);
%     c = cwtext(s,1:32,'cgau4');
%     c = cwtext(s,[64 32 16:-2:2],'morl');
%     c = cwtext(s,[3 18 12.9 7 1.5],'db2');
%     c = cwtext(s,1:32,'sym2','plotMode','lvl');
%     c = cwtext(s,1:64,'sym4','plotMode','abslvl','xlim',[100 400]);
%
%     [c,Sc] = cwtext(s,1:64,'sym4','plotMode','scal');
%     [c,Sc] = cwtext(s,1:64,'sym4','plotMode','scalCNT');
%     [c,Sc] = cwtext(s,1:64,'sym4','plotMode','scalCNT','extMode','sp1');
%
%     c = cwtext(s,1:64,'sym4','plotMode','lvl','extMode','sp0');
%     c = cwtext(s,1:64,'sym4','plotMode','lvl','extMode','sp1');
%     c = cwtext(s,1:64,'sym4','plotMode','lvl','extMode',{'sp1','b',300});
%
%     ext = struct('Mode','sp1','Side','b','Len',300);
%     c = cwtext(s,1:64,'sym4','plotMode','lvl','extMode',ext);
%
%     load wcantor
%     cwtext(wcantor,(1:256),'mexh','extmode','sp0','extLen',2000, ...
%               'plotMode','absglb');
%     colormap(pink(4))
%
%   参考 CWT, WAVEDEC, WAVEFUN, WAVEINFO, WCODEMAT.


%   Copyright 1995-2008 The MathWorks, Inc.
