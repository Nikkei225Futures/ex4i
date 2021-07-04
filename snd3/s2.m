clear;

% read file
[soundA,aFs]=audioread('sound1.wav');
[soundI,iFs]=audioread('sound2.wav');

at=[0:length(soundA)-1]/aFs;
it=[0:length(soundI)-1]/iFs;

originalA=soundA(:,1);
originalI=soundI(:,1);

inverseA=(-1).*originalA;    %a反転
inverseI=(-1).*originalI;    %i反転


figure;       %振幅は音の大きさを周波数は音の高さを表す。
%反転したとしても振幅と周波数が変わらないから音に違いはない

plot(at,originalA,at,inverseA);
legend('aの元の波形','反転した波形');
xlabel('Time[s]');
ylabel('Amplitude');
title('aの元の波形と反転させた波形');
axis([0 0.01,-0.04 0.04]);

figure;
plot(it,originalI,it,inverseI);
legend('iの元の波形','反転した波形');
xlabel('Time[s]');
ylabel('Amplitude');
title('iの元の波形と反転させた波形');
axis([0 0.01,-0.04 0.04]);

%sound(X1,Fs1);
%sound(X2,Fs1);
%sound(Y1,Fs2);
%sound(Y2,Fs2);
