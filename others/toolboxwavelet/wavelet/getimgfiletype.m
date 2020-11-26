function imgFileType = getimgfiletype(dummy)
%GETIMGFILETYPE Getimage file types.
%   imgFileType = GETIMGFILETYPE

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 10-Oct-2008.
%   Last Revision: 03-Nov-2008.
%   Copyright 1995-2008 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $ $Date: 2008/12/04 23:36:10 $ 

if nargin<1
    imgFileType = ['*.mat;*.bmp;*.hdf;*.jpg;' ...
        '*.jpeg;*.pcx;*.tif;*.tiff;*.gif;*.png;' ...
        '*.ras;*.ppm;*.pgm;*.pbm;'];
else
    imgFileType = {'bmp','jpg','jpeg' ,...
        'pcx','tif','tiff','gif','png',...
        'ras','ppm','pgm','pbm'};
end
