%%%%%臒l����%%%%%
close all;
clear;

gray=imread('kadai2_1.bmp');

%臒l����%
bin1_gray = gray >= 127;
bin2_gray = gray >= 100;

%�摜�̒l�͈̔͂��l�����ĉ摜��\������
figure;
imshow(bin1_gray,[0 1]);
figure;
imshow(bin2_gray,[0 1]);


imwrite(bin1_gray,'kadai4_1.bmp');
imwrite(bin2_gray,'kadai4_2.bmp');