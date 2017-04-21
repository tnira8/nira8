clc;
clear all;
close all;
mkdir('Images');
obj = videoinput('winvideo',2);
start(obj);
for i = 1:500

   Input = getsnapshot(obj);
   imwrite(Input,['Images\' num2str(i) '.jpg']);
end
stop(vid);