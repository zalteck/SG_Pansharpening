function B = subsref(A,index)
%SUBSREF Subscripted reference for Laurent matrix.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 29-Mar-2001.
%   Last Revision: 20-Dec-2010.
%   Copyright 1995-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $ $Date: 2011/04/12 20:45:59 $ 

switch index.type
case '()',
    MA = A.Matrix;
    B = laurmat(MA(index.subs{:}));
    
case '{}',
    B = A.Matrix(index.subs{:});
    if length(B)<2
        B = B{:};
    end
    
case '.',
    if isequal(index.subs,'Matrix')
       B = A.Matrix;
    else
       error(message('Wavelet:FunctionArgVal:Invalid_FieldNam'))
    end
end
