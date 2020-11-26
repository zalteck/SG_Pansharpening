%DISP  Laurent 多項式オブジェクトをテキストとして表示
%
%   DISP(P) は、多項式の名前 (ここでは P として) を印字するために Laurent 
%   多項式 P を表示します。
%   DISP(P,VarName) は、多項式名として "VarName" を使用します。
%
%   例:
%      % Laurent を作成
%      Z = laurpoly(1,1);  
%      M = laurmat({1 Z;0 1})
%
%      % Laurent 行列を表示
%      disp(M)
%      disp(M,'Matrix')


%   Copyright 1995-2009 The MathWorks, Inc.
