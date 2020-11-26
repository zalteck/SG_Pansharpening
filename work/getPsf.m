function psf = getPsf( ratio,sensor )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    switch sensor
    case 'QB' 
        GNyq = [0.34 0.32 0.30 0.22]; % Band Order: B,G,R,NIR
        flag_resize_new = 2;
    case 'IKONOS'
        GNyq = [0.26,0.28,0.29,0.28]; % Band Order: B,G,R,NIR
        flag_resize_new = 2;
    case 'GeoEye1' 
        GNyq = [0.23,0.23,0.23,0.23]; % Band Order: B,G,R,NIR
        flag_resize_new = 2;
    case 'WV2'
        GNyq = [0.35 .* ones(1,7), 0.27];
        flag_resize_new = 2;
    otherwise
        flag_resize_new = 1;
    end
    
    if (flag_resize_new==2)
        %%% Filtering with sensor MTF MS
        N = 41;
        fcut = 1 / ratio;

        nbandas = size(GNyq,2);
        psf = cell(nbandas,1);
        for ii = 1 : nbandas
            alpha = sqrt(((N-1)*(fcut/2))^2/(-2*log(GNyq(ii))));
            H = fspecial('gaussian', N, alpha);
            Hd = H./max(H(:));
            psf{ii} = fwind1(Hd,kaiser(N));
        end
    else
        psf = ones(ratio,ratio)/ratio/ratio;
        psf=padarray(psf,[ratio-1 ratio-1],0,'post');
    end
end

