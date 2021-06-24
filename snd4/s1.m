%音脈分業が発生しやすい音刺激と発生しにくい音刺激を作成する
%周波数の異なる音を作成し、交互に提示する
%音の切り替えるテンポを調節して比較する
%音の周波数差を変えて比較する

%脳は「一つの音源であれば短時間内に周波数成分が大きく変化する可能性は低い」
%と考えるため、周波数が離れた音は別の音源として知覚される

clear;

Fs=16000;
t=[0:Fs/5-1]/Fs;
f=440;
f1=550;
f2=2000;

y=sin(2*pi*f*t);
y1=sin(2*pi*f1*t);
y2=sin(2*pi*f2*t);
b=zeros(1,Fs/5);

Y1=[y y1 y b];
Y2=[y y2 y b];

Y1frq = fft(Y1);
Y1frq = abs(Y1frq);
Y1frq = fftshift(Y1frq);

T = length(Y1)/Fs;         
fax = [-Fs/2 : 1/T : Fs/2-1];

%spectrum
%{
figure;
plot(fax, Y1frq);
xlim([-1500 1500]);
%}

Y1=[Y1 Y1 Y1 Y1];   %音脈分凝を生じにくい
Y2=[Y2 Y2 Y2 Y2];   %音脈分凝を生じやすい

%time
%{
figure;
tt = [0:3.2*Fs-1]/Fs;
plot(tt, Y1);
xlim([0 1.6]);
%}

figure;
pspectrum(Y1, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440-880Hz, 音脈分凝を生じにくい音");

figure;
pspectrum(Y2, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440-1320Hz, 音脈分凝を生じやすい音");

%sound(Y1,Fs);
sound(Y2,Fs);
