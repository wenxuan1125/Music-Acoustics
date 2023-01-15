%% Variable initialization

disp('Song index: 1) Scale without staccato 2) Scale with staccato 3) Chinese melody') 
song_id = input('Please enter the song index: ');

fs = 44100;         % sampling frequency
t1 = 0.05; t2 = 1;  % two different time points for selecting frequencies

% Select frequencies and dB values by the measurements from the above magnitude spectra
% C2
f_C2 = [65 130 195 263 327 395 460 527 590 660 732 802 872 1015 1170 1402];
dB1_C2 = [-20.9 -18.7 -11.6 -11.7 -16 0 -12.6 -24.6 -27.7 -24 -23.3 -16.1 -20.7 -28.6 -31.2 -32.5];
dB2_C2 = [-25.2 -29.9 -18 -18.6 -21.5 -20.6 -36.6 -46.2 -57.7 -52.1 -53.3 -73.6 -52.6 -70.7 -74.1 -84.9];
% D2
f_D2 = [72 147 220 295 367 442 517 590 662 745 822 900 980 1064 1140];
dB1_D2 = [-10.2 0 -1 -10 -11.3 -2.6 -4.1 -13.6 -16.6 -11.7 -9.4 -3.5 -13.1 -7.9 -7.6];
dB2_D2 = [-13.9 -10.8 -9.6 -15.5 -18.2 -16.7 -23.1 -38.3 -40.3 -47.1 -47.9 -60.9 -56.2 -61 -53.1];
% E2
f_E2 = [83 165 247 330 412 495 577 662 750 835 920 1007 1077 1185 1365];
dB1_E2 = [-17.1 -16.5 -12.7 -4.9 -9.7  0 -21.6 -22.9 -34.5 -37.6 -22.2 -22.7 -35.1 -29.5 -33.9];
dB2_E2 = [-23.5 -26.9 -16.6 -20.5 -39.9 -18.6 -52.8 -37.9 -65.9 -64.7 -73.5 -65 -69.9 -88.3 -88.8];
% G2
f_G2 = [97 195 292 392 490 590 685 787 887 992 1095 1172 1272 1300];
dB1_G2 = [-14.3 -7 0 -10.7 -3.4 -15.6 -23 -18.5 -14.3 -20.4 -24.8 -36.9 -35.1 -30.7];
dB2_G2 = [-17.1 -10.8 -20.1 -13.5 -18.8 -35.8 -56.8 -48 -56.9 -55.9 -58.1 -74.3 -74.9 -82.5];
% A2
f_A2 = [110 220 330 440 550 660 772 887 997 1112 1225 1322];
dB1_A2 = [-16.6 -3.7 -8.4 0 -12.8 -27 -14.5 -15.2 -27.1 -27.5 -39.8 -37.6];
dB2_A2 = [-24.5 -15 -25.7 -16.2 -39.6 -51.4 -50.2 -57.8 -68.4 -92.4 -86.3 -86.3];
% C3
f_C3 = [130 260 392 440 490 522 652 785 917 1045 1177 1455 1570 2342 2505 3135 3172 3955 4337 4697];
dB1_C3 = [-22.5 -5.2 0 -41.3 -36.5 -10.9 -19.1 -18 -22.8 -29.2 -31.7 -35.8 -47.7 -60.7 -55.4 -63.1 -65 -80.2 -71.1 -71.9];
dB2_C3 = [-27 -26.3 -14.1 -63.8 -61.3 -26.5 -41 -52.5 -59.8 -70.1 -68.6 -85.2 -88.7 -98.6 -100 -102.4 -102 -108.7 -118.1 -118.1];
% D3
f_D3 = [147 292 440 587 732 882 1030 1175 1317 1485 1635 1785 1915];
dB1_D3 = [-2.67 0 -5.3 -24.4 -13 -20.1 -23.1 -19 -37.3 -30.9 -37.4 -42 -35.6];
dB2_D3 = [-17.5 -17.2 -35 -33.3 -43.2 -66.9 -71.7 -70.8 -74.2 -91.1 -86.9 -89.1 -93];
% E3
f_E3 = [165  330 390 495 657 825 992 1155 1317 1670 2185 2367 2725 3282];
dB1_E3 = [-3.2  -1.2 -31 0 -10.1 -21 -14.4 -30.7 -32.7 -33.1 -52.1 -51.5 -57.7 -66.2];
dB2_E3 = [-7.4  -4 -44.6 -17.1 -32.9 -43.5 -46.5 -69 -65.2 -85 -85.3 -95.7 -94.5 -95.7];
% G3
f_G3 = [195 245 392 590 782 982 1182 1385];
dB1_G3 = [-7.8 -43.2 0 -9.5 -31.6 -19.5 -26 -37.2];
dB2_G3 = [-18.3 -53.8 -34.6 -35 -55 -59.9 -66.7 -100.3];
% A3
f_A3 = [220 390 440 660 880 895 1105 1327 1552 1765 2235];
dB1_A3 = [-5.2 -28.2 0 -13.5 -23.9 -34.8 -25.7 -20.2 -31.6 -35.4 -37.6];
dB2_A3 = [-22.7 -51 -10.4 -34.8 -71.4 -58.7 -64.4 -75.6 -75.7 -88 -92.5];
% C4
f_C4 = [260 447 522 787 1050 1315 1585 1850 2110 2405 2670];
dB1_C4 = [-3.6 -29.1 0 -8.2 -15.9 -19.9 -30.5 -39.8 -47.6 -46.3 -46.6];
dB2_C4 = [-18.3 -40.5 -10 -37.2 -44.1 -70.2 -84.8 -87.7 -79.2 -89.4 -86.7];
% D4
f_D4 = [292 432 587 880 1175 1472 1775 2070 2367 2677 3245];
dB1_D4 = [0 -31.1 -4.4 -14.1 -8.6 -16.2 -33.9 -35 -38.9 -36.6 -32.5];
dB2_D4 = [-7.4 -41.6 -11.6 -45.1 -40.2 -69 -77.5 -77.1 -82.4 -82.6 -94.4];
% E4
f_E4 = [327 390 547 660 990 1317 1652 1977 2322 2670 3010 3335 3347 3385];
dB1_E4 = [-2.6 -35.8 -34.2 0 -25.3 -21/5 -26.6 -45.6 -49.0 -41.6 -64.5 -76.2 -57.6 -72];
dB2_E4 = [-16.6 -54.5 -53.6 -24.7 -56.1 -68.9 -91.5 -96.5 -91.8 -95.7 -108.4 -99 -110.1 -99.2];
% G4
f_G4 = [392 517 780 1180 1575 1667 1972 2377 2775 3179 3537 3550 3587];
dB1_G4 = [0 -49.7 -8.9 -22.3 -23.6 -50.6 -26.8 -44.5 -50.5 -50.5 -68.3 -63.2 -60.9];
dB2_G4 = [-21.2 -56 -44.8 -72.8 -82.1 -93.4 -94.5 -105.7 -102.9 -100.3 -109.8 -110.7 -116.1];
% Rest
f_Rest = [];
dB1_Rest = [];
dB2_Rest = [];

