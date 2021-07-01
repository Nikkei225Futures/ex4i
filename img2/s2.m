close all;
clear;

img=imread('kadai1_1.bmp');  
img2=imread('kadai1_2.bmp'); 


fil1=[1/9 1/9 1/9;1/9 1/9 1/9;1/9 1/9 1/9]; 
outimg1 = filter2(fil1,img);
outimg2 = filter2(fil1,img2);
outimg1=uint8(outimg1);
outimg2=uint8(outimg2);

 figure('Name', '�������t�B���^x�C���p���X�G��');
 imshow(outimg1);
 imwrite(outimg1,'kadai2_1.bmp');
 
 
 figure('Name', '�������t�B���^x���F�K�E�X�G��');
 imshow(outimg2);
 imwrite(outimg2,'kadai2_2.bmp');
 
 
 outimg3=imread('kadai1_1.bmp');  
 outimg4=imread('kadai1_2.bmp'); 
 out3=outimg3;   
 out4=outimg4;
 
 
 [height width] = size(outimg3); 
 for y =2:height-1
     for x = 2:width-1      
         a = outimg3(y-1:y+1,x-1:x+1);
         b = outimg4(y-1:y+1,x-1:x+1);
         
         A = reshape(a,[1,9]);
         B = reshape(b,[1,9]);
         
         
         out3(y,x) = median(A);
         out4(y,x) = median(B); 
      
     end
 end
 
 %outimg3=uint8(out3);
 %outimg4=uint8(out4);

 figure('Name', '���f�B�A���t�B���^x�C���p���X�G��');
 imshow(out3);
 imwrite(out3,'kadai2_3.bmp');
 
 figure('Name', '���f�B�A���t�B���^x���F�K�E�X�G��');
 imshow(out4);
 imwrite(out4,'kadai2_4.bmp');
 
 %平滑化フィルタ 輪郭が�?っきりしな�?周囲の画�??影響をうける)ためぼ�?���?  %インパルス:
  %白色ガウス雑音:
 %�������t�B���^�͗֊s���͂����肢�Ȃ��B���͂̉�f�̉e�����󂯂邽�߂ڂ₯��
 %���f�B�A���t�B���^: �G���̒l
 
 %メ�?��アンフィルタ
  %インパルス:雑音の値�?,255�?��ら中央値をとるときに雑音が含まれな�?���?��音を除去できる
  %白色ガウス雑音:雑音を加算す�? 