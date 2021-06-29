close all;
clear;

Fs = 16000;
f1 = 440;
f2 = 660;

taxis = [0:Fs-1]/Fs;
func1 = sin(2*pi*f1*taxis);
func2 = sin(2*pi*f2*taxis);

%plots from here
plot(taxis, func1, taxis, func2);
legend('440Hz', '660Hz');
axis([0 0.01 -1 1]);
xlabel('時間[s]');
ylabel('振幅');

%sound(func1, Fs);
%sound(func2, Fs);