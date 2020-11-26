%% Wavelet Scalogram Using 1D Wavelet Analysis
% This example shows how to obtain spectral information of a signal using
% continuous wavelet transform analysis. Signal Processing Toolbox(TM) is
% needed to run the example.
%%
% The tools best suited for a spectral analysis of signals are those
% based on the FFT. While wavelets are not specifically designed for  
% spectral analysis, we can recover some spectral information using
% wavelet analysis.
%%
% In this example, we perform both Fourier analysis and wavelet analysis 
% of various elementary periodic signals. Then, we compare the 
% spectral information found in each of them.

% Copyright 2008-2012 The MathWorks, Inc.

%% Analysis of an Elementary Periodic Signal
%
% Define a very simple periodic signal, such as a sine signal with
% frequency of *Frq = 10*.
Fs = 1000; 
t  = 0:1/Fs:1;
Frq = 10;
x =  sin(2*pi*t*Frq);
plot(x,'r'); axis tight
title('Signal');
xlabel('Time or Space')

%%
% Compute the power spectral density (PSD) estimate using spectral 
% estimation of the signal. Then, we find the main frequency by looking at 
% the spectral density and locating the frequency at which the PSD
% reaches its maximum.
h = spectrum.welch;
Hpsd = psd(h,x,'Fs',Fs);
hLIN = plot(Hpsd);
xdata = get(hLIN,'XData');
ydata = get(hLIN,'ydata');
[dummy,idxMax] = max(ydata);
FreqMax = xdata(idxMax)
hold on
ylim = get(gca,'YLim');
plot([FreqMax,FreqMax],ylim,'m--')

%%
% This result is an approximate value of the "true frequency."
%

%%
% Now, we compute the continuous wavelet transform using the *gaus4* wavelet 
% and we will see where to find spectral information.
wname = 'gaus4';
scales = 1:1:128;
coefs = cwt(x,scales,wname);

%%
% Using the function |scal2freq|, we can compute the correspondence table 
% of scales and frequencies. This table depends on the selected
% wavelet. We search the scale that corresponds to the frequency
% *Frq* used to design the signal.
TAB_Sca2Frq = scal2frq(scales,wname,1/Fs);
clf;
plot(TAB_Sca2Frq); axis tight; grid
hold on
plot([scales(1),scales(end)],[Frq Frq],'m--')
set(gca,'YLim',[0 100])
title('Correspondence Table of Scales and Frequencies');
xlabel('Scale')
ylabel('Frequency')


%%
% We find the scale *Sca* corresponding to the frequency *Frq* for the 
% wavelet *gaus4*.
[~,idxSca] = min(abs(TAB_Sca2Frq-Frq));
Sca = scales(idxSca)

%%
% Now, we use continuous wavelet analysis to compute the scalogram 
% of wavelet coefficients using the wavelet *gaus4*. Plot this scalogram 
% and an horizontal line corresponding to the scale *Sca* associated 
% with the frequency *Frq*. We can see that this line connects 
% the maxima of energy in the scalogram.
wscalogram('image',coefs,'scales',scales,'ydata',x);
hold on
plot([1 size(coefs,2)],[Sca Sca],'Color','m','LineWidth',2);

%%
% In the scalogram, maxima of energy are detected at scale 50, 
% which corresponds to frequency 10. This is one method of using
% wavelet analysis to obtain spectral information.

%%
% We can also use a contour plot to view the spectral information.
clf;  coefs = cwt(x,scales,wname,'scalCNT');
hold on
plot([1 size(coefs,2)],[Sca Sca],'Color','m','LineWidth',2);

%%
% The location of frequency information in the scalogram depends 
% on the wavelet used for the analysis. Some wavelets are able to 
% detect the frequency location very well. Now, we will show how
% other wavelets perform. 
%%
% Note that the value of the scale *Sca* corresponding to the frequency
% *Frq* also depends on the wavelet.
%%
% *_Good detection with Mexican hat wavelet_*
wname = 'mexh';
TAB_Sca2Frq = scal2frq(scales,wname,1/Fs);
[~,idxSca] = min(abs(TAB_Sca2Frq-Frq));
Sca = scales(idxSca)

%%
clf;  coefs = cwt(x,scales,wname,'scalCNT');
hold on
plot([1 size(coefs,2)],[Sca Sca],'Color','m','LineWidth',2);

