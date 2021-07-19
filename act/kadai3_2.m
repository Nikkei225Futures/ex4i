clear;

%csv�t�@�C���̓ǂݍ��݂Ɛ��`
data = csvread('2data1210325.csv',13,3);


%�G���[���N���������s�̏���
data = data.*(data(:,4) == 0);

%�f�[�^�i�[�p�z��̗p��
ave1 = zeros(1,3); %�^�[�Q�b�g����F�ڕW�h�����}��
ave2 = zeros(1,3); %�^�[�Q�b�g�Ȃ��F�ڕW�h�����}��
ave3 = zeros(1,3); %�^�[�Q�b�g����F�ڕW�h�����_�t���̃}��
ave4 = zeros(1,3); %�^�[�Q�b�g�Ȃ��F�ڕW�h�����_�t���̃}��

for k = 1:3
    
    %�e�p�^�[���̃f�[�^�̍��v���i�[����p�̕ϐ�
    sum1 = 0; 
    sum2 = 0;
    sum3 = 0;
    sum4 = 0;
    
    %�e�p�^�[���̃f�[�^�������������J�E���g����p�̕ϐ�
    count1 = 0; 
    count2 = 0;
    count3 = 0;
    count4 = 0;
    
    %���̃��[�v�ł̃Z�b�g�T�C�Y��2^(1+k)�ŋ��߂ĕϐ��Ɋi�[
    setsize = 2^(1+k);
    
    %�e�Z�b�g�T�C�Y�̊e�p�^�[���̍��v�ƃJ�E���g�����Z�o
    for l = 1:240
        
         if ((data(l,1) == 1) && (data(l,2) == 1) && data(l,3) == setsize)
            sum1 = sum1 + data(l,5);
            count1 = count1 + 1;
         
         elseif ((data(l,1) == 2) && (data(l,2) == 1) && data(l,3) == setsize)
            sum2 = sum2 + data(l,5);
            count2 = count2 + 1;
         
             elseif  ((data(l,1) == 1) && (data(l,2) == 2) && data(l,3) == setsize)
            sum3 = sum3 + data(l,5);
            count3 = count3 + 1;
              
              elseif ((data(l,1) == 2) && (data(l,2) == 2) && data(l,3) == setsize)
            sum4 = sum4 + data(l,5);
            count4 = count4 + 1;
              end
    end   
              
    ave1(1,k) = sum1 / count1;
    ave2(1,k) = sum2 / count2;
    ave3(1,k) = sum3 / count3;
    ave4(1,k) = sum4 / count4;
    
end

%�O���t�̃v���b�g
SET = [4 8 16];
figure;
p = plot(SET,ave1,SET,ave2,SET,ave3,SET,ave4);
axis([2 18,600 1300])
xlabel('Set size');
ylabel('Search time[ms]');
legend('�ڕW�h���L��:�ڕW�h������','�ڕW�h������:�ڕW�h������','�ڕW�h���L��:�ڕW�h�����_�t���̊�','�ڕW�h������:�ڕW�h�����_�t���̊�');
p(1).Marker = 'o';
p(1).LineStyle = '-';
p(2).Marker = 'o';
p(2).LineStyle = ':';
p(3).Marker = '^';
p(3).LineStyle = '-';
p(4).Marker = '^';
p(4).LineStyle = ':';



