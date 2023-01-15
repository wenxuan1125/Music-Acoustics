
%% ----- read the audio file -----

filename = 'C:\Users\WenXuan\Desktop\music acoustic\hw2\A2-Glockenspiel-samples\Gsp_ME_p_L-sus_F#6.wav';
[x,fs]=audioread(filename); % read the audio file
x = sum(x,2)/2;             % convert stereo sound file to monophonic
x = x./max(abs(x));         % normalise audio to lie in (-1, 1)
sound(x,fs);                % play back the audio file
              
t=0:1/fs:(length(x)-1)/fs;  % time axis


createFigure2                           
plot(t, x, 'k');            % plot the time domain waveform
grid on;    
axis([0 max(t) -1 1]);      % adjust the axis limits of the figure
xlabel('Time (s)'); ylabel('Amplitude');
title('Gsp_ME_p_L-sus_F#6 - real signal'); 


%% analyze spectrum at two points in time
t1 = 0.05; t2 = 1;          
windowlength = 0.2;         % s

refamp = myMakeMyAnalysis(x,fs,t1,windowlength);
myMakeMyAnalysis(x,fs,t2,windowlength,refamp);

%%
% I took the following measurements from the above magnitude spectra
fest = [1480 4042 5299 12381 12511];
dB1 = [-7.9 -13.5 -27.5 -27.1 -13.1];
dB2 = [-12.9 -66.3 -39.3 -62.8 -71.5];

% estimate parameters
gammaest = (dB1-dB2)./(20/log(10))/(t2-t1);
Ampest = 10.^(dB1/20 + gammaest*t1/log(10));

%% create plot of envelopes - click in fig to display each envelope
createFigure2
t = [0:0.01:2];
colors = ["#0072BD" "#EDB120" "#7E2F8E" "#77AC30" "#A2142F"];
for ii=1:length(Ampest)
  env = Ampest(ii)*exp(-gammaest(ii)*t);
  plot(t,env, 'color', colors(ii), 'Linewidth', 1.5);
  % gtext(num2str(ii),'FontSize',16)
end
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
axis([0 max(t) 0 1.2]);
legend('1', '2', '3', '4', '5')
title('Estimated Envelopes of the Overtones')
hold on;

%% resynthesize
%fs = 22050;
dur = (length(x)-1)/fs;
t = [0:dur*fs-1]'/fs;
xsynth = zeros(length(t),1);
for ii=1:length(Ampest)
  xsynth = xsynth + Ampest(ii)*exp(-gammaest(ii)*t).*sin(2*pi*t*fest(ii));
end
createFigure2;
plot(t,xsynth,'k');
grid on;
axis([0 dur -1.5 1.5])
xlabel('Time (s)');
ylabel('Amplitude');
title('Gsp_ME_p_L-sus_F#6 - synthesized signal'); 
soundsc(xsynth,fs);
audiowrite('Gsp_ME_p_L-sus_F#6_synth.wav',xsynth,fs);


