clear;
close all;

faceImg = imread('thispersondoesnotexist.jpg');

%rgb -> hsv
faceImg = rgb2hsv(faceImg);

%make logical filter
hueFilter = faceImg(:,:,1) < 0.10;   %色相
saturationFilter = faceImg(:,:,2) > 0.2;   %彩度
brightnessFilter = faceImg(:,:,3) > 0.1;   %明度
filter = hueFilter & saturationFilter & brightnessFilter;

faceImg = hsv2rgb(faceImg); %hsv -> rgb

%apply filter to each color
faceImg(:,:,1) = faceImg(:,:,1) .* filter;
faceImg(:,:,2) = faceImg(:,:,2) .* filter;
faceImg(:,:,3) = faceImg(:,:,3) .* filter;

figure;
imshow(faceImg);
imwrite(faceImg,'skinFiltered.bmp');

%figure;
%imshow(filter);

%rgbだと、明度を表現しにくいのでhsv色空間を使うとよい(影などは色相や彩度は同じだが、明度が大きく異なる)
