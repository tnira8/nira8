clc;
clear all;
close all;
warning off;

% obj = videoinput('winvideo',2);
% start(obj);
Input_path = dir('C:\Users\Nira Thava\Desktop\LOGITECH USE\New_Code\Logitec Images\Close');

for i = 3:length(Input_path)

%    Input = getsnapshot(obj);
  Input = imread(['C:\Users\Nira Thava\Desktop\LOGITECH USE\New_Code\Logitec Images\Close\' filesep Input_path(i).name]);
  
   if(size(Input,3) == 3)
           GrayImage = rgb2gray(Input); 
   else
           GrayImage = Input;
   end
   
%  Face Detcetion %  
 faceDetector = vision.CascadeObjectDetector;
 BB  = step(faceDetector,GrayImage);
 if(isempty(BB))
     msgbox('Face is not detected');
     break;
 else
 FaceImage = imcrop(GrayImage,BB(1,:));
 
 RGB = insertObjectAnnotation(Input, 'rectangle', BB(1,:), 'Face','Color','blue');
 figure;imshow(RGB);
 
%  EYE DETECTION %%
 EyePair = vision.CascadeObjectDetector('EyePairBig');
 BB_Pair = step(EyePair,FaceImage);
     if(isempty(BB_Pair))
         msgbox('Eye is not detected');
         break;
     end
  BB_Pair(1,1) = BB(1,1)+BB_Pair(1,1);
  BB_Pair(1,2) = BB(1,2)+BB_Pair(1,2);
 EyePair_Image = imcrop(GrayImage,BB_Pair(1,:));
 RGB = insertObjectAnnotation(Input, 'rectangle', BB_Pair(1,:), 'Eye Pair','Color','green');
 figure;imshow(RGB);
 
%% Left Eye
LeftEye_Image  = EyePair_Image(:,1:round(BB_Pair(1,3)/2));
%% Right Eye
RightEye_Image = EyePair_Image(:,round(BB_Pair(1,3)/2):end);
 
 Nose_Detect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);
 BB_N = step(Nose_Detect,FaceImage);
 if(isempty(BB_N))
     msgbox('Nose is not detected');
     break;
 end
 BB_N(1,1) = BB_N(1,1)+ BB(1,1);
 BB_N(1,2) = BB_N(1,2)+ BB(1,2);
 
 Nose_Image = imcrop(GrayImage,BB_N(1,:)); 
 
 RGB = insertObjectAnnotation(Input, 'rectangle', BB_N(1,:), 'Nose','Color','magenta');
 figure;imshow(RGB);
 
 %%Mouth Detection
 
 Mouth_Detect = vision.CascadeObjectDetector('Mouth','MergeThreshold',16);
 BB_M = step(Mouth_Detect,FaceImage);
 if(isempty(BB_M))
     msgbox('Mouth is not detected');
     break;
 end
    for l = 1:size(BB_M,1)
            BB_M(l,1) = BB_M(l,1)+BB(1,1);
            BB_M(l,2) = BB_M(l,2)+BB(1,2);

        if(BB_M(l,2)>BB_N(1,2))
            BB_Mouth = BB_M(l,:);
        end
    end
 Mouth_Image = imcrop(GrayImage,BB_Mouth); 
 RGB = insertObjectAnnotation(Input, 'rectangle', BB_Mouth, 'Mouth','Color','white');
 figure;imshow(RGB);
 
 out = FuzzyLogic(RightEye_Image,LeftEye_Image);
 
 if(out == 1)
     msgbox('The driver is drowsy');
 else
     msgbox('The driver is not drowsy');
 end
%  pause(5);
end
close all;
end
% stop(obj);