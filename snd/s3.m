clear;

Fs = 16000;         %samplingfreq = 16khz
f1 = 440;           %freq = 440hz
t = [0:Fs-1]/Fs;    %time

y = chirp(t, f1, t(Fs/2), 880);

plot(y, Fs);
axis([0 1 -1.2 1.2]);