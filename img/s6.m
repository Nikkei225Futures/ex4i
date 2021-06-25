%%%%%背景差分%%%%%

clear;

img1=imread('back.png');
img2=imread('person.png');

%グレイスケール画像の作成
red_img1 = img1(:,:,1);
green_img1 = img1(:,:,2);
blue_img1 = img1(:,:,3);

red_img2 = img2(:,:,1);
green_img2 = img2(:,:,2);
blue_img2 = img2(:,:,3);

gray1 = 0.3*red_img1+0.59*green_img1+0.11*blue_img1;
gray2 = 0.3*red_img2+0.59*green_img2+0.11*blue_img2;

%2つのグレイスケール画像をuint8からint16型に変換
gray1_int16 = int16(gray1);
gray2_int16 = int16(gray2);

gray1_int16 = gray1_int16 - gray2_int16;
%減算結果の絶対値をuint8型に戻し,画像を出力
diff_uint8 = uint8(abs(gray1_int16));

imshow(diff_uint8);








