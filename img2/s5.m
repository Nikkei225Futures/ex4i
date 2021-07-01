clear;

img = imread('thispersondoesnotexist.jpg');

%rgb -> hsv
img=rgb2hsv(img);

%make filter
hueFilter = img(:,:,1) < 0.10;   %色相
hueFilter = hueFilter > 0.01;
saturationFilter = img(:,:,2) > 0.25;   %彩度
brightnessFilter = img(:,:,3) > 0.20;   %明度

filter = hueFilter & saturationFilter & brightnessFilter;

%apply filter
brightness = img(:,:,3);
brightness(~(filter)) = 0;
img(:,:,3) = brightness;

%hsv -> rgb
img=hsv2rgb(img);


figure;
imshow(img);
imwrite(img,'skinFiltered.bmp');

%肌の色によっては検出できない事があるので倫理的に問題がある


