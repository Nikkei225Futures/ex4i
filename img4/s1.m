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

[x,y] = meshgrid(-199:200, 200:-1:-199);
phSinWavePhiLeft30 = avgBright * (1 + contrast * sin(2*pi*freq*(y*sin(phiLeft30) + x*cos(phiLeft30))));
phSinWavePhiRight60 = avgBright * (1 + contrast * sin(2*pi*freq*(y*sin(phiRight60) + x*cos(phiRight60))));

%img -> freq
swpl30Freq = fft2(phSinWavePhiLeft30);
swpl30FreqShifted = fftshift(swpl30Freq);
swpr60Freq = fft2(phSinWavePhiRight60);
swpr60FreqShifted = fftshift(swpr60Freq);

%get non-filtered power
nfp30Power = abs(swpl30FreqShifted);
nfp60Power = abs(swpr60FreqShifted);


%figure from here, no scaling(average bright = half of maximum bright)
figure();
    subplot(2,2,1);
    colormap(gray(256));
    image(phSinWavePhiLeft30);
    title('a. 左に30度傾いた正弦波縞');
    axis off;
    axis image;
    
    subplot(2,2,2);
    colormap(gray(256));
    image(phSinWavePhiRight60);
    title('b. 右に60度傾いた正弦波縞');
    axis off;
    axis image;
    
    subplot(2,2,3);
    colormap(gray);
    imagesc(nfp30Power);
    title('c. 左に30度傾いた正弦波縞power');
    axis off;
    axis image;
    
    subplot(2,2,4);
    colormap(gray);
    imagesc(nfp60Power);
    title('d. 右に60度傾いた正弦波縞power');
    axis off;
    axis image;
    
    %スケーリングによって斜め方向のスペクトルのパワーが小さく見えるが, 中心の白い点と斜め方向のパワーは同じ
    


 