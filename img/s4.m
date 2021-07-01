%%%%%è‡’lˆ—%%%%%
close all;
clear;

gray=imread('grayKut8bit.bmp');

threshold1 = 50;
threshold2 = 200;

% make binary imgs using threshold
bin1_gray = gray >= threshold1;
bin2_gray = gray >= threshold2;
threshold1 = string(threshold1);
threshold2 = string(threshold2);

% show imgs
figure('Name', 'threshold = ' + threshold1);
imshow(bin1_gray,[0 1]);
figure('Name', 'threshold = ' + threshold2);
imshow(bin2_gray,[0 1]);


imwrite(bin1_gray,'grayKutThreshold1.bmp');
imwrite(bin2_gray,'grayKutThreshold2.bmp');