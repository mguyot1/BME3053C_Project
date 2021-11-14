clc; clear;

d = uigetdir(pwd, 'Select a folder');
files = dir(fullfile(d, '.*'));
files_d = size(files)

load d;

for n = 1:files_d(1)
 

I = imread('CT_' + string(n));
I = rgb2gray(I);
Iblur = imgaussfilt(I,5);

% Create binary image with lungs segmented
BW = edge(Iblur,'canny');
sec90 = strel('line',6,90);
sec0 = strel('line',6,0);
Idil = imdilate(BW,[sec90 sec0]);
Ifill = imfill(Idil,'holes');
Ibord = imclearborder(Ifill,4);

% Isolate binary image to only the lungs (from Matt's code)
[labeledImage, numberOfBlobs] = bwlabel(Ibord);
blobMeasurements = regionprops(labeledImage, 'area', 'Centroid');
allAreas = [blobMeasurements.Area];
[sortedAreas, sortIndexes] = sort(allAreas, 'descend');
biggestBlob = ismember(labeledImage, sortIndexes(1:2));
Ibord = biggestBlob > 0;


%Display images
subplot(1,3,1)
imshow(I);
Ioutline = bwperim(Ibord);
Segout = I;
Segout(Ioutline) = 0;
subplot(1,3,2)
imshow(Segout);
Icut = I;
Icut(Ibord == 0) = 0;
subplot(1,3,3)
imshow(Icut);

end




