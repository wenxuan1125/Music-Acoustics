%% Supporting code for DT2212 
% assignment 2 voice synthesis
display('Please enter the value for the control parameter (0, 1].')
display('It can control both the sound level and the spectral slope of the source.')
display('The larger the parameter is, the larger the sound level is and the flatter the slope is.')
dynamics = input('Please enter the value: ');
vibrato_op = input('Do you want to add a vibrato modulation? (y/n): ', 's');

% Set up some variables
fsamp = 32000;      % sampling rate
    
% the relationship between the midi number, m, and the fundamental freauency, f_m
% f_m = 2^((m-69)/12)*440
stars = [60 60 67 67 69 69 67 65 65 64 64 62 62 60];
stars_time = [0.8 0.8 0.8 0.8 0.8 0.8 1.6 0.8 0.8 0.8 0.8 0.8 0.8 1.6];

note = stars;
note_frequency = 2.^((note-69)./12).*440;
note_time = stars_time;
pause_zero = [20 20 20 20 20 20 20 20 20 20 20 20 20 20];

pOut_all = [];
fN = [700, 1050, 2300, 2500, 2800;  % male
      499, 1022, 3162, 3856, 5640;  % o
      386, 899, 2851, 4039, 5160;   % u
      700, 1016, 3279, 4059, 6000]; % a 
fNrow = [4 4 2 2 4 4 2 4 3 4 3 4 4 3];

for i=1:length(note)
       %% Source signal #1 - additive synthesis
       
    % Create a sum of N harmonically related sine waves 
    f_0 = note_frequency(i);
    totalTime = note_time(i);
    
    vibAmp = 0.001;     % the amplitude for vibrato 
    vibFreq = 6;        % the frequency for vibrato

    % A for amplitude
    % The minus sign flips the resulting sawtooth upside down, 
    % to look more like a glottal flow with a rapid closing 
    % (it sounds the same).
    A = -0.8;  

    % Number of harmonics, staying below Nyquist
    % Nyquist frequency = fsamp/2
    % Nyquist frequency/fundamental frequency = the number of harmonics
    N_harmonics = floor(fsamp/(2*f_0)); 

    % Spectrum slope parameter
    a_slope = 1*(-1.8*dynamics+2);      

    % Make a time axis vector
    t = linspace(0.001, totalTime, totalTime*fsamp);

    % Make the sine waves and add them together 
    p = zeros(size(t));
    for n = 1 : N_harmonics
        if vibrato_op == 'y'
            % f_0vib = f_0 + (vibAmp ./ t) .* sin(2*pi*vibFreq*t) * f_0
            f_0vib = (1 + (vibAmp ./ t) .* sin(2*pi*vibFreq*t)) * f_0;
            p = p + A*(n^(-a_slope))*sin(2*pi*n*f_0vib .* t);   % vibrato 
        elseif vibrato_op == 'n'
            p = p + A*(n^(-a_slope))*sin(2*pi*n*f_0 .* t);     % no vibrato
        end
    end
    % p is now the source signal, representing glottal flow
    
    plot(t,p);  %Display audio waveform with time axis
    grid on;    %Overlay a grid to make it look sciency
    axis([0.1 0.2 -1.5 1.5]); % adjust the axis limits of the figure
    xlabel('Time (s)'); ylabel('Amplitude');
       %% Table of formant frequencies
    % Table of formant bandwidths
    bN = [25, 40, 60, 80, 100];

    % Table of Q factors
    qN = fN(fNrow(i), :) ./ bN; 

    % Compute the second order filter coefficients for the above five filters
    % using the Liljencrants 'cheat sheet'
    T = 1/fsamp;
    for j = 1 : 5
      betas(j) = fN(fNrow(i), j)*2*pi;
      beta0s(j) = betas(j)*sqrt(1+1/(4*qN(j)^2));
      alphas(j) = beta0s(j)/(2*qN(j));
      aOnes(j) = -2*exp(-alphas(j)*T)*cos(betas(j)*T);
      aTwos(j) = exp(-2*alphas(j)*T);
      Gs(j) = 1 + aOnes(j) + aTwos(j);
    end

    % Apply to "p" the desired number of resonances, in series.
    % The recursive filter formula is (lowpass formant resonator)
    % Yn = G*X(n) - aOne*Y(n-1) - aTwo*Y(n-2)
    pOut = p;
    pOut(1) = 0.0;
    pOut(2) = 0.0;

    for j = 1 : 5
        for n = 3 : length(pOut)
            pOut(n) = Gs(j)*pOut(n) - aOnes(j)*pOut(n-1) - aTwos(j)*pOut(n-2);
        end
    end

    pOut_all = [pOut_all, pOut];
    % pOut_all = [pOut_all, zeros(1,pause_zero(i))];


end

volume = 0.01;
% audioplayer(Y,Fs) creates an audioplayer object for signal Y, using sample rate Fs.
a = audioplayer(pOut_all*volume, fsamp);
a.play;


% normalise audio to lie in (-1, 1)
pOut_all = pOut_all./max(abs(pOut_all)+0.001);

%% ----- Spectrogram -----

wsize=0.05; % specify window size in seconds
wsize=round(wsize*fsamp); % convert to sample size

window=hanning(wsize); % use a Hanning window for analysis
% window=rectwin(wsize);

overl=0.9;  %The amount of overlap defined as a fraction of the window size
overl=round(overl*wsize); % convert to sample size
%{
overl is the number of the overlap sample
%}
                                      
fftres=wsize*2;                         %Same considerations for the
                                        %resolution as for the spectrum

% compute the spectrogram 
% Notice that we also get the corresponding frequency and time axes
[SG,Faxis,Taxis] = spectrogram(pOut_all,window,overl,fftres,fsamp);

%{
fftres is cyclical frequencies, specified as a vector. The units of f are specified by the sample rate, fs.
SG i spectrogram
Faxis is frequency axis
Taxis is time axis
%}

% plot sound level of spectrogram as an image and as a function of time and
% frequency
figure;
imagesc(Taxis,Faxis/1000,20*log10(abs(SG)./max(max(abs(SG))))); 
axis xy; % set the axis the right way around
ylabel('Frequency (kHz)'); xlabel('Time (s)')
grid on;
set(gca,'FontSize',14);
colormap('jet'); % choose a color map! set help graph3d for some options
set(gca,'clim',[-100 0]); % scale the color limit for the color map
colorbar; % create a colorbar as a legend!
% ylim([0 5000]/1000); % limit the range

