function [y] = PiecewiseCalcCool(t, yh, yl, ts, tau)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Determines piecewise function output for first order function.
%
% Function Call
% [y] = PiecewiseCalcCool(t, yh, yl, ts, tau)
%
% Input Arguments
% t - time vector
% yh - max y value(temp) of first order equation
% yl - min y value(temp) of first order equation
% ts - time step (seconds)
% tau - first order tau (seconds)
%
% Output Arguments
% y - array of y values to match piecewise function
%
% Assignment Information
%   Assignment:       	Project M2 2B
%   Author:             Evan Kelch ekelch@purdue.edu
%   Team ID:            014 - 07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION


%% ____________________
%% CALCULATIONS

for k = 1:length(t) % Plots all time values
    if t(k) < ts % When time is before step...
        y(k) = yl; % y is equal to yL
    else
        y(k) = (yl + (yh - yl)) * (1 - exp(-1 * ((t(k) - ts) / tau))); % Calculate using function
    end 
end


%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS


%% ____________________
%% COMMAND WINDOW OUTPUT

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.

