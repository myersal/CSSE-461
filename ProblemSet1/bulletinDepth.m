format compact

'please click on the bottom corner of the bulletin board in the following images'

% reading in each image
left = imread('left.ppm');
mid = imread('mid.ppm');
right = imread('right.ppm');

% color doesn't matter, but want the height and width of image
[leftHeight, leftWidth, color] = size(left);
[midHeight, midWidth, color] = size(mid);
[rightHeight, rightWidth, color] = size(right);

distBetween = 1;

% Field of view in each direction
fieldView = 33.25 / 2;

% show each image and ask user to click on specified object
imshow(left);
leftLock = ginput(1);

'paused'
pause

imshow(mid);
midLock = ginput(1);

'paused'
pause

imshow(right);
rightLock = ginput(1);


% Knowing that mortise lock is left side of the mid image and right we can calculate
% usindg the following equations

pixelFromCenterMid = (midWidth / 2) - midLock(1)
pixelFromCenterRight = (rightWidth / 2) - rightLock(1)

% add 90 to left angle and subtract from right (left is obtuse)
degreeFromCenterMid = ((pixelFromCenterMid / (midWidth / 2)) * fieldView) + 90
degreeFromCenterRight = 90 - (pixelFromCenterRight / (rightWidth / 2)) * fieldView
lastAngle = 180 - degreeFromCenterMid - degreeFromCenterRight

% Find the left side of triangle usinds ASA geometry.
% a/sind A = b/sind B
leftSideLength = (distBetween / sind(lastAngle)) * sind(degreeFromCenterRight)

if (leftSideLength < 0)
   leftSideLength = abs(leftSideLength)
end

% Now to find the Z distance from the x-axis

alpha2 = 180 - degreeFromCenterMid
alpha3 = 90;
alpha4 = 180 - alpha3 - alpha2;

zDist = (leftSideLength / sind(alpha3)) * sind(alpha2)
