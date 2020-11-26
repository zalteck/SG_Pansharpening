%% Pattern Adapted Wavelets for Signal Detection

%%
% The purpose of this example is to show how to use the continuous wavelet
% transform (CWT) to detect patterns in signals.
%
% First, we consider a simple detection problem. A signal S(t) is defined.
% It contains a superposition of dilated and translated versions of a given
% basic pattern f(t). In this context, when only S(t) and f(t) are known,
% we have to identify the number of patterns and the values of the
% scale-position pairs. To achieve this goal, the following process is
% used: 
%
% *1*- Construct a pattern adapted wavelet approximating the form f(t)
% using one of the methods available in the toolbox. 
%
% *2*- Obtain the CWT of the signal S using the pattern adapted wavelet.
%
% *3*- Estimate the scale and position of the pattern by locating the
% maxima of the absolute values of the CWT coefficients.
%
% This technique will be initially used on simulated signals and
% then applied to spike detection in EEG data.


% Copyright 2010-2012 The MathWorks, Inc.

%% Haar Pattern Detected by Haar Wavelet
% The first example illustrates how the maxima of the absolute values of
% the CWT coefficients can be used to estimate the position and scale of a
% signal pattern.
% To construct the signal to analyze, create a vector of zeros of length
% 897. We insert in the vector of zeros the basic form of the Haar wavelet
% of length 90 centered at index 385.

% Length of the signal and half-length of the pattern.
lenSIG = 897;
L = 45;

% Length, beginning, end and middle of the pattern.
long  = 2*L;
first = 340;
last  = first+long-1;
pat = [-ones(1,L) ones(1,L)];

%%
% The problem is to detect this pattern. Here we use the Haar wavelet,
% which is well-suited for this detection problem because it is matched to
% the pattern.

% Signal with inserted shape.
Z = zeros(1,lenSIG);
Z (first:last) = pat;
scales = 1:256;
wname = 'haar';

% Continuous wavelet transform (CWT).
figure;
c = cwt(Z,scales,wname,'scalCNT'); grid

% Detect the maximum of the absolute value of coefficients.
[~,imax] = max(abs(c(:)));
SIZ = size(c);
ROW = rem(imax,SIZ(1));
if ROW==0 , ROW = SIZ(1); end
[~,COL] = max(abs(c(ROW,:)));
display(sprintf('Detected indices COL and ROW: %3.0f %3.0f',COL,ROW))

%%
% Direct inspection of the output plot of the CWT
% shows that both the center position of the pattern (index 385) and
% the scale (length 90) are perfectly detected. This appears more clearly
% when zooming in on the maximum in the scalogram.  
%%
% <<DF_fig_1.png>>



%% Instant and Duration Associated with a Detection.
% In many contexts, it is natural to define the scales not in terms of the
% dilation factor, but rather in terms of the duration of the patterns to
% be detected. In order to establish the correspondence between scale and
% duration for a discrete-time sequence, it is necessary to know the
% sampling period. 

%%
% To handle detection problems in terms of pattern duration, we define a
% second usage of the CWT taking into account the sampling period in the
% numerical approximation of the wavelet coefficients. Denoting the
% sampling period by stepSIG, the key point is to properly scale the
% discretized version of the wavelet in order to compute integrals on
% intervals [k,k+1]*stepSIG instead of [k,k+1].

%%
% Revisiting the preceding pattern detection problem, assume that the
% sampling period of the sequence is 25 milliseconds.

% Set the sampling period.
stepSIG = 0.025;

%%
% The scale of the pattern is 90 samples. Using the sampling period, the
% duration of the pattern is 90*stepSIG (2.25) seconds. The pattern is
% centered at 385*stepSIG (9.60) seconds. In this example, we define the
% scales in terms of the pattern duration. The corresponding scales are
% then directly obtained by dividing by the sampling period (this is
% performed inside the cwt function).
scales  = (1:0.25:10);
positions = (0:lenSIG-1)*stepSIG;    

