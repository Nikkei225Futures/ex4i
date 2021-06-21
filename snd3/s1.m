clear;

%%%%%%%%%%矩形波%%%%%%%%%%

%高調波とは基本周波数成分の整数倍で表される
%純音の場合には位相を変化させてもほとんど音の変化は聞き取れないが、合成波の場合は位相のずれによる変化が加算され音に変化が生じる。

Fs=16000;  
f=440;
N=25;
t=([0:2*Fs-1]/Fs);    %2秒間
x1=0;
x2=0;
x3=0;
x4=sin(2*pi*f*t);

phix1=45*pi/180;        %位相をpi/4ずらす
phix2=90*pi/180;        %位相をpi/2ずらす

for k=1:N;
    ft=sin(2*pi*(2*k-1)*f*t)/(2*k-1);
    x1=x1+ft; 
end

for k=1:N;
    ft=sin(2*pi*(2*k-1)*f*t+phix1)/(2*k-1);
    x2=x2+ft; 
end

for k=1:N;
    ft=sin(2*pi*(2*k-1)*f*t+phix2)/(2*k-1);
    x3=x3+ft; 
end

for k=2:N;
    ft=sin(2*pi*(2*k-1)*f*t+rand(1)*2*pi)/(2*k-1);  %ランダムな値ずらす
    x4=x4+ft; 
end


%sound(x1,Fs);
%sound(x2,Fs);
%sound(x3,Fs);
%sound(x4,Fs);

figure;

subplot(4,1,1);
plot(t,x1);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('Amplitude');
title('矩形波');

subplot(4,1,2);
plot(t,x2);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('Amplitude');
title('矩形波(位相45度ずらした波形)');

subplot(4,1,3);
plot(t,x3);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('Amplitude');
title('矩形波(位相90度ずらした波形)');

subplot(4,1,4);
plot(t,x4);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('Amplitude');
title('矩形波(ランダムな位相ずらした波形)');




%%%%%%%%%%%%%%%ノコギリ波%%%%%%%%%%%%%%%

Fs=16000;  
f=440;
N=25;
t=([0:2*Fs-1]/Fs);       %2秒間
y1=0;
y2=0;
y3=0;
y4=sin(2*pi*f*t);

phiy1=45*pi/180;         %位相をpi/4ずらす
phiy2=90*pi/180;         %位相をpi/2ずらす

for k=1:N;
    ft=(-1)^(k-1)/k*sin(2*pi*k*f*t);
    y1=y1+ft;  
end

for k=1:N;
    ft=(-1)^(k-1)/k*sin(2*pi*k*f*t+phiy1);
    y2=y2+ft;  
end

for k=1:N;
    ft=(-1)^(k-1)/k*sin(2*pi*k*f*t+phiy2);
    y3=y3+ft;  
end

for k=2:N;
    ft=(-1)^(k-1)/k*sin(2*pi*k*f*t+rand(1)*2*pi);     %ランダムな値ずらす
    y4=y4+ft;  
end



%sound(y1,Fs);
%sound(y2,Fs);
%sound(y3,Fs);
%sound(y4,Fs);


figure;

subplot(4,1,1);
plot(t,y1);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('Amplitude');
title('ノコギリ波');

subplot(4,1,2);
plot(t,y2);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('Amplitude');
title('ノコギリ波(位相45度ずらした波形)');

subplot(4,1,3);
plot(t,y3);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('Amplitude');
title('ノコギリ波(位相90度ずらした波形)');

subplot(4,1,4);
plot(t,y4);
axis([0 0.01,-4 4]);
xlabel('Time[s]');
ylabel('Amplitude');
title('ノコギリ波(ランダムな位相ずらした波形)');

