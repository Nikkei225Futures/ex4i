close all;
clear;

img=imread('kadai1_1.bmp');  
img2=imread('kadai1_2.bmp'); 


fil1=[1/9 1/9 1/9;1/9 1/9 1/9;1/9 1/9 1/9]; 
outimg1 = filter2(fil1,img);
outimg2 = filter2(fil1,img2);
outimg1=uint8(outimg1);
outimg2=uint8(outimg2);

 figure('Name', '平滑化フィルタxインパルス雑音');
 imshow(outimg1);
 imwrite(outimg1,'kadai2_1.bmp');
 
 
 figure('Name', '平滑化フィルタx白色ガウス雑音');
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

 figure('Name', 'メディアンフィルタxインパルス雑音');
 imshow(out3);
 imwrite(out3,'kadai2_3.bmp');
 
 figure('Name', 'メディアンフィルタx白色ガウス雑音');
 imshow(out4);
 imwrite(out4,'kadai2_4.bmp');
 
 %蟷ｳ貊大喧繝輔ぅ繝ｫ繧ｿ 霈ｪ驛ｭ縺後?縺｣縺阪ｊ縺励↑縺?蜻ｨ蝗ｲ縺ｮ逕ｻ邏??蠖ｱ髻ｿ繧偵≧縺代ｋ)縺溘ａ縺ｼ繧?￠繧?  %繧､繝ｳ繝代Ν繧ｹ:
  %逋ｽ濶ｲ繧ｬ繧ｦ繧ｹ髮鷹浹:
 %平滑化フィルタは輪郭がはっきりいない。周囲の画素の影響を受けるためぼやける
 %メディアンフィルタ: 雑音の値
 
 %繝｡繝?ぅ繧｢繝ｳ繝輔ぅ繝ｫ繧ｿ
  %繧､繝ｳ繝代Ν繧ｹ:髮鷹浹縺ｮ蛟､縺?,255縺?°繧我ｸｭ螟ｮ蛟､繧偵→繧九→縺阪↓髮鷹浹縺悟性縺ｾ繧後↑縺?◆繧?尅髻ｳ繧帝勁蜴ｻ縺ｧ縺阪ｋ
  %逋ｽ濶ｲ繧ｬ繧ｦ繧ｹ髮鷹浹:髮鷹浹繧貞刈邂励☆繧? 