I = imread('Ct1.jpg'); % arbitary ct scan
    I = im2double(I);
    I = im2gray(I);
    
    %edge detection of lungs
    s = uint8(255 * mat2gray(I));
    s = imbinarize(s);
    binaryImage = xor(s,imerode(s, true(3)));

    %fills in surface area of lungs
    binaryImage = imfill(binaryImage, 'holes');
    lungsMask = imfill(binaryImage, 'holes');
    
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
    scar(scar < .5) = 0;
    
    
    figure(1)
    subplot(1,4,1); imshow(I)
    subplot(1,4,2); imshow(binaryImage)
    subplot(1,4,3); imshow(lungIm)
    subplot(1,4,4); imshow(scar)
    %create scar binary image
    scarbinary = scar > 0.01;
    %find ratio of scar pixels versus total lung volume based on the
    %segmented lungs
    scarbinary(scarbinary == 0) = [];
    binaryImage(binaryImage == 0) = [];
    ScarRatio = 1 - (length(binaryImage) - length(scarbinary))/(length(binaryImage));