%音と音の間に強いノイズを差し込むことで音が連続して聞こえる減少のこと
%ただし、ノイズに音の周波数が含まれていなければ連続して聞こえない

%ホワイトノイズ:　すべての周波数が同じ強さ(一様雑音)
%ピンクノイズ:　パワーが周波数に反比例

%ホワイトノイズはすべての周波数成分が一様に含まれているので
%どのような音でも連続聴効果が生じる

%ピンクノイズだと、高い音だとつながって聞こえにくい
%->高い音の周波数成分がピンクノイズに含まれない(少ししか含まれない)ため

close all;
clear;

Fs=16000;
t1=[0:0.15*Fs-1]/Fs;

whiteNoise=2*(rand(1,Fs*0.15)-1/2);      %ホワイトノイズ

T=length(whiteNoise)/Fs;
scaleFreq=[-Fs/2:1/T:Fs/2-1];

figure;
subplot(2,1,1);
plot(t1,whiteNoise);
axis([0 0.2,0 1.5]);
xlabel('時間[s]');
ylabel('Amplitude');
title('ホワイトノイズ(時間領域)');


freqWhiteNoise=fft(whiteNoise);
shiftedWhiteNoise=fftshift(freqWhiteNoise);

subplot(2,1,2);
plot(scaleFreq,abs(freqWhiteNoise));
xlabel('周波数[Hz]');
ylabel('Amplitude Spectrum');
title('ホワイトノイズ(周波数領域)');


y=[-Fs/2:1/T:Fs/2-1];
y=[-length(t1)/2:1:length(t1)/2-1];


%filters
figure;
subplot(3,1,1)
plot(scaleFreq,y);
xlabel('周波数[Hz]');
title('フィルタ1(y=f)');


y(y==0)=1;
Y=y.^(-1);

subplot(3,1,2);
plot(scaleFreq,Y);
axis([-4000 4000,-0.2 0.2]);
xlabel('周波数[Hz]');
title('フィルタ2(y=filter1^-1)');

Y=abs(Y);

subplot(3, 1, 3);
plot(scaleFreq,Y);
axis([-4000 4000,-0.2 0.2]);
xlabel('周波数[Hz]');
title('フィルタ3(y=1/f)');

%ピンクノイズの作成方法 -> ホワイトノイズとフィルタをかけ合わせる

pinkNoise=shiftedWhiteNoise.*Y;



Pshift=ifftshift(pinkNoise);
Ptime=ifft(Pshift);
Ptime=real(Ptime);

figure;

subplot(2,1,1);
plot(t1,Ptime);
xlabel('時間[s]');
ylabel('Amplitude');
title('ピンクノイズ(時間領域)');

subplot(2,1,2);
plot(scaleFreq,pinkNoise);
axis([-4000 4000, -3 3]);
xlabel('周波数[Hz]');
title('ピンクノイズ(周波数領域)');


Fs=16000;
Ptime=Ptime*700;
%sound(P,Fs);

f1=440;     %ra
f2=2000;    %mi +2

t=[0:Fs-1]/Fs;
y1=sin(2*pi*f1*t);
y3=0.08*sin(2*pi*f2*t);

%4つの音刺激
sound1=[y1 whiteNoise y1 whiteNoise y1 whiteNoise y1 whiteNoise y1 whiteNoise y1 whiteNoise]; %1 440Hz-whitenoise-440Hz-whitenoise....
sound2=[y1 Ptime y1 Ptime y1 Ptime y1 Ptime y1 Ptime y1 Ptime]; %2 440Hz-pink-440Hz-pink...
sound3=[y3 whiteNoise y3 whiteNoise y3 whiteNoise y3 whiteNoise y3 whiteNoise y3 whiteNoise]; %3 2000Hz-white-2000Hz-white...
sound4=[y3 Ptime y3 Ptime y3 Ptime y3 Ptime y3 Ptime y3 Ptime]; %4 2000Hz-pink-2000Hz-pink

figure;
subplot(2,2,1);
pspectrum(sound1, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440Hzにホワイトノイズを挿入");

subplot(2,2,2);
pspectrum(sound2, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440Hzにピンクノイズを挿入");

subplot(2,2,3);
pspectrum(sound3, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("2000Hzにホワイトノイズを挿入");

subplot(2,2,4);
pspectrum(sound4, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("2000Hzにピンクノイズを挿入");

%sound(sound1,Fs);  %440-wn
%sound(sound2,Fs);  %440-pn
%sound(sound3,Fs);  %1320-wn
%sound(sound4,Fs);  %1320-pn

