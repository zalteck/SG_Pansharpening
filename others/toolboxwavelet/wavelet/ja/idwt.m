% IDWT   単一レベルの逆離散1次元ウェーブレット変換
%
% IDWTは、('wname',WFILTERS を参照)で指定された特定のウェーブレット
% または指定された特定のウェーブレット再構成フィルタ(Lo_R と Hi_R)の
% いずれかに関連した単一レベルの1次元ウェーブレット再構成を行います。
%
% X = IDWT(CA,CD,'wname') は、ウェーブレット 'wname' を使って、
% Approximation 係数ベクトル CA と Detail 係数ベクトル CD をベースに、
% 単一レベルの再構成 Approximation 係数ベクトル X を計算します。
%
% X = IDWT(CA,CD,Lo_R,Hi_R) は、設定したフィルタを使って上述の処理を行います。
%   Lo_R は、再構成ローパスフィルタです。
%   Hi_R は、再構成ハイパスフィルタです。
%   Lo_R と Hi_R は、同じ長さでなければなりません。
%
% LA = length(CA) = length(CD) で、LF がフィルタ長の場合、length(X) = LX となり、
% DWT の拡張モードが周期的なモードである場合は LX = 2*LA です。
% 他の拡張モードでは、LX = 2*LA-LF+2 になります。異なる信号拡張モードに
% ついては、DWTMODE を参照してください。
%
% X = IDWT(CA,CD,'wname',L)、または、X = IDWT(CA,CD,Lo_R,Hi_R,L) は、
% IDWT(CA,CD,'wname') を使って得られる結果の中心部分の L の長さを出力します。
% L は、LX よりも小さくなければなりません。
%
% X = IDWT(CA,CD,'wname','mode',mode) 
% X = IDWT(CA,CD,Lo_R,Hi_R,'mode',mode) 
% X = IDWT(CA,CD,'wname',L,'mode',mode) 
% X = IDWT(CA,CD,Lo_R,Hi_R,L,'mode',mode) 
% のいずれも、指定可能な拡張モードで、ウェーブレット再構成の係数を計算します。
%
% X = IDWT(CA,[]、... ) は、Approximation 係数ベクトル CA をベースに単一レベルの
% 再構成された Approximation 係数ベクトル X を出力します。
%
% X = IDWT([],CD、... ) は、Detail 係数ベクトル CD をベースに単一レベルの
% 再構成された Detail 係数ベクトル X を出力します
% 
%   参考 DWT, DWTMODE, UPWLEV.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 19-May-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
