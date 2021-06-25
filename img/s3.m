%%%%%ŠK’²”½“]%%%%%
close all;
clear;

img1=imread('kadai2_1.bmp');
img2=imread('kadai2_2.bmp');
img3=imread('kadai2_3.bmp');
img4=imread('kadai2_4.bmp');

%ŠK’²”½“](ƒlƒKƒ|ƒW)•ÏŠ·‚ğs‚¤
img5=255-img1;
img6=255-img2;
img7=255-img3;
img8=255-img4;

%‰æ‘œ‚Ì’l‚Ì”ÍˆÍ‚ğl—¶‚µ‚Ä‰æ‘œ‚ğ•\¦
figure;
imshow(img5);
figure;
imshow(img6);
figure;
imshow(img7);
figure;
imshow(img8);

%imwriteŠÖ”‚ğg‚Á‚ÄbmpŒ`®‚Å•Û‘¶
imwrite(img5,'kadai3_1.bmp');
imwrite(img6,'kadai3_2.bmp');
imwrite(img7,'kadai3_3.bmp');
imwrite(img8,'kadai3_4.bmp');

