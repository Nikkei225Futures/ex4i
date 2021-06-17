clear;
%%%%%%%%%純音の周波数解析%%%%%%%%%
Fs = 8192;             % sampling rate = 8192Hz
t = [0:Fs-1]/Fs;       % 1sec   

% ((1024points/8192hz)^-1 = 8hz)
f2 = [0:8:8191];       % scale of freq1
f3 = [-Fs/2:8:Fs/2-8]; % scale of freq2

y = sin(2*pi*440*t);   % sin wave of 440hz
y2 = sin(2*pi*440.2*t);  % sin wave of 440.2hz

y1 = y(1:1024);        % sampling(1024 points of sin wave)
y2 = y2(1:1024);       % sampling

Y1 = fft(y1);          % fft y1
Y2 = fft(y2);          % fft y2
Y1 = abs(Y1);
Y2 = abs(Y2);
Y1shift = fftshift(Y1);  % - <-----> +
Y2shift = fftshift(Y2);

%%%%%% plots of pure tone %%%%%
figure;
subplot(2, 1, 1);
plot(f3,Y1shift);
axis([0 1000,0 600]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('拡大した440Hzの純音');

subplot(2, 1, 2);
plot(f3,Y2shift);
axis([0 1000,0 600]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('拡大した440.2Hzの純音');


%%%%%%%%%矩形波の周波数解析%%%%%%%%%
x=zeros(1,128);
x1=ones(1,128);
x2=[x x1];         % 1 cycle of square wave(0x128-1x128)
x3=[x2 x2 x2 x2];  % 4 cycle of square wave
t2=[0:Fs/8-1]/Fs;  % 1/8sec

X=fft(x3);         % fft 
X=abs(X);          
Xshift=fftshift(X); % - <---> + 

figure;

plot(f3,Xshift);
axis([0 200,0 600]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('拡大した矩形波(1/(2k-1)で減衰)');


%%%%%%%%%%%%%%%%%%%%%レポート用のグラフ%%%%%%%%%%%%%%%%%%%%%

%{
%正弦波のグラフ
figure;

subplot(2,2,1);
plot(t,y);
axis([0 0.02,-1 1]);
xlabel('Time[s]');
ylabel('Amplitude');
title('1.純音');

subplot(2,2,2);
plot(f2,Y1);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('2.FFT後の純音');

subplot(2,2,3);
plot(f3,Y1shift);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('3.fftshift後の純音');

%矩形波のグラフ
figure;

subplot(2,2,1);
plot(t2,x3);
axis([0 0.14,-0.2 1.2]);
xlabel('Time[s]');
ylabel('Amplitude');
title('1.矩形波');

subplot(2,2,2);
plot(f2,X);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('2.FFT後の矩形波');

subplot(2,2,3);
plot(f3,Xshift);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('3.fftshift後の矩形波');
%}
