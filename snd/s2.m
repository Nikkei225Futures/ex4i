clear;

Fs = 16000;         %samplingfreq = 16khz
f1 = 440;           %freq = 440hz
t = [0:Fs-1]/Fs;    %time
ph1 = 90*pi/180;    %phase1 = 90deg
ph2 = 180*pi/180;   %phase2 = 180deg

y1 = sin(2*pi*f1*t);    
y2 = 0.25 * sin(2*pi*f1*t); %amp = 0.25x
y3 = 0.50 * sin(2*pi*f1*t); %amp = 0.50x
y4 = sin(2*pi*f1*t + ph1);  %init phase = 90deg
y5 = sin(2*pi*f1*t + ph2);  %init phase = 180deg

plot(t, y1, t, y2, t, y3, t, y4, t, y5);
axis([0 0.01 -1.2 1.2]);

all = [y1 y1 y1 y1:y2 y3 y4 y5];
soundsc(all, Fs);