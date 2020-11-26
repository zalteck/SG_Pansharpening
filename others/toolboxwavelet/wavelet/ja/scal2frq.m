% SCAL2FRQ   スケールを周波数に変換
%
% F = SCAL2FRQ(A,'wname',DELTA) は、ウェーブレット関数 'wname' と
% サンプリング周期 DELTA とA で与えられたスケールに対応する擬似周波数を
% 出力します。
%
% SCAL2FRQ(A,'wname') は、SCAL2FRQ(A,'wname',1) と等価です。
%
% 例題:
%     %----------------------------------------------------
%     % この例題は、x(t) = cos(5t) の周期関数から始まり、
%     % scal2frq 関数は、CWT係数の最大値に対応するスケールを、
%     % 真の周波数 (5/(2*pi) =~ 0.796) に近い擬似周波数 
%     % (0.795) に変換するデモンストレーションを行います。
%     %----------------------------------------------------
%     wname = 'db10';
%     A = -64; B = 64; P = 224;
%     delta = (B-A)/(P-1);
%     t = linspace(A,B,P);
%     omega = 5; x = cos(omega*t);
%     freq  = omega/(2*pi);
%     scales = [0.25:0.25:3.75];
%     TAB_PF = scal2frq(scales,wname,delta);
%     [dummy,ind] = min(abs(TAB_PF-freq));
%     freq_APP  = TAB_PF(ind);
%     scale_APP = scales(ind);
%     str1 = ['224 samples of x = cos(5t) on [-64,64] - ' ...
%             'True frequency = 5/(2*pi) =~ ' num2str(freq,3)];
%     str2 = ['Array of pseudo-frequencies and scales: '];
%     str3 = [num2str([TAB_PF',scales'],3)];
%     str4 = ['Pseudo-frequency = ' num2str(freq_APP,3)];
%     str5 = ['Corresponding scale = ' num2str(scale_APP,3)];
%     figure; cwt(x,scales,wname,'plot'); ax = gca; colorbar;
%     axTITL = get(ax,'title');
%     axXLAB = get(ax,'xlabel');
%     set(axTITL,'String',str1);
%     set(axXLAB,'String',[str4,'  -  ' str5]);
%     clc; disp(strvcat(' ',str1,' ',str2,str3,' ',str4,str5))
%
%   参考 CENTFRQ.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 04-Mar-98.
%   Last Revision: 14-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
