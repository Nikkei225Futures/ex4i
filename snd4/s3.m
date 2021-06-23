%%%%%%ミッシングファンダメンタル%%%%%%%%%%%%%%%%%%%%



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

subplot(2,1,1);
plot(t,y1);
axis([0 0.01,-1 1]);
xlabel('Time[s]');
ylabel('Amplitude');
title('矩形波');

subplot(2,1,2);
plot(t,y2);
axis([0 0.01,-1 1]);
xlabel('Time[s]');
ylabel('Amplitude');
title('矩形波-基本周波数');

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

subplot(2,1,1);
plot(t,y3);
axis([0 0.01,-2.5 2.5]);
xlabel('Time[s]');
ylabel('Amplitude');
title('ノコギリ波');

subplot(2,1,2);
plot(t,y4);
axis([0 0.01,-2.5 2.5]);
xlabel('Time[s]');
ylabel('Amplitude');
title('ノコギリ波-基本周波数');

%sound(y3,Fs);%ただのノコギリ波
%sound(y4,Fs);%ノコギリ波から基本周波数を抜いた音(ミッシングファンダメンタル)

%基本周波数を抜いた音の方が少し高く聞こえる