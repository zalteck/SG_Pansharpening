%% Non-Decimated Wavelet Analysis
% This example shows you how to decompose a signal or an image using
% non-decimated wavelet analysis.
%
% This kind of redundant, translation-invariant transform is especially 
% useful for denoising, which is one of the most important wavelet
% applications. This type of analysis has already been developed for
% stationary wavelet transform (SWT) functions (1-D stationary wavelet
% functions) and the SWT GUI. This transform however has a serious
% limitation: the signal length must be a power of 2 and the periodized
% extension mode must be used for the underlying DWT.
%
% Wavelet Toolbox(TM) provides a new tool for handling such transforms for
% signals (or images) of arbitrary size and using different extension
% modes.

% Copyright 2009-2012 The MathWorks, Inc.

%% Load Original Signal
load noisbloc;
L = length(noisbloc)
plot(noisbloc,'r')
axis tight
title('Original Signal')

%%
% The loaded signal is of length 1024, so you can use the SWT functions
% to decompose it. 
% We now truncate the loaded signal and keep only 979 samples, which is not
% a power of 2 (blue line in the plot below).
nkeep = 979;
sig = noisbloc(1:nkeep);
hold on
plot(sig,'b')
title('Original and Truncated Signals')

%% Multilevel 1-D Non-Decimated Wavelet Decomposition
% 
% Perform non-decimated wavelet decomposition of |sig| at level |5| using
% the |haar| wavelet.
n = 5;                  % Decomposition level 
w = 'db1';              % Haar wavelet
WT = ndwt(sig,n,w)      % Multilevel 1-D wavelet decomposition.

%%
% The function |NDWT| returns a structure containing the parameters of the
% non-decimated transform.
%%
% Filters associated with the wavelet:
WT.filters

%%
% The decomposition is organized in sequences of coefficients according to
% the level and nature of the signal (approximation or detail).
% The coefficients are concatenated and are given by |WT.dec| which is
% equal to |[Ca(N) Cd(N) Cd(N-1) ... Cd(1)]|:
WT.dec

%%
% The lengths of the coefficient sequences and of the original signal are
% given by |WT.longs|:
WT.longs

%%
% And finally, the discrete wavelet transform extension mode is
WT.mode

%% Multilevel 1-D Non-Decimated Wavelet Reconstruction
% Starting from a decomposition, we can construct all the components
% (approximations and details) useful for analysis: 
A = cell(1,n);
D = cell(1,n);
for k = 1:n
    A{k} = indwt(WT,'a',k);   % Approximations (low-pass components)
    D{k} = indwt(WT,'d',k);   % Details (high-pass components)
end

%%
% To denoise or process the signal, you can modify the coefficients before
% reconstruction, for example, by thresholding it. 
%
% We now concentrate on the capabilities of the non-decimated transform. We
% first check that if the coefficients are unchanged, the reconstructions
% are perfect, i.e. |sig = A(k) + D(k) + ... + D(1)|.
err = zeros(1,n);
for k = 1:n
    E = sig-A{k};
    for j = 1:k
        E = E-D{j};
    end
    err(k) = max(abs(E(:)));
end
disp(err)

%%
% Next we illustrate graphically two different decompositions of the
% original signal: approximation and detail at level 1 and approximation at
% level 5, plus the sum of the details of level 1 to 5.
for k = [1 5]
    figure('Color','w')
    subplot(2,1,1);   
    plot(A{k},'b'); axis tight; xlabel(['A' int2str(k)])
    subplot(2,1,2); 
    plot(sig-A{k},'g'); axis tight;
    xlabel(['Sum of Details from 1 to ' int2str(k)])
end
clear A D E err

%%
% Starting from a different initial signal, we can show the effect of
% changing the extension mode.
load noissin;
% Truncate the signal
x = noissin(1:512);  
wname = 'sym4';
level = 5;
% Consider the decompositions obtained using two different extension modes:
W1 = ndwt(x,level,wname,'mode','zpd'),  % Zero padding
W2 = ndwt(x,level,wname,'mode','per'),  % Periodization 

A5_W1 = indwt(W1,'a',level);
A5_W2 = indwt(W2,'a',level);
%%
% The approximations are very similar, with the differences appearing at
% the beginning and the end of these approximations.
figure('Color','w')
subplot(3,1,1); plot(A5_W1,'r'); axis tight; title('A5 - Zero padding');
subplot(3,1,2); plot(A5_W2,'b'); axis tight; title('A5 - Periodization'); 
subplot(3,1,3); plot(A5_W1-A5_W2,'m','LineWidth',2); axis tight; 
xlabel('Diffence between the approximations');

