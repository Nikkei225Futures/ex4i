%%%%%2次元FFT1%%%%%

%1. 画像の作成(256x256で黒の縦縞4本,16本,64本)

clear;
close all;

height = 256;
width = 256;

 for k = 1:height
     for l = 1:width
         %dc included
         img4(k,l) = 1 + sin(2*pi*l*4/256);
         img16(k,l) = 1 + sin(2*pi*l*16/256);
         img64(k,l) = 1 + sin(2*pi*l*64/256);
         
         %dc not included
         img4ndc(k,l) = sin(2*pi*l*4/256);
         img16ndc(k,l) = sin(2*pi*l*16/256);
         img64ndc(k,l) = sin(2*pi*l*64/256);
         
     end
 end
 
 
 %img -> freq
 img4Freq = fft2(img4);
 img16Freq = fft2(img16);
 img64Freq = fft2(img64);
 img4ndcFreq = fft2(img4ndc);
 img16ndcFreq = fft2(img16ndc);
 img64ndcFreq = fft2(img64ndc);
 
 shifted4Freq = fftshift(img4Freq);
 shifted16Freq = fftshift(img16Freq);
 shifted64Freq = fftshift(img64Freq);
 
 shifted4ndcFreq = fftshift(img4ndcFreq);
 shifted16ndcFreq = fftshift(img16ndcFreq);
 shifted64ndcFreq = fftshift(img64ndcFreq);
 
 %get power spec
 img4Power = abs(shifted4Freq).^2;
 img16Power = abs(shifted16Freq).^2;
 img64Power = abs(shifted64Freq).^2;
 img4ndcPower = abs(shifted4ndcFreq).^2;
 img16ndcPower = abs(shifted16ndcFreq).^2;
 img64ndcPower = abs(shifted64ndcFreq).^2;
 
 %figure from here
 figure;
     subplot(2, 2, 1);
     colormap(gray);
     imagesc(img4);
     title('縦縞4本 with dc');

     subplot(2, 2, 2);
     colormap(gray);
     imagesc(img4ndc);
     title('縦縞4本, non dc');
 
     subplot(2, 2, 3);
     colormap(gray);
     imagesc(img4Power);
     title('縦縞4本power with dc');

     subplot(2, 2, 4);
     colormap(gray);
     imagesc(img4ndcPower);
     title('縦縞4本power non dc');

 
 figure;
     subplot(2,2,1);
     colormap(gray);
     imagesc(img16);
     title('縦縞16本 with dc');

     subplot(2,2,2);
     colormap(gray);
     imagesc(img16ndc);
     title('縦縞16本 non dc');
 
     subplot(2,2,3);
     colormap(gray);
     imagesc(img16Power);
     title('縦縞16本power with dc');

     subplot(2,2,4);
     colormap(gray);
     imagesc(img16ndcPower);
     title('縦縞16本power non dc');
 
 figure;
     subplot(2,2,1);
     colormap(gray);
     imagesc(img64);
     title('縦縞64本 with dc');
     
     subplot(2,2,2);
     colormap(gray);
     imagesc(img64ndc);
     title('縦縞64本 non dc');
 
     subplot(2,2,3);
     colormap(gray);
     imagesc(img64Power);
     title('縦縞64本power with dc');

     subplot(2,2,4);
     colormap(gray);
     imagesc(img64ndcPower);
     title('縦縞64本power non dc');
    
 % 縞が多くなると, パワースペクトルの点の間隔が広がる.(パワースペクトルの中心ほど低周波, 振幅にあたるものは濃淡)
 % 直流成分がなくなると, 中心の点がなくなる. パワースペクトルの中心を特に直流成分という.
 
 