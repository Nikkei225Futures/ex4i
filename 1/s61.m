clear;
Fs = 44100;
f = 440;
t = [0:Fs-1]/Fs;
y = sin(2*pi*f*t);

plot(t, y);
axis([0 0.01 -1 1]);
size(y)