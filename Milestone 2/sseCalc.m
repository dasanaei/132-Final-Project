function [sse] = sseCalc(y, fx)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Calculate modified SSE
%
% Function Call
% [sse] = sseCalc(y, fx)
%
% Input Arguments
% y - raw data points (y values)
% fx - piecewise data points (y values)
%
% Output Arguments
% sse - modified sse calculation
%
% Assignment Information
%   Assignment:       	Project M2
%   Author:             Evan Kelch ekelch@purdue.edu
%   Team ID:            014 - 07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

sse =  0; % initialization

%% ____________________
%% CALCULATIONS

for k = 1:length(y)
    sseStep = (y(k) - fx(k))^2;
    sse = sse + sseStep;
end
sse = sse / length(y);

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

