%%%%%%ミッシングファンダメンタル%%%%%%%%%%%%%%%%%%%%
%基本周波数成分が含まれていなくても、残っている成分から推定され、
%基本周波数に相当する高さが知覚される現象
%脳が残っている倍音成分から基本周波数を推定するため、同じような音が知覚される
%ミッシングファンダメンタルの音は同じ音階に聞こえるが、少し高い音のように感じる

%%%%%%%%%%%%%%%%%%%%%%%%%矩形波%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear;

Fs=16000;  
f=440;
N=15;               %number of loops
squareWave=0;
squareMF=0;
t=([0:Fs-1]/Fs);

for k=1:N
    squareWave=squareWave+sin(2*pi*(2*k-1)*f*t)/(2*k-1);    %make square wave 
end

squareMF=squareWave-sin(2*pi*f*t);

figure;
plot(t, squareWave, t, squareMF);
axis([0 0.005,-2 2]);
xlabel('Time[s]');
ylabel('Amplitude');
legend("矩形波", "missing fundamental");
%title('矩形波とミッシングファンダメンタル');

figure;
subplot(2,1,1);
pspectrum(squareWave, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("矩形波");

subplot(2,1,2);
pspectrum(squareMF, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("missingfundamental");

%{
subplot(2,1,2);
plot(t,squareMF);
axis([0 0.01,-1 1]);
xlabel('Time[s]');
ylabel('Amplitude');
title('矩形波-基本周波数');
%}

%sound(squareWave,Fs);  %ただの矩形波
%sound(squareMF,Fs);  %矩形波から基本周波数を抜いた音(ミッシングファンダメンタル)

% sawtooth wave
Fs=16000;  
f=440;
N=15;           %加算する三角関数の数
t=([0:Fs-1]/Fs);
sawtoothWave=0;
sawtoothMF=0;

for k=1:N
    sawtoothWave=sawtoothWave+(-1)^(k-1)/k*sin(2*pi*k*f*t);   %ノコギリ波の公式
end

sawtoothMF=sawtoothWave-sin(2*pi*f*t);
  
figure;
plot(t,sawtoothWave,t,sawtoothMF);
axis([0 0.005,-3 3]);
xlabel('Time[s]');
ylabel('Amplitude');
legend("ノコギリ波", "missing fundamental");
%title('ノコギリ波とミッシングファンダメンタル');

figure;
subplot(2,1,1);
pspectrum(sawtoothWave, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("ノコギリ波");

subplot(2,1,2);
pspectrum(sawtoothMF, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("missingfundamental");

%sound(sawtoothWave,Fs);%ただのノコギリ波
%sound(sawtoothMF,Fs);%ノコギリ波から基本周波数を抜いた音(ミッシングファンダメンタル)

%基本周波数を抜いた音の方が少し高く聞こえる