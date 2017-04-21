function out = FuzzyLogic(Image1,Image2)


BW_Image1 = ~im2bw(Image1,0.5);
figure;imshow(BW_Image1);
[centers_R, radii_R, metric_R] = imfindcircles(BW_Image1,[5 15]);
centersStrong5_R = centers_R(:,:);
radiiStrong5_R = radii_R(:);
metricStrong5_R = metric_R(:);
viscircles(centersStrong5_R, radiiStrong5_R,'EdgeColor','b');

figure;imshow(Image2);
BW_Image2 = ~im2bw(Image2,graythresh(Image2));
[centers_L, radii_L, metric_L] = imfindcircles(BW_Image2,[5 15]);
centersStrong5_L = centers_L(:,:);
radiiStrong5_L = radii_L(:);
metricStrong5_L = metric_L(:);
viscircles(centersStrong5_L, radiiStrong5_L,'EdgeColor','b');

if(isempty(radii_R) && isempty(radii_L))
    beep;
    pause(1);
    out = 1;
else
    out = 0;
end

