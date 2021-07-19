%%%%%カラーチャネル操作%%%%%
close all;
clear;

img=imread('kut2.jpg');

%make vars of each color channel
red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);

%show each color channel
figure('Name', 'grayscale(red channel)');
imshow(red);

figure('Name', 'grayscale(green channel)');
imshow(green);

figure('Name', 'grayscale(blue channel)');
imshow(blue);

% make swaped img(r<->b)
img2(:,:,1)=blue;
img2(:,:,2)=green;
img2(:,:,3)=red;

figure('Name', '赤色チャネルと青色チャネルを入れ替えた画像');
imshow(img2);

imwrite(red, "s1-red.jpeg", "JPEG");
imwrite(green, "s1-green.jpeg", "JPEG");
imwrite(blue, "s1-blue.jpeg", "JPEG");
imwrite(img2, "s1-swap.jpeg", "JPEG");



