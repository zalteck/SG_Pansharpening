%% Detecting Self-Similarity
% The purpose of this example is to show how analysis by wavelets can detect a
% self-similar, or fractal, signal. The work of many authors and the trials
% that they have carried out suggest that wavelet decomposition is very
% well adapted to the study of the fractal properties of signals and
% images. When the characteristics of a fractal evolve with time and become
% local, the signal is called a multifractal. The wavelets then are an
% especially suitable tool for practical analysis and generation.

% Copyright 2006-2012 The MathWorks, Inc.

%% Loading the Signal
% The signal here is the Koch curve -- a synthetic signal that is built
% recursively. Let's visualize the signal and zoom in  one section.
load vonkoch;
plot(vonkoch,'r'); 
set(gca,'XLim',[1 length(vonkoch)])
title('Analyzed signal - Koch curve');
xlabel('Time (or Space)');ylabel('Amplitude')
figure('Color','white')
plot(vonkoch,'r'); 
set(gca,'XLim',[3250 4120])
title('Analyzed signal - Koch curve');
xlabel('Time (or Space)');ylabel('Amplitude')


%% Wavelet Coefficients and Self-Similarity
% From an intuitive point of view, the wavelet decomposition consists of
% calculating a "resemblance index" between the signal and the wavelet. If
% the index is large, the resemblance is strong, otherwise it is slight.
% The indices are the wavelet coefficients. If a signal is similar to
% itself at different scales, then the "resemblance index" or wavelet
% coefficients also will be similar at different scales. In the
% coefficients plot, which shows scale on the vertical axis, this
% self-similarity generates a characteristic pattern. 
%%
% The command waveinfo displays the main properties of a wavelet family.
waveinfo('coif')
%%
% Let's compute the continuous wavelet transform (CWT) of the Koch curve:
scales = 2:2:128; 
wname = 'coif3';
cwt(vonkoch,scales,wname,'abslvl');
xlim([3250 4120]);
colormap(pink(128));
%%
% A repeating pattern in the wavelet coefficients plot is characteristic of
% a signal that looks similar on many scales. 


displayEndOfDemoMessage(mfilename)

