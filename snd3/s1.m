

%%%%%%%%%%矩形波%%%%%%%%%%

%高調波とは基本周波数成分の整数倍で表される
%純音の場合には位相を変化させてもほとんど音の変化は聞き取れないが、合成波の場合は位相のずれによる変化が加算され音に変化が生じる。
close all;
clear;

Fs=16000;  
f=440;
numLoops=25;
t=([0:2*Fs-1]/Fs);    %2sec

%init vals
pureSquareWave=0;
squareWavephi1=0;
squareWavePhi2=0;
squarePhiRand=sin(2*pi*f*t);

phix1=45*pi/180;        %phase + pi/4
phix2=90*pi/180;        %phase + pi/2

for k=1:numLoops
    ft=sin(2*pi*(2*k-1)*f*t)/(2*k-1);
    pureSquareWave=pureSquareWave+ft; 
end

for k=1:numLoops
    ft=sin(2*pi*(2*k-1)*f*t+phix1)/(2*k-1);
    squareWavephi1=squareWavephi1+ft; 
end

for k=1:numLoops
    ft=sin(2*pi*(2*k-1)*f*t+phix2)/(2*k-1);
    squareWavePhi2=squareWavePhi2+ft; 
end

for k=2:numLoops
    ft=sin(2*pi*(2*k-1)*f*t+rand(1)*2*pi)/(2*k-1);
    s=squarePhiRand+ft; 
end


%sound(pureSquareWave,Fs);
%sound(squareWavephi1,Fs);
%sound(squareWavePhi2,Fs);
%sound(squarePhiRand,Fs);

figure;

subplot(4,1,1);
plot(t,pureSquareWave);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('振幅');
title('矩形波');

subplot(4,1,2);
plot(t,squareWavephi1);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('振幅');
title('矩形波(位相45度ずらした波形)');

subplot(4,1,3);
plot(t,squareWavePhi2);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('振幅');
title('矩形波(位相90度ずらした波形)');

subplot(4,1,4);
plot(t,squarePhiRand);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('振幅');
title('矩形波(ランダムな位相ずらした波形)');

%%%%sawtooth wave

Fs=16000;  
f=440;
numLoops=25;
t=([0:2*Fs-1]/Fs);       %2秒間
pureSawtooth=0;
sawtoothPhi1=0;
sawtoothPhi2=0;
sawtoothPhiRand=sin(2*pi*f*t);

phiy1=45*pi/180;         %位相をpi/4ずらす
phiy2=90*pi/180;         %位相をpi/2ずらす

for k=1:numLoops
    ft=(-1)^(k-1)/k*sin(2*pi*k*f*t);
    pureSawtooth=pureSawtooth+ft;  
end

for k=1:numLoops
    ft=(-1)^(k-1)/k*sin(2*pi*k*f*t+phiy1);
    sawtoothPhi1=sawtoothPhi1+ft;  
end

for k=1:numLoops
    ft=(-1)^(k-1)/k*sin(2*pi*k*f*t+phiy2);
    sawtoothPhi2=sawtoothPhi2+ft;  
end

for k=2:numLoops
    ft=(-1)^(k-1)/k*sin(2*pi*k*f*t+rand(1)*2*pi);     %ランダムな値ずらす
    sawtoothPhiRand=sawtoothPhiRand+ft;  
end



%sound(y1,Fs);
%sound(y2,Fs);
%sound(y3,Fs);
%sound(y4,Fs);


figure;

subplot(4,1,1);
plot(t,pureSawtooth);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('振幅');
title('ノコギリ波');

subplot(4,1,2);
plot(t,sawtoothPhi1);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('振幅');
title('ノコギリ波(位相45度ずらした波形)');

subplot(4,1,3);
plot(t,sawtoothPhi2);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('振幅');
title('ノコギリ波(位相90度ずらした波形)');

subplot(4,1,4);
plot(t,sawtoothPhiRand);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('振幅');
title('ノコギリ波(ランダムな位相ずらした波形)');

