clear;

img = imread('kut.jpg');
red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);
gray = 0.3*red+0.59*green+0.11*blue;

%meke laplacian filter
laplacianFilter = [1 1 1;1 -8 1;1 1 1];

%apply laplacian filter
filteredImg = filter2(laplacianFilter,gray);

%remove negative value
filteredImg = abs(filteredImg);

%cast to uing8
filteredImg = uint8(filteredImg);

figure('Name', 'ラプラシアンフィルタ');
imshow(filteredImg);

%if filtered img < 128, output = 0(black)
%else, output = 255(white)
logical = filteredImg < 128;  
filteredImg(logical) = 0;        
filteredImg(not(logical)) = 255;

figure('Name', 'ラプラシアンフィルタ+閾値処理');
imshow(filteredImg);
imwrite(filteredImg,'laplacianFiltered.bmp');

%ラプラシアンフィルタを適用したときに取り得る値は255を超える可能性がある
%->最小値-最大値を正規化する必要があるが、検出する境界線が薄くなる事もあるので注意が必要