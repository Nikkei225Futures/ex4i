close all;
clear;

Fs = 16000;
freq1 = 440;
freq2 = 660;

t = [0:Fs-1]/Fs;
func1 = sin(2*pi*freq1*t);
func2 = sin(2*pi*freq2*t);

%plots from here
plot(t, func1, t, func2);
legend('440Hz', '660Hz');
axis([0 0.01 -1 1]);
xlabel('時間[s]');
ylabel('振幅');

%sound(func1, Fs);
sound(func2, Fs);