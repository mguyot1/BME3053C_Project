% Authors: Matthew Nguyen, Michael Guyot, Cameron Manson, Nathan Jones
% Course: BME 3053C Computer Applications for BME
% Term: Fall 2021
% J. Crayton Pruitt Family Department of Biomedical Engineering
% University of Florida

% Note: change 'image_folder" to directory of cropped image
clc; clear;
breakOutLoop = true; % used for terminating script
n = 0;
image_folder = '/Users/mattn/OneDrive - University of Florida/01 BME/BME3053/Group Project/cropped_Images_USE';

% determines total number of images in file
fileNames = dir(fullfile(image_folder,'*jpg'));
total_num_images = numel(fileNames);

while n <= total_num_images && breakOutLoop
    
    clf;
    advSegment = false; % used in scarDetectionAnalysis() for lung boundaries
    keepGoing = true; % used to determine if futher segmentation is needed
    n = n+1; % counter for number of images
    
    %gets image directory from struct
    name = fullfile(image_folder, fileNames(n).name);
    names(n) = {fileNames(n).name};        
        
    while keepGoing
        I = im2gray(im2double(imread(name))); %converts image to grayscale

        %edge detection of lungs
        binaryImage = edgeDetectLung(I);

        %fills in surface area of lungs
        binaryImage = imfill(binaryImage, 'holes');
        binaryImage = imclearborder(binaryImage,4);

        %takes the two largest 'blobs' (aka the lungs)
        lungBinaryIm = lungBlobDetection(binaryImage);

        %masks the pixel index of lungs to original image
        lungIm = I;
        lungIm(lungBinaryIm == 0) = 0;

        %identifies scar tissue
        binary_filt = scarIdentify(lungIm);

        %overlays scar tissue over original image
        imshow(labeloverlay(I,binary_filt))
        
        %Evaluates scar tissue detection effectiveness
        [name, keepGoing, breakOutLoop, advSegment] = scarDetectionAnalysis(I, name, n, keepGoing, breakOutLoop, advSegment);
    end
end

%deletes new Image from folder
delete('new.jpg');