%% Load Original Image and Select a ROI
% Now we illustrate the 2-D counterparts of the previous capabilities, with
% fewer details.
%%
% Load original image. 
load noiswom;   
S = size(X)

%%
% Select a ROI, the size of which is not a power of 2. 
X = X(2:94,2:94);  
sX = size(X)

%%
% Display the original image. 
figure('Color','w')
map = pink(255);
image(X)
colormap(map)
axis tight
title('Original Image')

%% Multilevel 2-D Non-Decimated Wavelet Decomposition
% Perform non-decimated wavelet decomposition of signal X at level 4 using
% the haar wavelet.
n = 4;                   % Decomposition Level 
w = 'db1';               % Haar wavelet
WT = ndwt2(X,n,w)        % Multilevel 2-D wavelet decomposition.

%% Multilevel 2-D Non-Decimated Wavelet Coefficients
% Extract the resulting family of coefficients from the wavelet
% decomposition
cAA = cell(1,n);
cAD = cell(1,n);
cDA = cell(1,n);
cDD = cell(1,n);
for k = 1:n
    cAA{k} = indwt2(WT,'caa',k);   % Coefficients of approximations
    cAD{k} = indwt2(WT,'cad',k);   % Coefficients of horizontal details
    cDA{k} = indwt2(WT,'cda',k);   % Coefficients of vertical details
    cDD{k} = indwt2(WT,'cdd',k);   % Coefficients of diagonal details
end
%% 
% Display the resulting family of coefficients 
figure('DefaultAxesXTick',[],'DefaultAxesYTick',[],'Color','w')
colormap(map)
for k = 1:n
    subplot(4,n,k);
    imagesc(cAA{k}); xlabel(['cAA' int2str(k)])
    subplot(4,n,k+n);
    imagesc(abs(cAD{k})); xlabel(['cAD' int2str(k)])
    subplot(4,n,k+2*n);
    imagesc(abs(cDA{k})); xlabel(['cDA' int2str(k)])
    subplot(4,n,k+3*n);
    imagesc(abs(cDD{k})); xlabel(['cDD' int2str(k)])
end

%% Multilevel 2-D Non-Decimated Wavelet Reconstruction
%
A = cell(1,n);
D = cell(1,n);
for k = 1:n
    A{k} = indwt2(WT,'a',k);   % Approximations (low-pass components)
    D{k} = indwt2(WT,'d',k);   % Details (high-pass components)
end

% We now check that without changing the coefficients, the various
% reconstructions are perfect.
err = zeros(1,n);
for k = 1:n
    E = X-A{k}-D{k};
    err(k) = max(abs(E(:)));
end
disp(err)

%%
figure('DefaultAxesXTick',[],'DefaultAxesYTick',[],'Color','w')
colormap(map)
for k = 1:n
    subplot(2,n,k);   
    imagesc(A{k}); xlabel(['A' int2str(k)])
    subplot(2,n,k+n); 
    imagesc(abs(D{k})); xlabel(['Det' int2str(k)])
end
clear D E err

%%
figure('DefaultAxesXTick',[],'DefaultAxesYTick',[],'Color','w')
colormap(map)
subplot(1,2,1);
image(X)
title('Original Image')
subplot(1,2,2);
image(A{1})
title('Denoised Image - A1')

%%
% Consider the approximations at level 1 obtained using three different
% extension modes. These approximations are rough denoised images.
WT = ndwt2(X,1,w,'mode','per');   % Multilevel 2-D wavelet decomposition.
A{1} = indwt2(WT,'a',1);
WT = ndwt2(X,1,w,'mode','sym');   % Multilevel 2-D wavelet decomposition.
A{2} = indwt2(WT,'a',1);
WT = ndwt2(X,1,w,'mode','zpd');   % Multilevel 2-D wavelet decomposition.
A{3} = indwt2(WT,'a',1);

%%
% As expected, the approximations are very similar, with the differences 
% concentrated on the edge.
figure('DefaultAxesXTick',[],'DefaultAxesYTick',[],'Color','w')
colormap(map)
subplot(2,3,2);
image(X)
title('Original Image')
subplot(2,3,4);
image(A{1})
xlabel('A1 - PER')
subplot(2,3,5);
image(A{2})
title('Denoised Images')
xlabel('A1 - SYM')
subplot(2,3,6);
image(A{3})
xlabel('A1 - ZPD')

%% Summary
% This example showed how the 1-D and 2-D Non-Decimated Wavelet transform 
% allows you to process signals or images of any size using any mode of 
% extension for the decomposition.
displayEndOfDemoMessage(mfilename)

