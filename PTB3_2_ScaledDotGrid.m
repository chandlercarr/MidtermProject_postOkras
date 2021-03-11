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

%   open window   %
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

%   window size in pixels   %
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

%center pixel % 
[xCenter, yCenter] = RectCenter(windowRect);
% ALPHA BLENDING (anti-aliasing)
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

% FRAME DURATION 
ifi = Screen('GetFlipInterval', window);

%meshgrid comand 
dim = 10;
[x, y] = meshgrid(-dim:1:dim, -dim:1:dim);

%scale dist between dots 
pixelScale = screenYpixels / (dim * 2 + 2);
x = x .* pixelScale;
y = y.* pixelScale;

numDots=numel (x); % number of dots 

%convert position matrix to vectors
xPosVector = reshape(x, 1, numDots);
yPosVector = reshape(y, 1, numDots);

%dot @ screen center 
dotCenter = [screenXpixels / 2 screenYpixels / 2];

% dot COLOR ~ random in this case
dotColors = rand(3, numDots);

% max dot SIZE 
maxDotSize = 25;

%  grid will PULSE by taking the absolute value of a sine wave, we
    % set the AMPLITUDE of the sine wave = 1 --> will be a multiplicative scale factor ranging between 0 and 1.
        % With 0 the dots will all be on top of one another. With 1 the gird will have its maximum size.
% parameters for the sine wave See: http://en.wikipedia.org/wiki/Sine_wave
amplitude = 1;
frequency = 0.05;
angFreq = 2 * pi * frequency;
startPhase = 0;
time = 0;

%time stamp 
vbl = Screen('Flip', window);
waitframes = 1;

%priority level = max ~ pretty sure you dont have to include this but
%that it takes longer if you dont? 
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% WHILE LOOP for the pulsing 
% Loop the animation until a key is pressed
while ~KbCheck

    % Scale the grid coordinates
    scaleFactor = abs(amplitude * sin(angFreq * time + startPhase));

    % Scale the dot size. Here we limit the minimum dot size to one pixel
    % by using the max function as PTB won't allow the dot size to scale to
    % zero (sensibly, as you'd be drawing no dots at all)
    thisDotSize = max(1, maxDotSize .* scaleFactor);

    % Draw all of our dots to the screen in a single line of code adding
    % the sine oscilation to the X coordinates of the dots
    Screen('DrawDots', window, [xPosVector; yPosVector] .* scaleFactor,...
        thisDotSize, dotColors, dotCenter, 2);

    % Flip to screen
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.7 5) * ifi);

    % time Increment
    time = time + ifi;

end

sca;
