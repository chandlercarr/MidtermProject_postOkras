%SETUP% 
sca;
close all;
clearvars;
PsychDefaultSetup(2); % default settings for Psychtoolbox
screens = Screen('Screens'); % Get the screen numbers
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black); % screen color
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% ALPHA BLENDING % 
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% POSITIONING % 
[xCenter, yCenter] = RectCenter(windowRect); %Center coordinate

baseRect = [0 0 400 400];

%the three rectangles
