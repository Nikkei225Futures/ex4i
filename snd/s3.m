clear;

Fs = 8000;
f0 = 440;
f1 = 880;
t = [0:Fs*(1/2)-1]/Fs;
k = (f1 - 440) / 0.5;
halfk = k/2;


y = sin(2 * pi * (f0 + halfk * t) .*t);

subplot(2,1,1);
plot(t, y);
axis([0.49 0.50 -1 1]);

subplot(2,1,2);
plot(t, y);
axis([0 0.01 -1 1]);
ylabel("周波数");

sound(y, Fs);