function [sse] = Project_M4sseCalc_014_07(y, fx)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Calculate modified SSE
%
% Function Call
% [sse] = Project_M4sseCalc_014_07(y, fx)
%
% Input Arguments
% y - raw data points (y values) (deg F)
% fx - piecewise data points (y values) (deg F)
%
% Output Arguments
% sse - modified sse calculation (def F^2)
%
% Assignment Information
%   Assignment:       	M4
%   Author:             Dante Sanaei, Cody Martin, Evan Kelch, Jeff Nickels ,dsanaei@purdue.edu,mart1390@purdue.edu, ekelch@purdue.edu, jnickels@purdue.edu
%   Team ID:            0014-07
%   Contributors: N/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

sse =  0; % initialization of the SSE

%% ____________________
%% CALCULATIONS

for k = 1:length(y)
    sseStep = (y(k) - fx(k))^2;     %Finds the SSE step (deg F^2)
    sse = sse + sseStep;            %finds the SSE (deg F^2)
end
sse = sse / length(y);              %finds the SSE mod (deg F^2)

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

