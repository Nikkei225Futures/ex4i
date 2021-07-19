%%%%%è‡’lˆ—%%%%%
close all;
clear;

gray=imread('grayKut8bit.bmp');

threshold1 = 50;
threshold2 = 200;

% make binary imgs using threshold
bin1 = gray >= threshold1;
bin2 = gray >= threshold2;
threshold1 = string(threshold1);
threshold2 = string(threshold2);

% show imgs
figure('Name', 'threshold = ' + threshold1);
imshow(bin1,[0 1]);
figure('Name', 'threshold = ' + threshold2);
imshow(bin2,[0 1]);


imwrite(bin1,'grayKutThreshold1.bmp');
imwrite(bin2,'grayKutThreshold2.bmp');

imwrite(bin1,'grayKutThreshold1.jpeg', "JPEG");
imwrite(bin2,'grayKutThreshold2.jpeg', "JPEG");