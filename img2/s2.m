close all;
clear;

imgImpulse=imread('grayImpulseNoise.bmp');  
imgGaussian=imread('grayGaussianNoise.bmp'); 

avgFilter=[1/9 1/9 1/9;1/9 1/9 1/9;1/9 1/9 1/9];    % filter(average)

%filtering each img which has noise
averagedImpulse = filter2(avgFilter,imgImpulse);   
averagedGaussian = filter2(avgFilter,imgGaussian);
averagedImpulse = uint8(averagedImpulse);
averagedGaussian = uint8(averagedGaussian);

figure('Name', '平滑化フィルタxインパルス雑音');
imshow(averagedImpulse);
imwrite(averagedImpulse, 'averagedImpulseNoise.bmp');
 
figure('Name', '平滑化フィルタx白色ガウス雑音');
imshow(averagedGaussian);
imwrite(averagedGaussian,'averagedGaussianNoise.bmp');

%read gray img which has 2 noises
impulseNoise = imread('grayImpulseNoise.bmp');  
gaussianNoise = imread('grayGaussianNoise.bmp'); 
midianizedImpulse = impulseNoise;
medianizedGaussian = gaussianNoise;
 
 
[height width] = size(impulseNoise); 
 
%determine value of target pixel to get near 8+1 pixels
for y = 2:height-1
    for x = 2:width-1      
         %get target pixels(3x3)
         impulse3x3 = impulseNoise(y-1:y+1,x-1:x+1);
         gaussian3x3 = gaussianNoise(y-1:y+1,x-1:x+1);
         
         %reshape 3x3 -> 1x9
         impulse1x9 = reshape(impulse3x3,[1,9]);
         gaussian1x9 = reshape(gaussian3x3,[1,9]);
         
         %apply median filter to target
         midianizedImpulse(y,x) = median(impulse1x9);
         medianizedGaussian(y,x) = median(gaussian1x9); 
      
    end
end
 
%outimg3=uint8(out3);
%outimg4=uint8(out4);

figure('Name', 'メディアンフィルタxインパルス雑音');
imshow(midianizedImpulse);
imwrite(midianizedImpulse, 'medianizedImpulseNoise.bmp');
 
figure('Name', 'メディアンフィルタx白色ガウス雑音');
imshow(medianizedGaussian);
imwrite(medianizedGaussian, 'medianizedGaussianNoise.bmp');
 
%平滑化フィルタは輪郭がはっきりいない。周囲の画素の影響を受けるためぼやける

 