% Authors: Matthew Nguyen, Michael Guyot, Cameron Manson, Nathan Jones
% Course: BME 3053C Computer Applications for BME
% Term: Fall 2021
% J. Crayton Pruitt Family Department of Biomedical Engineering
% University of Florida

% Code adapted from Image Analyst post on MathWorks Community Blog
% (https://www.mathworks.com/matlabcentral/answers/68696-how-can-i-extract-the-largest-blob-in-a-binary-image)

% Detects two largest regions in image (i.e. finds incidies of lungs) 
function lungBinaryIm = lungBlobDetection(binaryImage)  

[labeledImage, ~] = bwlabel(binaryImage);
blobMeasurements = regionprops(labeledImage, 'area', 'Centroid');
allAreas = [blobMeasurements.Area];
[~, sortIndexes] = sort(allAreas, 'descend');
biggestBlob = ismember(labeledImage, sortIndexes(1:2));
lungBinaryIm = biggestBlob > 0;

end