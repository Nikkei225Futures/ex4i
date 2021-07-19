clear;

%csvファイルの読み込みと整形
data = csvread('2data1210325.csv',13,3);


%エラーを起こした試行の除去
data = data.*(data(:,4) == 0);

%データ格納用配列の用意
ave1 = zeros(1,3); %ターゲットあり：目標刺激がマル
ave2 = zeros(1,3); %ターゲットなし：目標刺激がマル
ave3 = zeros(1,3); %ターゲットあり：目標刺激が棒付きのマル
ave4 = zeros(1,3); %ターゲットなし：目標刺激が棒付きのマル

for k = 1:3
    
    %各パターンのデータの合計を格納する用の変数
    sum1 = 0; 
    sum2 = 0;
    sum3 = 0;
    sum4 = 0;
    
    %各パターンのデータが何個あったかカウントする用の変数
    count1 = 0; 
    count2 = 0;
    count3 = 0;
    count4 = 0;
    
    %そのループでのセットサイズを2^(1+k)で求めて変数に格納
    setsize = 2^(1+k);
    
    %各セットサイズの各パターンの合計とカウント数を算出
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

%グラフのプロット
SET = [4 8 16];
figure;
p = plot(SET,ave1,SET,ave2,SET,ave3,SET,ave4);
axis([2 18,600 1300])
xlabel('Set size');
ylabel('Search time[ms]');
legend('目標刺激有り:目標刺激が丸','目標刺激無し:目標刺激が丸','目標刺激有り:目標刺激が棒付きの丸','目標刺激無し:目標刺激が棒付きの丸');
p(1).Marker = 'o';
p(1).LineStyle = '-';
p(2).Marker = 'o';
p(2).LineStyle = ':';
p(3).Marker = '^';
p(3).LineStyle = '-';
p(4).Marker = '^';
p(4).LineStyle = ':';



