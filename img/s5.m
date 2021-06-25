%%%%%�q�X�g�O����%%%%%
close all;
clear;

gray=imread('kadai2_1.bmp');

%��f�l(0�`255)���Ƃ̉�f���̏W�v

his=zeros(1,256);
for i=0:255
    bin = gray == i;           %��f�l��i�̒l������f�����o��
    vec = sum(bin);          %�s��̗񂲂Ƃ̗v�f�̘a�����s�x�N�g��
    his(i+1) = sum(vec);    %�s�x�N�g���̗v�f�̘a
end

%�q�X�g�O�����̕\��

figure;
bar(his);
axis([0 255 0 8000])
xlabel("Pixel value");
ylabel("Number of picels");
title("Histgram")
