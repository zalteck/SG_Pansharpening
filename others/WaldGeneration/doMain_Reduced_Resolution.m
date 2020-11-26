function doMain_Reduced_Resolution( im_tag, sensor, input_file, output_file )
% doMain_Reduced_Resolution generates  low resolution PANchromatic
% (PAN) and MultiSpectral (MS) images according to the Wald's protocol for
% one image following the same procedure as Vivone, G. paper.
%
% Input arguments:
%       im_tag      tag for the image to be generated
%       sensor      sensor
%       input_file  .mat input file with observed images
%       output_file .mat output file where generated images and other
%       variables will be stored
%
% Output arguments:
%
%       Example:
%
%       dododoMain_Reduced_Resolution()
%
% Pérez-Bueno, F., Vega, M., Mateos, J., Molina, R., & Katsaggelos, A. K. (2020). 
% Variational Bayesian Pansharpening with Super-Gaussian Sparse Image Priors. Sensors, 20(18), 5308. 
%
% This function uses other functions from
%
%    Vivone, G.; Alparone, L.; Chanussot, J.; Dalla Mura, M.; Garzelli, A.; Licciardi, G.A.; Restaino, R.; Wald, L. 
%    A critical comparison among pansharpening algorithms. IEEE Trans. Geosci. Remote Sens. 2015, 53, 2565–2586.
%
%    See : https://rscl-grss.org/coderecord.php?id=541

    load(input_file);
    %% Quality Index Blocks
    Qblocks_size = 32;

    %% Interpolator
    bicubic = 0;

    %% Cut Final Image
    flag_cut_bounds = 1;
    dim_cut = 11;

    %% Threshold values out of dynamic range
    thvalues = 0;

    %% Print Eps
    printEPS = 0;

    %% Resize Factor
    ratio = 4;

    %% Radiometric Resolution
    L = 11;

    %% %%%%%%%%%%%%%%%%%%%%%%%% Dataset load %%%%%%%%%%%%%%%%%%%%%%%%%%
    switch im_tag
        case 'MD'
            I_MS_loaded = I_MS;
            I_PAN_loaded = I_PAN;
            im_prepare='resize';
            ratio = 2;
        case 'NL_subset'
            I_MS_loaded = I_MS;
            I_PAN_loaded = I_PAN;
            im_prepare='resize';
            ratio = 2;
        case 'NL_clouds'
            I_MS_loaded = I_MS;
            I_PAN_loaded = I_PAN;
            im_prepare='resize';
            ratio = 2;
        case 'Romax2'
            I_MS_loaded = I_MS;
            I_PAN_loaded = I_PAN;
            im_prepare='resize';
            ratio = 2;
       case 'Romax4'
            I_MS_loaded = I_MS;
            I_PAN_loaded = I_PAN;
            im_prepare='resize';
            ratio = 4;
       case 'FORMOSASPOTx2'
            I_MS_loaded = I_MS;
            I_PAN_loaded = I_PAN;
            im_prepare='resize';
            ratio = 2;
       case 'FORMOSASPOTx4'
            I_MS_loaded = I_MS;
            I_PAN_loaded = I_PAN;
            im_prepare='resize';
            ratio = 4;
    end

    if strcmp(im_tag,'MD') ...
            || strcmp(im_tag,'NL_subset')|| strcmp(im_tag,'Romax2')  || strcmp(im_tag,'Romax4') ...
            || strcmp(im_tag,'FORMOSASPOTx2')  || strcmp(im_tag,'FORMOSASPOTx4')

        I_GT = double(I_MS_loaded);
    end

    %% %%%%%%%%%%%%%    Preparation of image to fuse            %%%%%%%%%%%%%%

    if strcmp(im_prepare,'resize')
        [I_MS_LR, I_PAN]=resize_images(I_MS_loaded,I_PAN_loaded,ratio,sensor);
    end


    %% Upsampling

    if strcmp(im_tag,'MD') || strcmp(im_tag,'NL_subset') ...
            || strcmp(im_tag,'Romax2')  || strcmp(im_tag,'Romax4')|| strcmp(im_tag,'FORMOSASPOTx2')  || strcmp(im_tag,'FORMOSASPOTx4')

        if bicubic == 1
            H = zeros(size(I_PAN,1),size(I_PAN,2),size(I_MS_LR,3));    
            for idim = 1 : size(I_MS_LR,3)
                H(:,:,idim) = imresize(I_MS_LR(:,:,idim),ratio);
            end
            I_MS = H;
        else
            I_MS = interp23tap(I_MS_LR,ratio);
        end

    end
    
    save(output_file);
end

