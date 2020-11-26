%GET  WDECTREE オブジェクトフィールドの内容を取得
%
%   [FieldValue1,FieldValue2, ...] = ...
%       GET(T,'FieldName1','FieldName2', ...) 
%   は、WDECTREE オブジェクト T で指定されるフィールドの内容を返します。
%   オブジェクト、または構造体のフィールドに対して、サブフィールドの内容を
%   取得します (DTREE/GET を参照)。
%
%   [...] = GET(T) は、T のすべてのフィールドの内容を返します。
%
%   'FieldName' で選択できる値は以下のとおりです。
%   'dtree' - 親オブジェクト
%   'typData' - データのタイプ
%   'dimData' - データの次元
%   'WT_Settings' - ウェーブレット変換設定の構造体
%     'typeWT'  - ウェーブレット変換のタイプ
%     'wname'   - ウェーブレット名
%     'extMode' - DWT 拡張モード
%     'shift'   - DWT シフト値
%     'Filters' - フィルタの構造体
%        'Lo_D'    - 分解側ローパスフィルタ
%        'Hi_D'    - 分解側ハイパスフィルタ
%        'Lo_R'    - 再構成側ローパスフィルタ
%        'Hi_R'    - 再構成側ハイパスフィルタ
%
%   または、DTREE 親オブジェクトのフィールド。
%   'FieldName' で選択できる値については、help dtree/get と入力してください。
%
%   参考 DTREE/READ, DTREE/SET, DTREE/WRITE.


%   Copyright 1995-2008 The MathWorks, Inc.
