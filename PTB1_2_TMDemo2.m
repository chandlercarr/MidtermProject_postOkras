sca
Screen('Preference', 'SkipSyncTests', 1);
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey); 
rect = Screen('Rect', window);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);
ifi = Screen('GetFlipInterval', window);
hertz = FrameRate(window);
nominalHertz = Screen('NominalFrameRate', window);
pixelSize = Screen('PixelSize', window);
[width, height] = Screen('DisplaySize', screenNumber);
maxLum = Screen('ColorRange', window);
KbStrokeWait 