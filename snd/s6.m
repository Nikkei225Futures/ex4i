close all;
clear;

Fs=16000;            % sampling rate = 16kHz
t=([0:Fs-1]/Fs);     % time = 1sec
whiteGaussianNoise=0.2*randn(1,Fs);   % make white noise

% plots from here 
figure;
%subplot(2,1,1);
plot(t, whiteGaussianNoise);
axis([0 1,-1 1]);
xlabel('時間[s]');
ylabel('振幅');
%title('白色ガウス雑音');

%make histgram
ranks=100; 
[h,c]=hist(whiteGaussianNoise,ranks);

figure;
%subplot(2,1,2);
plot(c,h);
ylabel('頻度');
xlabel('周波数[Hz]');
%title('振幅ヒストグラム');

sound(whiteGaussianNoise,Fs);