%%%%%�J���[�`���l������%%%%%
close all;
clear;
%�摜�̓ǂݍ���
img=imread('kut2.jpg');
%���ꂼ��̐F�`���l���̔z����쐬
red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);
%���ꂼ��̐F�`���l�����O���C�X�P�[���摜�Ƃ��ĕ\������
figure('Name', 'grayscale(red channel)');
imshow(red);

figure('Name', 'grayscale(green channel)');
imshow(green);

figure('Name', 'grayscale(blue channel)');
imshow(blue);

%�ԃ`���l���Ɛ`���l�������ւ����摜%
img2(:,:,1)=blue;
img2(:,:,2)=green;
img2(:,:,3)=red;

figure('Name', 'r<->b');
imshow(img2);





