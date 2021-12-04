% Authors: Matthew Nguyen, Michael Guyot, Cameron Manson, Nathan Jones
% Course: BME 3053C Computer Applications for BME
% Term: Fall 2021
% J. Crayton Pruitt Family Department of Biomedical Engineering
% University of Florida

%Removes a n pixel thick border from the segmented lungs
function lungIm = reduceBorder(lungIm, n)
lungIm1 = lungIm;
w = length(lungIm(1,:));
h = length(lungIm(:,1));
for ii = n+1:h-n
    for jj = n+1:w-n
        if lungIm1((ii + n),(jj + n)) == 0
            lungIm(ii,jj) = 0;
        elseif lungIm1((ii - n),(jj + n)) == 0
            lungIm(ii,jj) = 0;
        elseif lungIm1((ii + n),(jj - n)) == 0
            lungIm(ii,jj) = 0;
        elseif lungIm1((ii - n),(jj - n)) == 0
            lungIm(ii,jj) = 0;
        elseif lungIm1((ii),(jj + n)) == 0
            lungIm(ii,jj) = 0;
        elseif lungIm1((ii),(jj - n)) == 0
            lungIm(ii,jj) = 0;
        elseif lungIm1((ii + n),(jj)) == 0
            lungIm(ii,jj) = 0;
        elseif lungIm1((ii - n),(jj)) == 0
            lungIm(ii,jj) = 0;
        end
    end
end