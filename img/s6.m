%%%%%�w�i����%%%%%

clear;

img1=imread('back.png');
img2=imread('person.png');

%�O���C�X�P�[���摜�̍쐬
red_img1 = img1(:,:,1);
green_img1 = img1(:,:,2);
blue_img1 = img1(:,:,3);

red_img2 = img2(:,:,1);
green_img2 = img2(:,:,2);
blue_img2 = img2(:,:,3);

gray1 = 0.3*red_img1+0.59*green_img1+0.11*blue_img1;
gray2 = 0.3*red_img2+0.59*green_img2+0.11*blue_img2;

%2�̃O���C�X�P�[���摜��uint8����int16�^�ɕϊ�
gray1_int16 = int16(gray1);
gray2_int16 = int16(gray2);

gray1_int16 = gray1_int16 - gray2_int16;
%���Z���ʂ̐�Βl��uint8�^�ɖ߂�,�摜���o��
diff_uint8 = uint8(abs(gray1_int16));

imshow(diff_uint8);








