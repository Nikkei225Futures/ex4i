close all;
clear;

Fs=16000;               % sampling rate = 16kHz
func1 = 0;
func2 = 0;
func3 = 0;
t=([0:Fs-1]/Fs);        % 1sec
f0 = 2*pi/0.5;          % cycle = 0.5s

for k=1:1
    y=(-1)^(k-1)/(2*k-1)^2*sin((2*k-1)*f0*t);    
    func1 = func1 + y;        % triangle wave, N = 1
end

for k=1:5
    y=(-1)^(k-1)/(2*k-1)^2*sin((2*k-1)*f0*t);    
    func2 = func2 + y;        % triangle wave, N = 5
end

for k=1:25
    y=(-1)^(k-1)/(2*k-1)^2*sin((2*k-1)*f0*t);    
    func3 = func3 +y;         % triangle wave, N = 25
end

% plots from here
plot(t,func1,t,func2,t,func3);
legend('N=1','N=5','N=25');
xlabel('時間[s]');
ylabel('振幅');
%title('三角波');

