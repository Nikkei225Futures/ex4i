close all;
clear;

Fs = 8000;              % sampling rate = 8000Hz
t = [0:Fs*(1/2)-1]/Fs;  % time = 0.5sec
startFreq = 440;               % init freq = 440Hz
endFreq = 880;               % final freq = 880Hz
k = (endFreq - 440) / 0.5;   
halfk = k/2;            % half of k

y = sin(2 * pi * (startFreq + halfk * t) .*t); % fomula of chirp wave(liner)

% plots from here

subplot(2,1,1);
plot(t, y);
axis([0 0.01 -1 1]);
xlabel('時間[s]');
ylabel('振幅');
title('チャープ波(0-0.01秒)');

subplot(2,1,2);
plot(t, y);
axis([0.49 0.50 -1 1]);
xlabel('時間[s]');
ylabel('振幅');
title('チャープ波(0.49-0.50秒)');

figure;
pspectrum(y, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60, 'FrequencyLimits',[200 1200]);
%sound(y, Fs);