% Sampling rate of the analyzing wavelet. 
stepWAV = 1/1024;
wname   = 'haar';
WAV = {wname,stepWAV};

% Caution, SIG is a cell array containing the signal Z and the sampling
% period stepSIG. 
SIG = {Z,stepSIG};

% Recall that scales are expressed as multiple of the sampling period.
figure;
c = cwt(SIG,scales,WAV,'scalCNT'); grid
ylabel('Duration')

% Detect the maximum of the absolute value of coefficients.
[~,imax] = max(abs(c(:)));
SIZ = size(c);
ROW = rem(imax,SIZ(1));
if ROW==0 , ROW = SIZ(1); end
[~,COL] = max(abs(c(ROW,:)));
display(sprintf('Detected indices COL and ROW: %3.0f %3.0f',COL,ROW))
display(sprintf('Duration: %4.2f',scales(ROW)))
display(sprintf('Instant:  %4.2f',positions(COL)))

%%
% By incorporating the sampling period, you can translate position and
% scale into the temporal notions of instant and duration. These are
% estimated from the CWT as:
%% 
% (385-1) * 0.025 = 9.60s and 90 * 0.025 = 2.25s

%% Constructing an Adapted Wavelet    
% It is well known that detection of a deterministic signal in white noise
% is optimized by the use of a filter whose impulse response is matched to
% the signal. The Wavelet Toolbox(TM) software enables you to design
% admissible wavelets based on the pattern you wish to detect. Designing a
% valid wavelet based on your pattern allows you to exploit the optimality
% of matched filtering in the framework of the CWT.
%
% In designing your pattern adapted wavelet, you can define the pattern
% either as a function of time (which is given without any a priori
% reference to the signal), or extract the pattern from a sampled signal.
% The first transformation, which is in fact performed implicitly, is to
% map the pattern on the unit interval [0,1] using an arbitrary regular
% grid.
%
% Then, the MATLAB(R) function pat2cwav computes a pattern-adapted wavelet
% defined on a grid of 256 points on the interval [0,1].
% 
% The last step is to compute the CWT using this wavelet and extract the
% local maxima in absolute value. Each maximum corresponds to an instant
% (fixed as the middle of the suitably rescaled pattern) and a duration
% (the length of the suitably rescaled pattern). 
%
% Note that in the CWT, each wavelet is rescaled in such a way that the
% associated pattern is supported on the interval [0,1]. So a fair 
% comparison could be performed to evaluate the detection
% performance of the adapted wavelet versus a predefined well known
% wavelet. In this example we focus on the pattern adapted detection. 
%
% In the next example we illustrate how to use the CWT to identify
% translation and dilation factors corresponding to the original detection
% problem when the pattern is given without any a priori reference to the
% signal.

%% Two Translated Versions of a sine Pattern Detected using an Adapted Wavelet
% We construct a signal S containing two dilated versions of a basic
% form F given by:

% Define the form to detect.
C1 = 1; C2 = 0.9; 
X = linspace(-1,1,256);
F = C1*(sin(pi*X)+abs(sin(pi*X)))/2 ...
    - C2*(sin(-pi*X)+abs(sin(-pi*X)))/2;

% Construct the signal containing two similar forms.
Z = zeros(1,2048);

% Insert the first form.
L = 128;
long  = 2*L;
first = 513;
last = first+long-1;
middle = (first+last)/2;
Z(first:last) = F;

% Insert the second form.
long2  = L;
first2 = 1473;
last2 = first2+long2-1;
middle2 = (first2+last2)/2;
Z(first2:last2) = sqrt(2)*F(1:2:end);

%%
% Since the integral of the form to detect is not zero, this form is not a
% wavelet. To use the CWT, we need to construct an approximating wavelet.
%
% The principle for designing a new wavelet for the CWT is to approximate a
% given pattern using least squares optimization under constraints leading
% to an admissible wavelet. 

