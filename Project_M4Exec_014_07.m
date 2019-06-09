function Project_M4Exec_014_07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Acts as the executive function for the assignment. It finds all of the descriptive statistics for the taus for each thermocouple. Also calls the regression UDF 
%
% Function Call
% Project_M4Exec_014_07
%
% Input Arguments
% No inputs
%
% Output Arguments
% No outputs
%
% Assignment Information
%   Assignment:       	M4
%   Author:             Dante Sanaei, Cody Martin, Evan Kelch, Jeff Nickels ,dsanaei@purdue.edu,mart1390@purdue.edu, ekelch@purdue.edu, jnickels@purdue.edu
%   Team ID:            0014-07
%   Contributors: N/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ____________________
%% INITIALIZATION

close all
clc
timeHeat = csvread('M3_Data_HeatingTimeHistories.csv');                     %Reads data from the files
timeCool = csvread('M3_Data_CoolingTimeHistories.csv');                     %Reads the cooling data
timeDataH = timeHeat(:,1);                                                  %The heating times(sec)
timeDataC = timeHeat(:,1);                                                  %The cooling times(sec)
[rowsH, columnsH] = size(timeHeat);                                         %Creates a vector of heating rows and columns
[rowsC, columnsC] = size(timeCool);                                         %creates a vector of cooling rows and columns
parametersHeat = zeros(columnsH - 1, 4);                                    %Creates a vector of zeros
parametersCool = zeros(columnsC - 1, 4);                                    %creates another vector of zeros
SSEHEAT = zeros(50,1);                                                      %Initializing SSEHEAT
SSECOOL = zeros(50,1);                                                      %Initializing SSECOOL
%% ____________________
%% CALCULATIONS

% PART 1
% Heating Array Loop
for k = 2:columnsH                                                              %Initializes the for loop from 2 to the number of columns
    [yH, yL, Ts, Tau] = Project_M4Alogrithm_014_07(timeDataH, timeHeat(:, k));  %Determines the yH (deg F) yL (deg F) Ts (sec) and Tau (sec)
    parametersHeat(k - 1, :) = [yH, yL, Ts, Tau];                               %Changes parametersHeat to the previously created vector
    PwHeat = Project_M4PiecewiseCalcHeat_014_07(timeDataH, yH, yL, Ts, Tau);                     %Determines the Peacewise function for heat
    SSEHEAT(k-1, 1) = Project_M4sseCalc_014_07(timeHeat(:, k), PwHeat);                          %Determines the SSEHEAT vector from the sseCalc (degF2)
end
% Cooling Array Loop
for i = 2:columnsC                                                              %Initializes the for loop from 2 to the number of columns for cool
    [yH, yL, Ts, Tau] = Project_M4Alogrithm_014_07(timeDataC, timeCool(:, i));  %Determines the yH (deg F) yL (deg F) Ts (sec) and Tau (sec)
    parametersCool(i - 1, :) = [yH, yL, Ts, Tau];                               %Changes parametersCool to the previously created vector
    PwCool = Project_M4PiecewiseCalcCool_014_07(timeDataC, yH, yL, Ts, Tau);                     %Determines the Peacewise function for cool
    SSECOOL(i-1, 1) = Project_M4sseCalc_014_07(timeCool(:, i), PwCool);                          %Determines the SSECOOL vector from the ssecalc (degF2)
end

% PART 2
meanTau = zeros(1,5);                                                           %Determines the meanTau (sec)
sdTau = zeros(1,5);                                                             %Determines the Tau (sec)
meanSSE = zeros(1,5);                                                           %Determines the meanSSE (degF^2)
for t = [1 10 20 30 40]                                                                 %T goes from o to 40 in increments of 10
    if t == 1
        Taus = [parametersHeat(t:(t+9), 4); parametersCool(t:(t+9), 4)];  
    else
        Taus = [parametersHeat(t+1:(t+10), 4); parametersCool(t+1:(t+10), 4)];  
    end
    SSES = [SSEHEAT(t:(t+10), 1); SSECOOL(t:(t+10), 1)];                        %THe list of SSEs (degF^2)
    meanTau(floor(t/10) + 1) = mean(Taus);                                      %THe mean of tau (sec)
    meanSSE(floor(t/10) + 1) = mean(SSES);                                      %The mean of SSE (degF^2)
    sdTau(floor(t/10) + 1) = std(Taus);                                         %The standard deviation of tau
end

% PART 3
tauList = [parametersHeat(:,4); parametersCool(:,4)]; 
% All heating + all cooling tau values
Project_M4Regression_014_07(tauList);                                           %Calls regression


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.

