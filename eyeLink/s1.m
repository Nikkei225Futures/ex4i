
clear;
close all;

N=20;  %試行回数(全20回)

keyData=csvread('exp4i_g04_08.csv');   %選択結果のデータの読み込み
judgeData = zeros(500, N+1);
judgeData(:,1) = [-998:2:0];


for count=1:N       %試行回数t(20回)の処理
    trialData=csvread(['g04_08.asc_TRIAL_' num2str(count) '.csv']); %各試行のデータの読み込み
    [height,width]=size(trialData);   %data2のサイズを取得
    
    sp=[trialData(1,1):2:trialData(height,1)]'; %data2の時間飛びがない正しい時間配列(2ms間隔)で作成
    [sp_height, sp_width] = size(sp);
    expos = zeros(sp_width, 5);
    expos(:,1) = sp(count) - sp(sp_height);
    
    expos(:,2:4)=-1;              %exposの全行の2から4列(画面状態,視線方向,選択結果と視線方向の合致)に-1を設定
    
    %データがある場合には欠損値-1が上書きされて,データがなければ-1のままになる
    
    logic=ismember(sp,trialData(:,1));
    %試行データの時間(data2の1列目)に対して全時間を探索するismemberを使用
    %ismember(A,B)はAを元にしてBの値がAにある場合に1,ない場合は0を返す論理配列を作成
    
    expos(logic,2)=trialData(:,3);
    %exposの2列目に(画面情報)を代入.引数のok(論理配列)をexposnの2列目に適用して,1のところに代入
    %0のところは代入されず欠損値-1のまま
    
    expos(logic,5)=trialData(:,4);
    %exposの5列目に(視線のx座標)を代入.引数のok(論理配列)をexposnの5列目に適用して,1のところに代入
    %0のところは代入されず欠損値0のまま
    
    centerJudge = find(expos(:,2) == 1);
    center = expos(centerJudge, 5);
    center_mean = mean(center);
    
    left = expos(:,5) < center_mean;
    right = expos(:,5) >= center_mean;
    expos(left,3) = 100;
    expos(right,3) = 102;
    
    correct = expos(:,3) == keyData(count,2);
    expos(correct, 4) = 1;
    error = expos(:,3) ~= keyData(count, 2) & expos(:,2) ~= -1;
    expos(error, 4) = 0;
    judgeData(:, count+1) = expos(sp_height-499:sp_height,4);
    
    result_data = zeros(1,500);
    
    
    for n = 1:500
        ok = ~ismember(judgeData(n,2:21),-1);
        count = 0; %足したデータを数えるため䛾変数
        for k = 1:N
            if ok(1,k) ==1
                result_data(1,n) =result_data(1,n) + judgeData(n,k+1);
                count = count+1;
            end
        end
        result_data(1, n) = result_data(1,n) / count;
    end
  
end

t = [-0.998: 0.002: 0];
plot(t, result_data);
axis([-1 0 0 1]);
xlabel('Time[s]');
ylabel('Ratio of reaction');

%反応率が50%より上だと、判断する前に選択した方をよく見ていた(カスケード現象が生じていた)
%カスケード現象: 選択する前に無意識的にその方向を向く
%今回の実験では, 選択の1秒前からのデータを分析した
%1秒前から反応率が50パーセントを超えていて, カスケード現象が明確に確認できる.