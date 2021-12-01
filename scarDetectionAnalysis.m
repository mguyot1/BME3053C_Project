% Authors: Matthew Nguyen, Michael Guyot, Cameron Manson, Nathan Jones
% Course: BME 3053C Computer Applications for BME
% Term: Fall 2021
% J. Crayton Pruitt Family Department of Biomedical Engineering
% University of Florida

%evaluates effectiveness of scar detection based on user input
function [drawnLungIm, keepGoing, breakOutLoop, advSegment] = scarDetectionAnalysis(image, dirName, n, keepGoing, breakOutLoop, advSegment)

check = input('Is the scar tissue properly segmented? Input "yes" or "no" to quit code, press "enter": ', 's');
disp(check)

if isempty(check) % pressing 'enter' will terminate program
    breakOutLoop = false;
    advSegment = false;
    keepGoing = false;
    drawnLungIm = dirName;
end

while strcmpi(check, 'yes') + strcmpi(check, 'no') == 0 && breakOutLoop % unknown input
    check = input('Invalid input; please input "yes" or "no". To quit code, press "enter": ', 's');
    disp(check)
    
    if isempty(check) % pressing 'enter' will terminate program
        breakOutLoop = false;
        keepGoing = false;
        drawnLungIm = dirName;

    end
end

if strcmpi(check,'no') == 1 %input is 'no'
   advSegment = true;
elseif strcmpi(check,'yes') == 1 %input is 'yes'
    keepGoing = false;
    advSegment = false;
    drawnLungIm = dirName;
end

if advSegment %reruns lung segmentation given new restricted edge
    disp('Please outline the perimeter of the LEFT lung')
    imshow(image); h = drawfreehand('color', 'k');
    saveas(figure(n), 'new.jpg'); %save image of new left lung edge

    disp('Please outline the perimeter of the RIGHT lung')
    imshow(imread('new.jpg')); h = drawfreehand('color', 'k');
    saveas(figure(n), 'new.jpg');
    drawnLungIm = 'new.jpg'; %save image of new right lung edge

end

end