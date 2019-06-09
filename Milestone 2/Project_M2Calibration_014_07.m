function [] = Project_M2Calibration_014_07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Plots Calibration data to calculated data values in first order system
% scenario.
%
% Function Call
% [] = Project_M2Calibration_014_07
%
% Input Arguments
% no input

% Output Arguments
% no output
%
% Assignment Information
%   Assignment:       	Project M2
%   Author:             Evan Kelch ekelch@purdue.edu
%   Team ID:            014 - 07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

%FILE READS / DATA IMPORT

dataHC = csvread('M2_Data_Calibration_HeatingClean.csv'); % Imports clean heating data set
dataHN = csvread('M2_Data_Calibration_HeatingNoisy.csv'); % Imports noisy cooling data set
dataCC = csvread('M2_Data_Calibration_CoolingClean.csv'); % Imports clean cooling data set
dataCN = csvread('M2_Data_Calibration_CoolingNoisy.csv'); % Imports noisy cooling data set

tHC = dataHC(:,1); % Values of time (clean heating set)
tHN = dataHN(:,1); % Values of time (noisy heating set)
tCC = dataCC(:,1); % Values of time (clean cooling set)
tCN = dataCN(:,1); % Values of time (noisy cooling set)

tempHC = dataHC(:,2); % Values of temp (clean heating set)
tempHN = dataHN(:,2); % Values of temp (noisy heating set)
tempCC = dataCC(:,2); % Values of temp (clean cooling set)
tempCN = dataCN(:,2); % Values of temp (noisy cooling set)

%CALIBRATION DATA

ylHCcal = 0.00;        % [Calibration Data] Heat | Clean
yhHCcal = 100.00;     
tsHCcal = 1.50;       
tauHCcal = 0.31;      

ylHNcal = -0.64;       % [Calibration Data] Heat | Noise
yhHNcal = 99.36;       
tsHNcal = 1.50;        
tauHNcal = 1.65;       

ylCCcal = 100.00;      % [Calibration Data] Cool | Clean
yhCCcal = 0.94;        
tsCCcal = 1.50;       
tauCCcal = 1.82;      

ylCNcal = 98.81;       % [Calibration Data] Cool | Noise 
yhCNcal = -0.21;       
tsCNcal = 1.50;        
tauCNcal = 1.12;       

%% ____________________
%% CALCULATIONS

%PIECEWISE FUNCTIONS

% [Heat | Clean]

yHCcal = PiecewiseCalcHeat(tHC, yhHCcal, ylHCcal, tsHCcal, tauHCcal);

% [Heat | Noise]

yHNcal = PiecewiseCalcHeat(tHN, yhHNcal, ylHNcal, tsHNcal, tauHNcal);

% [Cool | Clean]

yCCcal = PiecewiseCalcCool(tCC, ylCCcal, yhCCcal, tsCCcal, tauCCcal);

% [Cool | Noise]

yCNcal = PiecewiseCalcCool(tCN, ylCNcal, yhCNcal, tsCNcal, tauCNcal);

%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS
figure(1) % Heating plots

subplot(2,1,1) % [Upper] Clean Heating

grid on
disp(tempHC)
plot(tHC, tempHC, 'r-'); % Plots Raw Data
hold on
plot(tHC, yHCcal, 'b-'); % Plots Piecewise Data
title('Clean Heating Calibration Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempHC), max(tempHC)]); % Sets range to data values 
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')

subplot(2,1,2) % [Lower] Noisy Heating

grid on
hold on
plot(tHN, tempHN, 'r-'); % Plots Calibration data
plot(tHN, yHNcal, 'b-'); % Plots algorithm data
title('Noisy Heating Calibration Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempHN), max(tempHN)]); % Sets range to data values 
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')


figure(2) % Cooling plots

subplot(2,1,1) % [Upper] Clean Cooling

grid on
hold on
plot(tCC, tempCC, 'r-'); % Plots Calibration data
plot(tCC, yCCcal, 'b-'); % Plots algorithm data
title('Clean Cooling Calibration Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempCC), max(tempCC)]); % Sets range to data values 
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')

subplot(2,1,2) % [Upper] Noisy Cooling

grid on
hold on
plot(tCN, tempCN, 'r-'); % Plots Calibration data
plot(tCN, yCNcal, 'b-'); % Plots algorithm data
title('Noisy Cooling Calibration Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempCN), max(tempCN)]); % Sets range to data values 
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')

%% ____________________
%% COMMAND WINDOW OUTPUT

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.

