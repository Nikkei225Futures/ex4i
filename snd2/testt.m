clear;
Fs=8192;
t=(0:Fs-1)/Fs;
f1=440;
y1=sin(2*pi*f1*t);
y2=y1(1:1024);
t=t(1:1024);
y3=fft(y2);
y4=fftshift(y3);
y5=abs(y4);
n=1024;
fshift=(-n/2:n/2-1)*(8192/n);
subplot(2,1,1);
plot(fshift,y5);
xlabel('Hz');
title('Puretone');
axis([0 1000 0 600]);
y6=[zeros(1,128) ones(1,128) zeros(1,128) ones(1,128) zeros(1,128) ones(1,128) zeros(1,128) ones(1,128)];
y7=fft(y6);
y8=fftshift(y7);
y9=abs(y8);
subplot(2,1,2);
plot(fshift,y9);
xlabel('Hz');
title('Square wave');
axis([0 200 0 600]);





