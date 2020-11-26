% PLOT   DTREE オブジェクトのプロット
%
% PLOT(T) は、DTREE オブジェクト T をプロットします。
% FIG = PLOT(T) は、ツリー T を含むfigureのハンドルを出力します。
% PLOT(T,FIG)  は、既にツリー構造が含まれるfigure FIG にツリー構造 T を
% プロットします。
%
% PLOT は、グラフィカルなツリー管理ユーティリティ関数です。
% figureは、ツリー構造を含む GUI ツールです。Node Level では、Depth_Position か 
% Index を、Node Action では、Split-Merge か Visualize を変更することが
% できます。デフォルト値は、Depth_Position と Visualize です。
%
% 現在の Node Action を実行するには、ノードをクリックします。
%
% 何回かノードの分離または組み替え操作を行った後に、ノードの含まれる
% figureのハンドルを用いて、新しいツリーを取得することができます。
% 以下の特定のシンタックスを使わなければなりません:
%       NEWT = PLOT(T,'read',FIG).
%  ここでは、最初の引数はダミーです。この用途に関する最も一般的な
%  シンタックスは、以下の通りです。:
%       NEWT = PLOT(DUMMY,'READ',FIG);
% ここで、DUMMY は、NTREE オブジェクトによって親となる任意のオブジェクトです
%
% DUMMY は、NTREE によって親となるオブジェクトで、構成される任意の
% オブジェクト名を指定できます。:
%      NEWT = PLOT(ntree,'read',FIG);


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 12-Mar-96.
%   Last Revision: 13-Feb-2002.
%   Copyright 1995-2004 The MathWorks, Inc.
