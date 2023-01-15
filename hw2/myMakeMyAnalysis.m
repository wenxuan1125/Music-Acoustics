function [refamp] = myMakeMyAnalysis(y,fs,timeofanalysis,windowlength,varargin)

% y -> sound data
% fs -> sampling frequency
% timeofanalysis -> time to start the analysis (in second)
% windowlength -> how long the analysis will be (in second)
% varargin -> 

tstart = round(timeofanalysis*fs);                                      % from seconds to samples
ysegment = y(tstart:tstart+round(windowlength*fs));                     % signal to be analysize
YSEGMENT = fft(hanning(length(ysegment)).*ysegment,length(ysegment)*2); % time domain to frequency domain
                                                                        % hanning window is used to attenuate the sides of the window of the signal
[h1,h2] = createFigure;
axes(h1);
t = timeofanalysis+[0:length(ysegment)-1]./fs;
plot(t,ysegment,'k');
axis([timeofanalysis t(end) 0.99*[-1 1]]);
set(gca,'FontSize',14,'XTickLabel','');
grid on;
ylabel('Amplitude');
text(t(1)+0.01,-0.8, ...
  ['[' num2str(timeofanalysis) ',' num2str(timeofanalysis + windowlength) '] s'], ...
  'FontSize',14);
axes(h2);
f = fs*[0:length(YSEGMENT)-1]./(length(YSEGMENT));
if nargin > 4   % nargin returns the number of function input arguments given in the call to the currently executing function.
                % varargin is an input variable in a function definition statement that enables the function to accept any number of input arguments.
                % varargin is a 1-by-N cell array, where N is the number of inputs that the function receives after the explicitly declared inputs.
    refamp = varargin{1};
else
    refamp = max(abs(YSEGMENT));
end
dB = 20*log10(abs(YSEGMENT)./refamp);
plot(f,dB,'k');
axis([0 15000 -100 0]);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');

