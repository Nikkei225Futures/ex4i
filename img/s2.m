%%%%%量子化ビット変換%%%%%
close all;
clear;

img=imread('kut2.jpg');
red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);

% make grayscale img
gray=0.3*red+0.59*green+0.11*blue;
gray8bit = gray;

% bitshift
gray4bit=bitshift(gray,-4);
gray2bit=bitshift(gray,-6);
gray1bit=bitshift(gray,-7);

%show imgs
figure('Name', 'grayscale 8bit');
imshow(gray);

figure('Name', 'grayscale 4bit');
imshow(gray4bit,[0 15]);

figure('Name', 'grayscale 2bit');
imshow(gray2bit,[0 3]);

figure('Name', 'grayscale 1bit(二値化画像)');
imshow(gray1bit,[0 1]);

% save imgs as files
imwrite(gray,'grayKut8bit.bmp');
imwrite(gray4bit*(255/15),'grayKut4bit.bmp');
imwrite(gray2bit*(255/3),'grayKut2bit.bmp');
imwrite(gray1bit*255,'grayKut1bit.bmp');

imwrite(gray,'grayKut8bit.jpeg', "JPEG");
imwrite(gray4bit*(255/15),'grayKut4bit.jpeg', "JPEG");
imwrite(gray2bit*(255/3),'grayKut2bit.jpeg', "JPEG");
imwrite(gray1bit*255,'grayKut1bit.jpeg', "JPEG");




