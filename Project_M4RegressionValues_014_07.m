function [SSE, SST, coefDetermination] = Project_M4RegressionValues_014_07(xList, yList)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% 
% Takes x and y values from an array to calculate the regression of that
% data set. This function will be able to calculate the regressions of
% multiple x and y array sets by inputting those arrays.
%
% Function Call
% 
% [SSE, SST, coefDetermination] = Project_M4RegressionValues_014_07(xList, yList);
%
% Input Arguments
% 
% [x, y]; Where x is the full set of x values and y is all of the y values
% to be calculated within the regression.
% In the context of this project, x is seconds and y is temperature (deg F)
%
% Output Arguments
% 
% SSE - SSE of data set (deg F^2)
% SST - SST of data set  (deg F^2)
% coefDetermination - r^2 value of data set
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

dataPolyFit = polyfit(xList,yList, 1);                                      % Calculates a and b coefficients for linear regression equation
dataPolyVal = polyval(dataPolyFit, xList);                                  % Calculates y values for x values of model

dataDiff = yList - dataPolyVal;                                             % Calculates difference in model approximations and real data set y values
dataDiffSquared = dataDiff .^ 2;                                            % Squares differences calculated above
SSE = sum(dataDiffSquared);                                                 % Sums differences of squares

yAverage = sum(yList)/length(yList);                                        % Computes average y value in data set
yAverageDiff = yList - yAverage;                                            % Calculates difference of y values from y average
yAverageSquared = yAverageDiff .^ 2;                                        % Squares differents calculated above
SST = sum(yAverageSquared);                                                 % Sums differences of squares (deg F^2)

coefDetermination = 1 - (SSE / SST);                                        % Calculates r^2 value of model

%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I/We have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I/we provided
% access to my/our code to another. The project I/we am/are submitting
% is my/our own original work.

