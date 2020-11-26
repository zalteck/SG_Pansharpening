% LSINFO   リフティングスキームについての情報
%
% リフティングスキーム (LS) は、N x 3 のセル配列です。配列の N-1 の
% 最初の行は、"基本的なリフティングステップ" (ELS) です。
% 最後の行は、LS の正規化されたものが与えられます。
%
% 各 ELS はつぎの形式です: 
%      {type , coefficients , max_degree}
% ここで:
%     - "type" は、'p' (primal) または 'd' (dual) になります。
%     - "coefficients" は、以下に記述されるLaurent多項式 P の実数で
%       定義されている係数のベクトル C です。
%     - "max_degree" は、P の単項式の最高次数 d です。
%     Laurent多項式 P は、つぎの形式です:
%       P(z) = C(1)*z^d + C(2)*z^(d-1) + ... + C(m)*z^(d-m+1)
%   
% リフティングスキーム LS は、つぎのようになります:
%   k = 1:N-1 に対して、LS{k,:} は ELS です:
%       LS{k,1} は、リフティングの "タイプ" 'p' (primal) または 'd' (dual) です。
%       LS{k,2} は、対応するリフティングフィルタです。
%       LS{k,3} は、filter LS{k,2} に対応するLaurent多項式の最高次数です。
%   LS{N,1} は、primal の正規化 (実数) です。
%   LS{N,2} は、dual の正規化 (実数) です。
%   LS{N,3} は、使用されません。
%   通常、LS{N,1}*LS{N,2} = 1 となるように正規化されます。
%
% たとえば、ウェーブレット db1 に関連するリフティングスキームは、
% つぎのとおりです:
%
%       LS = {...
%             'd'         [    -1]    [0]
%             'p'         [0.5000]    [0]
%             [1.4142]    [0.7071]     []
%            }
%
%   参考 DISPLS, LP.


%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 17-Jun-2003.
%   Last Revision: 11-Jul-2003.
%   Copyright 1995-2004 The MathWorks, Inc.
