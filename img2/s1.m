close all;
clear;

img=imread('kut.jpg');
red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);
gray=0.3*red+0.59*green+0.11*blue;
gray2=0.3*red+0.59*green+0.11*blue;

 %インパルス雑音の生成
 [a b]=size(gray);       %画像のサイズの取得
 rd=rand(a,b);
 black=(rd<=0.01);
 white=(rd>=0.99);
 gray(black)=0;
 gray(white)=255;
 
 figure('Name', 'インパルス雑音');
 imshow(gray);
 imwrite(gray,'kadai1_1.bmp');
 
 
 %白色ガウス雑音の生成
 rd2=10*randn(a,b);
 outimg=rd2+double(gray2); %double型からuint8型に変換
 outimg=uint8(outimg);
 
 figure('Name', '白色ガウス');
 imshow(outimg);
 imwrite(outimg,'kadai1_2.bmp');
 
 %インパルス雑音は0か1の極端な値を入れているから白と黒の雑音がはっきり確認できる
 %白色ガウス雑音は
 
 
 
 
 