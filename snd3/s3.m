close all;
clear;

[sound1,Fs1]=audioread('sound1.wav');
[sound2,Fs2]=audioread('sound2.wav');

t1=[0:length(sound1)-1]/Fs1;
t2=[0:length(sound2)-1]/Fs2;

sound1=sound1(:,1);         %1列目のみを取り出す
sound2=sound2(:,1);

sound1FreqInterval=1/(length(sound1)/Fs1);
sound2FreqInterval=1/(length(sound2)/Fs2);

faxis1=[-Fs1/2:sound1FreqInterval:Fs1/2-sound1FreqInterval];
faxis2=[-Fs2/2:sound2FreqInterval:Fs2/2-sound2FreqInterval];

%time -> freq
sound1=fft(sound1);
sound1=abs(sound1);
shiftedSound1=fftshift(sound1);

sound2=fft(sound2);
sound2=abs(sound2);
shiftedSound2=fftshift(sound2);

%select peeks and its value
peekOfSound1Freq=[1093 545.5 819.2 680.42 2869];    % peek of a (x)
valOfPeekSound1Freq=[77.48 51.39 50.25 42.04 36.09];  % y of selected peeks(f1)

peekOfSound2Freq=[306.3 2906 2448 153 2757];        % peek of i(x)
valOfPeekSound2Freq=[52.85 52.23 44.03 41.26 24.31];   % y of selected peeks(f2)

a=0;
i=0;

% make synthetic voices
for k=1:5
    a = a+valOfPeekSound1Freq(k)*sin(2*pi*peekOfSound1Freq(k)*t1);   %それぞれのピークの純音を加算(あ)(= 合成音の生成)
    i = i+valOfPeekSound2Freq(k)*sin(2*pi*peekOfSound2Freq(k)*t2);   %それぞれのピークの純音を加算(い)(= 合成音の生成)
end

synASptl = fft(a);
synASptl = abs(synASptl);
synASptl = fftshift(synASptl);
synASptl = synASptl/(length(sound1)/2);

synISptl = fft(i);
synISptl = abs(synISptl);
synISptl = fftshift(synISptl);
synISptl = synISptl/(length(sound2)/2);

%sound(a,Fs1);
%sound(i,Fs2);

%sound(a,Fs1);
%sound(i,Fs2);

%%% plots from here %%%
figure;
subplot(2,1,1);
plot(faxis1,shiftedSound1);
xlabel('Frequency[Hz]');
ylabel('');
title('aのスペクトル');
axis([0 5000,0 80]);

subplot(2,1,2);
plot(faxis1, synASptl);
xlabel('Frequency[Hz]');
ylabel('');
title('aの合成音のスペクトル');
axis([0 5000, 0 80]);

figure;
subplot(2,1,1);
plot(faxis2,shiftedSound2);
xlabel('Frequency[Hz]');
ylabel('');
title('iのスペクトル');
axis([0 5000,0 100]);

subplot(2,1,2);
plot(faxis2, synISptl);
xlabel('Frequency[Hz]');
ylabel('');
title('iの合成音のスペクトル');
axis([0 5000, 0 80]);

