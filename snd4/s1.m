%音脈分業が発生しやすい音刺激と発生しにくい音刺激を作成する
%周波数の異なる音を作成し、交互に提示する
%音の切り替えるテンポを調節して比較する
%音の周波数差を変えて比較する

%脳は「一つの音源であれば短時間内に周波数成分が大きく変化する可能性は低い」
%と考えるため、周波数が離れた音は別の音源として知覚される

close all;
clear;

Fs=16000;
t=[0:Fs/5-1]/Fs;
f=440;
f1=550;
f2=2000;

pure440hz=sin(2*pi*f*t);
pure550hz=sin(2*pi*f1*t);
pure2000hz=sin(2*pi*f2*t);

blank=zeros(1,Fs/5);

closerFreqsFunc=[pure440hz pure550hz pure440hz blank];
distantFreqsFunc=[pure440hz pure2000hz pure440hz blank];

Y1frq = fft(closerFreqsFunc);
Y1frq = abs(Y1frq);
Y1frq = fftshift(Y1frq);

T = length(closerFreqsFunc)/Fs;         
fax = [-Fs/2 : 1/T : Fs/2-1];

%spectrum
%{
figure;
plot(fax, Y1frq);
xlim([-1500 1500]);
%}

closerFreqsFunc=[closerFreqsFunc closerFreqsFunc closerFreqsFunc closerFreqsFunc];   %音脈分凝を生じにくい
distantFreqsFunc=[distantFreqsFunc distantFreqsFunc distantFreqsFunc distantFreqsFunc];   %音脈分凝を生じやすい

%time
%{
figure;
tt = [0:3.2*Fs-1]/Fs;
plot(tt, Y1);
xlim([0 1.6]);
%}

figure;
pspectrum(closerFreqsFunc, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440-550Hz, 音脈分凝を生じにくい音");

figure;
pspectrum(distantFreqsFunc, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440-2000Hz, 音脈分凝を生じやすい音");

%sound(closerFreqsFunc,Fs);
%sound(distantFreqsFunc,Fs);
