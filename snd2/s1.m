close all;
clear;

Fs = 8192;             % sampling rate = 8192Hz
t = [0:Fs-1]/Fs;       % 1sec   

% ((1024points/8192hz)^-1 = 8hz)
fscale2 = [0:8:8191];       % scale of freq1
fscale3 = [-Fs/2:8:Fs/2-8]; % scale of freq2

pure440hz = sin(2*pi*440*t);   % sin wave of 440hz
pure4402Hz = sin(2*pi*440.2*t);  % sin wave of 440.2hz

smpld440hz = pure440hz(1:1024);        % sampling(1024 points of sin wave)
pure4402Hz = pure4402Hz(1:1024);       % sampling

freq440hz = fft(smpld440hz);          % fft y1
freq4402hz = fft(pure4402Hz);          % fft y2
freq440hz = abs(freq440hz);
freq4402hz = abs(freq4402hz);
shiftedFreq440hz = fftshift(freq440hz);  % - <-----> +
shiftedFreq4402hz = fftshift(freq4402hz);

%%%%%% plots of pure tone %%%%%
figure;
subplot(2, 1, 1);
plot(fscale3,shiftedFreq440hz);
axis([0 1000,0 600]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
%title('拡大した440Hzの純音');

subplot(2, 1, 2);
plot(fscale3,shiftedFreq4402hz);
axis([0 1000,0 600]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
%title('拡大した440.2Hzの純音');


%矩形波
zeroArea=zeros(1,128);
oneArea=ones(1,128);

cycleOfSquare=[zeroArea oneArea];         % 1 cycle of square wave(0x128-1x128)
fourCycle=[cycleOfSquare cycleOfSquare cycleOfSquare cycleOfSquare];  % 4 cycle of square wave
t2=[0:Fs/8-1]/Fs;  % 1/8sec

X=fft(fourCycle);         % fft 
X=abs(X);          
Xshift=fftshift(X); % - <---> + 

figure;

plot(fscale3,Xshift);
axis([0 200,0 600]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
%title('拡大した矩形波(1/(2k-1)で減衰)');


%%%%%%%%%%%%%%%%%%%%%レポート用のグラフ%%%%%%%%%%%%%%%%%%%%%


%正弦波のグラフ
figure;

subplot(2,2,1);
plot(t,pure440hz);
axis([0 0.02,-1 1]);
xlabel('Time[s]');
ylabel('Amplitude');
%title('1.純音');

subplot(2,2,2);
plot(fscale2,freq440hz);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
%title('2.FFT後の純音');

subplot(2,2,3);
plot(fscale3,shiftedFreq440hz);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
%title('3.fftshift後の純音');

%矩形波plots
figure;
%subplot(2,2,1);
plot(t2,fourCycle);
axis([0 0.14,-0.2 1.2]);
xlabel('Time[s]');
ylabel('Amplitude');
%title('1.矩形波');

figure
%subplot(2,2,2);
plot(fscale2,X);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
%title('2.FFT後の矩形波');

figure;
%subplot(2,2,3);
plot(fscale3,Xshift);
axis([0 200,0 600]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
%title('3.fftshift後の矩形波');

