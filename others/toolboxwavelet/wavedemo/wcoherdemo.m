%% Wavelet Coherence
% The continuous wavelet transform (CWT) allows you to analyze the temporal
% evolution of the frequency content of a given signal or time series. The
% application of the CWT to two time series and the cross examination of
% the two decompositions can reveal localized similarities in time and
% scale. Areas in the time-frequency plane where two time series exhibit
% common power or consistent phase behavior indicate a relationship between
% the signals.
%
% For jointly stationary time series, the cross spectrum and associated
% coherence function based on the Fourier transform are key tools for
% detecting common behavior in frequency. In the general nonstationary
% case, wavelet-based counterparts can be defined to provide time-localized
% alternatives. The |wcoher.m| function provides these wavelet-based
% estimators. The purpose of this example is to understand how to use |wcoher.m| 
% and interpret the results.
%
% In all of the following examples, complex-valued wavelets are used.
% When a complex wavelet is used, the CWT, Cx(a,b), of a real-valued
% time series, x, is a complex-valued function of the scale parameter
% a and the location parameter b.

% Copyright 2010-2012 The MathWorks, Inc.
% $Revision: 1.1.6.4 $  $Date: 2012/05/04 00:20:35 $

%% Example 1: Two Sine Waves in Gaussian Noise
% The first example introduces the different graphical representations
% provided by the |wcoher.m| function. The example also highlights the
% usefulness of the phase information obtained from using complex-valued
% wavelets.
% 
% Consider two sine functions on the interval [0,1] using 2048 points. Both
% sine functions have a frequency of 8 Hz. One of the functions has an
% initial phase offset of pi/4 radians. Both sine functions are corrupted
% by additive zero-mean Gaussian noise with a variance of 0.5. Consider the
% CWT of the two signals (denoted by x and y) using the cgau3 complex
% wavelet for integer scales from 1 to 512.
%
wname  = 'cgau2';
scales = 1:512;
ntw = 21;
t  = linspace(0,1,2048);
x = sin(16*pi*t)+0.25*randn(size(t));
y = sin(16*pi*t+pi/4)+0.25*randn(size(t));
wcoher(x,y,scales,wname,'ntw',ntw,'plot','cwt');

%%
% The common period of the signals at scale 128 is clearly detected in the
% moduli of the individual wavelet spectra. Using 
Freq = scal2frq(128,'cgau3',1/2048);
%%
% note that	this corresponds to a frequency of 8 Hz, which is equivalent to
% (1/8)*2048 = 256 	samples per period with the given sampling frequency.
%
% The wavelet spectrum, defined for each signal, is characterized by the
% modulus and the phase of the CWT obtained using the complex-valued
% wavelet. Denote the individual wavelet spectra as Cx(a,b) and Cy(a,b).
% The two decompositions are exactly the same, up to a translation, since
% the CWT is translation-invariant. To examine the relationship between the
% two signals in the time-scale plane, consider the wavelet cross spectrum
% Cxy(a,b), which is defined as
%
% $$ Cxy(a,b){\rm{ }} = {\rm{ }} \overline {Cx(a,b)} {Cy(a,b)} $$
%
% where $$ \bar z $$ denotes the complex conjugate of $$ z $$.  A smoothed
% version of this function is depicted in the following figure.
%
wcoher(x,y,scales,wname,'ntw',ntw,'plot','wcs');

%%
% The magnitude of the wavelet cross spectrum can be interpreted as the
% absolute value of the local covariance between the two time series in the
% time-scale plane. In this example, this nonnormalized quantity highlights
% the fact that both signals have a significant contribution around scale 128 
% at all positions.
%
% The next figure displays the wavelet coherence and is the most important.
% The empirical wavelet coherence for x and y is defined as the ratio:
%
% $$ 
%  S(Cxy(a,b))/\sqrt{S( |Cx(a,b)|^2)}\sqrt{S(|Cy(a,b)|^2)}
% $$
%
% where S stands for a smoothing operator in time and scale. The wavelet
% coherence can be interpreted as the local squared correlation coefficient
% in the time-scale plane.
wcoher(x,y,scales,wname,'ntw',ntw,'plot');

%%
% The arrows in the figure represent the relative phase between the two
% signals as a function of scale and position. The relative phase
% information is obtained from the smoothed estimate of the wavelet cross
% spectrum, S(Cxy(a,b)). The plot of the relative phases is superimposed on
% the wavelet coherence. The relative phase information produces a local
% measure of the delay between the two time series. Note that for scales
% around 128, the direction of the arrows captures the relative phase
% difference between the two signals of pi/4 radians.
%
% Now consider an example involving transient behavior and a
% more subtle relationship between two time series.

%% Example 2: Sine and Doppler Signal
% A 4-Hz sine wave with additive Gaussian noise is sampled on a grid of
% 1024 points over the interval [0,1]. The second time series is a Doppler
% signal with decreasing frequency over time. Consider the CWT of the two
% signals (denoted by x and y ) using the cgau3 complex wavelet for integer
% scales from 1 to 512.
wname  = 'cgau2';
scales = 1:512;
ntw = 21;
t = linspace(0,1,1024);
x = -sin(8*pi*t) + 0.4*randn(1,1024);
x = x/max(abs(x));
y = wnoise('doppler',10);
wcoher(x,y,scales,wname,'ntw',ntw,'plot','cwt');

