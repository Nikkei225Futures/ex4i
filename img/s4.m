%%%%%閾値処理%%%%%
close all;
clear;

gray=imread('kadai2_1.bmp');

%閾値処理%
bin1_gray = gray >= 127;
bin2_gray = gray >= 100;

%画像の値の範囲を考慮して画像を表示する
figure;
imshow(bin1_gray,[0 1]);
figure;
imshow(bin2_gray,[0 1]);


imwrite(bin1_gray,'kadai4_1.bmp');
imwrite(bin2_gray,'kadai4_2.bmp');