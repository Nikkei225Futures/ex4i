%%%%%ヒストグラム%%%%%
close all;
clear;

gray=imread('kadai2_1.bmp');

%画素値(0～255)ごとの画素数の集計

his=zeros(1,256);
for i=0:255
    bin = gray == i;           %画素値がiの値を持つ画素を取り出す
    vec = sum(bin);          %行列の列ごとの要素の和をもつ行ベクトル
    his(i+1) = sum(vec);    %行ベクトルの要素の和
end

%ヒストグラムの表示

figure;
bar(his);
axis([0 255 0 8000])
xlabel("Pixel value");
ylabel("Number of picels");
title("Histgram")
