%% Signal Reconstruction from Continuous Wavelet Transform Coefficients 
% The continuous wavelet transform (CWT) allows you to analyze the temporal
% evolution of the frequency content of a signal or time series. The CWT
% can be used to detect time-localized events and scale-localized
% components. When the Fourier transform of a wavelet satisfies certain
% properties, it is possible to invert the CWT by integrating only over
% scales. Accordingly, Fourier transform based CWT and inverse CWT
% algorithms with select wavelets enable you to reconstruct a time and
% scale-localized approximation to a signal.

% Copyright 2012-2013 The MathWorks, Inc.

%% Step 1: Detection of System Anomaly Using the CWT 
% The data analyzed in this example were generously provided by the oil
% company Total. These data are also used in the wavelet coherence example. 
% In that example, the wavelet coherence between signals recorded at different
% sensor locations enables you to detect a system anomaly indicated by the
% appearance of an oscillatory component. Since it is possible to detect
% this component by examining data recorded at an individual sensor, we
% restrict our attention here to the signal at sensor 1. Analyzing the time
% series recorded at sensor 1 with the CWT reveals the quasi-periodic
% signal indicative of a system anomaly.

% Define the signal to analyze.
clear
load sensor1; 
long  = 4000;
first = 5000;
last  = first + long-1;
indices = (first:last);
dt = 1;
signal = sensor1(indices);
s1{1} = signal;
s1{2} = dt;

%%
% Obtain the CWT over scales 1 to 50 in 0.1 increments using the analytic
% Morlet wavelet, |'morl'|. With the bandwidth and center frequency
% settings used in the wavelet coherence example, the oscillatory behavior in
% the sensor data was observed at approximately scale 15. This scale
% translates approximately to scale 6 with the analytic Morlet wavelet used
% here. Define the parameters and perform the CWT analysis.
scales = 1:0.1:50;
wname  = 'morl';
par    = 6;
WAV    = {wname,par};
cwt_s1_lin = cwtft(s1,'scales',scales,'wavelet',WAV,'plot');

%%
% The figure shows the CWT decomposition. The middle figure panel in the
% left column contains a plot of the CWT moduli revealing strong components
% around scale 6 over approximately the first 2000 points.
%  
% Another way to compute the CWT coefficients is to use the
% logarithmically-spaced scales provided by the default values.
cwt_s1_pow = cwtft(s1,'plot');

%%
% The output |cwt_s1_pow| is a structure array which contains six fields:
% the CWT coefficients (|cfs|), the vector of scales, the angular
% frequencies used in the Fourier transform in radians/sample (|omega|),
% the mean of the signal (|meanSIG|), the sampling period (|dt|), and the
% wavelet (|wav|). You can use |icwtft| to reconstruct the original signal
% based on the CWT coefficients.

rec_s1_pow = icwtft(cwt_s1_pow);
%%
% Utilizing a subset of the CWT coefficients, you can reconstruct an
% approximation to the original signal. The next example illustrates this
% for the oscillatory component in the sensor 1 data. As a preliminary
% step, determine the scale containing the greatest percentage of the
% signal energy.

% Compute the energy distribution over scales.
cfs = cwt_s1_lin.cfs;
energy = sum(abs(cfs),2);
percentage = 100*energy/sum(energy);

% Detect the scale of greatest energy.
[maxpercent,maxScaleIDX] = max(percentage)
figure;
plot(percentage,'.-r'); hold on; 
plot(maxScaleIDX,maxpercent,'.k','Markersize',20)
xlabel('Indices of Scales')
ylabel('Percentage of energy');
axis tight
grid

% The scale of greatest energy is given by:
scaMaxEner = scales(maxScaleIDX)

%% Step 2: Reconstruction of System Anomaly Signature in the Time Domain
% An interesting use of the analysis-reconstruction process involves
% modifying the wavelet coefficients between analysis and reconstruction.
% This is routinely done for denoising or compression applications using
% the discrete wavelet transform. Because the Fourier transform based CWT
% enables us to efficiently implement an inverse transform, it is possible
% to extend this selective reconstruction to the CWT. Using this technique,
% we can obtain a clearer picture of the system anomaly.
cwt_anomaly = cwt_s1_pow;

