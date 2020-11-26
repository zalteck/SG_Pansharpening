%% Continuous and Discrete Wavelet Analysis
% These examples aim to show the difference between the discrete 
% wavelet transform (*DWT*) and the continuous wavelet transform (*CWT*).
%
% <<freqbrkcwtdwtex.png>> 

% Copyright 2006-2012 The MathWorks, Inc.

%% When is Continuous Analysis More Appropriate than Discrete Analysis? 
% To answer this, consider the related questions: Do you need to know all
% values of a continuous decomposition to reconstruct the signal exactly?
% Can you perform nonredundant analysis? When the energy of the signal is
% finite, not all values of a decomposition are needed to exactly
% reconstruct the original signal, provided that you are using a wavelet
% that satisfies some admissibility condition. Usual wavelets satisfy this
% condition. In this case, a continuous-time signal is characterized by
% the knowledge of the discrete transform. In such cases, discrete analysis
% is sufficient and continuous analysis is redundant. 

%% Example 1: Fractal Signal
% When a signal is recorded in continuous time or on a very fine time
% grid, both analyses are possible. Which should be used? It depends; each
% one has its own advantages. 
load vonkoch;
lv = 510;
signal = vonkoch(1:lv);
plot(signal,'r'); 
set(gca,'XLim',[1 length(signal)])
title('Analyzed signal');
xlabel('Time (or Space)')
ylabel('Amplitude')


%% Discrete Wavelet Transform (DWT)
% Discrete analysis ensures space-saving coding and is sufficient for exact
% reconstruction. Perform discrete wavelet transform at level 5 by sym2:
lev   = 5; 
wname = 'sym2';
nbcol = 64;
[c,l] = wavedec(signal,lev,wname);
%%
% Expand the discrete wavelet coefficients for visualization
len = length(signal);
cfd = zeros(lev,len);
for k = 1:lev
    d = detcoef(c,l,k);
    d = d(:)';
    d = d(ones(1,2^k),:);
    cfd(k,:) = wkeep1(d(:)',len);
end
cfd =  cfd(:);
I = find(abs(cfd)<sqrt(eps));
cfd(I) = zeros(size(I));
cfd = reshape(cfd,lev,len);
cfd = wcodemat(cfd,nbcol,'row');
%%
% Plot the discrete coefficients.
colormap(pink(nbcol));
image(cfd);
tics = 1:lev; 
labs = int2str((1:lev)');
set(gca,...
    'YTickLabelMode','manual','YDir','normal', ...
    'Box','On','YTick',tics,'YTickLabel',labs);
title('Discrete Wavelet Transform, Absolute Coefficients.');
xlabel('Time (or Space)')
ylabel('Level');


%% Continuous Wavelet Transform (CWT)
% Continuous analysis is often easier to interpret, since its redundancy
% tends to reinforce the traits and makes all information more visible.
% This is especially true of very subtle information. Thus, the analysis
% gains in "readability" and in ease of interpretation what it loses in
% terms of saving space. 
scales = (1:32); % Levels 1 to 5 correspond to scales 2, 4, 8, 16 and 32.
cwt(signal,scales,wname,'plot');
colormap(pink(nbcol));


%% Example 2: Frequency Break
% Let's do the same comparison on a second signal. The purpose of this
% example is to show how analysis by wavelets can detect the exact instant
% when a signal changes. The discontinuous signal consists of a slow sine
% wave abruptly followed by a medium sine wave.
load freqbrk; 
signal = freqbrk;
%% 
% Perform the discrete wavelet transform (DWT) at level 5 using db1.
lev   = 5;
wname = 'db1'; 
nbcol = 64; 
[c,l] = wavedec(signal,lev,wname);
%%
% Expand discrete wavelet coefficients for plot.
len = length(signal);
cfd = zeros(lev,len);
for k = 1:lev
    d = detcoef(c,l,k);
    d = d(:)';
    d = d(ones(1,2^k),:);
    cfd(k,:) = wkeep1(d(:)',len);
end
cfd =  cfd(:);
I = find(abs(cfd)<sqrt(eps));
cfd(I) = zeros(size(I));
cfd    = reshape(cfd,lev,len);
cfd = wcodemat(cfd,nbcol,'row');
%% 
% Perform the continuous wavelet transform (CWT) and visualize results
set(subplot(3,1,1),'XTick',[]);
plot(signal,'r'); 
title('Analyzed signal.');
set(gca,'XLim',[1 length(signal)])
subplot(3,1,2);
colormap(cool(128));
image(cfd);
tics = 1:lev; 
labs = int2str(tics');
set(gca,...
    'YTickLabelMode','manual','YDir','normal', ...
    'Box','On','YTick',tics,'YTickLabel',labs ...
    );
title('Discrete Transform, absolute coefficients.');
ylabel('Level');
set(subplot(3,1,2),'XTick',[]);
subplot(3,1,3);
scales = (1:32);
cwt(signal,scales,wname,'plot');
colormap(cool(128));
tt = get(gca,'YTickLabel');
[r,c] = size(tt);
yl = char(32*ones(r,c));
for k = 1:3:r , yl(k,:) = tt(k,:); end
set(gca,'YTickLabel',yl);
%%
% Here is a noteworthy example of an important advantage of wavelet
% analysis over Fourier. If the same signal had been analyzed by the
% Fourier transform, we would not have been able to detect the instant when
% the signal's frequency changed, whereas it is clearly observable here.


displayEndOfDemoMessage(mfilename)

