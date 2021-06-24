%音と音の間に強いノイズを差し込むことで音が連続して聞こえる減少のこと
%ただし、ノイズに音の周波数が含まれていなければ連続して聞こえない

%ホワイトノイズ:　すべての周波数が同じ強さ(一様雑音)
%ピンクノイズ:　パワーが周波数に反比例

%ホワイトノイズはすべての周波数成分が一様に含まれているので
%どのような音でも連続聴効果が生じる

%ピンクノイズだと、高い音だとつながって聞こえにくい
%->高い音の周波数成分がピンクノイズに含まれない(少ししか含まれない)ため

clear;

Fs=16000;
t1=[0:0.15*Fs-1]/Fs;   

x=2*(rand(1,Fs*0.15)-1/2);      %ホワイトノイズ

T=length(x)/Fs;         
f=[-Fs/2:1/T:Fs/2-1];   

figure;
subplot(2,1,1);
plot(t1,x);
axis([0 0.2,0 1.5]);
xlabel('Time[s]');
ylabel('Amplitude');
title('ホワイトノイズ(時間領域)');


X=fft(x);
Xshift=fftshift(X);

subplot(2,1,2);
plot(f,abs(X));
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('ホワイトノイズ(周波数領域)');


y=[-Fs/2:1/T:Fs/2-1];
y=[-length(t1)/2:1:length(t1)/2-1];     


%filters
    figure;
    subplot(3,1,1)
    plot(f,y);
    xlabel('Frequency[Hz]');
    ylabel('R');
    title('フィルタ1(y=f)');


    y(y==0)=1;       
    Y=y.^(-1);

    subplot(3,1,2);
    plot(f,Y);
    axis([-4000 4000,-0.2 0.2]);
    xlabel('Frequency[Hz]');
    ylabel('R');
    title('フィルタ2(y=filter1^-1)');

    Y=abs(Y);
    
    subplot(3, 1, 3);
    plot(f,Y);
    axis([-4000 4000,-0.2 0.2]);
    xlabel('Frequency[Hz]');
    ylabel('R');
    title('フィルタ3(y=1/f)');

%ピンクノイズの作成方法 -> ホワイトノイズとフィルタをかけ合わせる

p=Xshift.*Y;

figure;
subplot(2,1,1);
plot(f,p);
axis([-4000 4000, -3 3]);
xlabel('Frequency[Hz]');
ylabel('R');
title('ピンクノイズ(周波数領域)');


Pshift=ifftshift(p);
P=ifft(Pshift);
P=real(P);

subplot(2,1,2);
plot(t1,P);
xlabel('Time[s]');
ylabel('Amplitude');
title('ピンクノイズ(時間領域)');

Fs=16000;
P=P*700;
%sound(P,Fs);

f1=440;     %ra
f2=2000;    %mi +2

t=[0:Fs-1]/Fs;          
y1=sin(2*pi*f1*t);
y3=0.08*sin(2*pi*f2*t);

%4つの音刺激
Z1=[y1 x y1 x y1 x y1 x y1 x y1 x]; %1 440Hz-whitenoise-440Hz-whitenoise.... 
Z2=[y1 P y1 P y1 P y1 P y1 P y1 P]; %2 440Hz-pink-440Hz-pink...
Z3=[y3 x y3 x y3 x y3 x y3 x y3 x]; %3 1320Hz-white-1320Hz-white...
Z4=[y3 P y3 P y3 P y3 P y3 P y3 P]; %4 1320Hz-pink-1320Hz-pink

figure;
subplot(2,2,1);
pspectrum(Z1, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440Hzにホワイトノイズを挿入");

subplot(2,2,2);
pspectrum(Z2, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440Hzにピンクノイズを挿入");

subplot(2,2,3);
pspectrum(Z3, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("1320Hzにホワイトノイズを挿入");

subplot(2,2,4);
pspectrum(Z4, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("1320Hzにピンクノイズを挿入");

%sound(Z1,Fs);  %440-wn
%sound(Z2,Fs);  %440-pn
%sound(Z3,Fs);  %1320-wn
%sound(Z4,Fs);  %1320-pn

