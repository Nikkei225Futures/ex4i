clear;
Fs=16000;  
y1 = 0;
y2 = 0;
y3 = 0;
f = 2;
t=([0:Fs-1]/Fs);        %1sec
f0 = 2*pi/0.5;          %cycle = 0.5s

for k=1:1
    y=sin(2*pi*(2*k-1)*f*t)/(2*k-1);    
    y1 = y1 + y;        %square wave, N = 1
end

for k=1:5
    y=sin(2*pi*(2*k-1)*f*t)/(2*k-1);
    y2 = y2 + y;        %square wave, N = 5
end

for k=1:25
    y=sin(2*pi*(2*k-1)*f*t)/(2*k-1);
    y3 = y3 +y;         %square wave, N = 25
end

plot(t,y1,t,y2,t,y3);
legend('N=1','N=5','N=25');
xlabel('時間[s]');
ylabel('振幅');
title('矩形波');
