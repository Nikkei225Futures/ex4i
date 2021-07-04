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

figure;
%IFFT後の波形
plot(t2,timeOctave);
axis([0 2,-1.5 1.5]);
xlabel('Time[s]');
ylabel('振幅');
%title('HPF適用後のドレミファソラシドの音');

sound(timeOctave,Fs); %ドレミファの音

%plots from here%

figure;
pspectrum(naturalOctave, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60, 'FrequencyLimits',[0 1000]);
figure;
pspectrum(timeOctave, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60, 'FrequencyLimits',[0 1000]);

%graph of hpf
%subplot(2,2,4);
figure;
plot(freqScale2,HPF);
axis([-600 600, -0.1 1.1]);
xlabel('周波数[Hz]');
ylabel('filter');
%title('HPF');