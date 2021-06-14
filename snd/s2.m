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

%plots from here
subplot(2, 1, 1);
plot(t, y2, t, y3);
legend('振幅0.25倍', '振幅0.50倍');
xlabel('時間[s]');
ylabel('振幅');
axis([0 0.01 -1 1]);

subplot(2, 1, 2);
plot(t, y4, t, y5);
legend('位相90度', '位相180度');
xlabel('時間[s]');
ylabel('振幅');
axis([0 0.01 -1 1]);

ampDiff = [y1; y2]';    %1xAmp vs 0.25Amp
phDiff = [y1; y5]';     %0deg vs 180deg

sound(ampDiff, Fs);