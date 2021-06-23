clear;

Fs=16000;
t1=[0:0.15*Fs-1]/Fs;   

x=2*(rand(1,Fs*0.15)-1/2);      %noise

T=length(x)/Fs;         
f=[-Fs/2:1/T:Fs/2-1];   

figure;
plot(t1,x);
axis([0 0.2,0 1.5]);
xlabel('Time[s]');
ylabel('Amplitude');
title('�z���C�g�m�C�Y(���ԗ̈�)');

X=fft(x);
Xshift=fftshift(X);


figure;
plot(f,abs(X));
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('�z���C�g�m�C�Y(���g���̈�)');


y=[-Fs/2:1/T:Fs/2-1];
y=[-length(t1)/2:1:length(t1)/2-1];     

figure;
plot(f,y);
xlabel('Frequency[Hz]');
ylabel('R');
title('�t�B���^1');


y(y==0)=1;       
Y=y.^(-1);

figure;
plot(f,Y);
axis([-4000 4000,-0.2 0.2]);
xlabel('Frequency[Hz]');
ylabel('R');
title('�t�B���^2');


Y=abs(Y);    
figure;
plot(f,Y);
axis([-4000 4000,-0.2 0.2]);
xlabel('Frequency[Hz]');
ylabel('R');
title('�t�B���^3');

%�s���N�m�C�Y�̍쐬���@�ƃz���C�g�m�C�Y���������킹��
p=Xshift.*Y;

figure;
plot(f,p);
axis([-4000 4000,-3 3]);
xlabel('Frequency[Hz]');
ylabel('R');
title('�s���N�m�C�Y(���g���̈�)');


Pshift=ifftshift(p);
P=ifft(Pshift);
P=real(P);

figure;
plot(t1,P);
xlabel('Time[s]');
ylabel('Amplitude');
title('�s���N�m�C�Y(���ԗ̈�)');

%sound(P,Fs);



Fs=16000;
P=P*700;
f1=440;     %ra
f2=1320;    %mi +2

t=[0:Fs-1]/Fs;          
y1=sin(2*pi*f1*t);
y2=0.01*sin(2*pi*f1*t);
y3=sin(2*pi*f2*t);
y4=0.01*sin(2*pi*f2*t);

%4�̉��h��
Z1=[y1 x y1 x y1 x y1 x y1 x y1 x]; %1 440Hz-whitenoise-440Hz-whitenoise.... 
Z2=[y1 P y1 P y1 P y1 P y1 P y1 P]; %2 440Hz-pink-440Hz-pink...
Z3=[y2 x y2 x y2 x y2 x y2 x y2 x]; %3 1320Hz-white-1320Hz-white...
Z4=[y2 P y2 P y2 P y2 P y2 P y2 P]; %4 1320Hz-pink-1320Hz-pink

figure;
title("440Hz�����Ƀz���C�g�m�C�Y��}��");
tt = [0:6.9*Fs-1]/Fs;
plot(tt, Z1);
ylim([-2 2]);
xlim([0.9 1.2]);

%sound(Z1,Fs);
%sound(Z2,Fs);
%sound(Z3,Fs);
%sound(Z4,Fs);







