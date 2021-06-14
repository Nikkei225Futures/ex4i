clear;

Fs=16000;           % sampling rate = 16KHz
f1=440;
f2=441;             

t=([0:Fs*4-1]/Fs);  % 4sec for time

y1=sin(2*pi*f1*t);  % sin wave at 440Hz
y2=sin(2*pi*f2*t);  % sin wave at 441Hz
y3=y1+y2;           % y3 = y1+y2

% plots from here
plot(t,y3);         % 440Hz + 441Hz sin wave
axis([0 4 -2 2]);   
xlabel('時間[s]');
ylabel('振幅');
title('うなり');

soundsc(y3,Fs);