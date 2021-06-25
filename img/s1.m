%%%%%カラーチャネル操作%%%%%
close all;
clear;
%画像の読み込み
img=imread('kut2.jpg');
%それぞれの色チャネルの配列を作成
red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);
%それぞれの色チャネルをグレイスケール画像として表示する
figure('Name', 'grayscale(red channel)');
imshow(red);

figure('Name', 'grayscale(green channel)');
imshow(green);

figure('Name', 'grayscale(blue channel)');
imshow(blue);

%赤チャネルと青チャネルを入れ替えた画像%
img2(:,:,1)=blue;
img2(:,:,2)=green;
img2(:,:,3)=red;

figure('Name', 'r<->b');
imshow(img2);





