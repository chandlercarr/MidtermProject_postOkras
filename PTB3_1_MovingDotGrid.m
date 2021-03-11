sca;
close all;
clearvars;
PsychDefaultSetup(2);

Screen('Preference', 'SkipSyncTests',1); % !!!! 
% NEW LINE % 
% RANDOM NUMBER GENERATOR ~ SEED
   % Newer syntax would be rng('shuffle') Look at the help function of rand "help rand" for more information
rand('seed', sum(100 * clock));

%screens
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

%   open window   %
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

%   window size in pixels   %
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

%center pixel % 
[xCenter, yCenter] = RectCenter(windowRect);

% ALPHA BLENDING (anti-aliasing)
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

%  NEW  % 
% Query the FRAME DURATION 
ifi = Screen('GetFlipInterval', window);

% meshgrid command to create base dot coordinates
dim = 10; %dimenstions 
[x, y] = meshgrid(-dim:1:dim, -dim:1:dim);

% SCALE by desired distance in pixels between each dot
pixelScale = screenYpixels / (dim * 2 + 2);
x = x .* pixelScale;
y = y.* pixelScale;

% Calculate NUMBER OF DOTS
numDots = numel(x);

% matrix of positions for the dots --> into two vectors
xPosVector = reshape(x, 1, numDots);
yPosVector = reshape(y, 1, numDots);

% Can define a center for the dot coordinates to be relaitive to. Here
% we set the centre to be the centre of the screen
dotCenter = [screenXpixels / 2 screenYpixels / 2];

% Set the color of our dot to be random
dotColors = rand(3, numDots);

% Set the size of the dots randomly between 10 and 30 pixels
dotSizes = rand(1, numDots) .* 20 + 10;

% Our grid will oscilate with a sine wave function to the left and right
% of the screen. These are the parameters for the sine wave
% See: http://en.wikipedia.org/wiki/Sine_wave
amplitude = screenYpixels * 0.25;
frequency = 0.2;
angFreq = 2 * pi * frequency;
startPhase = 0;
time = 0;

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% Loop the animation until a key is pressed !!!fa
while ~KbCheck

    % Position of the square on this frame
    gridPos = amplitude * sin(angFreq * time + startPhase);

    % DRAW ALL DOTS ON SCREEN --> adding sine oscilation to X coordinates of the dots
    Screen('DrawDots', window, [xPosVector + gridPos; yPosVector],...
        dotSizes, dotColors, dotCenter, 2);

    % Flip to screen
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % time increment
    time = time + ifi;

end
sca;