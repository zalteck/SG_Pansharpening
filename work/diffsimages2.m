% diffsimages2 script gets Fig.5 & 6 absolute error images in Pérez-Bueno2020 paper

load('Sensors/data/NL_subset.mat')
load('Sensors/results/NL_subset_SGME_l1_0_0_0_.mat')
Idiff = abs(I_GT - I_lp);
fact = 255 * max(Idiff(:)) / max(I_GT(:));
IMN = showImage8B432(fact*Idiff,1,0,0,0,11);
ind = find(isnan(IMN));
IMN(ind) = 0.0;
imwrite(im2uint8(64*IMN+1,'indexed'),'someImages/NL_subsetIdiff_lp.png')
Icrop = IMN(1371:1626,1211:1466,:);
imwrite(im2uint8(64*Icrop+1,'indexed'),'someImages/NL_subsetIdiff_lpcr.png')

load('Sensors/data/NL_subset.mat')
load('Sensors/results/NL_subset_MTF_GLP_CBD.mat')
Idiff = abs(I_GT - I_MTF_GLP_CBD);
IMN = showImage8B432(fact*Idiff,1,0,0,0,11);
ind = find(isnan(IMN));
IMN(ind) = 0.0;
imwrite(im2uint8(64*IMN+1,'indexed'),'someImages/NL_subsetIdiff_MTF_GLP_CBD.png')
Icrop = IMN(1371:1626,1211:1466,:);
imwrite(im2uint8(64*Icrop+1,'indexed'),'someImages/NL_subsetIdiff_MTF_GLP_CBDcr.png')

load('Sensors/data/NL_subset.mat')
load('Sensors/results/NL_subset_PRACS.mat')
Idiff = abs(I_GT - I_PRACS);
IMN = showImage8B432(fact*Idiff,1,0,0,0,11);
ind = find(isnan(IMN));
IMN(ind) = 0.0;
imwrite(im2uint8(64*IMN+1,'indexed'),'someImages/NL_subsetIdiff_PRACS.png')
Icrop = IMN(1371:1626,1211:1466,:);
imwrite(im2uint8(64*Icrop+1,'indexed'),'someImages/NL_subsetIdiff_PRACScr.png')

load('Sensors/data/NL_subset.mat')
load('Sensors/results/NL_subset_SGME_log_0_0_.mat')
Idiff = abs(I_GT - I_log);
IMN = showImage8B432(fact*Idiff,1,0,0,0,11);
ind = find(isnan(IMN));
IMN(ind) = 0.0;;
imwrite(im2uint8(64*IMN+1,'indexed'),'someImages/NL_subsetIdiff_log.png')
Icrop = IMN(1371:1626,1211:1466,:);
imwrite(im2uint8(64*Icrop+1,'indexed'),'someImages/NL_subsetIdiff_logcr.png')

load('Sensors/data/NL_subset.mat')
load('Sensors/results/NL_subset_TVME_0_8_.mat')
Idiff = abs(I_GT - I_TV);
IMN = showImage8B432(fact*Idiff,1,0,0,0,11);
ind = find(isnan(IMN));
IMN(ind) = 0.0;
imwrite(im2uint8(64*IMN+1,'indexed'),'someImages/NL_subsetIdiff_TV.png')
Icrop = IMN(1371:1626,1211:1466,:);
imwrite(im2uint8(64*Icrop+1,'indexed'),'someImages/NL_subsetIdiff_TVcr.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('Sensors/data/NL_clouds.mat')
load('Sensors/results/NL_clouds_PRACS.mat')
Idiff = abs(I_GT - I_PRACS);
fact = 255 * max(Idiff(:)) / max(I_GT(:));
IMN = showImage8B432(fact*Idiff,1,0,0,0,11);
ind = find(isnan(IMN));
IMN(ind) = 0.0;
imwrite(im2uint8(64*IMN+1,'indexed'),'someImages/NL_cloudsIdiff_PRACS.png')


load('Sensors/data/NL_clouds.mat')
load('Sensors/results/NL_clouds_MTF_GLP_CBD.mat')
Idiff = abs(I_GT - I_MTF_GLP_CBD);
IMN = showImage8B432(fact*Idiff,1,0,0,0,11);
ind = find(isnan(IMN));
IMN(ind) = 0.0;
imwrite(im2uint8(64*IMN+1,'indexed'),'someImages/NL_cloudsIdiff_MTF_GLP_CBD.png')

load('Sensors/data/NL_clouds.mat')
load('Sensors/results/NL_clouds_SGME_l1_0_0_0_.mat')
Idiff = abs(I_GT - I_lp);
IMN = showImage8B432(fact*Idiff,1,0,0,0,11);
ind = find(isnan(IMN));
IMN(ind) = 0.0;
imwrite(im2uint8(64*IMN+1,'indexed'),'someImages/NL_cloudsIdiff_lp.png')

load('Sensors/data/NL_clouds.mat')
load('Sensors/results/NL_clouds_SGME_log_0_0_.mat')
Idiff = abs(I_GT - I_log);
IMN = showImage8B432(fact*Idiff,1,0,0,0,11);
ind = find(isnan(IMN));
IMN(ind) = 0.0;
imwrite(im2uint8(64*IMN+1,'indexed'),'someImages/NL_cloudsIdiff_log.png')

load('Sensors/data/NL_clouds.mat')
load('Sensors/results/NL_clouds_TVME_0_8_.mat')
Idiff = abs(I_GT - I_TV);
IMN = showImage8B432(fact*Idiff,1,0,0,0,11);
ind = find(isnan(IMN));
IMN(ind) = 0.0;
imwrite(im2uint8(64*IMN+1,'indexed'),'someImages/NL_cloudsIdiff_TV.png')