%%
% *_Good detection with Morlet wavelet_* 
wname = 'morl';
TAB_Sca2Frq = scal2frq(scales,wname,1/Fs);
[~,idxSca] = min(abs(TAB_Sca2Frq-Frq));
Sca = scales(idxSca)

%%
clf;  coefs = cwt(x,scales,wname,'scalCNT');
hold on
plot([1 size(coefs,2)],[Sca Sca],'Color','m','LineWidth',2);

%%
% *_Poor detection with Haar wavelet_* 
wname = 'haar';
TAB_Sca2Frq = scal2frq(scales,wname,1/Fs);
[~,idxSca] = min(abs(TAB_Sca2Frq-Frq));
Sca = scales(idxSca)

%%
clf;  coefs = cwt(x,scales,wname,'scalCNT');
hold on
plot([1 size(coefs,2)],[Sca Sca],'Color','m','LineWidth',2);


%% Analysis of a Sum of Two Periodic Signals
%
% We now define a more complicated periodic signal, which is a sum of two  
% sines of frequencies *F1 = 10* and *F2 = 40*.  We will compute the power
% spectral density (PSD) estimate using spectral estimation and the continuous 
% wavelet transform using the wavelet *gaus4*.  

%%
% First, we build and plot the analyzed signal.
F1 = 10;
F2 = 40;
Fs = 1000; 
t  = 0:1/Fs:1;
x =  sin(2*pi*t*F1) + sin(2*pi*t*F2);
clf; plot(x,'r'); axis tight
title('Signal');
xlabel('Time or Space')

%%
% Then, compute and plot the PSD of the signal.
h = spectrum.welch;
Hpsd = psd(h,x,'Fs',Fs);
clf; plot(Hpsd);

%%
% Using an interpolated function of the PSD function and locating
% the two first local maxima of this function, we see approximations 
% of the two "true" frequencies at F1_approx = 7.8 and F2_approx = 39.1. 

%%
% Using the function |scal2freq|, we compute the correspondence table 
% of scales and frequencies for the *gaus4* wavelet.  Then, we find the scales 
% corresponding to the frequencies *F1 = 10* and *F2 = 40*.
wname = 'gaus4';
scales = 1:1:128;
TAB_Sca2Frq = scal2frq(scales,wname,1/Fs);
[~,idxSca_1] = min(abs(TAB_Sca2Frq-F1));
Sca_1 = scales(idxSca_1)
[~,idxSca_2] = min(abs(TAB_Sca2Frq-F2));
Sca_2 = scales(idxSca_2)

%%
% Now, we compute the continuous wavelet transform of the signal, and then, plot the
% scalogram of wavelet coefficients and two horizontal lines
% corresponding to the scales *Sca_1* and *Sca_2* linked to the frequencies
% *F1* and *F2*. We can see that these lines are associated to the 
% local maxima of energy in the scalogram. 
%%
% Note that the component with the lowest frequency contains the most 
% energy. 
clf;  coefs = cwt(x,scales,wname,'scalCNT');
hold on
plot([1 size(coefs,2)],[Sca_1 Sca_1],'Color','m','LineWidth',2);
plot([1 size(coefs,2)],[Sca_2 Sca_2],'Color','m','LineWidth',1);

%%
% As above, we can use an image representation instead of a contour plot.
%%
clf; wscalogram('image',coefs,'scales',scales,'ydata',x);
hold on
plot([1 size(coefs,2)],[Sca_1 Sca_1],'Color','m','LineWidth',2);
plot([1 size(coefs,2)],[Sca_2 Sca_2],'Color','w','LineWidth',1);

%% Analysis of a Periodic Signal Corrupted by a Noise
% We define a periodic signal which is a sum of two sines of 
% frequencies *F1 = 10* and *F2 = 40* corrupted by normally
% distributed white noise. We will compute the power spectral density (PSD)
% estimate using spectral estimation and the continuous wavelet transform 
% using the wavelet *gaus4*.  
%%
% We build the analyzed signal.
F1 = 10;
F2 = 40;
Fs = 1000; 
t  = 0:1/Fs:1;
x  = sin(2*pi*t*F1) + sin(2*pi*t*F2);
wn = randn(1,length(x));
wn = 1.5*wn/std(wn);
xn = x + wn;

