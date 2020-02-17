   %%Time specifications:
   Fs = 8000;                   % samples per second
   dt = 1/Fs;                   % seconds per sample
   StopTime = 0.5;             % seconds
   t = (0:dt:StopTime-dt)';     % seconds
   %%Sine wave:
   Fc = 60;                     % hertz
   x = 2*cos(2*pi*Fc*t);
   % Plot the signal versus time:
   figure;
   plot(t,x);
   xlabel('time (in seconds)');
   title('Signal versus Time');
   zoom xon;
   zcd = dsp.ZeroCrossingDetector;
   numZeroCross = zcd(x);
   m = mean(abs(x));