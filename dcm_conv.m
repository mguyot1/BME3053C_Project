imagetype = 'jpg';
filename = 'ID_0000_AGE_0060_CONTRAST_1_CT.dcm';



dcmfile = dicomread(filename);
dcmImagei = uint8(255 * mat2gray(dcmfile));
imwrite(dcmImagei,'HU_dcmImage.jpg', imagetype);


V = niftiread('coronacases_org_001.nii');
imshow(V)
