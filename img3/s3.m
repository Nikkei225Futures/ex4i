
clear;
close all;

height = 256;
width = 256;

img00 = zeros(height,width);
img6060 = zeros(height,width);

centerH = height/2;
centerW = width/2;

for y = 1:height
    for x = 1:width
        if(y > centerH-15 && y < centerH+15 && x > centerW - 30 && x < centerW + 30)
            img00(y,x) = 1;
        else if(y > centerH-15+60 && y < centerH+15+60 && x > centerW - 30+60 && x < centerW + 30+60)
                img6060(y,x) = 1;
            end
        end
    end
end


%img -> freq
img00Freq = fft2(img00);
img6060Freq = fft2(img6060);

shifted00 = fftshift(img00Freq);
shifted6060 = fftshift(img6060Freq);

%get power
img00Power = abs(shifted00).^2;
img6060power = abs(shifted6060).^2;


figure;
colormap(gray);
imagesc(img00);

figure;
colormap(gray);
imagesc(img6060);

figure;
colormap(gray);
imagesc(log(img00Power));

figure;
colormap(gray);
imagesc(log(img6060power));