%% Mapping the notes, frequencies, dB1, dB2

note_set = {'C2' 'D2' 'E2' 'G2' 'A2' 'C3', 'D3', 'E3', 'G3', 'A3', 'C4', 'D4', 'E4', 'G4', 'Rest'};
fest_set = {f_C2, f_D2, f_E2, f_G2, f_A2, f_C3, f_D3, f_E3, f_G3, f_A3, f_C4, f_D4, f_E4,f_G4, f_Rest};
dB1_set = {dB1_C2, dB1_D2, dB1_E2, dB1_G2, dB1_A2, dB1_C3, dB1_D3, dB1_E3, dB1_G3, dB1_A3, dB1_C4, dB1_D4, dB1_E4, dB1_G4, dB1_Rest};
dB2_set = {dB2_C2, dB2_D2, dB2_E2, dB2_G2, dB2_A2, dB2_C3, dB2_D3, dB2_E3, dB2_G3, dB2_A3, dB2_C4, dB2_D4, dB2_E4, dB2_G4, dB2_Rest};
fest_map = containers.Map(note_set, fest_set);
dB1_map = containers.Map(note_set, dB1_set);
dB2_map = containers.Map(note_set, dB2_set);

%% Interpolate other notes

intepolate_note = {'F' 'A#' 'B' 'C#' 'D#' 'F#' 'G#'};
for note = intepolate_note
    for i=2:4 % C2-C4
        note_name = cell2mat(note);
        
        % those are at the end of the scale
        if i == 4 & (note_name == 'G#' | note_name == 'A#' | note_name == 'B')
            continue
        end
        
        % determine the lower and the higher notes of the interpolated notes
        if note_name == 'F'
            l = strcat('E', num2str(i));
            r = strcat('G', num2str(i));
        elseif note_name == 'A#'
            l = strcat('A', num2str(i));
            r = strcat('C', num2str(i+1));
        elseif note_name == 'C#'
            l = strcat('C', num2str(i));
            r = strcat('D', num2str(i));
        elseif note_name == 'D#'
            l = strcat('D', num2str(i));
            r = strcat('E', num2str(i));
        elseif note_name == 'F#'
            l = strcat('F', num2str(i));
            r = strcat('G', num2str(i));
        elseif note_name == 'G#'
            l = strcat('G', num2str(i));
            r = strcat('A', num2str(i));
        elseif note_name == 'B'
            l = strcat('A#', num2str(i));
            r = strcat('C', num2str(i+1));
        end
        
        % get the minimum length of the lower and the higher notes
        min_len = min(length(fest_map(l)), length(fest_map(r)));
        f_l = fest_map(l);
        f_l = f_l(1:min_len);
        f_r = fest_map(r);
        f_r = f_r(1:min_len);
        
        dB1_l = dB1_map(l);
        dB1_l = dB1_l(1:min_len);
        dB1_r = dB1_map(r);
        dB1_r = dB1_r(1:min_len);
        dB2_l = dB2_map(l);
        dB2_l = dB2_l(1:min_len);
        dB2_r = dB2_map(r);
        dB2_r = dB2_r(1:min_len);
        
        % calculating the frequency of the interpolated notes
        if cell2mat(note) == 'F' | cell2mat(note) == 'A#'
            fest = (f_r ./ f_l).^(1/3) .* f_l;  % two semitones b/w the notes
        else
            fest = sqrt(f_l .* f_r);            % one semitone  b/w the notes
        end
        
        dB1 = (dB1_l + dB1_r)/2;
        dB2 = (dB2_l + dB2_r)/2;
        
        name = strcat(note_name, num2str(i));
        fest_map(name) = fest;
        dB1_map(name) = dB1;
        dB2_map(name) = dB2;
       
    end
