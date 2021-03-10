% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% NEW LINES % 

% NUMBER OF POLYGON SIDES
numSides = 7;

% Angles at which our polygon vertices endpoints will be. We start at zero
% and then equally space vertex endpoints around the edge of a circle. The
% polygon is then defined by sequentially joining these end points.
anglesDeg = linspace(0, 360, numSides + 1);
anglesRad = anglesDeg * (pi / 180);
radius = 200;

% X and Y coordinates of the points defining out polygon, centred on the
% centre of the screen
yPosVector = sin(anglesRad) .* radius + yCenter;
xPosVector = cos(anglesRad) .* radius + xCenter;

% color 
rectColor = [1 0 0];

% tell PTB that the polygon is a CONVEX POLYGON(concave polygons are much
% more complicated
isConvex = 1;

% Draw the rect to the screen
Screen('FillPoly', window, rectColor, [xPosVector; yPosVector]', isConvex);
 %CHANGE TO 'FramePoly' FOR JUST LINE
 
% Flip to the screen
Screen('Flip', window);

% Wait for a key press
KbStrokeWait;

% Clear the screen
sca;
