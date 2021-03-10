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
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black); % screen color
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

% make a base Rect:
    % 1/2 screen Y dimension for the black and white background squares
    % 1/6 screen y dimension for the front grey squares 
%  illustion where the two smaller grey sqaures, although the same luminance appear different shades of grey
% due to being on different backgrounds
backDim = screenYpixels / 2;
baseRectBack = [0 0 backDim backDim];

frontDim = screenYpixels / 6;
baseRectFront = [0 0 frontDim frontDim];

% Position the rectangles
backLeftRect = CenterRectOnPointd(baseRectBack,...
    xCenter - backDim / 2, yCenter);
backRightRect = CenterRectOnPointd(baseRectBack,...
    xCenter + backDim / 2, yCenter);

frontLeftRect = CenterRectOnPointd(baseRectFront,...
    xCenter - backDim / 2, yCenter);
frontRightRect = CenterRectOnPointd(baseRectFront,...
    xCenter + backDim / 2, yCenter);

% Make a marix of all the rect coordinates
allRects = [backLeftRect; backRightRect; frontLeftRect; frontRightRect]';

% We do the same of the colors of the rects. Put them in one matrix for
% drawing
allColors = [white white white; black black black;...
    grey grey grey; grey grey grey]';

% DRAW ALL THE RECTANGLES 
Screen('FillRect', window, allColors, allRects);

% Flip to the screen
Screen('Flip', window);

KbStrokeWait;

sca;

