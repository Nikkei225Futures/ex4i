clear;
close all;

height = 400;
width = 400;

%def vals
contrast = 0.5;
freq = 0.05;
phiLeft30 = -30*(pi/180);
phiRight60 = 60*(pi/180);
avgBright = 255/2;

%predefine
phSinWavePhiLeft30 = zeros(height, width);
phSinWavePhiRight60 = zeros(height, width);


for k = 1:height
    for l = 1:width
        %dc included
        phSinWavePhiLeft30(k,l) = avgBright * (1 + contrast * sin(2*pi*freq*(k*sin(phiLeft30) + l*cos(phiLeft30))));
        phSinWavePhiRight60(k,l) = avgBright * (1 + contrast * sin(2*pi*freq*(k*sin(phiRight60) + l*cos(phiRight60))));
    end
end

%define lpf
lpf = ones(height, width);
passRange = height;        %pass all
for k = 1:height
    for l = 1:width
        d = sqrt((l-width/2)^2 + (k-height/2)^2);
        if(d > passRange)
            lpf(k, l) = 0;
        end
    end
end

%img -> freq
swpl30Freq = fft2(phSinWavePhiLeft30);
swpl30FreqShifted = fftshift(swpl30Freq);
swpr60Freq = fft2(phSinWavePhiRight60);
swpr60FreqShifted = fftshift(swpr60Freq);

%get non-filtered power
nfp30Power = abs(swpl30FreqShifted).^2;
nfp60Power = abs(swpr60FreqShifted).^2;

%apply lpf
swpl30FreqFiltered = lpf .* swpl30FreqShifted;
filteredPower1 = abs(swpl30FreqFiltered).^2;
swpr60FreqFiltered = lpf .* swpr60FreqShifted;
filteredPower2 = abs(swpr60FreqFiltered).^2;

%get power
swpl30Power = abs(swpl30FreqFiltered).^2;
swpr60Power = abs(swpr60FreqFiltered).^2;

%freq -> img
swpl30 = ifftshift(swpl30FreqFiltered);
swpl30 = ifft2(swpl30);
swpl30 = real(swpl30);

swpr60 = ifftshift(swpr60FreqFiltered);
swpr60 = ifft2(swpr60);
swpr60 = real(swpr60);

%figure from here, no scaling(average bright = half of maximum bright)
figure();
    subplot(2,1,1);
    colormap(gray(256));
    image(swpl30);
    title('左に30度傾いた正弦波縞');
    axis off;
    axis image;
    
    subplot(2,1,2);
    colormap(gray(256));
    image(swpr60);
    title('右に60度傾いた正弦波縞');
    axis off;
    axis image;
    %{
    subplot(2,2,3);
    colormap(gray);
    imagesc(nfp30Power);
    title('左に30度傾いた正弦波縞power');
    axis off;
    axis image;
    
    subplot(2,2,4);
    colormap(gray);
    imagesc(nfp60Power);
    title('右に60度傾いた正弦波縞power');
    axis off;
    axis image;
    %}


 