global ScreenRect MainWindow

% 初期設定
Screen('Preference','SkipSyncTests');
Screen('Preference', 'ConserveVRAM', 2^24); % bugによるエラー回避のため
KbName('UnifyKeyNames'); % キー配置の設定

% 実験パラメタの入力
subject = '1230394 '; % 被験者番号（学籍番号を入力）
setsizes = [4 8 16]; % 刺激セットサイズ
nSetSizes = length(setsizes); % セットサイズの条件数
pTrials = 12; % 練習試行数
rTrials = 20; % 繰り返し数
xTrials = rTrials*2*2*nSetSizes; % 本実験試行数

% その他の実験パラメタの設定
keys = [KbName('f')  KbName('j')]; % 反応用キー
maxWait = 5; % 反応時間の制限時間
fixationDuration = 0.5; % 注視点の表示時間（秒）

% データ出力用ファイルの設定
formatString = '%s, %d, %d, %d, %d, %d, %d, %d \n';
dataFileName = ['data', subject, '.txt'];
if exist(dataFileName, 'file') == 0
	dataFile = fopen(dataFileName, 'a');
	count = fprintf(dataFile, '%s \n', 'subject, practice/real, trial#, target/nontarget, target type, setsize, error, responsetime');
	%count = fprintf(dataFile, '%s \n', '被験者番号, 練習/本試行, 試行数, ターゲットありなし, ターゲットの種類, 刺激セットサイズ, 誤答, 反応時間');	
	fclose('all');
end

try

ListenChar(2); % プログラム実行中のキー押し反応がコマンドウィンドウやエディタに入力されないようにする
    
% 乱数の種設定（clock関数使用）
rand('state',sum(100*clock));

% 明るさの設定
scrnNum = max(Screen('Screens'));
white = WhiteIndex(scrnNum);
black = BlackIndex(scrnNum);
gray = round((white+black)/2); % whiteが255，blackが0，grayが128

% ウィンドウの提示
windRect = get(scrnNum,'ScreenSize');
xSize = 1800;
ySize = 900;
%[MainWindow, ScreenRect] = Screen('OpenWindow', scrnNum, gray, [(windRect(3)-xSize)/2 (windRect(4)-ySize)/2-8 (windRect(3)+xSize)/2 (windRect(4)+ySize)/2-8]);
[MainWindow, ScreenRect] = Screen('OpenWindow', scrnNum, gray);
hz = FrameRate(MainWindow); % リフレッシュレート

% カーソルを隠す
HideCursor;

% 5 x 5 cells のマトリクスに刺激を提示するための設定
nColumns = 5; 
nRows = 5;
objectSize=40; % 刺激サイズ
objectRect = [0 0 objectSize objectSize]; % 刺激１個の矩形サイズ
stimulusRange = objectSize*2; % 刺激１個の中心座標が取りうる範囲
stimulusRect = [0 0 stimulusRange*nColumns stimulusRange*nRows]; % 刺激全体の提示範囲
fieldRect = CenterRect(stimulusRect, ScreenRect); % 刺激の提示範囲をスクリーンの中央に設定

columns = ((1:nColumns) - .5) * stimulusRange;
rows = ((1:nRows) - .5) * stimulusRange;
[X, Y] = meshgrid(columns, rows); % 各cellの中心座標

jitter = 40; % cellの中心座標からのバラツキ度合い
nPositions = nColumns * nRows; % 位置の数

% オフスクリーンウィンドウの用意
stimulus = Screen('OpenOffscreenWindow', MainWindow, gray, stimulusRect); % 刺激描画領域
%circle = Screen('OpenOffscreenWindow', MainWindow, gray, objectRect); % 円刺激用の領域
%cplusline = Screen('OpenOffscreenWindow', MainWindow, gray, objectRect); % 円プラス線刺激用の領域
fixation = Screen('OpenOffscreenWindow', MainWindow, gray, objectRect); % 十字の注視点の領域
line = Screen('OpenOffscreenWindow', MainWindow, gray, objectRect);
crossline = Screen('OpenOffscreenWindow', MainWindow, gray, objectRect);

