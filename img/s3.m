%%%%%ŠK’²”½“]%%%%%
close all;
clear;

grayKut8bit=imread('grayKut8bit.bmp');
grayKut4bit=imread('grayKut4bit.bmp');
grayKut2bit=imread('grayKut2bit.bmp');
grayKut1bit=imread('grayKut1bit.bmp');

% make inverse of img
grayKut8bitInv=255-grayKut8bit;
grayKut4bitInv=255-grayKut4bit;
grayKut2bitInv=255-grayKut2bit;
grayKut1bitInv=255-grayKut1bit;

% show img 
figure('Name', '255 - 8bitImg');
imshow(grayKut8bitInv);
figure('Name', '255 - 4bitImg');
imshow(grayKut4bitInv);
figure('Name', '255 - 2bitImg');
imshow(grayKut2bitInv);
figure('Name', '255 - 1bitImg');
imshow(grayKut1bitInv);

% save imgs as file
imwrite(grayKut8bitInv,'grayKut8bitInv.bmp');
imwrite(grayKut4bitInv,'grayKut4bitInv.bmp');
imwrite(grayKut2bitInv,'grayKut2bitInv.bmp');
imwrite(grayKut1bitInv,'grayKut1bitInv.bmp');

imwrite(grayKut8bitInv,'grayKut8bitInv.jpeg', "JPEG");
imwrite(grayKut4bitInv,'grayKut4bitInv.jpeg', "JPEG");
imwrite(grayKut2bitInv,'grayKut2bitInv.jpeg', "JPEG");
imwrite(grayKut1bitInv,'grayKut1bitInv.jpeg', "JPEG");

