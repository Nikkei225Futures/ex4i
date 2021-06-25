%%%%%�ʎq���r�b�g�ϊ�%%%%%
close all;
clear;

img=imread('kut2.jpg');
red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);

%�O���C�X�P�[���摜�̉��Z
gray=0.3*red+0.59*green+0.11*blue;

%bitshift�֐��ŃV�t�g���ăO���C�X�P�[���摜�̗ʎq���r�b�g����ω�������
gray_shift_4=bitshift(gray,-4);
gray_shift_6=bitshift(gray,-6);
gray_shift_7=bitshift(gray,-7);

%�摜�̒l�͈̔͂��l�����ĉ摜��\��
figure('Name', 'grayscale 8bit');
imshow(gray);

figure('Name', 'grayscale 4bit');
imshow(gray_shift_4,[0 15]);

figure('Name', 'grayscale 2bit');
imshow(gray_shift_6,[0 3]);

figure('Name', 'grayscale 1bit(��l���摜)');
imshow(gray_shift_7,[0 1]);

%imwrite�֐����g����bmp�`���ŕۑ�
imwrite(gray,'kadai2_1.bmp');
imwrite(gray_shift_4*(255/15),'kadai2_2.bmp');
imwrite(gray_shift_6*(255/3),'kadai2_3.bmp');
imwrite(gray_shift_7*255,'kadai2_4.bmp');






