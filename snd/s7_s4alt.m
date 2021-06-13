clear;

Fs=16000;  
f1=440;
f2=450;

t=([0:Fs*4-1]/Fs); %4sec for time

y1=sin(2*pi*f1*t);  %sin wave at 440Hz
y2=sin(2*pi*f2*t);  %sin wave at 441Hz
y3=y1+y2;         %y3 = y1+y2

plot(t,y3);
axis([0 1 -2 2]);
xlabel('時間[s]');
ylabel('振幅');
title('うなり');

soundsc(y3,Fs);

%周波数を高い側にnHz, 変えても, 低い側に変えても結果は変わらない
%差周波数10Hzだと, 1秒間に10回のうなりが発生する