close all;
clear;

img=imread('kut.jpg');
red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);
gray=0.3*red+0.59*green+0.11*blue;

%水平方向・垂直方向微分フィルタの生成(3*3行列)
fil1=[-1 0 1;-2 0 2;-1 0 1];   %水平方向微分フィルタ
fil2=[-1 -2 -1;0 0 0;1 2 1];   %垂直方向微分フィルタ

%Sobelフィルターをかける
outimg1 = filter2(fil1,gray);
outimg2 = filter2(fil2,gray);

%結果に負の値が含まれているため,abs関数を用いて絶対値をとる
outimg1 = abs(outimg1);
outimg2 = abs(outimg2);

%uint型に変換
outimg1=uint8(outimg1);
outimg2=uint8(outimg2);

figure;
 imshow(outimg1);
 imwrite(outimg1,'kadai3_1.bmp');
 
 figure;
 imshow(outimg2);
 imwrite(outimg2,'kadai3_2.bmp');

