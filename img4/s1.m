clear;
close all;

height = 256;
width = 256;

%def vals
contrast = 0.5;
freq = 0.05;
phiLeft30 = 150*(pi/180);
phiRight60 = 210*(pi/180);
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
passRange = 50;
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
    subplot(2,2,1);
    colormap(gray(256));
    image(swpl30);
    title('左に30度傾いた正弦波縞');
    axis off;
    axis image;
    
    subplot(2,2,2);
    colormap(gray(256));
    image(swpr60);
    title('右に60度傾いた正弦波縞');
    axis off;
    axis image;
    
    subplot(2,2,3);
    colormap(gray);
    imagesc(log(filteredPower1));
    title('左に30度傾いた正弦波縞power');
    axis off;
    axis image;
    
    subplot(2,2,4);
    colormap(gray);
    imagesc(log(filteredPower2));
    title('右に60度傾いた正弦波縞power');
    axis off;
    axis image;

%%%%%%%%%%%%%%%%%%%%%make img of next task%%%%%%%%%%%%%%%%%%%%%%%%
clear;

height = 400;
width = 400;

%[x,y] = meshgrid(-149:150,150:-1:-149);

%def vals
contrast = 0.5;
freq = 0.03;
phiLeft10 = 170*(pi/180);
phiRight10 = 190*(pi/180);
phiLeft45 = 135*(pi/180);
phiRight45 = 225*(pi/180);
phi0 = 360 * (pi/180);
avgBright = 255*0.7;

%predefine
phSinWavePhiLeft10 = zeros(height, width);
phSinWavePhiRight10 = zeros(height, width);

phSinWavePhiLeft45 = zeros(height, width);
phSinWavePhiRight45 = zeros(height, width);

phSinWavePhi0 = zeros(height, width);

for k = 1:height
    for l = 1:width
        %def sin wave
        phSinWavePhiLeft10(k,l) = avgBright * (1 + contrast * sin(2*pi*freq*(k*sin(phiLeft10) + l*cos(phiLeft10))));
        phSinWavePhiRight10(k,l) = avgBright * (1 + contrast * sin(2*pi*freq*(k*sin(phiRight10) + l*cos(phiRight10))));
        
        phSinWavePhiLeft45(k,l) = avgBright * (1 + contrast * sin(2*pi*freq*(k*sin(phiLeft45) + l*cos(phiLeft45))));
        phSinWavePhiRight45(k,l) = avgBright * (1 + contrast * sin(2*pi*freq*(k*sin(phiRight45) + l*cos(phiRight45))));
        
        phSinWavePhi0(k, l) = avgBright * (1 + contrast * sin(2*pi*freq*(k*sin(phi0) + l*cos(phi0))));
    end
end

%define lpf
lpf = ones(height, width);
passRange = 50;
for k = 1:height
    for l = 1:width
        d = sqrt((l-width/2)^2 + (k-height/2)^2);
        if(d > passRange)
            lpf(k, l) = 0;
        end
    end
end

%img -> freq
    %+-10deg
    swpl10Freq = fft2(phSinWavePhiLeft10);
    swpl10FreqShifted = fftshift(swpl10Freq);
    swpr10Freq = fft2(phSinWavePhiRight10);
    swpr10FreqShifted = fftshift(swpr10Freq);
    
    %+-45deg
    swpl45Freq = fft2(phSinWavePhiLeft45);
    swpl45FreqShifted = fftshift(swpl45Freq);
    swpr45Freq = fft2(phSinWavePhiRight45);
    swpr45FreqShifted = fftshift(swpr45Freq);
    
    %+-0deg
    swp0Freq = fft2(phSinWavePhi0);
    swp0FreqShifted = fftshift(swp0Freq);

%apply lpf
    %+-10deg
    swpl10FreqFiltered = lpf .* swpl10FreqShifted;
    filteredPower101 = abs(swpl10FreqFiltered).^2;
    swpr10FreqFiltered = lpf .* swpr10FreqShifted;
    filteredPower102 = abs(swpr10FreqFiltered).^2;
    
    %+-45deg
    swpl45FreqFiltered = lpf .* swpl45FreqShifted;
    filteredPower451 = abs(swpl45FreqFiltered).^2;
    swpr45FreqFiltered = lpf .* swpr45FreqShifted;
    filteredPower452 = abs(swpr45FreqFiltered).^2;
    
    %+-0deg
    swp0FreqFiltered = lpf .* swp0FreqShifted;
    filteredPower0 = abs(swp0FreqFiltered).^2;
    
%freq -> img
    %+-10deg
    swpl10 = ifftshift(swpl10FreqFiltered);
    swpl10 = ifft2(swpl10);
    swpl10 = real(swpl10);
    swpr10 = ifftshift(swpr10FreqFiltered);
    swpr10 = ifft2(swpr10);
    swpr10 = real(swpr10);
    
    %+-45deg
    swpl45 = ifftshift(swpl45FreqFiltered);
    swpl45 = ifft2(swpl45);
    swpl45 = real(swpl45);
    swpr45 = ifftshift(swpr45FreqFiltered);
    swpr45 = ifft2(swpr45);
    swpr45 = real(swpr45);
    
    %+-0deg
    swp0 = ifftshift(swp0FreqFiltered);
    swp0 = ifft2(swp0);
    swp0 = real(swp0);

%figure from here, no scaling(average bright = half of maximum bright)
figure('Name', '+-10deg');
    subplot(2,2,1);
    colormap(gray(256));
    image(swpl10);
    title('左に10度傾いた正弦波縞');
    axis off;
    axis image;

    subplot(2,2,2);
    colormap(gray(256));
    image(swpr10);
    title('右に10度傾いた正弦波縞');
    axis off;
    axis image;
    
    subplot(2,2,3);
    colormap(gray);
    imagesc(log(filteredPower101));
    title('左に10度傾いた正弦波縞power');
    axis off;
    axis image;
    
    subplot(2,2,4);
    colormap(gray);
    imagesc(log(filteredPower102));
    title('右に10度傾いた正弦波縞power');
    axis off;
    axis image;

figure('Name', '+-45deg');
    subplot(2,2,1);
    colormap(gray(256));
    image(swpl45);
    title('左に45度傾いた正弦波縞');
    axis off;
    axis image;

    subplot(2,2,2);
    colormap(gray(256));
    image(swpr45);
    title('右に45度傾いた正弦波縞');
    axis off;
    axis image;
    
    subplot(2,2,3);
    colormap(gray);
    imagesc(log(filteredPower451));
    title('左に45度傾いた正弦波縞power');
    axis off;
    axis image;
    
    subplot(2,2,4);
    colormap(gray);
    imagesc(log(filteredPower452));
    title('右に45度傾いた正弦波縞power');
    axis off;
    axis image;
    
figure('Name', '+-0deg');
    subplot(2,1,1);
    colormap(gray(256));
    image(swp0);
    title('正弦波縞');
    axis off;
    axis image;

    subplot(2,1,2);
    colormap(gray(256));
    imagesc(log(filteredPower0));
    title('正弦波縞power');
    axis off;
    axis image;
    

 