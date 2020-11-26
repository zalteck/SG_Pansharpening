% WAVE2LP   ウェーブレットに関連するLaurent多項式
%
% [Hs,Gs,Ha,Ga] = WAVE2LP(W) は、ウェーブレット W に関連する4つの
% Laurent多項式を出力します (LIFTWAVE を参照)。
% (Hs,Gs) と (Ha,Ga) の組は、それぞれ、シンセシスおよび解析の組です。
% H-多項式 (G-多項式) は、"ローパス" ("ハイパス") 多項式です。
% 直交ウェーブレットに対して、Hs = Ha と Gs = Ga です。
%
%   参考 LP.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 03-Jun-2003.
%   Last Revision: 12-Nov-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
