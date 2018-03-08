format compact

'please click on the picture frame in the following images'

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


% Knowing that picture Frasme right side of the mid image and right we can calculate
% usindg the following equations

pixelFromCenterMid = abs((midWidth / 2) - midLock(1))
pixelFromCenterRight = abs((rightWidth / 2) - rightLock(1))

% add 90 to right angle and subtract from left (right is obtuse)
degreeFromCenterMid = 90 -((pixelFromCenterMid / (midWidth / 2)) * fieldView)
degreeFromCenterRight = 90 + ((pixelFromCenterRight / (rightWidth / 2)) * fieldView)
lastAngle = 180 - degreeFromCenterMid - degreeFromCenterRight

% Find the left side of triangle usinds ASA geometry.
% a/sind A = b/sind B
rightSideLength = (distBetween / sind(lastAngle)) * sind(degreeFromCenterMid)

if (rightSideLength < 0)
   rightSideLength = abs(rightSideLength)
end

% Now to find the Z distance from the x-axis

alpha2 = 180 - degreeFromCenterRight
alpha3 = 90;
alpha4 = 180 - alpha3 - alpha2;

zDist = (rightSideLength / sind(alpha3)) * sind(alpha2)
