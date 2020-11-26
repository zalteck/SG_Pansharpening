% WFBM   非整数ブラウン運動のシンセシス
%
% FBM = WFBM(H,L) は、Abry と Sellan により提案されたアルゴリズムに従い、
% パラメータ H (0 < H < 1) と長さ L の非整数ブラウン運動信号 (fBm) を
% 出力します。
%
% FBM = WFBM(H,L,'plot') は、fBm信号を生成しプロットします。
%
% FBM = WFBM(H,L,NS,W) または FBM = WFBM(H,L,W,NS) は、十分に滑らかな
% 直交ウェーブレットの名前を W として、NS の再構成ステップを使用する 
% fBm を出力します。
%
% WFBM(H,L,'plot',NS)、WFBM(H,L,'plot',W)、WFBM(H,L,'plot',NS,W)、
% あるいは WFBM(H,L,'plot',W,NS) は、fBm 信号を生成しプロットします。
%
% WFBM(H,L) は、WFBM(H,L,6,'db10') と同じです。
% WFBM(H,L,NS) は、WFBM(H,L,NS,'db10') と同じです。
% WFBM(H,L,W) は、WFBM(H,L,W,6) と同じです。


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 04-Dec-1996.
%   Last Revision: 01-Jun-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
