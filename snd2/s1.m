clear;

%純音の周波数解析

Fs=8192;            
f=440;               
t=[0:Fs-1]/Fs; 
t2=[0:Fs/8-1]/Fs;

f2=[0:8:8191];       %周波数軸の設定1(仮)
f3=[-Fs/2:8:Fs/2-8]; %サンプリング定理より周波数軸の設定2

y=sin(2*pi*f*t);    
y1=y(1:1024);        %純音の1024点の取り出し
Y=fft(y1);           %fftする
Y=abs(Y);            %絶対値をとる

Yshift=fftshift(Y);  %正と負の順番の入れ替え

sound(y,Fs);        

figure;

plot(f3,Yshift);
axis([0 1000,0 600]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('拡大した純音(440Hzの所にピーク)');

%矩形波の周波数解析

x=zeros(1,128);  %128点で0
x1=ones(1,128);  %128点で1
x2=[x x1];
x3=[x2 x2 x2 x2];  %128点で0,128点で1を4回繰り返す矩形波

X=fft(x3);
X=abs(X);         
Xshift=fftshift(X); 

figure;

plot(f3,Xshift);
axis([0 200,0 600]);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('拡大した矩形波(1/(2k-1)で減衰)');


%%%%%%%%%%%%%%%%%%%%%レポート用のグラフ%%%%%%%%%%%%%%%%%%%%%


%正弦波のグラフ
figure;

subplot(2,2,1);
plot(t,y);
axis([0 0.02,-1 1]);
xlabel('Time[s]');
ylabel('Amplitude');
title('1.純音');

subplot(2,2,2);
plot(f2,Y);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('2.FFT後の純音');

subplot(2,2,3);
plot(f3,Yshift);
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('3.fftshift後の純音');

%subplot(2,2,4);
%plot(f3,Yshift);
%axis([0 1000,0 600]);
%xlabel('Frequency[Hz]');
%ylabel('Amplitude Spectrum');
%title('4.拡大した純音');




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

%subplot(2,2,4);
%plot(f3,Xshift);
%axis([0 200,0 600]);
%xlabel('Frequency[Hz]');
%ylabel('Amplitude Spectrum');
%title('4.矩形波の周波数解析');
