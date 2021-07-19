close all;
clear;

img = imread('kut.jpg');
red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);
grayImpulse = 0.3*red+0.59*green+0.11*blue;
grayGaussian = 0.3*red+0.59*green+0.11*blue;

%make impulse noise
[height width] = size(grayImpulse);       %get size of kut.jpg
rndmVal = rand(height,width);
black = (rndmVal <= 0.01);
white = (rndmVal >= 0.99);
grayImpulse(black) = 0;
grayImpulse(white) = 255;

figure('Name', 'kut.jpg + インパルス雑音');
imshow(grayImpulse);
imwrite(grayImpulse, 'grayImpulseNoise.bmp');
imwrite(grayImpulse, 's1-grayImpulseNoise.jpeg', "JPEG");

%make white gaussian noise
rndmVal2 = 10*randn(height, width);
outimg = rndmVal2+double(grayGaussian);  %double -> uint8
outimg = uint8(outimg);

figure('Name', 'kut.jpg + 白色ガウス雑音');
imshow(outimg);
imwrite(outimg, 'grayGaussianNoise.bmp');
imwrite(outimg, 's1-grayGaussianNoise.jpeg', "JPEG");

%インパルス雑音は0か1の極端な値を入れているから白と黒の雑音がはっきり確認できる
%白色ガウス雑音は

