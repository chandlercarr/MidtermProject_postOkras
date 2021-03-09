% Boilerplate
% Clear all screens and figures as well as all variables in the
% workspacesca
sca;
close all;
clear all;
Screen('Preference', 'SkipSyncTests',1);
% Skip some tests in case your initial ScreenTest command failed. Ignore otherwise
% Screen('Preference', 'SkipSyncTests', 1); 
% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);% Get the screen numbers. This gives us a number for each of the screens attached to your computer. The default should be 0.
screens = Screen('Screens');
% Find the maximum screen number - if there are two screens attached to your computer, the one with the higher number will be the external display. We will use the external display here. 
screenNumber = max(screens);
% Define white, black, and grey using the luminance values for the display.
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
KbStrokeWait;
sca;
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
KbStrokeWait;
ifi = Screen('GetFlipInterval', window);
