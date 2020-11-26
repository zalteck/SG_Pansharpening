%% Wavelet Packets: Decomposing the Details
% In the orthogonal wavelet decomposition procedure, the generic step
% splits the approximation coefficients into two parts. After splitting we
% obtain a vector of approximation coefficients and a vector of detail
% coefficients, both at a coarser scale. The information lost between two
% successive approximations is captured in the detail coefficients. Then
% the next step consists of splitting the new approximation coefficient
% vector, successive details are never reanalyzed. 
%
% In the corresponding wavelet packet situation, each detail coefficient
% vector is also decomposed into two parts using the same approach as in
% approximation vector splitting. This offers the richest analysis. The
% complete binary tree is produced in the one-dimensional case or a
% quaternary tree in the two-dimensional case.

% Copyright 2006-2010 The MathWorks, Inc.

%% Wavelet Packets Decomposition
% A single decomposition using wavelet packets generates a large number of
% bases. Decompose a signal at depth 3 with db1 wavelet, using default
% entropy (shannon). 
load noisdopp; 
wpt = wpdec(noisdopp,3,'db1');
plot(wpt)
%% 
% Decompose the packet [3 0] and plot the modified wavelet packet tree
wpt = wpsplt(wpt,[3 0]);
plot(wpt) 
%%
% You can then look for the best representation with respect to a
% design objective, using the function *besttree* with an entropy function.
% The resulting tree may be much smaller than the initial one.
bt = besttree(wpt);
plot(bt)

%%
% You can change the node labels. Instead of *Depth_Position* labels you
% can use *Index* labels.
% Using the *Node Label* submenu, you can select the displayed labels.
openfig('wpdemo_fig_1.fig');

%%
% You can examine the data associated to each node clicking with the mouse
% on this node.
% In the next window, the data associated to the *node 2* is displayed.
% You can find the *coefficients of detail at level 1* in wavelet decomposition
% of the original signal.
openfig('wpdemo_fig_2.fig');
%%
% Using the *Node Action* submenu, you can select the type of action
% associated to each node. The default action is *Visualize*, you can
% choose *Split-Merge* to split or merge selected nodes. 
openfig('wpdemo_fig_3.fig');
 
%% Wavelet Packets for De-Noising
% In the wavelet packet framework, compression and de-noising ideas are
% identical to those developed in the wavelet framework. The only new
% feature is a more complete analysis that provides increased flexibility.
% Next you will de-noise a noisy chirp signal using of Stein's Unbiased
% Estimate of Risk (SURE) criterion threshold and you will compare wavelet
% packets-based and de-noising wavelet-based de-noising results.
load noischir; x = noischir;
n = length(x); 
thr = sqrt(2*log(n*log(n)/log(2))); % SURE criterion threshold
xwpd = wpdencmp(x,'s',4,'sym4','sure',thr,1); % Wavelet-packets-based de-noising
xwd = wden(x,'rigrsure','s','one',4,'sym4');  % Wavelet-based de-noising
%%
% Plot original and de-noised signals
subplot(311),plot(x), xlim([1 n])
title('Original Signal')
subplot(312),plot(xwpd), xlim([1 n])
title('De-noised Signal using Wavelet Packets')
subplot(313),plot(xwd), xlim([1 n])
title('De-noised Signal using Wavelets')

%% Wavelet Packets for Compression
% In this section, you employ wavelet packets to analyze and compress an
% image of a fingerprint. This is a real-world problem: the Federal Bureau
% of Investigation (FBI) maintains a large database of fingerprints. The
% FBI uses eight bits per pixel to define the shade of gray and stores 500
% pixels per inch, which works out to about 700 000 pixels and 0.7
% megabytes per finger to store finger prints in electronic form. By
% turning to wavelets, the FBI has achieved a 15:1 compression ratio. In
% this application, wavelet compression is better than the more traditional
% JPEG compression, as it avoids small square artifacts and is particularly
% well suited to detect discontinuities (lines) in the fingerprint. 
%
% Note that the international standard JPEG 2000 includes the wavelets
% as a part of the compression and quantization process. This points out
% the present strength of the wavelets.
load detfingr        
wname = 'bior6.8';
lev   = 3; 
sorh  = 'h'; 
crit  = 'shannon'; 
thr   = 30; 
keepapp = 1;
[xd,t,perf0,perfl2] = wpdencmp(X,sorh,lev,wname,crit,thr,keepapp);
%%
% Plot the wavelet packet best tree decomposition 
plot(t)
%%
% Plot original and compressed image
sm = size(map,1);
figure('Color','white');colormap(pink(sm))
image(wcodemat(X,sm));title('Original Image')
axis('square'); set(gca,'XTick',[],'YTick',[]);

figure('Color','white');colormap(pink(sm))
image(wcodemat(xd,sm));title('Compressed Image')
N2Str = ['Retained Energy: ',num2str(perfl2,'%5.2f'),' %'];
N0Str = ['Number of zeros: ',num2str(perf0,'%5.2f'),' %'];
xlabel({N2Str,N0Str});
axis('square'); set(gca,'XTick',[],'YTick',[]);


displayEndOfDemoMessage(mfilename)

