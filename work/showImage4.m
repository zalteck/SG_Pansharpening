%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: 
%           Visualize and return a four-band multispectral image.
% 
% Interface:
%           showImage4(I_F,print,id,flag_cut_bounds,dim_cut,thvalues,L)
%
% Inputs:
%           I_MS:               Four band multispectral image;
%           id:                 Identifier (name) of the printed EPS image;
%           flag_cut_bounds:    Cut the boundaries of the viewed Panchromatic image;
%           dim_cut:            Define the dimension of the boundary cut;
%           th_values:          Flag. If th_values == 1, apply an hard threshold to the dynamic range;
%           L:                  Radiomatric resolution of the input image.
%
% Outputs:
%           IMN:                printable image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function IMN = showImage4(I_MS,id,flag_cut_bounds,dim_cut,th_values,L)

if flag_cut_bounds
    I_MS = I_MS(dim_cut:end-dim_cut,dim_cut:end-dim_cut,:);
end

if th_values
    I_MS(I_MS > 2^L) = 2^L;
    I_MS(I_MS < 0) = 0;
end

IMN = viewimage(I_MS(:,:,1:3));
IMN = IMN(:,:,3:-1:1);

end