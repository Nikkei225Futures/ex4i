clear;
Fs=8192;
t=0:0.0001:0.25;
df1=261.38;
ref=293.67;
mf=329.63;
ff=349.23;
sf=392;
raf=440;
shf=492.88;
df2=523.23;
dy1=sin(2*pi*df1*t);
rey=sin(2*pi*ref*t);
my=sin(2*pi*mf*t);
fy=sin(2*pi*ff*t);
sy=sin(2*pi*sf*t);
ray=sin(2*pi*raf*t);
shy=sin(2*pi*shf*t);
dy2=sin(2*pi*df2*t);
y1=[dy1 rey my fy sy ray shy dy2];
n=20008;
t=t(1:1024);
y1=y1(1:n);
y2=fft(y1);
plot(y2);
y3=fftshift(y2);
y4=abs(y3);
leng=820;
o=ones(1, leng);
test=(20008/2)-leng;
z=zeros(1,test);
filterA=[z o o z];
y5=y4.*filterA;
fshift=(-n/2:n/2-1)*(8192/n);
subplot(2,1,1);
plot(fshift,y4);
axis([0 1000 0 1200]);
subplot(2,1,2);
plot(fshift, y5);
axis([0 1000 0 1200]);

sound(y1, Fs);
