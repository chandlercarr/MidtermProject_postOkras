%SETUP% 
sca;
close all;
clearvars;
PsychDefaultSetup(2); % default settings for Psychtoolbox
screens = Screen('Screens'); % Get the screen numbers
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

%Open/setup windows 
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black); % screen color
[screenXpixels, screenYpixels] = Screen('WindowSize', window);% screen pixels (size)
[xCenter, yCenter] = RectCenter(windowRect); %center pixel
baseRect = [0 0 200 200]; %  base Rect (200x200 pixels)

% Center left hand side squares positions on screen
leftBackRect = CenterRectOnPointd(baseRect, screenXpixels * 0.25, yCenter);
leftForwardRect = CenterRectOnPointd(baseRect,...
    screenXpixels * 0.25 + 100, yCenter + 100);

%  right hand side squares positions
%but not concatonate these
% into a single matrix. This is bacause we will be drawing these both in a
% single line of code. For more details use Screen DrawRect?
rightBackRect = CenterRectOnPointd(baseRect,...
    screenXpixels * 0.75, yCenter);
rightForwardRect = CenterRectOnPointd(baseRect,...
    screenXpixels * 0.75 + 100, yCenter + 100);
rightRects = [rightBackRect; rightForwardRect]';

% We do the same of the colors of the rects. Put them in one matrix for
% drawing
rightRectColors = [1 0 0; 0 1 0]';

% Draw the left hand side squares onto the screen, we do this sequentially
% with two lines of code, one for each rectangle.
Screen('FillRect', window, [1 0 0], leftBackRect);
Screen('FillRect', window, [0 1 0], leftForwardRect);

% Now we draw the two right hand side squares to the screen. We get the
% same results as if we draw in two seperate lines, however we efficiently
% draw both squares in a single line of code. Note, that as detailed above,
% we acheive the same ordering of squares by placing the coordinates of the
% square we want to draw first into the matrix first.
Screen('FillRect', window, rightRectColors, rightRects);

% Flip to the screen. This command basically draws all of our previous
% commands onto the screen. See later demos in the animation section on more
% timing details. And how to demos in this section on how to draw multiple
% rects at once.
Screen('Flip', window);

KbStrokeWait;
sca;