%%
% The analysis of the sine function on the left exhibits the scale
% associated with the period (which is equal to 1024/8 = 128). The analysis
% of the Doppler signal highlights a typical time-scale picture
% illustrating the decreasing frequency (increasing scale) as a function of
% time. The wavelet cross spectrum is shown in the following figure.
wcoher(x,y,scales,wname,'ntw',ntw,'nsw',1,'plot','wcs');

%%
% The magnitude is the more instructive and shows the similarity of
% the local frequency behavior of the two time series in the time-scale
% plane. Both signals have a similar contribution around scale 128 over the
% interval [300, 700]. This is consistent with the behavior observed by
% visual inspection of the time-domain plot. Additional interesting
% information is discernible in the wavelet coherence.
wcoher(x,y,scales,wname,'ntw',ntw,'plot');

%%
% The phase information can be interpreted by locating different regions of
% the time-scale plane and highlighting some coherent behaviors. Some
% transient minor contributions to the variability of the time series occur
% at small scales at the beginning of the Doppler signal, which exhibits
% rapid oscillations. The behavior is not coherent and the phase changes
% very quickly.  However, at positions greater than 150 and scales greater
% than 130, numerous coherent regions can be easily detected, delimited by
% the stability of the phase information. Because phase information is so
% useful in determining coherent behavior, another representation tool is
% available for focusing on the phase. The phase information is coded both
% by the arrow, or vector, orientation and by the background color. The
% background color  is associated with a mapping onto the interval
% [-pi,pi].
wcoher(x,y,scales,wname,'ntw',ntw,'plot','wcoh');

%% Example 3: Detection of System Anomaly Using Wavelet Coherence
% The data analyzed in this example were generously provided by the oil
% company Total. The two signals, sensor1 and sensor2, were recorded at two
% different spatial locations. A quasi-periodic signal appearing at both
% sensors indicates a system anomaly. While it is possible to detect the
% oscillatory behavior by examining data recorded at an individual sensor,
% analyzing the joint time-scale variations in the sampled input at two
% spatially-separated sensors results in a reduction in the false positive
% rate. Prior studies using the complex Morlet wavelet show that the
% spurious signal evolves around scale 15. This example uses
% the complex Morlet wavelet cmor1-3 and the scales 1:0.1:50.
scales = 1:0.1:50;
wname  = 'cmor1-3';
load sensor1; load sensor2
long  = 4000;
first = 5000;
last  = first + long-1;
indices = (first:last);
s1 = sensor1(indices);
s2 = sensor2(indices);
wcoher(s1,s2,scales,wname,'ntw',ntw,'plot','cwt');

%%
% The figure shows both CWT decompositions. The data from sensor1 is to the
% left, and the data from sensor2 to the right. The middle figure panels
% contain plots of the individual CWT moduli for sensor1 and sensor2. Both
% CWT moduli plots reveal strong components around scale 16 over
% approximately the first 2000 points. Both the scale and positions of the
% components show good agreement at the two spatially-separated
% sensors. The next step shows the wavelet cross spectrum.
wcoher(s1,s2,scales,wname,'ntw',ntw,'plot','wcs');

%%
% The modulus of the wavelet cross spectrum clearly shows a strong
% component around scale 16. The magnitude of the component increases and
% decreases over time, but is generally strong for approximately the first
% 2500 points of the signals. Finally, computing the wavelet coherence
% and superimposing the phase of the smoothed wavelet cross spectrum
% shows that data from the two sensors exhibit coherence near 1 and
% approximately constant relative phase at the scales of interest.
ntw = 51;   % N-point time window 
nts = 10;   % N-point scale window
nat = 50;   % number of arrows in time
nas = 20;   % number of arrows in scale
asc = 0.75; % scale factor  for the arrows (see QUIVER).
wcoher(s1,s2,scales,wname,'nat',nat,'nas',nas, ...
    'ntw',ntw,'nts',nts,'asc',asc,'plot');
%%
% Coding the background color in the coherence plot for phase highlights
% the consistent relative phase behavior at the two sensors at the scales
% of interest.
wcoher(s1,s2,scales,wname,'nat',nat,'nas',nas, ...
    'ntw',ntw,'nts',nts,'asc',asc,'plot','wcoh');
%%
% Wavelet coherence analysis greatly facilitates the detection of the
% quasi-periodic component indicative of a system anomaly. The use of other
% wavelets ( cgaus2 or cmor1.5 ) does not alter these conclusions, but the
% precise localization in scale of the critical phenomenon naturally
% changes depending on the analyzing wavelet.

%% Summary
% This example has shown you how to use wavelet cross spectrum and wavelet
% coherence to reveal localized similarities between two time series in the
% time-scale plane and to interpret the results. 

displayEndOfDemoMessage(mfilename)
