%%%%%”wŒi·•ª%%%%%
close all;
clear;

back=imread('back.jpg');
forward=imread('forward.jpg');

%make gray imgs
redBack = back(:,:,1);
greenBack = back(:,:,2);
blueBack = back(:,:,3);

redForward = forward(:,:,1);
greenForward = forward(:,:,2);
blueForward = forward(:,:,3);

grayBack = 0.3*redBack+0.59*greenBack+0.11*blueBack;
grayForward = 0.3*redForward+0.59*greenForward+0.11*blueForward;

%uint8 -> double, take diff
backDouble = cast(grayBack, 'double');
forwardDouble = cast(grayForward, 'double');
difDouble = backDouble - forwardDouble;

%abs(diffed double) -> uint8
diff_uint8 = uint8(abs(difDouble));

imshow(diff_uint8);








