clear;

img=imread('kut.jpg');
red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);
gray=0.3*red+0.59*green+0.11*blue;

%ラプラシアンフィルタの生成(3*3行列)
fil1=[1 1 1;1 -8 1;1 1 1];

%ラプラシアンフィルタをかける
outimg1 = filter2(fil1,gray);

%結果に負の値が含まれているため,abs関数を用いて絶対値をとる
outimg1 = abs(outimg1);

%uint型に変換
outimg1=uint8(outimg1);

%閾値処理を行う
logical = outimg1 < 128;  
outimg1(logical) = 0;        %1が格納されている
outimg1(not(logical)) = 255;  %0が格納されている

figure;
 imshow(outimg1);
 imwrite(outimg1,'kadai4_1.bmp');