end

%% Construct scales

song_scale = {'C2' 'C#2' 'D2' 'D#2' 'E2' 'F2' 'F#2' 'G2' 'G#2' 'A2' 'A#2' 'B2' ...
        'C3' 'C#3' 'D3' 'D#3' 'E3' 'F3' 'F#3' 'G3' 'G#3' 'A3' 'A#3' 'B3' ...
        'C4' 'C#4' 'D4' 'D#4' 'E4' 'F4' 'F#4' 'G4' };

tempo_scale = ones(1, 32)*0.8;
no_staccato_scale = ones(1, 32); % the larger the value is, the more the staccato is
staccato_scale = ones(1, 32)*4;  % the larger the value is, the more the staccato is
volume_scale = ones(1, 32);

%% Construct Chinese song

% 1 for right hand part
song1_chinese = {'E4' 'G4' 'D4' 'E4' 'G4' 'D4' 'E4' 'G4' 'C4' 'B3' 'A3' 'G3' 'A3' 'G3' ... 
        'A3' 'E4' 'D4' 'E4' 'G4' 'D4' ...
        'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' 'E4' ...
        'E4' 'G4' 'D4' 'E4' 'G4' 'D4' 'E4' 'G4' 'C4' 'B3' 'A3' 'G3' 'A3' 'A3' 'C4' ...  
        'E4' 'A3' 'C4' 'D4' 'E4' 'G4' 'A3' };
