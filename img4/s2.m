%方位残効:
%ある方位＋空間周波数に対する選択性を持つ複雑型細胞は、その方位＋空間周波数を見たとき, 発火頻度が高くなる
%しかし, ある空間周波数と方位の縞を見続けると, 複雑型細胞が順応し, 発火頻度が低下する
%このあと, 垂直の縞を見ると, ある方位に選択性を持つ複雑型細胞は発火頻度が低下したままになる. 
%すると, 逆方向の方位に選択性を持つ複雑型細胞の発火頻度の方が順応した複雑型細胞の発火頻度より高くなり, 
%結果として, 逆方向に方位のある縞が知覚される.
%ただし, 順応している時間には限りがあるので, ある程度時間が経つと方位残効の効果はなくなる.

clear;

height = 400;
width = 400;

%def vals
contrast = 0.5;
freq = 0.03;
phiLeft10 = -10*(pi/180);
phiRight10 = 10*(pi/180);
phiLeft45 = -45*(pi/180);
phiRight45 = 45*(pi/180);
phi0 = 0*(pi/180);
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

clearvars -except swpl10 swpr10 swpl45 swpr45 swp0 phSinWave*;
close all;

%margin between stimlus and rectangle, circle
margin = ones(40, 400);
margin = margin .* 255;
margin = margin .* 0.95;

%make rectangle, circle
rectangle = ones(20, 400);
rectangle = rectangle .* 255;
rectangle = rectangle .* 0.95;
for k = 1:20
    for l = 150:250
        rectangle(k, l) = 0;
    end
end

circle = ones(20, 400);
circle = circle .* 255;
circle = circle .* 0.95;
r = 10;

porHeight = 20;
porWidth = 400;
for k = 1:porHeight
    for l = 1:porWidth
        d = sqrt((l-porWidth/2)^2 + (k-porHeight/2)^2);
        if(d <= r)
            circle(k, l) = 0;
        end
    end
end

%make each stim image
wholeImg10 = [swpl10; margin; rectangle; margin; swpr10];
wholeImg10raw = [phSinWavePhiLeft10; margin; rectangle; margin; phSinWavePhiRight10];
wholeImg45 = [swpl45; margin; rectangle; margin; swpr45];
wholeImg45raw = [phSinWavePhiLeft45; margin; rectangle; margin; phSinWavePhiRight45];
fin = [swp0; margin; circle; margin; swp0];
finRaw = [phSinWavePhi0; margin; circle; margin; phSinWavePhi0];

%experiment 
finish = figure;
finish.WindowState = 'maximized';
    colormap(gray(256));
    image(fin);
    %image(finRaw);
    axis off;
    axis image;

waitsec = 10;
stim = figure;
stim.WindowState = 'maximized';
    colormap(gray(256));
    %image(wholeImg45raw);
    image(wholeImg10);
    axis off;
    axis image;
    pause(waitsec);
    close(stim);

%順応後, テスト刺激が左側に引っ張られるような感じがした.
%引っ張られるような感じの度合いは+-10度の方が大きいように感じた.
