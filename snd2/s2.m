clear;

Fs=8192;           
t=[0:Fs/4-1]/Fs;         %時刻 それぞれの周波数における
t2=[0:2*Fs-1]/Fs;        %yの時間

h1=[0:0.5:Fs-0.5];       %周波数軸の設定1(仮)
h2=[-Fs/2:0.5:Fs/2-0.5]; %サンプリング定理より周波数軸の設定2

y1=sin(2*pi*261.38*t);  %ドの信号
y2=sin(2*pi*293.67*t);  %レの信号
y3=sin(2*pi*329.63*t);  %ミの信号
y4=sin(2*pi*349.23*t);  %ファの信号
y5=sin(2*pi*392.00*t);  %ソの信号
y6=sin(2*pi*440.00*t);  %ラの信号
y7=sin(2*pi*493.88*t);  %シの信号
y8=sin(2*pi*523.23*t);  %ドの信号

y=[y1 y2 y3 y4 y5 y6 y7 y8];  %ドレミファソラシドの連結

Y=fft(y);          %fftする
Yshift=fftshift(Y);     %fftshiftする

%HPFの作成
x1=ones(1,7442);
x2=zeros(1,750);
x3=zeros(1,750);
x4=ones(1,7442);
X=[x1 x2 x3 x4];  %HPF
A=Yshift.*X;      %HPF

Ashift=ifftshift(A);   %ifftshiftする
Z=ifft(Ashift);        %ifftする
Z=real(Z);    %周波数領域に変換して空間領域に戻したときに虚数部が残るので実部のみを取り出す

%figure;

%IFFT後の波形
plot(t2,Z);
axis([0 2,-1.5 1.5]);
xlabel('Time[s]');
ylabel('Amplitude');
title('IFFT後の波形');

sound(Z,Fs); %ドレミファの音

%%%%%%%%%%%%%%%%%%%%%%%%レポート用グラフ%%%%%%%%%%%%%%%%%%%%%%%%%%

%figure;

%yの波形
subplot(2,2,1);
plot(t2,y);
axis([0 2,-1.5 1.5]);
xlabel('Time[s]');
ylabel('Amplitude');
title('1.ドレミファソラシドの波形');

%FFT後の波形
subplot(2,2,2);
Y=abs(Y);
plot(h1,Y);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('2.FFT後の波形');

%fftshift後の波形
subplot(2,2,3);
Yshift=abs(Yshift);
plot(h2,Yshift);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');Yshift=abs(Yshift);
title('3.fftshift後の波形');

%拡大後の波形
subplot(2,2,4);
plot(h2,Yshift);
axis([200 600,0 1200]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('4.拡大後の波形');

figure;

%HPF適用前の波形
subplot(2,2,1);
plot(h2,Yshift);
axis([-600 600,0 1200]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('5.HPF適用前の波形');

%HPF適用後の波形
subplot(2,2,2);
A=abs(A);
plot(h2,A);
axis([-600 600,0 1200]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('6.HPF適用後の波形');

%IFFT後の波形
subplot(2,2,3);
plot(t2,Z);
axis([0 2,-1.5 1.5]);
xlabel('Time[s]');
ylabel('Amplitude');
title('7.IFFT後の波形');

%graph of hpf
subplot(2,2,4);
plot(h2,X);
axis([-600 600, -0.1 1.1]);
xlabel('Frequency[Hz]');
ylabel('filter');
title('HPF');