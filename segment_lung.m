image_folder = 'C:\Users\Michael\Documents\BME3053C\Project\covid-chestxray-dataset-master\images';
fileNames = dir(fullfile(image_folder, '*.jpeg'));
total_num_images = numel(fileNames);

for n = 1: total_num_images
    name = fullfile(image_folder, fileNames(n).name);
    names(n) = {fileNames(n).name}; 
    image = imread(name);
end

grayscale = rgb2gray(image);

threshold_value = 120;

binary_image = grayscale < threshold_value;

imshow(binary_image);

lungs = bwareafilt(binary_image,2);
imshow(lungs)
props = regionprops(binary_image)

