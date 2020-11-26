%DWT  単一レベルの離散 1 次元ウェーブレット変換
%
%   DWT は、指定された特定のウェーブレット ('wname', WFILTERS を参照)、
%   または、指定された特定のウェーブレットフィルタ (Lo_D と Hi_D) の
%   いずれかに対応する単一レベルでの 1 次元ウェーブレット分解を返します。
%
%   [CA,CD] = DWT(X,'wname') は、ベクトル X のウェーブレット分解で得られた 
%   Approximation 係数ベクトル CA と Detail 係数ベクトル CD を計算します。
%
%   [CA,CD] = DWT(X,Lo_D,Hi_D) は、入力として以下のフィルタを与え、
%   上述のウェーブレット分解を計算します。
%   Lo_D は、分解ローパスフィルタです。
%   Hi_D は、分解ハイパスフィルタです。
%   Lo_D と Hi_D は、同じ長さでなければなりません。
%
%   LX = length(X) と LF がフィルタ長の場合は、length(CA) = length(CD) = LA 
%   になります。ここで、DWT の拡張モードが周期的なモードの場合、LA = CEIL(LX/2) 
%   です。他の拡張モードでは、LA = FLOOR((LX+LF-1)/2) になります。異なる信号拡張
%   モードについては、DWTMODE を参照してください。
%
%   [CA,CD] = DWT(...,'mode',MODE) は、指定した拡張モード MODE で、
%   ウェーブレット分解を計算します。MODE は拡張モードを含む文字列です。
%
%   例:
%     x = 1:8;
%     [ca,cd] = dwt(x,'db1','mode','sym')
%
%   参考 DWTMODE, IDWT, WAVEDEC, WAVEINFO.


%   Copyright 1995-2009 The MathWorks, Inc.
