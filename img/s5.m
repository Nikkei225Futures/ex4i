%%%%%ヒストグラム%%%%%
close all;
clear;

gray=imread('grayKut8bit.bmp');

%make histogram
histogram=zeros(1,256);
for i=0:255
    numOfSpecifiedPxVal = gray == i;         %画素値がiの値を持つ画素を取り出す
    row = sum(numOfSpecifiedPxVal);          %行列の列ごとの要素の和をもつ行ベクトル
    histogram(i+1) = sum(row);               %行ベクトルの要素の和
end

%ヒストグラムの表示

figure;
plot(histogram);
xlim([0 255]);
xlabel("Pixel value");
ylabel("quantity of pixel");
title("Histgram")
