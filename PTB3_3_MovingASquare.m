%same every time% 
sca;
close all;
clearvars;
Screen('Preference', 'SkipSyncTests',1);

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
ifi = Screen('GetFlipInterval', windowRect);

baseRect = [0 0 200 200];
rectColor = [1 0 1]; 

% NEW PART % 
% square oscilates with sine wave function to left and right of screen 
amplitude = screenXpixels * 0.25;
frequency = 0.2;
angFreq = 2 * pi * frequency;
startPhase = 0;
time = 0;

%sync & get time stamp 
vbl = Screen('Flip', window);
waitframes = 1;

topPriorityLevel = MaxPriorrity(window);
Priority(topPriorityLevel);

%movement loop ~ same as 3_2
while ~KbCheck

    % Position of the square on this frame
    xpos = amplitude * sin(angFreq * time + startPhase);

    % Add this position to the screen center coordinate. This is the point
    % we want our square to oscillate around
    squareXpos = xCenter + xpos;

    % Center the rectangle on the centre of the screen
    centeredRect = CenterRectOnPointd(baseRect, squareXpos, yCenter);

    % Draw the rect to the screen
    Screen('FillRect', window, rectColor, centeredRect);

    % Flip to the screen
    vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Increment the time
    time = time + ifi;

end

sca;


