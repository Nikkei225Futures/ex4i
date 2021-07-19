global ScreenRect MainWindow

% �����ݒ�
Screen('Preference','SkipSyncTests');
Screen('Preference', 'ConserveVRAM', 2^24); % bug�ɂ��G���[����̂���
KbName('UnifyKeyNames'); % �L�[�z�u�̐ݒ�

% �����p�����^�̓���
subject = '1230373'; % �팱�Ҕԍ��i�w�Дԍ�����́j
setsizes = [4 8 16]; % �h���Z�b�g�T�C�Y
nSetSizes = length(setsizes); % �Z�b�g�T�C�Y�̏�����
pTrials = 10; % ���K���s��
rTrials = 10; % �J��Ԃ���
xTrials = rTrials*2*2*nSetSizes; % �{�������s��

% ���̑��̎����p�����^�̐ݒ�
keys = [KbName('f')  KbName('j')]; % �����p�L�[
maxWait = 5; % �������Ԃ̐�������
fixationDuration = 0.5; % �����_�̕\�����ԁi�b�j

% �f�[�^�o�͗p�t�@�C���̐ݒ�
formatString = '%s, %d, %d, %d, %d, %d, %d, %d \n';
dataFileName = ['data', subject, '.txt'];
if exist(dataFileName, 'file') == 0
	dataFile = fopen(dataFileName, 'a');
	count = fprintf(dataFile, '%s \n', 'subject, practice/real, trial#, target/nontarget, target type, setsize, error, responsetime');
	%count = fprintf(dataFile, '%s \n', '�팱�Ҕԍ�, ���K/�{���s, ���s��, �^�[�Q�b�g����Ȃ�, �^�[�Q�b�g�̎��, �h���Z�b�g�T�C�Y, �듚, ��������');	
	fclose('all');
end

try

ListenChar(2); % �v���O�������s���̃L�[�����������R�}���h�E�B���h�E��G�f�B�^�ɓ��͂���Ȃ��悤�ɂ���
    
% �����̎�ݒ�iclock�֐��g�p�j
rand('state',sum(100*clock));

% ���邳�̐ݒ�
scrnNum = max(Screen('Screens'));
white = WhiteIndex(scrnNum);
black = BlackIndex(scrnNum);
gray = round((white+black)/2); % white��255�Cblack��0�Cgray��128

% �E�B���h�E�̒�
windRect = get(scrnNum,'ScreenSize');
xSize = 1800;
ySize = 900;
%[MainWindow, ScreenRect] = Screen('OpenWindow', scrnNum, gray, [(windRect(3)-xSize)/2 (windRect(4)-ySize)/2-8 (windRect(3)+xSize)/2 (windRect(4)+ySize)/2-8]);
[MainWindow, ScreenRect] = Screen('OpenWindow', scrnNum, gray);
hz = FrameRate(MainWindow); % ���t���b�V�����[�g

% �J�[�\�����B��
HideCursor;

% 5 x 5 cells �̃}�g���N�X�Ɏh����񎦂��邽�߂̐ݒ�
nColumns = 5; 
nRows = 5;
objectSize=40; % �h���T�C�Y
objectRect = [0 0 objectSize objectSize]; % �h���P�̋�`�T�C�Y
stimulusRange = objectSize*2; % �h���P�̒��S���W����肤��͈�
stimulusRect = [0 0 stimulusRange*nColumns stimulusRange*nRows]; % �h���S�̂̒񎦔͈�
fieldRect = CenterRect(stimulusRect, ScreenRect); % �h���̒񎦔͈͂��X�N���[���̒����ɐݒ�

columns = ((1:nColumns) - .5) * stimulusRange;
rows = ((1:nRows) - .5) * stimulusRange;
[X, Y] = meshgrid(columns, rows); % �ecell�̒��S���W

jitter = 40; % cell�̒��S���W����̃o���c�L�x����
nPositions = nColumns * nRows; % �ʒu�̐�

% �I�t�X�N���[���E�B���h�E�̗p��
stimulus = Screen('OpenOffscreenWindow', MainWindow, gray, stimulusRect); % �h���`��̈�
circle = Screen('OpenOffscreenWindow', MainWindow, gray, objectRect); % �~�h���p�̗̈�
cplusline = Screen('OpenOffscreenWindow', MainWindow, gray, objectRect); % �~�v���X���h���p�̗̈�
fixation = Screen('OpenOffscreenWindow', MainWindow, gray, objectRect); % �\���̒����_�̗̈�

% �h���`��
stroke = 4; % ���̑���
margin = 4;
ovalRect = [margin margin objectSize-margin objectSize-margin]; % �~�̕`��͈�
lineRect = [(objectSize-stroke)/2 objectSize-margin*2-stroke (objectSize+stroke)/2 objectSize]; % ���̕`��͈�

Screen('FrameOval', circle, black, ovalRect, stroke); % �~��`��
Screen('FrameOval', cplusline, black, ovalRect, stroke); % �~��`��
Screen('FillRect', cplusline, black, lineRect); % ����ǉ�

% �����_
hCrossRect = [0 (objectSize - stroke)/2 objectSize (objectSize + stroke)/2];
vCrossRect = [(objectSize - stroke)/2 0 (objectSize + stroke)/2 objectSize];
Screen('FillRect', fixation, black, vCrossRect);
Screen('FillRect', fixation, black, hCrossRect);
fixationRect = CenterRect(objectRect,ScreenRect);

% �������̕\��
Screen('FillRect', MainWindow, gray); % ��ʃN���A
Screen('TextSize', MainWindow, 24);

offset = 60;
Screen('DrawText', MainWindow, ['Your task is to detect the presence of the odd target in the distractors.'], ScreenRect(3)/2-offset*6, ScreenRect(4)/2-offset*2);
Screen('DrawText', MainWindow, ['If the target exists,  press ''F'' key with your left hand.'], ScreenRect(3)/2-offset*6, ScreenRect(4)/2-offset);
Screen('DrawText', MainWindow, ['If not,  press ''J'' key with your right hand.'], ScreenRect(3)/2-offset*6,  ScreenRect(4)/2);
Screen('DrawText', MainWindow, ['Please respond as accurately and quickly as possible.'], ScreenRect(3)/2-offset*6, ScreenRect(4)/2+offset);
Screen('DrawText', MainWindow, ['The number of practice trials is: ', num2str(pTrials), '  and the number of experimental trials is: ', num2str(xTrials)], ScreenRect(3)/2-offset*6, ScreenRect(4)/2+offset*2);
Screen('DrawText', MainWindow, ['Press any key'], ScreenRect(3)/2-offset, ScreenRect(4)/2+offset*4);
Screen('Flip', MainWindow);

% �L�[�҂�
FlushEvents('keyDown');
KbWait;
WaitSecs(1);

% �����J�n
for block = 1:2
	if block == 1
		blockMessage = ['Practice'];
		nTrials = pTrials;
	else
		blockMessage = ['Test'];
		nTrials = xTrials;
    end

    Screen(MainWindow,'FillRect',gray); % ��ʃN���A
    
    % �L�[�����ŊJ�n
    nTrialString = num2str(nTrials);
    message = double([' Press any Key to start   (', blockMessage, '= ', nTrialString, ' ', 'trials)']);
    Screen('DrawText', MainWindow, message, ScreenRect(3)/2-offset*3, ScreenRect(4)/2-10);
    Screen('Flip', MainWindow);
    FlushEvents('keyDown');
    KbWait;
    WaitSecs(0.5);
    
    trialsequence=randperm(nTrials); % �h���̒񎦏����V���b�t��
	
	for trial = 1:nTrials
		Screen(MainWindow, 'FillRect', gray); % ��ʃN���A
		Screen(stimulus, 'FillRect', gray); % �I�t�X�N���[���N���A

		% �h�������̐ݒ�
        if block == 1 % ���K���s�̏ꍇ�̓����_��
            target = ceil(2*rand); % 1 = �^�[�Q�b�g����, 2 = �^�[�Q�b�g�Ȃ�
            whichtarget = ceil(2*rand); % 1 = �^�[�Q�b�g���~, 2 = �^�[�Q�b�g���~�v���X��
            setSize = setsizes(ceil(nSetSizes*rand));
        else
            target = rem(trialsequence(trial),2)+1; % 1 = �^�[�Q�b�g����, 2 = �^�[�Q�b�g�Ȃ�
            whichtarget = ceil(trialsequence(trial)/(2*nSetSizes*rTrials)); % 1 = �^�[�Q�b�g���~�v���X��, 2 = �^�[�Q�b�g���~
            setSize = setsizes( ceil((rem(trialsequence(trial),2*nSetSizes*rTrials)+1)/(2*rTrials)) ); % �Z�b�g�T�C�Y�̐ݒ�
        end
        positionIndex = randperm(nPositions); % �h���������_���ɔz�u
		
		% �h��������
		for i = 1:setSize
			if whichtarget == 1 % �^�[�Q�b�g���~
                if target == 1 && i == 1 % �^�[�Q�b�g����̏ꍇ
                	item = circle;
                else % �f�B�X�g���N�^
                	item = cplusline;
                end
            else % �^�[�Q�b�g���~�v���X��
                if target == 1 && i == 1 % �^�[�Q�b�g����
                	item = cplusline;
                else % �f�B�X�g���N�^
                	item = circle;
                end
            end
            % cell�̒��S���烉���_���ɂ��炷
			dx = round(ceil(jitter*rand) - jitter/2); %x��
			dy = round(ceil(jitter*rand) - jitter/2); %y��
			itemRect = CenterRectOnPoint(objectRect, X(positionIndex(i)) + dx, Y(positionIndex(i)) + dy);
			Screen('DrawTexture', stimulus, item, objectRect, itemRect);
		end
	
		% �����_��
		Screen('DrawTexture', MainWindow, fixation, objectRect, fixationRect);
     	Screen('Flip', MainWindow);
        Screen(MainWindow, 'WaitBlanking', ceil(fixationDuration*hz));
        
        
		% �h����
        Screen('DrawTexture', MainWindow, stimulus, stimulusRect, fieldRect);
     	Screen('Flip', MainWindow);
		
		% �����擾
		initTime = GetSecs; % ���ԏ�����
		response = []; % ����������
		
		while isempty(response) && (GetSecs - initTime) < maxWait
			[keyIsDown, KbTime, keyCode] = KbCheck; % �L�[�����擾
			if keyIsDown
				response = find(keyCode); % �������L�[�̃L�[�R�[�h�擾
				response = response(1);
				responseTime = KbTime; % �L�[������������
			end
		end
	
		if isempty(response) % �L�[�������ĂȂ������ꍇ���Ԑ؂�Ƃ��ď���
			err = 3;
			feedback = 'Time out!';
			RT = 0;
        else
			responseKey = find(keys == response); % f�܂���j�����������m�F
			RT = round((responseTime - initTime) * 1000); % �������ԁi�~���b�j
			if isempty(responseKey) % f�܂���j�ł͂Ȃ������ꍇ
                if response == KbName('ESCAPE') % esc�L�[�̏ꍇ������                   
                   break;
                end
				err = 2;
				feedback = ['Wrong key! press "F" if YES, press "J" if NO.   '];
			elseif responseKey == target % �����̏ꍇ
				err = 0;
				feedback = double('Correct!  ');
			else % �듚�̏ꍇ
				err = 1;
				feedback = double('Wrong!  ');
			end
		end
	
		% ���s���ƂɃf�[�^��������
		dataFile = fopen(dataFileName, 'a');
		fprintf(dataFile, formatString, subject, block, trial, target, whichtarget, setSize, err, RT);
		fclose(dataFile);
        
        % �t�B�[�h�o�b�N
		Screen(MainWindow,'FillRect', gray);
		feedbacks=double([feedback, ' /   RT = ', num2str(RT), ' ms']);
        Screen('DrawText', MainWindow, feedbacks, ScreenRect(3)/2-130, ScreenRect(4)/2-10);
       	Screen('Flip', MainWindow);
		WaitSecs(1);
		
    end
end

% �I������
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
    % �G���[���Ƀt���X�N���[���̃E�B���h�E�����
    ListenChar(0);
    Screen('CloseAll');
    psychrethrow(psychlasterror);
end;
