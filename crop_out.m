function new_image = crop_out()

%Replace ** with directory like C:\Users\Michael\
cd **;

%Replace this for which CT images you want CT_2-CT_4
start_number = 2;
end_number = 4;

for i = start_number:end_numbner
    file_name = sprintf('CT_%d.jpg',i);
    image = imread(file_name);
    figure('Name', file_name)
    imshow(image);
    [x1,y1] = ginput(1);
    [x2,y2] = ginput(1);
    image = image(ceil(y1):ceil(y2),ceil(x1):ceil(x2));
   
    imwrite(image,file_name);

end