% 刺激描画
stroke = 4; % 線の太さ
margin = 4;
ovalRect = [margin margin objectSize-margin objectSize-margin]; % 円の描画範囲
%lineRect_hor= [stroke (objectSize - stroke)/2 objectSize+stroke (objectSize + stroke)/2]; % 線の描画範囲
%lineRect_ver = [(objectSize - stroke)/2 stroke (objectSize + stroke)/2 objectSize+stroke]; % 線の描画範囲

Screen('DrawLine', line, black, 0, objectSize/2, objectSize, objectSize/2); %線の描画
Screen('DrawLine', crossline, black, objectSize/2, 0, objectSize/2, objectSize); %線の描画
Screen('DrawLine', crossline, black, 0, objectSize/2, objectSize, objectSize/2); % 線を追加

% 注視点
hCrossRect = [0 (objectSize - stroke)/2 objectSize (objectSize + stroke)/2];
vCrossRect = [(objectSize - stroke)/2 0 (objectSize + stroke)/2 objectSize];
Screen('FillRect', fixation, black, vCrossRect);
Screen('FillRect', fixation, black, hCrossRect);
fixationRect = CenterRect(objectRect,ScreenRect);

% 教示文の表示
Screen('FillRect', MainWindow, gray); % 画面クリア
Screen('TextSize', MainWindow, 24);

offset = 60;
Screen('DrawText', MainWindow, ['Your task is to detect the presence of the odd target in the distractors.'], ScreenRect(3)/2-offset*6, ScreenRect(4)/2-offset*2);
Screen('DrawText', MainWindow, ['If the target exists,  press ''F'' key with your left hand.'], ScreenRect(3)/2-offset*6, ScreenRect(4)/2-offset);
Screen('DrawText', MainWindow, ['If not,  press ''J'' key with your right hand.'], ScreenRect(3)/2-offset*6,  ScreenRect(4)/2);
Screen('DrawText', MainWindow, ['Please respond as accurately and quickly as possible.'], ScreenRect(3)/2-offset*6, ScreenRect(4)/2+offset);
Screen('DrawText', MainWindow, ['The number of practice trials is: ', num2str(pTrials), '  and the number of experimental trials is: ', num2str(xTrials)], ScreenRect(3)/2-offset*6, ScreenRect(4)/2+offset*2);
Screen('DrawText', MainWindow, ['Press any key'], ScreenRect(3)/2-offset, ScreenRect(4)/2+offset*4);
Screen('Flip', MainWindow);

% キー待ち
FlushEvents('keyDown');
KbWait;
WaitSecs(1);

