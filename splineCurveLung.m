% Authors: Matthew Nguyen, Michael Guyot, Cameron Manson, Nathan Jones
% Course: BME 3053C Computer Applications for BME
% Term: Fall 2021
% J. Crayton Pruitt Family Department of Biomedical Engineering
% University of Florida

% Code adapted from Image Analyst post on MathWorks Community Blog
%(https://www.mathworks.com/matlabcentral/answers/751334-how-can-i-save-roi-parameters-from-drawfreehand-and-load-it-onto-another-image)

%Spline curves ROI points and connects them
function [smoothedXCoordinates,smoothedYCoordinates] = splineCurveLung(xCoordinates,yCoordinates)
    samplingRateIncrease = 10;
    numberOfKnots = length(xCoordinates);
    
    newXSamplePoints = linspace(1, numberOfKnots, numberOfKnots * samplingRateIncrease);
    % smoothedY = spline(xCoordinates, yCoordinates, newXSamplePoints);
    % Make the 2D array where the top row is the x coordinates and the bottom row is the y coordinates,
    % but with the exception that the left column and right column is a vector that gives the direction of the slope.
    yy = [0, xCoordinates', 0; 1, yCoordinates', 1];
    pp = spline(1:numberOfKnots, yy); % Get interpolant
    smoothedY = ppval(pp, newXSamplePoints); % Get smoothed y values in the "gaps".
    % smoothedY is a 2D array with the x coordinates in the top row and the y coordinates in the bottom row.
    smoothedXCoordinates = smoothedY(1, :);
    smoothedYCoordinates = smoothedY(2, :);

end

