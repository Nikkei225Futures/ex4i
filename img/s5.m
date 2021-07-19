close all;
clear;

gray=imread('grayKut8bit.bmp');

%make histogram
histogram=zeros(1,256);
for i=0:255
    numOfSpecifiedPxVal = gray == i; 
    histogram(i+1) = sum(sum(numOfSpecifiedPxVal));
end

%ヒストグラムの表示

figure;
plot(histogram);
xlim([0 255]);
xlabel("Pixel value");
ylabel("quantity of pixel");
%title("Histgram")
