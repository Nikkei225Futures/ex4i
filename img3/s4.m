% LPF

clear;
close all;

imgLenna = imread('LENNA.bmp');

freq = fft2(imgLenna);

shifted = fftshift(freq);

figure;
colormap(gray);
pimg1 = abs(shifted).^2;
imagesc(log(pimg1));

[height width] = size(imgLenna);

%initialize filters
filter10 = ones(height,width);
filter50 = ones(height,width);

for y = 1:height
    for x = 1:width
        d = sqrt((x-width/2)^2 + (y-height/2)^2);
        if(d > 10)
            filter10(y,x) = 0;
        end
    end
end

for y = 1:height
    for x = 1:width
        d = sqrt((x-width/2)^2 + (y-height/2)^2);
        if(d > 50)
            filter50(y,x) = 0;
        end
    end
end


%filterの描画
%figure;
%colormap(gray);
%imagesc(filter1);

%figure;
%colormap(gray);
%imagesc(filter2);

%apply filter
filtered10Freq = shifted .* filter10;
filtered50Freq = shifted .* filter50;

%周波数領域でのパワースペクトルの描画
filteredPower10 = abs(filtered10Freq).^2;
filteredPower50 = abs(filtered50Freq).^2;

figure;
colormap(gray);
imagesc(log(filteredPower10));

figure;
colormap(gray);
imagesc(log(filteredPower50));

%freq -> img
ifftshifted10 = ifftshift(filtered10Freq);
ifftshifted50 = ifftshift(filtered50Freq);

filtered10img = ifft2(ifftshifted10);
filtered50img = ifft2(ifftshifted50);

filtered10img = real(filtered10img);
filtered50img = real(filtered50img);

figure;
colormap(gray);
imagesc(filtered10img);

figure;
colormap(gray);
imagesc(filtered50img);

