clc; clear;

image_folder = 'C:\Users\Michael\Documents\BME3053C\Project\New_images';
fileNames = dir(fullfile(image_folder,'*'));
total_num_images = numel(fileNames);


for n = 3:total_num_images-20
 
name = fullfile(image_folder, fileNames(n).name);
names(n) = {fileNames(n).name};                      
I = imread(name);
  
   I = im2double(I);
    I = im2gray(I);
    
    %edge detection of lungs
    s = uint8(255 * mat2gray(I));
    s = im2bw(s);
    binaryImage = xor(s,imerode(s, true(3)));

    %fills in surface area of lungs
    binaryImage = imfill(binaryImage, 'holes');
    lungsMask = imfill(binaryImage, 'holes');
    lungsMask = imclearborder(lungsMask,8);
    
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
    scar_binary = scar > 0.3;
    binary_filt = bwareafilt(scar_binary,[100 10000000]);
    
    
%      [L,N] = superpixels(scar,500);
%         BW = boundarymask(L);
       
        
          figure('Name', names{n})
%         subplot(1,5,1); imshow(I)
%         subplot(1,5,2); imshow(binaryImage)
%         subplot(1,5,3); imshow(lungIm)
%         subplot(1,5,4); imshow(scar)
% %         subplot(1,5,5); 
%         imshow(imshow(imoverlay(scar,BW,'cyan'),'InitialMagnification',60))
imshow(imoverlay(I,binary_filt,'red'));
    
  
 
    %super pixels?!?!?!??!?!?!
    %look into super pixels to help identify scar tissue




end


