clear;

    [X,Fs1]=audioread('sound1.wav');   
    [Y,Fs2]=audioread('sound2.wav');   
    
    t1=[0:length(X)-1]/Fs1; 
    t2=[0:length(Y)-1]/Fs2; 
   
  
    X1=X(:,1);   %Xの1列目全体
    Y1=Y(:,1);     
    b1=1/(length(X1)/Fs1);
    b2=1/(length(Y1)/Fs2);
    
    faxis1=[-Fs1/2:b1:Fs1/2-b1]; 
    faxis2=[-Fs2/2:b2:Fs2/2-b2];
    X1=fft(X1);
    X1=abs(X1); 
    
    Xshift=fftshift(X1);   
    
    Y1=fft(Y1);
    Y1=abs(Y1);
    Yshift=fftshift(Y1);
  
    figure;
   
    plot(faxis1,Xshift);
    xlabel('Frequency[Hz]');
    ylabel('');
    title('a');
    axis([0 5000,0 100]);
    
    figure;
    
  
    plot(faxis2,Yshift);
    xlabel('Frequency[Hz]');
    ylabel('');
    title('i');
    axis([0 5000,0 100]);
    
    f1=[1093 545.5 819.2 682.4 2869];    % peek of a (x)
    A1=[77.48 51.39 50.25 42.04 36.09];  % y of selected peeks(f1) 
    
    
    f2=[306.3 2906 2448 153 2757];        % peek of i(x)
    A2=[52.85 52.23 44.03 41.26 24.31];   % y of selected peeks(f2)
     

    a=0;
    i=0;
    
    for k=1:5
        a=a+A1(k)*sin(2*pi*f1(k)*t1);   %それぞれのピークの純音を加算(あ)(= 合成音の生成)
        i=i+A2(k)*sin(2*pi*f2(k)*t2);   %それぞれのピークの純音を加算(い)(= 合成音の生成)
    end
   
    %sound(a,Fs1);
    %sound(i,Fs2);
    
clear;

    [Ya,Fs]=audioread('sound1.wav');
    
    Y1=Ya(:,1);
    Y2=Ya(:,2);
    Y=Y1+Y2;
    Y=Y./2;
    ya1=length(Y);
    t=[0:ya1-1]/Fs;
    
    figure;
    plot(t,Y);
    axis([0 3,-0.03 0.03]);
    title('aの波形');
    xlabel('time[s]');
    ylabel('waveform');
    
    pick=fft(Y);
    pick=fftshift(pick);
    
    a=(ya1)/Fs;
    f2=Fs/2;
    freec=[-f2:1/a:f2-1/a];
    
    figure;
    plot(freec,abs(pick));
    axis([-f2 f2, 0 70]);
    title('aのスペクトル');
    xlabel('frequency[Hz]');
    ylabel('power');
    
    
    freq = [135 311 403 530 708 837];
    peek = [-59.1 -56.4 -56.5 -46.6 -47.6 -48.5];
    N=length(peek);
    ams=(zeros(1,N));
    
    for k=1:N
        ams(k)=10^(peek(k)/20);
    end
    
    y1=0;
    
    for k=1:N
        p=ams(k);
        f=freq(k);
        y1=y1+p*sin(2*pi*f*t);
    end
    
    ya1=length(y1);
    