tempo1_chinese = [1 1 2 1 1 2 1 1 1 1 1 1 3 1 ...
          3 1 1 1 1 1 ...
          0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 2 ...
          1 1 2 1 1 2 1 1 1 1 1 1 2 1 1 ...
          2 1 1 2 1 1 8] / 2;
staccato1_chinese = [0.85 1 1 0.9 1 1 1.2 1 1.2 1.1 1.1 1 1 1.2 ...
          1 0.6 0.9 1 1 1 ...
          0.5 2 1.2 1 0.2 1 1.1 1.4 1.1 0.3 2.5 0.2 1.4 0.9 1.3 1.6 1 0.7 1.1 1.1 1.3 ...
          0.95 1 1 0.9 1 1 1.2 1 1.2 1.1 1.1 1 1.1 1.2 1.2 ...
          0.85 1.2 1.2 1 1 1 0.7]/1.5;
volume1_chinese = [0.7 1.2 0.9 0.8 1.3 0.8 1 1.4 1.6 1.3 1 0.9 0.8 0.8 ...
          1.1 0.6 1 1.1 1.4 1.1 ...
          0.5 0.1 0.05 0.15 0.3 0.4 0.35 0.6 0.5 0.65 0.8 0.6 0.85 0.95 1.05 0.65 0.6 0.4 0.45 0.3 0.4 ...
          0.6 1 0.7 0.8 1.3 1.1 1 1.4 1.6 1.3 1 0.9 0.8 0.8 0.8 ...
          0.8 1 1 1 1.1 1.1 1];

% 2 for left hand part
song2_chinese = {'Rest' ...
         'F2' 'C3' 'A3' 'G2' 'D3' 'G3' 'A2' 'E3' 'A3' 'C3' 'E3' 'C3' ...%'A2' 'E3' 'E3' 'C3' 'A2' ...
         'F2' 'C3' 'F3' 'G2' 'D3' 'G3' 'C3' 'G3' 'C4' 'G3' 'D4' 'E4' ...
         'F2' 'C3' 'A3' 'G2' 'D3' 'G3' 'A2' 'E3' 'A3' 'C3' 'E3' 'C3' ...
         'F2' 'C3' 'F3' 'G2' 'D3' 'G3' 'A2' 'E3' 'A3' 'D4' 'E4' 'A3' 'D4' 'E4' 'C#4'};
tempo2_chinese = [2 ...
          1 1 2 1 1 2 1 1 1 1 2 2 ...% 1 2 2 1 2 ...
          1 1 2 1 1 2 1 1 1 1 2 2 ...
          1 1 2 1 1 2 1 1 1 1 2 2 ...
          1 1 2 1 1 2 1 1 1 1 1 1 1 1 8] /2;
staccato2_chinese = [1 ...
          1 1 1 1 1 1 1.2 1.2 1.2 1.2 1 0.8 ...% 1 2 2 1 2 ...
          1 1 1 1 1 1 1.2 1.2 1.2 1.2 1 0.8 ...
          1 1 1 1 1 1 1.2 1.2 1.2 1.2 1 0.8 ...
          1 1 1 1 1 1 1.2 1.2 1.1 0.8 0.9 1.1 1 0.9 0.7]/1.5;
