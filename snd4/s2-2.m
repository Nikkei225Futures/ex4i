clear;

Fs=16000;
t1=[0:0.15*Fs-1]/Fs;   


x=2*(rand(1,Fs*0.15)-1/2);  

T=length(x)/Fs;        
f=[-Fs/2:1/T:Fs/2-1];  


%figure;
%plot(t1,x);
%axis([0 0.2,0 1.5]);
%xlabel('Time[s]');
%ylabel('Amplitude');
%title('ホワイトノイズ(時間領域)');

X=fft(x);
Xshift=fftshift(X);


%figure;
%plot(f,abs(X));
%xlabel('Frequency[Hz]');
%ylabel('Amplitude Spectrum');
%title('ホワイトノイズ(周波数領域)');


y=[-Fs/2:1/T:Fs/2-1];
y=[-length(t1)/2:1:length(t1)/2-1];     

%figure;
%plot(f,y);
%xlabel('Frequency[Hz]');
%ylabel('R');
%title('フィルタ1');

y(y==0)=1;        
Y=y.^(-1);

%figure;
%plot(f,Y);
%axis([-4000 4000,-0.2 0.2]);
%xlabel('Frequency[Hz]');
%ylabel('R');
%title('フィルタ2');


Y=abs(Y);    
%figure;
%plot(f,Y);
%axis([-4000 4000,-0.2 0.2]);
%xlabel('Frequency[Hz]');
%ylabel('R');
%title('フィルタ3');

p=Xshift.*Y;

%figure;
%plot(f,p);
%axis([-4000 4000,-3 3]);
%xlabel('Frequency[Hz]');
%ylabel('R');
%title('ピンクノイズ(周波数領域)');


Pshift=ifftshift(p);
P=ifft(Pshift);
P=real(P);

%figure;
%plot(t1,P);
%xlabel('Time[s]');
%ylabel('Amplitude');
%title('ピンクノイズ(時間領域)');

%sound(P,Fs);




[Z,Fs1]=audioread('aの音.wav');   
t1=[0:length(Z)-1]/Fs1;         
Z1=Z(:,1);  
for k=1:2400;
m=k+40000;
Z1(m)=x(k);
end

for k=1:2400;
m=k+60000;
Z1(m)=x(k);
end

for k=1:2400;
m=k+80000;
Z1(m)=x(k);
end

for k=1:2400;
m=k+100000;
Z1(m)=x(k);
end

for k=1:2400;
m=k+120000;
Z1(m)=x(k);
end


%sound(Z1,Fs);


for k=1:2400;
m=k+40000;
Z1(m)=P(k);
end

for k=1:2400;
m=k+60000;
Z1(m)=P(k);
end

for k=1:2400;
m=k+80000;
Z1(m)=P(k);
end

for k=1:2400;
m=k+100000;
Z1(m)=P(k);
end

for k=1:2400;
m=k+120000;
Z1(m)=P(k);
end


sound(Z1,Fs);

for k=1:2400;
m=k+40000;
Z1(m)=zeros(1);
end

for k=1:2400;
m=k+60000;
Z1(m)=zeros(1);
end


for k=1:2400;
m=k+80000;
Z1(m)=zeros(1);
end

for k=1:2400;
m=k+100000;
Z1(m)=zeros(1);
end


for k=1:2400;
m=k+120000;
Z1(m)=zeros(1);
end

%sound(Z1,Fs);












