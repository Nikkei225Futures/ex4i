clear;

img=imread('sc1.png');

%RGB色空間からHSV色空間へ変換
img=rgb2hsv(img);

%論理配列を用いて,肌色領域を抽出するフィルタを作成
filter1=img(:,:,1) < 0.10;   %色相1
filter2=img(:,:,1) > 0.01;   %色相2
filter3=img(:,:,2) > 0.25;   %彩度
filter4=img(:,:,3) > 0.20;   %明度

filter=filter1 & filter2 & filter3 & filter4;

%元画像とフィルタをかける
V=img(:,:,3);
V(~(filter)) = 0;
img(:,:,3) = V;

%作成した画像をHSV色空間からRGB色空間へ変換
img=hsv2rgb(img);


figure;
imshow(img);
imwrite(img,'kadai5_1.bmp');




