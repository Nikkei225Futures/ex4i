close all;
clear;

Fs=8192;                % sampling rate = 8292hz
t=[0:Fs/4-1]/Fs;
t2=[0:2*Fs-1]/Fs;

freqScale1=[0:0.5:Fs-0.5];
freqScale2=[-Fs/2:0.5:Fs/2-0.5];

do=sin(2*pi*261.38*t);  %ド
re=sin(2*pi*293.67*t);  %レ
mi=sin(2*pi*329.63*t);  %ミ
fa=sin(2*pi*349.23*t);  %ファ
so=sin(2*pi*392.00*t);  %ソ
ra=sin(2*pi*440.00*t);  %ラ
si=sin(2*pi*493.88*t);  %シ
doUpper=sin(2*pi*523.23*t);  %ド↑

naturalOctave=[do re mi fa so ra si doUpper];  %ドレミファソラシドの連結

freqNatural=fft(naturalOctave);          %fftする
shiftedFreqNatural=fftshift(freqNatural);     %fftshiftする

%HPFの作成
freqHigh=ones(1,7442);
freqLow=zeros(1,750);
HPF=[freqHigh freqLow freqLow freqHigh];    %HPF
filteredOctave=shiftedFreqNatural.*HPF;      %HPFをかける

shiftedOctave=ifftshift(filteredOctave);
timeOctave=ifft(shiftedOctave); 
timeOctave=real(timeOctave);

%figure;

%IFFT後の波形
plot(t2,timeOctave);
axis([0 2,-1.5 1.5]);
xlabel('Time[s]');
ylabel('Amplitude');
title('IFFT後の波形');

sound(timeOctave,Fs); %ドレミファの音

%%%%%%%%%%%%%%%%%%%%%%%%レポート用グラフ%%%%%%%%%%%%%%%%%%%%%%%%%%

%figure;

%yの波形
subplot(2,2,1);
plot(t2,naturalOctave);
axis([0 2,-1.5 1.5]);
xlabel('Time[s]');
ylabel('Amplitude');
title('1.ドレミファソラシドの波形');

%FFT後の波形
subplot(2,2,2);
freqNatural=abs(freqNatural);
plot(freqScale1,freqNatural);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('2.FFT後の波形');

%fftshift後の波形
subplot(2,2,3);
shiftedFreqNatural=abs(shiftedFreqNatural);
plot(freqScale2,shiftedFreqNatural);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');shiftedFreqNatural=abs(shiftedFreqNatural);
title('3.fftshift後の波形');

%拡大後の波形
subplot(2,2,4);
plot(freqScale2,shiftedFreqNatural);
axis([200 600,0 1200]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('4.拡大後の波形');

figure;

%HPF適用前の波形
subplot(2,2,1);
plot(freqScale2,shiftedFreqNatural);
axis([-600 600,0 1200]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('5.HPF適用前の波形');

%HPF適用後の波形
subplot(2,2,2);
filteredOctave=abs(filteredOctave);
plot(freqScale2,filteredOctave);
axis([-600 600,0 1200]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('6.HPF適用後の波形');

%IFFT後の波形
subplot(2,2,3);
plot(t2,timeOctave);
axis([0 2,-1.5 1.5]);
xlabel('Time[s]');
ylabel('Amplitude');
title('7.IFFT後の波形');

%graph of hpf
subplot(2,2,4);
plot(freqScale2,HPF);
axis([-600 600, -0.1 1.1]);
xlabel('Frequency[Hz]');
ylabel('filter');
title('HPF');