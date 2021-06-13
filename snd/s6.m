clear;

Fs=16000;  
t=([0:Fs-1]/Fs);
x=0.2*randn(1,Fs);   %make white noise


% plots from here 
subplot(2,1,1);
plot(t,x);
axis([0 1,-1 1]);
xlabel('時間[s]');
ylabel('振幅');
title('白色ガウス雑音');

subplot(2,1,2);
num=100;                %ヒストグラムを何段階に分割するのか
[h,c]=hist(x,num);      %h:各スロットの頻度,c:各スロットの中心値
plot(c,h);
ylabel('value');
xlabel('amplitude');
title('振幅ヒストグラム');

sound(x,Fs);