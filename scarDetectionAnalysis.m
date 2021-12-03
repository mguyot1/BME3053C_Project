% Authors: Matthew Nguyen, Michael Guyot, Cameron Manson, Nathan Jones
% Course: BME 3053C Computer Applications for BME
% Term: Fall 2021
% J. Crayton Pruitt Family Department of Biomedical Engineering
% University of Florida

%evaluates effectiveness of scar detection based on user input
function [drawnLungIm, keepGoing, breakOutLoop, advSegment] = scarDetectionAnalysis(image, dirName, n, keepGoing, breakOutLoop, advSegment)
load('var.mat')
% check = input('Is the scar tissue properly segmented? Input "yes" or "no" to quit code, press "enter": ', 's');
% disp(check)

if strcmpi(check, 'del') % pressing 'exit' will terminate program
    breakOutLoop = false;
    advSegment = false;
    keepGoing = false;
    drawnLungIm = dirName;
end

if strcmpi(check,'no') == 1 %input is 'no'
   advSegment = true;
elseif strcmpi(check,'yes') == 1 %input is 'yes'
    keepGoing = false;
    advSegment = false;
    drawnLungIm = dirName;
end

if advSegment %reruns lung segmentation given new restricted edge
    waitfor(advSegGUI)
    load('var.mat');
    
    %obtains (x,y) coordinates of spline curves for left and right lung
    [xLeftSmooth, yLeftSmooth] = splineCurveLung(xLeft, yLeft);
    [xRightSmooth, yRightSmooth] = splineCurveLung(xRight, yRight);
    
    figure(n);
    imshow(I);
    hold on;
    plot(xLeftSmooth, yLeftSmooth, 'k', xRightSmooth, yRightSmooth, 'k')
    
    saveas(figure(n), 'new.jpg') %saves figure to 'new.jpg'
    drawnLungIm = 'new.jpg';
    
end

save('var.mat', '-append');
end