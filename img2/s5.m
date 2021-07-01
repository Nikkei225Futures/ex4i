clear;
close all;

faceImg = imread('thispersondoesnotexist.jpg');

%rgb -> hsv
faceImg = rgb2hsv(faceImg);

%make filter
hueFilter = faceImg(:,:,1) < 0.10;   %色相
hueFilter = hueFilter > 0.01;
saturationFilter = faceImg(:,:,2) > 0.2;   %彩度
brightnessFilter = faceImg(:,:,3) > 0.1;   %明度

filter = hueFilter & saturationFilter & brightnessFilter;
figure;
imshow(filter);

%apply filter
brightness = faceImg(:,:,3);
brightness(~(filter)) = 0;
faceImg(:,:,3) = brightness;

%hsv -> rgb
faceImg = hsv2rgb(faceImg);

figure;
imshow(faceImg);
imwrite(faceImg,'skinFiltered.bmp');


