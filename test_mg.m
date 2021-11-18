clc; clear;

%Input your image folder directory C:\Users\Michael\...
image_folder = 'C:\Users\Michael\Documents\BME3053C\Project\cropped_images';
fileNames = dir(fullfile(image_folder,'*'));
total_num_images = numel(fileNames);


for n = 3:total_num_images-20
 
    name = fullfile(image_folder, fileNames(n).name);
    names(n) = {fileNames(n).name};                      
    I = imread(name);
    I = im2double(I);
    I_g = im2gray(I);
    I = im2gray(I);
    
    
    %edge detection of lungs
    s = uint8(255 * mat2gray(I));
    s = im2bw(s);
    binaryImage = xor(s,imerode(s, true(3)));

    %fills in surface area of lungs
    binaryImage = imfill(binaryImage, 'holes');
    lungsMask = imfill(binaryImage, 'holes');
    lungsMask = imclearborder(lungsMask,4);
    
    %takes the two largest 'blobs' (aka the lungs)
    [labeledImage, numberOfBlobs] = bwlabel(binaryImage);
    blobMeasurements = regionprops(labeledImage, 'area', 'Centroid');
    allAreas = [blobMeasurements.Area];
    [sortedAreas, sortIndexes] = sort(allAreas, 'descend');
    biggestBlob = ismember(labeledImage, sortIndexes(1:2));
    binaryImage = biggestBlob > 0;
    
    %masks the pixel index of lungs to original image
    lungIm = I;
    lungIm(binaryImage == 0) = 0;
    
    %identifies scar tissue
    scar = lungIm;
    scar(scar < .40) = 0;
    scar_binary = scar > 0.3 & scar < 0.57;
    binary_filt = bwareafilt(scar_binary,[100 10000000]);
    
    %Display output
    figure('Name', names{n})
    subplot(1,3,1); imshow(I)
    %subplot(1,5,2); imshow(binaryImage)
    subplot(1,3,2); imshow(lungIm)
    %subplot(1,5,4); imshow(scar)
    %imshow(imshow(imoverlay(scar,BW,'cyan'),'InitialMagnification',60))
    subplot(1,3,3); imshow(labeloverlay(I,binary_filt));
    
  end


