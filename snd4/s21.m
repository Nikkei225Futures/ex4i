%���Ɖ��̊Ԃɋ����m�C�Y���������ނ��Ƃŉ����A�����ĕ������錸���̂���
%�������A�m�C�Y�ɉ��̎��g�����܂܂�Ă��Ȃ���ΘA�����ĕ������Ȃ�

%�z���C�g�m�C�Y:�@���ׂĂ̎��g������������(��l�G��)
%�s���N�m�C�Y:�@�p���[�����g���ɔ����

%�z���C�g�m�C�Y�͂��ׂĂ̎��g����������l�Ɋ܂܂�Ă���̂�
%�ǂ̂悤�ȉ��ł��A�������ʂ�������

%�s���N�m�C�Y���ƁA���������ƂȂ����ĕ������ɂ���
%->�������̎��g���������s���N�m�C�Y�Ɋ܂܂�Ȃ�(���������܂܂�Ȃ�)����

close all;
clear;

Fs=16000;
t1=[0:0.15*Fs-1]/Fs;

whiteNoise=2*(rand(1,Fs*0.15)-1/2);      %�z���C�g�m�C�Y

T=length(whiteNoise)/Fs;
scaleFreq=[-Fs/2:1/T:Fs/2-1];

figure;
subplot(2,1,1);
plot(t1,whiteNoise);
axis([0 0.2,0 1.5]);
xlabel('����[s]');
ylabel('Amplitude');
title('�z���C�g�m�C�Y(���ԗ̈�)');


freqWhiteNoise=fft(whiteNoise);
shiftedWhiteNoise=fftshift(freqWhiteNoise);

subplot(2,1,2);
plot(scaleFreq,abs(freqWhiteNoise));
xlabel('���g��[Hz]');
ylabel('Amplitude Spectrum');
title('�z���C�g�m�C�Y(���g���̈�)');


y=[-Fs/2:1/T:Fs/2-1];
y=[-length(t1)/2:1:length(t1)/2-1];


%filters
figure;
subplot(3,1,1)
plot(scaleFreq,y);
xlabel('���g��[Hz]');
title('�t�B���^1(y=f)');


y(y==0)=1;
Y=y.^(-1);

subplot(3,1,2);
plot(scaleFreq,Y);
axis([-4000 4000,-0.2 0.2]);
xlabel('���g��[Hz]');
title('�t�B���^2(y=filter1^-1)');

Y=abs(Y);

subplot(3, 1, 3);
plot(scaleFreq,Y);
axis([-4000 4000,-0.2 0.2]);
xlabel('���g��[Hz]');
title('�t�B���^3(y=1/f)');

%�s���N�m�C�Y�̍쐬���@ -> �z���C�g�m�C�Y�ƃt�B���^���������킹��

pinkNoise=shiftedWhiteNoise.*Y;



Pshift=ifftshift(pinkNoise);
Ptime=ifft(Pshift);
Ptime=real(Ptime);

figure;

subplot(2,1,1);
plot(t1,Ptime);
xlabel('����[s]');
ylabel('Amplitude');
title('�s���N�m�C�Y(���ԗ̈�)');

subplot(2,1,2);
plot(scaleFreq,pinkNoise);
axis([-4000 4000, -3 3]);
xlabel('���g��[Hz]');
title('�s���N�m�C�Y(���g���̈�)');


Fs=16000;
Ptime=Ptime*700;
%sound(P,Fs);

f1=440;     %ra
f2=2000;    %mi +2

t=[0:Fs-1]/Fs;
y1=sin(2*pi*f1*t);
y3=0.08*sin(2*pi*f2*t);

%4�̉��h��
sound1=[y1 whiteNoise y1 whiteNoise y1 whiteNoise y1 whiteNoise y1 whiteNoise y1 whiteNoise]; %1 440Hz-whitenoise-440Hz-whitenoise....
sound2=[y1 Ptime y1 Ptime y1 Ptime y1 Ptime y1 Ptime y1 Ptime]; %2 440Hz-pink-440Hz-pink...
sound3=[y3 whiteNoise y3 whiteNoise y3 whiteNoise y3 whiteNoise y3 whiteNoise y3 whiteNoise]; %3 2000Hz-white-2000Hz-white...
sound4=[y3 Ptime y3 Ptime y3 Ptime y3 Ptime y3 Ptime y3 Ptime]; %4 2000Hz-pink-2000Hz-pink

figure;
subplot(2,2,1);
pspectrum(sound1, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440Hz�Ƀz���C�g�m�C�Y��}��");

subplot(2,2,2);
pspectrum(sound2, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("440Hz�Ƀs���N�m�C�Y��}��");

subplot(2,2,3);
pspectrum(sound3, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("2000Hz�Ƀz���C�g�m�C�Y��}��");

subplot(2,2,4);
pspectrum(sound4, Fs, 'spectrogram', 'OverlapPercent', 0, 'Leakage', 1, 'MinThreshold', -60);
title("2000Hz�Ƀs���N�m�C�Y��}��");

%sound(sound1,Fs);  %440-wn
%sound(sound2,Fs);  %440-pn
%sound(sound3,Fs);  %1320-wn
%sound(sound4,Fs);  %1320-pn