volume2_chinese = [1 ...
          1 1.1 1.25 0.7 1.2 1.5 1 1.3 1.5 1.2 1.45 1.5 ...
          1 1 1 1 1.1 1.2 1.2 1.2 1.2 1.2 1.4 1 ...
          0.8 0.95 1.1 0.9 1.2 1.4 1.1 1.1 1.1 1.1 1.4 1.2 ...
          0.7 0.9 1 0.9 1.2 1.4 1 0.7 1.05 0.75 0.8 1.1 0.85 0.8 0.7]*0.8;

% Play out different melody according to the user input
if song_id == 1
    song1 = song_scale;
    tempo1 = tempo_scale;
    staccato1 = no_staccato_scale;
    volume1 = volume_scale;
    song2 = [];
    tempo2 = [];
    staccato2 = [];
elseif song_id == 2
    song1 = song_scale;
    tempo1 = tempo_scale;
    staccato1 = staccato_scale;
    volume1 = volume_scale;
    song2 = [];
    tempo2 = [];
    staccato2 = [];
elseif song_id == 3
    song1 = song1_chinese;
    tempo1 = tempo1_chinese;
    staccato1 = staccato1_chinese;
    volume1 = volume1_chinese;
    song2 = song2_chinese;
    tempo2 = tempo2_chinese;
    staccato2 = staccato2_chinese;
    volume2 = volume2_chinese;
end
xsynth_all = zeros(ceil(max(sum(tempo1+6),sum(tempo2+6))*fs), 1);

% right hand
for i=1:length(song1)
    fest = fest_map(cell2mat(song1(i)));
    dB1 = dB1_map(cell2mat(song1(i)));
    dB2 = dB2_map(cell2mat(song1(i)));
    % estimate parameters
    gammaest = (dB1-dB2)./(20/log(10))/(t2-t1);
    Ampest = 10.^(dB1/20 + gammaest*t1/log(10));
    
    dur = 6;
    t = [0:dur*fs-1]'/fs;
    xsynth = zeros(length(t),1);
    for ii=1:length(Ampest)
        xsynth = xsynth + volume1(i)*Ampest(ii)*exp(-staccato1(i)*gammaest(ii)*t).*sin(2*pi*t*fest(ii));
    end
    pos = ceil(sum(tempo1(1:i-1))*fs)+1;
    xsynth_all(pos:pos+length(xsynth)-1) = xsynth_all(pos:pos+length(xsynth)-1) + xsynth;
end

% left hand
for i=1:length(song2)
    fest = fest_map(cell2mat(song2(i)));
    dB1 = dB1_map(cell2mat(song2(i)));
    dB2 = dB2_map(cell2mat(song2(i)));
    % estimate parameters
    gammaest = (dB1-dB2)./(20/log(10))/(t2-t1);
    Ampest = 10.^(dB1/20 + gammaest*t1/log(10));
    
    dur = 6;
    t = [0:dur*fs-1]'/fs;
    xsynth = zeros(length(t),1);
    for ii=1:length(Ampest)
        xsynth = xsynth + volume2(i)*Ampest(ii)*exp(-staccato2(i)*gammaest(ii)*t).*sin(2*pi*t*fest(ii));
    end
    pos = ceil(sum(tempo2(1:i-1))*fs)+1;
    xsynth_all(pos:pos+length(xsynth)-1) = xsynth_all(pos:pos+length(xsynth)-1) + xsynth;
end

% Play out the melody
soundsc(xsynth_all,fs);

%{
x = xsynth./max(abs(xsynth));
createFigure2;
plot(t,xsynth,'k');
grid on;
axis([0 dur -1.5 1.5])
xlabel('Time (s)');
ylabel('Amplitude');
title('Gsp_ME_f_L-sus_F#5 - synthesized signal'); 
soundsc(xsynth,fs);
audiowrite('more.wav',xsynth,fs);
%}
