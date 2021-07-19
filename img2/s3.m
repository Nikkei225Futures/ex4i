close all;
clear;

%read img, create grayImg
img = imread('kut.jpg');
red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);
gray = 0.3*red+0.59*green+0.11*blue;

%make derivative filter, horizontal and vertical
hrznDerivFilter = [-1 0 1;-2 0 2;-1 0 1];   %horizontal derivative filter
verDerivFilter = [-1 -2 -1;0 0 0;1 2 1];    %vertical derivative filter

%apply each derivative filter
hrznDerivatived = filter2(hrznDerivFilter,gray);
verDerivatived = filter2(verDerivFilter,gray);

%remove negative val
hrznDerivatived = abs(hrznDerivatived);
verDerivatived = abs(verDerivatived);

%cast to uint8
hrznDerivatived = uint8(hrznDerivatived);
verDerivatived = uint8(verDerivatived);

figure('Name', '水平方向微分フィルタ');
imshow(hrznDerivatived);
imwrite(hrznDerivatived, 'horizontalDerivatived.bmp');
imwrite(hrznDerivatived, 's3-horizontalDerivatived.jpeg', "JPEG");
 
figure('Name', '垂直方向微分フィルタ');
imshow(verDerivatived);
imwrite(verDerivatived, 'verticalDerivatived.bmp');
imwrite(verDerivatived, 's3-verticalDerivatived.jpeg', "JPEG");


