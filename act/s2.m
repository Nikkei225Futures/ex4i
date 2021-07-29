close all;
clear all;
N=240;
setsize=[4,8,16];
data=readmatrix('data1230373-s3.txt');

target1_16=0;
count1_16=0;
target1_8=0;
count1_8=0;
target1_4=0;
count1_4=0;
for i=13:252
    if(data(i,7)==0)
        if(data(i,4)==1)
            if(data(i,5)==1)
                if(data(i,6)==16)
                    target1_16=target1_16+data(i,8);
                    count1_16=count1_16+1;
                else if(data(i,6)==8)
                        target1_8=target1_8+data(i,8);
                        count1_8=count1_8+1;
                    else if(data(i,6)==4)
                            target1_4=target1_4+data(i,8);
                            count1_4=count1_4+1;
                            
                        end
                    end
                end
            end
        end
    end
end

X=target1_16/count1_16;
Y=target1_8/count1_8;
Z=target1_4/count1_4;

target1=[X Y Z];


%target2
target2_16=0;
count2_16=0;
target2_8=0;
count2_8=0;
target2_4=0;
count2_4=0;
for i=13:252
    if(data(i,7)==0)
        if(data(i,4)==1)
            if(data(i,5)==2)
                if(data(i,6)==16)
                    target2_16=target2_16+data(i,8);
                    count2_16=count2_16+1;
                else if(data(i,6)==8)
                        target2_8=target2_8+data(i,8);
                        count2_8=count2_8+1;
                    else if(data(i,6)==4)
                            target2_4=target2_4+data(i,8);
                            count2_4=count2_4+1;
                            
                        end
                    end
                end
            end
        end
    end
end

X2=target2_16/count2_16;
Y2=target2_8/count2_8;
Z2=target2_4/count2_4;

target2=[X2 Y2 Z2];

%target3
target3_16=0;
count3_16=0;
target3_8=0;
count3_8=0;
target3_4=0;
count3_4=0;
for i=13:252
    if(data(i,7)==0)
        if(data(i,4)==2)
            if(data(i,5)==1)
                if(data(i,6)==16)
                    target3_16=target3_16+data(i,8);
                    count3_16=count3_16+1;
                else if(data(i,6)==8)
                        target3_8=target3_8+data(i,8);
                        count3_8=count3_8+1;
                    else if(data(i,6)==4)
                            target3_4=target3_4+data(i,8);
                            count3_4=count3_4+1;
                            
                        end
                    end
                end
            end
        end
    end
end

X3=target3_16/count3_16;
Y3=target3_8/count3_8;
Z3=target3_4/count3_4;

target3=[X3 Y3 Z3];

%target4
target4_16=0;
count4_16=0;
target4_8=0;
count4_8=0;
target4_4=0;
count4_4=0;
for i=13:252
    if(data(i,7)==0)
        if(data(i,4)==2)
            if(data(i,5)==2)
                if(data(i,6)==16)
                    target4_16=target4_16+data(i,8);
                    count4_16=count4_16+1;
                else if(data(i,6)==8)
                        target4_8=target4_8+data(i,8);
                        count4_8=count4_8+1;
                    else if(data(i,6)==4)
                            target4_4=target4_4+data(i,8);
                            count4_4=count4_4+1;
                            
                        end
                    end
                end
            end
        end
    end
end

X4=target4_16/count4_16;
Y4=target4_8/count4_8;
Z4=target4_4/count4_4;

target4=[X4 Y4 Z4];

%inverse
target1 = flip(target1);
target2 = flip(target2);
target3 = flip(target3);
target4 = flip(target4);


plot(setsize,target1,'-o',setsize,target2,'--o',setsize,target3,'-^',setsize,target4,'--^');
axis([0 20 500 2000]);
legend('目標刺激：丸（目標刺激あり)','目標刺激；丸＋棒（目標刺激あり)','目標刺激；丸（目標刺激なし)','目標刺激；丸＋棒（目標刺激なし)');
xlabel('setsize');
ylabel('response time[ms]');