% Build and display the adapted wavelet.
[Y,X] = pat2cwav(F,'orthconst',0,2);
figure;
plot(X,F/max(abs(F)),'b'); 
hold on; 
plot(X,Y/max(abs(Y)),'r');
title('Form to detect (b) and adapted Wavelet (r)')

%%
% To use the new constructed wavelet, it must be added to the available
% wavelets of the toolbox.

% Save the adapted wavelet and add it to the toolbox 
locdir = cd;
cd(tempdir);
save adp_FRM1 X Y
wavemngr('add','AdapF1','adpf1',4,'','adp_FRM1.mat',[0 1]);
addpath(tempdir,'-begin');
cd(locdir);

%%
% Assume the sampling interval of the signal Z is 1/32 seconds. Construct
% an appropriate time axis and plot the signal
time = linspace(0,64,length(Z));
figure;
plot(time,Z); grid on;
set(gca,'XTick',[0 10 16 20 24 30 40 46 50]);

%%
% From the figure, we see that one pattern is centered around 20
% seconds and the second pattern is centered around 48 seconds.
% The pattern centered around 20 seconds has a duration of 8 seconds while
% the second pattern has a duration of 4 seconds.

% We analyze the signal by computing the CWT coefficients of Z using the
% admissible wavelet we constructed to approximate the basic form F. 

stepSIG = 1/32;
stepWAV = 1/256;
wname = 'adpf1';
scales  = (1:2*long)*stepSIG;
WAV = {wname,stepWAV};
SIG = {Z,stepSIG};
figure;
cwt(SIG,scales,WAV,'scalCNT'); grid

% Detect the maximum of the absolute value of coefficients.
lenSIG = length(Z);
positions = (0:lenSIG-1)*stepSIG;    
fprintf('Instant 1:  %4.2f\n',positions(round(middle)))
fprintf('Instant 2:  %4.2f\n',positions(round(middle2)))

%%
% The contour plots of the CWT coefficients show that the
% pattern-adapted wavelet is effective in locating the center positions of
% the patterns along the x-axis and the scales along the y-axis.


%% Detection of Two Superimposed Versions of a sine Pattern.
% Let us consider another example, which is more difficult since we 
% partially superimpose two translated and dilated versions of the same 
% basic form (see the signal at the top of the next figure).

%%
% We first build a signal containing two superimposed similar forms.

% Construct the signal containing two similar forms.
Z = zeros(1,768);

% Insert the first form.
L = 128;
long  = 2*L;
first = 253;
last = first+long-1;
Z(first:last) = F;

% Insert the second form.
L2 = 16;
long2  = 2*L2;
first2 = 353;
last2 = first2+long2-1;
Z(first2:last2) = Z(first2:last2)+2*sqrt(2)*F(1:8:end);
 
%%
% The same pattern-adapted wavelet is used to detect the superimposed forms.
% Define the wavelet, the signal, and the wavelet sampling period.
wname = 'adpf1';
stepSIG = 1/8;
stepWAV = 1/256;
scales = (1:2*long)*stepSIG;

%%
% We analyze the signal with the adapted wavelet. The two dilated forms are
% clearly detected. The adapted wavelet is very accurate in locating the
% two scales, 32 and 8, at position 48. 

figure;
SIG = {Z,stepSIG};
WAV = {wname,stepWAV};
cwt(SIG,scales,WAV,'scalCNT'); grid

%% Real World Example: Epileptic Spikes in EEG Signals
% This part of the example is based on the paper by Hector Mesa entitled
% "Adapted wavelets for pattern detection", Lecture Notes in Computer 
% Sciences, vol. 3773, 2005, p. 933-944.
%
% The main objective of this real world example is to illustrate the 
% capability of the pattern adapted wavelet procedure to highlight
% epileptic spikes in EEG signals by distinguishing them from the
% background brain activity.

