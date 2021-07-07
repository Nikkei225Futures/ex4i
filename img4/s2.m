%execute previous script before execute this. some vals are inherited
%from previous task
clearvars -except swpl10 swpr10 swpl45 swpr45 swp0;
close all;

%margin between stimlus and rectangle, circle
margin = ones(25, 400);
margin = margin .* 255;
margin = margin .* 0.95;

%make rectangle, circle
rectangle = ones(20, 400);
rectangle = rectangle .* 255;
rectangle = rectangle .* 0.95;
for k = 1:20
    for l = 150:250
        rectangle(k, l) = 0;
    end
end

circle = ones(20, 400);
circle = circle .* 255;
circle = circle .* 0.95;
r = 10;

porHeight = 20;
porWidth = 400;
for k = 1:porHeight
    for l = 1:porWidth
        d = sqrt((l-porWidth/2)^2 + (k-porHeight/2)^2);
        if(d <= r)
            circle(k, l) = 0;
        end
    end
end

%make each stim image
wholeImg10 = [swpl10; margin; rectangle; margin; swpr10];
wholeImg45 = [swpl45; margin; rectangle; margin; swpr45];
fin = [swp0; margin; circle; margin; swp0];

%experiment 
finish = figure;
finish.WindowState = 'maximized';
    colormap(gray(256));
    image(fin);
    axis off;
    axis image;

%{
stim10 = figure;
stim10.WindowState = 'maximized';
    colormap(gray(256));
    image(wholeImg10);
    axis off;
    axis image;
    pause(60);
    close(stim10);
%}
stim45 = figure;
stim45.WindowState = 'maximized';
    colormap(gray(256));
    image(wholeImg45);
    axis off;
    axis image;
    pause(60);
    close(stim45);

%順応後, テスト刺激が左側に引っ張られるような感じがした.
%引っ張られるような感じの度合いは+-10度の方が大きいように感じた.
