%%%%%%ミッシングファンダメンタル%%%%%%%%%%%%%%%%%%%%
%基本周波数成分が含まれていなくても、残っている成分から推定され、
%基本周波数に相当する高さが知覚される現象
%脳が残っている倍音成分から基本周波数を推定するため、同じような音が知覚される
%ミッシングファンダメンタルの音は同じ音階に聞こえるが、少し高い音のように感じる

%%%%%%%%%%%%%%%%%%%%%%%%%矩形波%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;


Fs=16000;  
f=440;
N=15;           %加算する三角関数の数
y1=0;
y2=0;
t=([0:Fs-1]/Fs);

for k=1:N;
    y1=y1+sin(2*pi*(2*k-1)*f*t)/(2*k-1);    %矩形波の公式  
end

y2=y1-sin(2*pi*f*t);

figure;
plot(t, y1, t, y2);
axis([0 0.005,-2 2]);
xlabel('Time[s]');
ylabel('Amplitude');
legend("矩形波", "missing fundamental");
title('矩形波とミッシングファンダメンタル');

figure;
subplot(2,1,1);
pspectrum(y1, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("矩形波");

subplot(2,1,2);
pspectrum(y2, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("missingfundamental");

%{
subplot(2,1,2);
plot(t,y2);
axis([0 0.01,-1 1]);
xlabel('Time[s]');
ylabel('Amplitude');
title('矩形波-基本周波数');
%}

%sound(y1,Fs);  %ただの矩形波
%sound(y2,Fs);  %矩形波から基本周波数を抜いた音(ミッシングファンダメンタル)



%%%%%ノコギリ波%%%%%%%%%%%%

Fs=16000;  
f=440;
N=15;           %加算する三角関数の数
t=([0:Fs-1]/Fs);
y3=0;
y4=0;

for k=1:N;
    y3=y3+(-1)^(k-1)/k*sin(2*pi*k*f*t);   %ノコギリ波の公式
end

y4=y3-sin(2*pi*f*t);
  
figure;
plot(t,y3,t,y4);
axis([0 0.005,-3 3]);
xlabel('Time[s]');
ylabel('Amplitude');
legend("ノコギリ波", "missing fundamental");
title('ノコギリ波とミッシングファンダメンタル');

figure;
subplot(2,1,1);
pspectrum(y3, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("ノコギリ波");

subplot(2,1,2);
pspectrum(y4, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("missingfundamental");

%sound(y3,Fs);%ただのノコギリ波
%sound(y4,Fs);%ノコギリ波から基本周波数を抜いた音(ミッシングファンダメンタル)

%基本周波数を抜いた音の方が少し高く聞こえる