%%
% We are going to briefly present the data. We will consider two different
% EEG datasets. The first one, Espiga3.mat, contains recordings of 995
% samples obtained from 23 channels. In the following plot of the data, a
% single spike is observable in many of the channels around sample 650.
% Note that the spike is not equally well resolved in all the channels.
%%
% <<DF_fig_2.png>>

%%
% For instance, the spike cannot be detected in channel 23 which is 
% dominated by the ECG recording. Contrast this to channel 1 where the spike
% is easy to identify. Let us focus on the channel 1 data in the next plot. 
% Since the sampling period is 1/200 seconds, the total duration of 
% the recording is approximately 4.97 seconds.
%%
% <<DF_fig_3.png>>



%%
% In the next three sections, we apply pattern adapted wavelet detection to
% EEG data. Specifically, we perform the following:
%
% *1* - Construct an admissible wavelet to approximate the spike pattern
% extracted from a single channel EEG recording. The pattern adapted
% wavelet is constructed from the channel one recording and tested on the
% same channel.
%
% *2* - Using the pattern adapted wavelet obtained in the first section,
% spike detection is performed in the other channels of the same EEG
% dataset.
%
% *3* - The pattern adapted wavelet is utilized for spike detection in a
% different EEG dataset.

%% Constructing Adapted Wavelets from a Single EEG Channel.
% In the following plot of the channel 1 data, the spike is located between
% the two vertical lines drawn on the plot. The spike occurs in the
% interval from 3 to 3.5 seconds.
%%
% <<DF_fig_4.png>>



%%
% Using the GUI tools for designing pattern adapted wavelets (instead of
% the command line tool pat2cwav.m), and using different
% available approximation methods, four different wavelets are generated
% and plotted in the next figure: the pattern in blue and the adapted
% wavelet in red (all the functions are rescaled on the interval [0,1]). 
%%
% <<DF_fig_5.png>>



%%
% From the top left to the bottom right, one can find the wavelets (denoted
% by adp7 to adp10) obtained using different set of parameters (ORTH_CONT,
% ORTH_NONE, Pol6_CONT, and Pol6_DIFF respectively). In the following
% examples, we exclusively use the adp8 wavelet (top right) to process the
% EEG data.

%% Applying the Adapted Wavelet to the Channel 1 Data
% In this section, we use the adapted wavelet for the detection of the
% original pattern to verify the procedure.

% Load the channel 1 of the EEG record.
load eeg_3_01;
Z = eeg_3_01;

stepSIG = 1/200;       % sampling period of the EEG.
stepWAV = 1/1024;
stepSCA = 0.1;
lenSIG = length(Z);    % length of the record.
first  = 645;          % beginning of the pattern (spike).
middle = 663;          % middle of the pattern.
long   = 36;           % length of the pattern.
last   = first+long-1;
F = Z(first:last);     % pattern. 

%%
% Add the adapted wavelets to the toolbox 
cd(tempdir);
wavemngr('add','AdpWave','adp',4,'7 8 9 10','adpwavf',[0 1]);
cd(locdir);

% Detection of the spike using the adapted wavelet.
scales = (1:stepSCA:2*long)*stepSIG; 
positions = (0:lenSIG-1)*stepSIG;    
SIG = {Z,stepSIG};          % Signal and sampling period.
WAV = {'adp8',stepWAV};     % Wavelet and sampling period.

%%
% Note that the adapted wavelet can be built either using the function
% pat2cwav (as shown in a previous section), or using the GUI, which
% allows you to design and save the new adapted wavelet interactively.
% See "Adding Your Own Wavelets" in the User's Guide for more information.

% Find the CWT of the EEG signal using the pattern adapted wavelet.
fig = figure;
c = cwt(SIG,scales,WAV,'scalCNT');
ax = findobj(fig,'Type','axes');
tag = get(ax,'Tag');
sig_Axes = ax(strcmpi(tag,'SIG_Axes'));
axis(sig_Axes,'tight');

