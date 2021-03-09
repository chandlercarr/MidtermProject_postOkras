sca;
close all;
clearvars;
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
ifi = Screen('GetFlipInterval', window);
topPriorityLevel = MaxPriority(window);
numSecs = 1;
numFrames = round(numSecs / ifi);
waitframes = 1;
vbl = Screen('Flip', window);
Priority(topPriorityLevel);
vbl = Screen('Flip', window);
for frame = 1:numFrames

    % Color the screen blue
    Screen('FillRect', window, [0 0 0.5]);

    % Tell PTB no more drawing commands will be issued until the next flip
    Screen('DrawingFinished', window);

    % One would do some additional stuff here to make the use of
    % "DrawingFinished" meaningful / useful

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

end
Priority(0);
