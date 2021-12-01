% Authors: Matthew Nguyen, Michael Guyot, Cameron Manson, Nathan Jones
% Course: BME 3053C Computer Applications for BME
% Term: Fall 2021
% J. Crayton Pruitt Family Department of Biomedical Engineering
% University of Florida

%uses thresholding to identify scar tissue
function binaryFilter = scarIdentify(image)
lungThresh = .4;
scarMinThresh = .3;
scarMaxThresh = .68;

image(image < lungThresh) = 0; %eliminates non-lung tissue
scar_binary = image > scarMinThresh & image < scarMaxThresh; %thresholds only lung tissue
binaryFilter = bwareafilt(scar_binary,[100 10000000]);

end