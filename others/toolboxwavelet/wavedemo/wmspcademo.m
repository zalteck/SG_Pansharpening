%% Multiscale Principal Components Analysis
% The purpose of this example is to show the features of multiscale principal
% components analysis (PCA) provided in the Wavelet Toolbox(TM).
%
% The aim of multiscale PCA is to reconstruct a simplified multivariate 
% signal, starting from a multivariate signal and using a simple
% representation at each resolution level. Multiscale principal components
% analysis generalizes the PCA of a multivariate signal represented as a
% matrix by simultaneously performing a PCA on the matrices of details of
% different levels. A PCA is also performed on the coarser approximation
% coefficients matrix in the wavelet domain as well as on the final
% reconstructed matrix. By selecting the numbers of retained principal
% components, interesting simplified signals can be reconstructed. This
% example uses a number of noisy test signals and performs the following
% steps. 

% Copyright 2007-2012 The MathWorks, Inc.

%% Load Multivariate Signal
%  Load the multivariate signal by typing the following at the MATLAB(R) prompt:
 load ex4mwden
 whos
%%
% Usually, only the matrix of data |x| is available. Here, we also have the
% true noise covariance matrix |covar| and the original signals |x_orig|. 
% These signals are noisy versions of simple combinations of the two
% original signals. The first signal is "Blocks" which is irregular, and
% the second one is "HeavySine" which is regular, except around time 750.
% The other two signals are the sum and the difference of the two original
% signals, respectively. Multivariate Gaussian white noise exhibiting
% strong spatial correlation is added to the resulting four signals, which
% produces the observed data stored in |x|.

%% Perform Simple Multiscale PCA
% Multiscale PCA combines noncentered PCA on approximations and details in
% the wavelet domain and a final PCA. At each level, the most significant
% principal components are selected.
%%
% First, set the wavelet parameters:
level = 5;
wname = 'sym4';
%%
% Then, automatically select the number of retained principal components
% using Kaiser's rule, which retains components associated with eigenvalues
% exceeding the mean of all eigenvalues, by typing:
npc = 'kais';
%%
% Finally, perform multiscale PCA:
[x_sim, qual, npc] = wmspca(x ,level, wname, npc); 

%% Display the Original and Simplified Signals
% To display the original and simplified signals type:
kp = 0;
for i = 1:4 
    subplot(4,2,kp+1), plot(x (:,i)); axis tight; 
    title(['Original signal ',num2str(i)])
    subplot(4,2,kp+2), plot(x_sim(:,i)); axis tight;
    title(['Simplified signal ',num2str(i)])
    kp = kp + 2;
end
%%
% We can see that the results from a compression perspective are good. The 
% percentages reflecting the quality of column reconstructions given by the
% relative mean square errors are close to 100%.
qual

%% Improve the First Result by Retaining Fewer Principal Components
% We can improve the results by suppressing noise, because the details at
% levels 1 to 3 are composed essentially of noise with small contributions
% from the signal. Removing the noise leads to a crude, but efficient,
% denoising effect.
%
% The output argument |npc| is the number of retained principal components
% selected by Kaiser's rule:
npc
%%
% For _d_ from 1 to 5, |npc|(_d_) is the number of retained noncentered 
% principal components (PCs) for details at level _d_. |npc|(6) is the
% number of retained non-centered PCs for approximations at level 5, and
% |npc| (7) is the number of retained PCs for final PCA after wavelet
% reconstruction. As expected, the rule keeps two principal components,
% both for the PCA approximations and the final PCA, but one principal
% component is kept for details at each level.
%
% To suppress the details at levels 1 to 3, update the |npc| argument as
% follows:
npc(1:3) = zeros(1,3);
npc
%%
% Then, perform multiscale PCA again by typing:
[x_sim, qual, npc] = wmspca(x, level, wname, npc); 

%% Display the Original and Final Simplified Signals
% To display the original and final simplified signals type:
kp = 0;
for i = 1:4 
    subplot(4,2,kp+1), plot(x (:,i)); axis tight;
    title(['Original signal ',num2str(i)])
    subplot(4,2,kp+2), plot(x_sim(:,i)); axis tight; 
    title(['Simplified signal ',num2str(i)])
    kp = kp + 2;
end
%%
% As we can see above, the results are improved.

%% More about Multiscale Principal Components Analysis
% More about multiscale PCA, including some theory, simulations and real
% examples, can be found in the following reference:
% 
% Aminghafari, M.; Cheze, N.; Poggi, J-M. (2006), "Multivariate denoising
% using wavelets and principal component analysis," Computational
% Statistics & Data Analysis, 50, pp. 2381-2398.


displayEndOfDemoMessage(mfilename)

