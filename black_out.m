function new_image = black_out()

%Replace ** with directory like C:\Users\Michael\
cd **;

%Replace this for which CT images you want CT_2-CT_4
start_number = 2;
end_number = 4;

for i = start_number:end_numbner
    file_name = sprintf('CT_%d.jpg',i);
    figure('Name', file_name)
    image = imread(file_name);
    imshow(image);
    in = input('want to add black box? (1 = yes and 0 = no)');
    while in == 1
        [x1,y1] = ginput(1);
        [x2,y2] = ginput(1);
        image(ceil(y1):ceil(y2),ceil(x1):ceil(x2),:) = 0;
        imshow(image)
        imwrite(image,file_name);
        %continue typing 1 until you have all black boxes needed
        in = input('want to add black box? (1 = yes and 0 = no)');
    end
    

end