% Find the index of logarithmic scale detecting the anomaly.
[valMin,anomaly_index_scales] = min(abs(cwt_s1_pow.scales-scaMaxEner))

%%
anomaly_cfs = cwt_s1_pow.cfs(anomaly_index_scales,:);
newCFS = zeros(size(cwt_s1_pow.cfs));
newCFS(anomaly_index_scales,:) = anomaly_cfs;
cwt_anomaly.cfs = newCFS;

% Reconstruction from the modified structure.
anomaly = icwtft(cwt_anomaly,'plot','signal',s1);

%%
% In this example only the reconstructed signal is of interest. Plots of
% the CWT coefficients are not informative because only a single scale
% contains nonzero coefficients. To obtain a better view of the anomaly,
% you can perform a horizontal zoom for all axes of the figure.
ax = findobj(gcf,'type','axes','tag','');
set(ax,'Xlim',[250 500]);

%%
% The selective reconstruction process may be done more directly using the
% IdxSc name-value pair in the |icwtft| function.
icwtft(cwt_anomaly,'plot','signal',s1,'IdxSc',anomaly_index_scales);
ax = findobj(gcf,'type','axes','tag','');
set(ax,'Xlim',[250 500]);

%% Step 3: A Second Reconstruction of System Anomaly Signature 
% Continuous wavelet analysis greatly facilitates the detection of the
% quasi-periodic component indicative of a system anomaly. In addition, the
% inverse CWT algorithm enables you to reconstruct a time and
% scale-localized approximation to the component based on selected
% coefficients. The Fourier transform based CWT and inverse CWT algorithms
% for logarithmic scales are described in Torrence & Compo, 1998. Sun, 2010
% proposes an inversion formula for linearly-spaced scales. The algorithm
% with linearly-spaced scales is less efficient than its
% logarithmically-spaced counterpart because more scales are required for
% an accurate reconstruction. Nevertheless, this algorithm is
% experimentally useful and complements the algorithm with
% logarithmically-spaced scales. To end this example, we illustrate the use of
% selective linearly-spaced scales for signal approximation.

% First step for building the new structure corresponding to the anomaly.
cwt_anomaly = cwt_s1_lin;

% Choose a vector of scales centered on the most energetic scale.
dScale = 5;
anomaly_index_scales = (maxScaleIDX-dScale:maxScaleIDX+dScale);
anomaly_cfs = cwt_s1_lin.cfs(anomaly_index_scales,:);
newCFS = zeros(size(cwt_s1_lin.cfs));
newCFS(anomaly_index_scales,:) = anomaly_cfs;
cwt_anomaly.cfs = newCFS;

% Reconstruction from the modified structure.
anomaly = icwtlin(cwt_anomaly,'plot');

%%
% To get a better view of the anomaly, you can perform a horizontal zoom
% for all axes of the figure.
ax = findobj(gcf,'type','axes','tag','');
set(ax,'Xlim',[250 500]);

%%
% The selective reconstruction process may be done more directly using the 
% IdxSc name-value pair in the |icwtlin| function.
icwtlin(cwt_anomaly,'plot','signal',s1,'IdxSc',anomaly_index_scales);
ax = findobj(gcf,'type','axes','tag','');
set(ax,'Xlim',[250 500]);

%% Summary
% This example shows how to use continuous wavelet analysis to detect time and
% scale-localized components in the time-scale plane. Using Fourier
% transform based continuous wavelet transform (CWT) and inverse CWT
% algorithms, the example illustrates how to reconstruct a signal
% approximation based on scales identified in the analysis.

%% References
% # Torrence, C. & Compo, G.C. _A Practical Guide to Wavelet Analysis_,
% Bull. Am. Meteorol. Soc., 79, 61-78, 1998.
% # Sun, W. _Convergence of Morlet's Reconstruction Formula_, Preprint, 2010.

displayEndOfDemoMessage(mfilename)
