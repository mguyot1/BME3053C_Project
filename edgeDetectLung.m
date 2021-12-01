% Authors: Matthew Nguyen, Michael Guyot, Cameron Manson, Nathan Jones
% Course: BME 3053C Computer Applications for BME
% Term: Fall 2021
% J. Crayton Pruitt Family Department of Biomedical Engineering
% University of Florida

% Code adapted from Image Analyst post on MathWorks Community Blog
% (https://www.mathworks.com/matlabcentral/answers/154027-how-can-imfill-an-image-with-a-lot-of-edge#comment_236068)


%Creates binary image of lung then detects edges of lung
function lungEdge = edgeDetectLung(image) 

image = uint8(255 * mat2gray(image));
bwIm = im2bw(image);
lungEdge = xor(bwIm,imerode(bwIm, true(3)));

end