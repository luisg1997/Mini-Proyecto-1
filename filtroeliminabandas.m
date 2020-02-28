function Hd = filtroeliminabandas
%FILTROELIMINABANDAS Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.6 and Signal Processing Toolbox 8.2.
% Generated on: 24-Feb-2020 15:17:45

% Butterworth Bandstop filter designed using FDESIGN.BANDSTOP.

% All frequency values are in Hz.
Fs = 48000;  % Sampling Frequency

Fpass1 = 1;           % First Passband Frequency
Fstop1 = 60;          % First Stopband Frequency
Fstop2 = 61;          % Second Stopband Frequency
Fpass2 = 63;          % Second Passband Frequency
Apass1 = 0.5;         % First Passband Ripple (dB)
Astop  = 60;          % Stopband Attenuation (dB)
Apass2 = 1;           % Second Passband Ripple (dB)
match  = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandstop(Fpass1, Fstop1, Fstop2, Fpass2, Apass1, Astop, ...
                      Apass2, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);

% [EOF]