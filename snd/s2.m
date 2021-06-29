close all;
clear;

Fs = 16000;         %samplingfreq = 16khz
f1 = 440;           %freq = 440hz
ph1 = 90*pi/180;    %phase1 = 90deg
ph2 = 180*pi/180;   %phase2 = 180deg
t = [0:Fs-1]/Fs;    %time

func1 = sin(2*pi*f1*t);        %amp = 1.00x, init phase = 0deg  
func2 = 0.25 * sin(2*pi*f1*t); %amp = 0.25x
func3 = 0.50 * sin(2*pi*f1*t); %amp = 0.50x
func4 = sin(2*pi*f1*t + ph1);  %init phase = 90deg
func5 = sin(2*pi*f1*t + ph2);  %init phase = 180deg

%plots from here
subplot(2, 1, 1);
plot(t, func1, t, func2, t, func3);
legend('振幅1.00倍', '振幅0.25倍', '振幅0.50倍');
xlabel('時間[s]');
ylabel('振幅');
axis([0 0.01 -1 1]);

subplot(2, 1, 2);
plot(t, func1, t, func4, t, func5);
legend('位相0度', '位相90度', '位相180度');
xlabel('時間[s]');
ylabel('振幅');
axis([0 0.01 -1 1]);

ampDiff = [func1; func2]';    %1xAmp vs 0.25Amp
phDiff = [func1; func5]';     %0deg vs 180deg

%listen sound to remove comment out
%sound(ampDiff, Fs);
%sound(phDiff, Fs);