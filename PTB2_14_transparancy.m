%SETUP% 
sca;
close all;
clearvars;

Screen('Preference', 'SkipSyncTests',1); % MAKE SURE TO ADD THIS LINE IF THERE IS A PROBLEM!!!

PsychDefaultSetup(2); % default settings for Psychtoolbox
screens = Screen('Screens'); % Get the screen numbers
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white); % screen color
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% ALPHA BLENDING % 
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% POSITIONING % 
[xCenter, yCenter] = RectCenter(windowRect); %Center coordinate

baseRect = [0 0 400 400];

%the three rectangles
squareXpos = [xCenter - 200 xCenter + 200 xCenter];
squareYpos = [yCenter yCenter yCenter + 200];
numSqaures = length(squareXpos);

% Set the colors to Red, Green and Blue, with the fourth value being the
% "alpha" value. This also takes a value between 0 and 1 just like a
% normal colour, however now 0 = totally transparent and 1 = totally
% opaque. Our RGB triplets are now RGBA values.
allColors = [1 0 0 1; 0 1 0 1; 0 0 1 0.5]';

% Make our rectangle coordinates
allRects = nan(4, 3);
for i = 1:numSqaures
    allRects(:, i) = CenterRectOnPointd(baseRect,...
        squareXpos(i), squareYpos(i));
end

% Draw the rect to the screen
Screen('FillRect', window, allColors, allRects);

squareXpos = [xCenter - 200 xCenter + 200 xCenter];
squareYpos = [yCenter yCenter yCenter + 200];
numSqaures = length(squareXpos);

% Set the colors to Red, Green and Blue, with the fourth value being the
% "alpha" value. This also takes a value between 0 and 1 just like a
% normal colour, however now 0 = totally transparent and 1 = totally
% opaque. Our RGB triplets are now RGBA values.
allColors = [1 0 0 1; 0 1 0 1; 0 0 1 0.5]';

% Make our rectangle coordinates
allRects = nan(4, 3);
for i = 1:numSqaures
    allRects(:, i) = CenterRectOnPointd(baseRect,...
        squareXpos(i), squareYpos(i));
end

% Draw rect on screen
Screen('FillRect', window, allColors, allRects);
%flip to screen 
Screen('Flip', window);

KbStrokeWait;

sca;