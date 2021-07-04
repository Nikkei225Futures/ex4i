%%%%%2次元FFT2%%%%%

%1. 画像の作成(256x256で黒の横縞4本,16本,64本)


clear;
close all;

height = 256;
width = 256;
 
 for k = 1:height
     for l = 1:width
         img4(k,l) = 1 + sin(2*pi*k*4/256);
         img16(k,l) = 1 + sin(2*pi*k*16/256);
         img64(k,l) = 1 + sin(2*pi*k*64/256);
         
     end
 end

 %img -> freq
 img4Freq = fft2(img4);
 img16Freq = fft2(img16);
 img64Freq = fft2(img64);
 
 shifted4Freq = fftshift(img4Freq);
 shifted16Freq = fftshift(img16Freq);
 shifted64Freq = fftshift(img64Freq);
 
 %get power 
 img4Power = abs(shifted4Freq).^2;
 img16Power = abs(shifted16Freq).^2;
 img64Power = abs(shifted64Freq).^2;
 
 
 %figure from here
 figure;
 colormap(gray);
 imagesc(img4);
 
 
 figure;
 colormap(gray);
 imagesc(img4Power);
 
 figure;
 colormap(gray);
 imagesc(img16);
 
 figure;
 colormap(gray);
 imagesc(img16Power);
 
 figure;
 colormap(gray);
 imagesc(img64);
 
 figure;
 colormap(gray);
 imagesc(img64Power);
 
 