% Detect the maximum of the absolute value of coefficients.
[~,imax] = max(abs(c(:)));
SIZ = size(c);
ROW = rem(imax,SIZ(1));
if ROW==0 , ROW = SIZ(1); end
[maxi,COL] = max(abs(c(ROW,:)));

% Zoom in the axes on the region of interest.
ax = findobj(fig,'Type','axes');
Xlim  = [2.8 3.6];
set(ax(2:3),'XLim',Xlim);

% Position and Duration.
TimePos  = positions(COL)
Duration = scales(ROW)

CFS_Axes = ax(strcmpi(tag,'CFS_Axes'));
LW = 2;              % Linewidth
CL = [0.2 0.7 0.2];  % LineColor
propLINE = {'Color',CL,'LineWidth',LW,'LineStyle','--','Parent',CFS_Axes};
line('XData',[positions(1) positions(end)],'YData',[ROW ROW],propLINE{:});
line('XData',[TimePos TimePos],'YData',[1 length(scales)],propLINE{:});

%%
% The maximum absolute value of the CWT coefficients occurs at 3.31 seconds
% and corresponds to a duration (scale) of 0.1835 seconds. Both the
% position and duration corresponding to the maximum show good agreement
% with the spike as expected. This is confirmed in the contour plot.

%%
% The detected position and duration are illustrated below by the portion
% of the signal and the adapted wavelet superimposed with the pattern.
%%
% <<DF_fig_6.png>>



%% Spike Detection on Other Channels of the Same EEG Dataset.
% Discarding the channels for which the signal to noise ratio is not
% sufficient, we have selected the 12 channels displayed on the left of
% the following figure:
%%
% <<DF_fig_7.png>>



%%
% From top to bottom in the right portion of the figure, you can find the
% following information.
%
%%
% - the 12 portions of the signals containing the spikes;
%%
% - the adapted wavelet superimposed with the pattern (spike of 
%   channel 1);
%%
% - the table of the 12 detected positions and durations.

%%
% As shown in the table, the estimated center position and duration
% show good agreement across all 12 channels.

%% Spike Detection on a Different EEG Dataset with the Same Adapted Wavelet.
% In this section, we use the wavelet adapted to the pattern extracted from
% channel 1 of the previous EEG dataset and apply it to second EEG dataset
% consisting of 23 channels. The EEG data contain 1001 samples with a
% sampling period of 1/200 seconds, leading to a total duration of 5
% seconds.
%%
% <<DF_fig_8.png>>



%%
% Repeating the procedure used above, the left part of the following figure
% displays the data from the 12 usable channels. The right part of the
% figure displays the spike patterns from the 12 channels, the
% pattern-adapted wavelet, and the table of estimated center positions and
% durations.
%%
% <<DF_fig_9.png>>



%%
% The estimated center position and duration again show good agreement
% across the 12 channels. This illustrates that the wavelet adapted from a
% spike pattern in the first EEG dataset is effective in detecting spike
% patterns in a different EEG dataset.

%%
% We now delete the newly-created wavelets and temporary files.

% Delete the adapted wavelets and the wavelet files. 
cd(tempdir);
wavemngr('del','AdapF1');
delete('adp_FRM1.mat')
delete('wavelets.prv');
delete('wavelets.asc');
delete('wavelets.inf')
cd(locdir);
rmpath(tempdir);

%% Summary
% This example has shown you how to use pattern adapted wavelets with the CWT
% for signal detection. First, we have shown how to use the local
% absolute maxima in the CWT to detect a simple Haar pattern with the Haar
% Wavelet. Next, two translated versions of a sine pattern are detected
% using an adapted wavelet. Subsequently, a more difficult problem is
% addressed: the detection of two superimposed versions of a sine pattern.
% Finally, pattern adapted wavelets are used in a real world example: the
% detection and localization of epileptic spikes in EEG signals.

displayEndOfDemoMessage(mfilename)

