clear;

Fs = 16000;
f1 = 440;
f2 = 660;
t = [0:Fs-1]/Fs;
y1 = sin(2*pi*f1*t);
y2 = sin(2*pi*f2*t);

%plots from here
plot(t, y1, t, y2);
legend('440Hz', '660Hz');
axis([0 0.01 -1 1]);
xlabel('時間[s]');
ylabel('振幅');

sound(y1, Fs);
sound(y2, Fs);