% 実験開始
for block = 1:2
	if block == 1
		blockMessage = ['Practice'];
		nTrials = pTrials;
	else
		blockMessage = ['Test'];
		nTrials = xTrials;
    end

    Screen(MainWindow,'FillRect',gray); % 画面クリア
    
    % キー押しで開始
    nTrialString = num2str(nTrials);
    message = double([' Press any Key to start   (', blockMessage, '= ', nTrialString, ' ', 'trials)']);
    Screen('DrawText', MainWindow, message, ScreenRect(3)/2-offset*3, ScreenRect(4)/2-10);
    Screen('Flip', MainWindow);
    FlushEvents('keyDown');
    KbWait;
    WaitSecs(0.5);
    
    trialsequence=randperm(nTrials); % 刺激の提示順をシャッフル
	
	for trial = 1:nTrials
		Screen(MainWindow, 'FillRect', gray); % 画面クリア
		Screen(stimulus, 'FillRect', gray); % オフスクリーンクリア

		% 刺激条件の設定
        if block == 1 % 練習試行の場合はランダム
            target = ceil(2*rand); % 1 = ターゲットあり, 2 = ターゲットなし
            whichtarget = ceil(2*rand); % 1 = ターゲットが円, 2 = ターゲットが円プラス線
            setSize = setsizes(ceil(nSetSizes*rand));
        else
            target = rem(trialsequence(trial),2)+1; % 1 = ターゲットあり, 2 = ターゲットなし
            whichtarget = ceil(trialsequence(trial)/(2*nSetSizes*rTrials)); % 1 = ターゲットが円プラス線, 2 = ターゲットが円
            setSize = setsizes( ceil((rem(trialsequence(trial),2*nSetSizes*rTrials)+1)/(2*rTrials)) ); % セットサイズの設定
        end
        positionIndex = randperm(nPositions); % 刺激をランダムに配置
		
		% 刺激を決定
        %circle -> line
        %cplusline -> crossline
		for i = 1:setSize
			if whichtarget == 1 % ターゲットが円
                if target == 1 && i == 1 % ターゲットありの場合
                	item = line;
                else % ディストラクタ
                	item = crossline;
                end
            else % ターゲットが円プラス線
                if target == 1 && i == 1 % ターゲットあり
                	item = crossline;
                else % ディストラクタ
                	item = line;
                end
            end
            % cellの中心からランダムにずらす
			dx = round(ceil(jitter*rand) - jitter/2); %x軸
			dy = round(ceil(jitter*rand) - jitter/2); %y軸
			itemRect = CenterRectOnPoint(objectRect, X(positionIndex(i)) + dx, Y(positionIndex(i)) + dy);
			Screen('DrawTexture', stimulus, item, objectRect, itemRect);
		end
	
		% 注視点提示
		Screen('DrawTexture', MainWindow, fixation, objectRect, fixationRect);
     	Screen('Flip', MainWindow);
        Screen(MainWindow, 'WaitBlanking', ceil(fixationDuration*hz));
        
        
		% 刺激提示
        Screen('DrawTexture', MainWindow, stimulus, stimulusRect, fieldRect);
     	Screen('Flip', MainWindow);
		
		% 反応取得
		initTime = GetSecs; % 時間初期化
		response = []; % 反応初期化
		
		while isempty(response) && (GetSecs - initTime) < maxWait
			[keyIsDown, KbTime, keyCode] = KbCheck; % キー反応取得
			if keyIsDown
				response = find(keyCode); % 押したキーのキーコード取得
				response = response(1);
				responseTime = KbTime; % キー押しした時間
			end
		end
	
		if isempty(response) % キー押ししてなかった場合時間切れとして処理
			err = 3;
			feedback = 'Time out!';
			RT = 0;
        else
			responseKey = find(keys == response); % fまたはjを押したか確認
			RT = round((responseTime - initTime) * 1000); % 反応時間（ミリ秒）
			if isempty(responseKey) % fまたはjではなかった場合
                if response == KbName('ESCAPE') % escキーの場合抜ける                   
                   break;
                end
				err = 2;
				feedback = ['Wrong key! press "F" if YES, press "J" if NO.   '];
			elseif responseKey == target % 正答の場合
				err = 0;
				feedback = double('Correct!  ');
			else % 誤答の場合
				err = 1;
				feedback = double('Wrong!  ');
			end
		end
	
		% 試行ごとにデータ書き込み
		dataFile = fopen(dataFileName, 'a');
		fprintf(dataFile, formatString, subject, block, trial, target, whichtarget, setSize, err, RT);
		fclose(dataFile);
        
        % フィードバック
		Screen(MainWindow,'FillRect', gray);
		feedbacks=double([feedback, ' /   RT = ', num2str(RT), ' ms']);
        Screen('DrawText', MainWindow, feedbacks, ScreenRect(3)/2-130, ScreenRect(4)/2-10);
       	Screen('Flip', MainWindow);
		WaitSecs(1);
		
    end
end

% 終了処理
dataFile = fopen(dataFileName, 'a');
fprintf(dataFile, '\n');
fclose(dataFile);

Screen(MainWindow, 'FillRect', gray);
Screen('DrawText', MainWindow, double('All done! Thank you for participating'), ScreenRect(3)/2-150, ScreenRect(4)/-offset);
Screen('DrawText', MainWindow, double('Press any key'), ScreenRect(3)/2-150, ScreenRect(4)/2-offset+30);
FlushEvents('keyDown');
KbWait;
ListenChar(0);
clear Screen;

catch
    % エラー時にフルスクリーンのウィンドウを閉じる
    ListenChar(0);
    Screen('CloseAll');
    psychrethrow(psychlasterror);
end;
