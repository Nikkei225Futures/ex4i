clear;

    [X,Fs1]=audioread('sound1.wav');   %音声ファイルの読み込み
    [Y,Fs2]=audioread('sound2.wav');   %音声ファイルの読み込み
    
    t1=[0:length(X)-1]/Fs1; %Xの時間 length()は配列の長さを持ってくる関数
    t2=[0:length(Y)-1]/Fs2; %Yの時間
    
    X1=X(:,1);   %片方の列ベクトル取り出し
    Y1=Y(:,1);   %片方の列ベクトル取り出し
    
    X2=(-1).*X1;    %グラフの反転(-1倍)
    Y2=(-1).*Y1;    %グラフの反転(-1倍)
    
    
    figure;       %振幅は音の大きさを周波数は音の高さを表す。
                  %反転したとしても振幅と周波数が変わらないから音に違いはない
    
    plot(t1,X1,t1,X2);
    legend('aの元の波形','位相反転した波形');
    xlabel('Time[s]');
    ylabel('Amplitude');
    title('aの元の波形と位相反転させた波形');
    axis([0 0.01,-0.04 0.04]);
    
    
    figure;
    
    plot(t2,Y1,t2,Y2);
    legend('iの元の波形','位相反転した波形');
    xlabel('Time[s]');
    ylabel('Amplitude');
    title('iの元の波形と位相反転させた波形');
    axis([0 0.01,-0.04 0.04]);
    
  
    
     %sound(X1,Fs1);
     %sound(X2,Fs1);
     %sound(Y1,Fs2);
     %sound(Y2,Fs2);
