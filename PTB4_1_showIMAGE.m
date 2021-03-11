% Clear the workspace and the screen
sca;
close all;
clearvars;
Screen('Preference', 'SkipSyncTests', 1);
% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Defining colors 
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2; % GREY COMES BACK 
inc = white - grey; % NEW LINE%

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

[screenXpixels, screenYpixels] = Screen('WindowSize', window);

ifi = Screen('GetFlipInterval', window);

[xCenter, yCenter] = RectCenter(windowRect);

%alpha blending%
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%LOAD THE IMAGE FROM ITS LOCATION ~ this is a given file in PTB already% 
theImageLocation = [PsychtoolboxRoot 'PsychDemos' filesep...
    'AlphaImageDemo' filesep 'konijntjes1024x768.jpg'];
theImage = imread(theImageLocation);

% size of the image
[s1, s2, s3] = size(theImage);

%check if image fits screen --> if too big, abort the script --> can
%resize image in later tutorial 
if s1 > screenYpixels || s2 > screenYpixels
    disp('ERROR! Image is too big to fit on the screen');
    sca;
    return;
end

%MAKE THE IMAGE INTO A TEXTURE ~ NEW%
imageTexture = Screen('MakeTexture', window, theImage);

% Draw image to screen (unless otherwise specified PTB will draw
% the texture full size in center of screen) 
%This allows for correct orientation 
Screen('DrawTexture', window, imageTexture, [], [], 0);
Screen('Flip', window);
WaitSecs(2); % wait for 2 seconds 

%fill screen with color 
Screen('FillRect', window, [0 1 0]);
Screen('Flip', window);
WaitSecs(2);

% Draw the image onto the screen a 2nd time (upside down and onto an
% updated blue background)
Screen('DrawTexture', window, imageTexture, [], [], 180);
Screeen('Flip', window);
WaitSecs(2);

sca;

