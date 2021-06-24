%���Ɖ��̊Ԃɋ����m�C�Y���������ނ��Ƃŉ����A�����ĕ������錸���̂���
%�������A�m�C�Y�ɉ��̎��g�����܂܂�Ă��Ȃ���ΘA�����ĕ������Ȃ�

%�z���C�g�m�C�Y:�@���ׂĂ̎��g������������(��l�G��)
%�s���N�m�C�Y:�@�p���[�����g���ɔ����

%�z���C�g�m�C�Y�͂��ׂĂ̎��g����������l�Ɋ܂܂�Ă���̂�
%�ǂ̂悤�ȉ��ł��A�������ʂ�������

%�s���N�m�C�Y���ƁA���������ƂȂ����ĕ������ɂ���
%->�������̎��g���������s���N�m�C�Y�Ɋ܂܂�Ȃ�(���������܂܂�Ȃ�)����

clear;

Fs=16000;
t1=[0:0.15*Fs-1]/Fs;   

x=2*(rand(1,Fs*0.15)-1/2);      %�z���C�g�m�C�Y

T=length(x)/Fs;         
f=[-Fs/2:1/T:Fs/2-1];   

figure;
subplot(2,1,1);
plot(t1,x);
axis([0 0.2,0 1.5]);
xlabel('Time[s]');
ylabel('Amplitude');
title('�z���C�g�m�C�Y(���ԗ̈�)');


X=fft(x);
Xshift=fftshift(X);

subplot(2,1,2);
plot(f,abs(X));
xlabel('Frequency[Hz]');
ylabel('Amplitude Spectrum');
title('�z���C�g�m�C�Y(���g���̈�)');


y=[-Fs/2:1/T:Fs/2-1];
y=[-length(t1)/2:1:length(t1)/2-1];     


%filters
    figure;
    subplot(3,1,1)
    plot(f,y);
    xlabel('Frequency[Hz]');
    ylabel('R');
    title('�t�B���^1(y=f)');


    y(y==0)=1;       
    Y=y.^(-1);

    subplot(3,1,2);
    plot(f,Y);
    axis([-4000 4000,-0.2 0.2]);
    xlabel('Frequency[Hz]');
    ylabel('R');
    title('�t�B���^2(y=filter1^-1)');

    Y=abs(Y);
    
    subplot(3, 1, 3);
    plot(f,Y);
    axis([-4000 4000,-0.2 0.2]);
    xlabel('Frequency[Hz]');
    ylabel('R');
    title('�t�B���^3(y=1/f)');

%�s���N�m�C�Y�̍쐬���@�ƃz���C�g�m�C�Y���������킹��
p=Xshift.*Y;

figure;
subplot(2,1,1);
plot(f,p);
axis([-4000 4000, 0 3]);
xlabel('Frequency[Hz]');
ylabel('R');
title('�s���N�m�C�Y(���g���̈�)');


Pshift=ifftshift(p);
P=ifft(Pshift);
P=real(P);

subplot(2,1,2);
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
y2=0.05*sin(2*pi*f1*t);
y3=0.08*sin(2*pi*f2*t);
y4=0.01*sin(2*pi*f2*t);

%4�̉��h��
Z1=[y1 x y1 x y1 x y1 x y1 x y1 x]; %1 440Hz-whitenoise-440Hz-whitenoise.... 
Z2=[y1 P y1 P y1 P y1 P y1 P y1 P]; %2 440Hz-pink-440Hz-pink...
Z3=[y3 x y3 x y3 x y3 x y3 x y3 x]; %3 1320Hz-white-1320Hz-white...
Z4=[y3 P y3 P y3 P y3 P y3 P y3 P]; %4 1320Hz-pink-1320Hz-pink

%{
figure;
subplot(2,2,1);
title("440Hz�����Ƀz���C�g�m�C�Y��}��");
tt = [0:6.9*Fs-1]/Fs;
plot(tt, Z1);
ylim([-5 5]);
xlim([0.9 1.2]);

subplot(2,2,2);
title("440Hz�����Ƀs���N�m�C�Y��}��");
tt = [0:6.9*Fs-1]/Fs;
plot(tt, Z2);
ylim([-2 2]);
xlim([0.9 1.2]);

subplot(2,2,3);
title("1320Hz�����Ƀz���C�g�m�C�Y��}��");
tt = [0:6.9*Fs-1]/Fs;
plot(tt, Z3);
ylim([-5 5]);
xlim([0.9 1.2]);

subplot(2,2,4);
title("1320Hz�����Ƀs���N�m�C�Y��}��");
tt = [0:6.9*Fs-1]/Fs;
plot(tt, Z4);
ylim([-2 2]);
xlim([0.9 1.2]);
%}

figure;
subplot(2,2,1);
pspectrum(Z1, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440Hz�Ƀz���C�g�m�C�Y��}��");

subplot(2,2,2);
pspectrum(Z2, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440Hz�Ƀs���N�m�C�Y��}��");

subplot(2,2,3);
pspectrum(Z3, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("1320Hz�Ƀz���C�g�m�C�Y��}��");

subplot(2,2,4);
pspectrum(Z4, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("1320Hz�Ƀs���N�m�C�Y��}��");

%sound(Z1,Fs);  440-wn
%sound(Z2,Fs);  440-pn
%sound(Z3,Fs);  1320-wn
%sound(Z4,Fs);  1320-pn