%%
% We compute and plot the PSD of the signal.
h = spectrum.welch;
Hpsd = psd(h,xn,'Fs',Fs);
clf; hLIN = plot(Hpsd);
ydata_XN = get(hLIN,'ydata');

%%
% We still see the two main frequencies in the spectrogram.

%%
% We now compute the correspondence table of values of scales and 
% frequencies for the *gaus4* wavelet. Then, we find the scales 
% corresponding to the frequencies *F1 = 10* and *F2 = 40*.
wname = 'gaus4';
scales = 1:1:128;
TAB_Sca2Frq = scal2frq(scales,wname,1/Fs);
[~,idxSca_1] = min(abs(TAB_Sca2Frq-F1));
Sca_1 = scales(idxSca_1)
[mini,idxSca_2] = min(abs(TAB_Sca2Frq-F2));
Sca_2 = scales(idxSca_2)

%%
% Next, we compute the continuous wavelet transform of the signal, and then, 
% plot the scalogram of wavelet coefficients and two horizontal lines
% corresponding to the scales *Sca_1* and *Sca_2* linked to the frequencies
% *F1* and *F2*.
coefs = cwt(xn,scales,wname);
clf; wscalogram('image',coefs,'scales',scales,'ydata',xn);
hold on
plot([1 size(coefs,2)],[Sca_1 Sca_1],'Color','m','LineWidth',2);
plot([1 size(coefs,2)],[Sca_2 Sca_2],'Color','w','LineWidth',1);

%%
% Although less clear than in the noiseless case, we can see that these
% lines are still associated with the local maxima of energy in the
% scalogram.

%% Analysis of a More Complicated Signal
% Now we design a more complicated signal, which is a piecewise sine defined 
% on three adjacent intervals: frequency *F1 = 10* for the intervals [0 0.25] and 
% [0.75  1] which correspond to the indices 1:250 and 750:1000, and frequency 
% *F2 = 40* for the interval [0.25 0.75] which corresponds to the indices 251:749. 
%% 
% We build the analyzed signal, 
F1 = 10;
F2 = 40;
Fs = 1000; 
t  = 0:1/Fs:1;
x  = sin(2*pi*t*F1).*((t<0.25)+(t>0.75)) + sin(2*pi*t*F2).*(t>0.25).*(t<0.75);

%% 
% and display the analyzed signal.
clf; plot(x);axis tight
title('Signal');
xlabel('Time or Space')

%%
% Now we compute and plot the PSD of the signal.
h = spectrum.welch;
Hpsd = psd(h,x,'Fs',Fs);
clf; plot(Hpsd);

%%
% The spectrum is very similar to that achieved for the case of the sum of
% two sines. It gives no information on the location of any events in time or space.

%%
% Now, compute the continuous wavelet transform of the signal and plot the
% scalogram of wavelet coefficients and two horizontal lines
% corresponding to the scales *Sca_1* and *Sca_2* linked to the frequencies
% *F1* and *F2*. We will also draw the two vertical lines that separate the intervals.
%
wname = 'gaus4';
scales = 1:1:128;
coefs = cwt(x,scales,wname);
clf; wscalogram('image',coefs,'scales',scales,'ydata',x);
hold on
plot([1 size(coefs,2)],[Sca_1 Sca_1],'Color','m');
plot([1 size(coefs,2)],[Sca_2 Sca_2],'Color','m');
plot([250 250],[1 128],'Color','g','LineWidth',2);
plot([750 750],[1 128],'Color','g','LineWidth',2);
%%	
% Note that the wavelet analysis works very effectively to detect time
% or space events. The intervals with the different frequencies are
% clearly detected. 
%
%% Summary
% 
% In general, the tools best suited for spectral analysis of signals are 
% based on FFT, however, wavelets, though not specifically dedicated 
% to this type of analysis, can recover some of this spectral information.

%%
% The wavelet procedure we used was to use both the continuous wavelet
% transform and the function |scal2freq| to compute a correspondence table 
% between values of scales and frequencies. This table depends on the selected wavelet. 
% Then, we searched the scale corresponding to the frequency or vice versa.  

%%
% This procedure produces approximated values, however they
% are generally good enough when applied to signals that are not too complex.
% This procedure is also very efficient at detecting time or space events.

displayEndOfDemoMessage(mfilename)


