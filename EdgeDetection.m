clc; clear;

% Upload image and convert it to grey scale
file = input('Enter image name: ');
I = imread(file);
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

for ii = 1:

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



