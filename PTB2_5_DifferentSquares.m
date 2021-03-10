% clear the workspace and the screen

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
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base Rect of 200 by 200 pixels
baseRect = [0 0 200 200];

%%%    NEW/DIF LINES FROM SINGLE RECT/DOT   %%% 

% Screen X positions of our 3 rectangles
squareXpos = [screenXpixels * 0.25 screenXpixels * 0.5 screenXpixels * 0.75];
numSqaures = length(squareXpos);

% Set the colors to Red, Green and Blue % CONFUSED WHAT THIS MEANS! 
allColors = [1 1 0; 0 1 1; 1 0 1];

% NEW LINE FROM MULTIPLE SQUARES % 

sizeChanger = [0.7 1 1.3];

% SAME LINES AS MULTIPLE SQUARES -- WITH ADDED VARIABLE 'sizeChanger(i)' % 

% Make our rectangle coordinates
allRects = nan(4, 3);
for i = 1:numSqaures
    allRects(:, i) = CenterRectOnPointd(baseRect .* sizeChanger(i), squareXpos(i), yCenter);
end

% Draw the rect to the screen
Screen('FillRect', window, allColors, allRects);

% Flip to the screen
Screen('Flip', window);

% Wait for a key press
KbStrokeWait;

% Clear the screen
sca;