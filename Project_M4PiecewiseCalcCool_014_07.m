function [y] = Project_M4PiecewiseCalcCool_014_07(t, yh, yl, ts, tau)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Determines piecewise function output for first order function. COOLING
%
% Function Call
% [y] =  Project_M4PiecewiseCalcCool_014_07(t, yh, yl, ts, tau)
%
% Input Arguments
% t - time vector (sec)
% yh - max y value(temp) of first order equation
% yl - min y value(temp) of first order equation
% ts - time step (seconds)
% tau - first order tau (seconds)
%
% Output Arguments
% y - array of y values to match piecewise function (deg F)
%
% Assignment Information
%   Assignment:       	M4
%   Author:             Dante Sanaei, Cody Martin, Evan Kelch, Jeff Nickels ,dsanaei@purdue.edu,mart1390@purdue.edu, ekelch@purdue.edu, jnickels@purdue.edu
%   Team ID:            0014-07
%   Contributors: N/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION


%% ____________________
%% CALCULATIONS

for k = 1:length(t)                                                         % Plots all time values
    if t(k) < ts                                                            % When time is before step...
        y(k) = yh;                                                          % y is equal to yL
    else
        y(k) = yl + (yh - yl) * (exp(-1 * (t(k) - ts) / tau));              % Calculate using function
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

