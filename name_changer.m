%this function renames the images 
original_foler = 'C:\Users\micha\OneDrive\Documents\BME3503C\Cross Section CT Scans';
new_folder = 'C:\Users\micha\OneDrive\Documents\BME3503C\New_images';

fileNames = dir(fullfile(original_foler ,'*'));
total_num_images = numel(fileNames);

for n = 3:total_num_images
    name = fullfile(original_foler, fileNames(n).name);
    image = imread(name);
    imgName = [new_folder,'\CT_',num2str(n-2),'.jpg'] ;
    imwrite(image, imgName);
end