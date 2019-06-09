function [] = Project_M2AlgExec_sss_tt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Plots Calibration data to calculated data values in first order system
% scenario.
%
% Function Call
% [] = Project_M2AlgExec_sss_tt
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

%ALGORITHM 1 DATA IMPORT

[yhHC1, ylHC1, tsHC1, tauHC1] = Project_M2Algorithm1_014_07(1); % [Algorithm Data] Heat | Clean
   
[yhHN1, ylHN1, tsHN1, tauHN1] = Project_M2Algorithm1_014_07(2); % [Algorithm Data] Heat | Noise
     
[yhCC1, ylCC1, tsCC1, tauCC1] = Project_M2Algorithm1_014_07(3); % [Algorithm Data] Cool | Clean
  
[yhCN1, ylCN1, tsCN1, tauCN1] = Project_M2Algorithm1_014_07(4); % [Algorithm Data] Cool | Noise 

%ALGORITHM 2 DATA IMPORT

[yhHC2, ylHC2, tsHC2, tauHC2] = Project_M2Algorithm2_014_07(1); % [Algorithm Data] Heat | Clean
   
[yhHN2, ylHN2, tsHN2, tauHN2] = Project_M2Algorithm2_014_07(2); % [Algorithm Data] Heat | Noise
     
[yhCC2, ylCC2, tsCC2, tauCC2] = Project_M2Algorithm2_014_07(3); % [Algorithm Data] Cool | Clean
  
[yhCN2, ylCN2, tsCN2, tauCN2] = Project_M2Algorithm2_014_07(4); % [Algorithm Data] Cool | Noise 

%% ____________________
%% CALCULATIONS

%PIECEWISE FUNCTIONS

% [Heat | Clean | y values]

yHCcal = PiecewiseCalcHeat(tHC, yhHCcal, ylHCcal, tsHCcal, tauHCcal);
yHC1 = PiecewiseCalcHeat(tHC, yhHC1, ylHC1, tsHC1, tauHC1);
yHC2 = PiecewiseCalcHeat(tHC, yhHC2, ylHC2, tsHC2, tauHC2);

% [Heat | Noise | y values]

yHNcal = PiecewiseCalcHeat(tHN, yhHNcal, ylHNcal, tsHNcal, tauHNcal);
yHN1 = PiecewiseCalcHeat(tHN, yhHN1, ylHN1, tsHN1, tauHN1);
yHN2 = PiecewiseCalcHeat(tHN, yhHN2, ylHN2, tsHN2, tauHN2);

% [Cool | Clean | y values]

yCCcal = PiecewiseCalcCool(tCC, yhCCcal, ylCCcal, tsCCcal, tauCCcal);
yCC1 = PiecewiseCalcCool(tCC, yhCC1, ylCC1, tsCC1, tauCC1);
yCC2 = PiecewiseCalcCool(tCC, yhCC2, ylCC2, tsCC2, tauCC2);

% [Cool | Noise | y values]

yCNcal = PiecewiseCalcCool(tCN, yhCNcal, ylCNcal, tsCNcal, tauCNcal);
yCN1 = PiecewiseCalcCool(tCN, yhCN1, ylCN1, tsCN1, tauCN1);
yCN2 = PiecewiseCalcCool(tCN, yhCN2, ylCN2, tsCN2, tauCN2);


%SSE Calculations

%[Calibration Data Set]
sseHCcal = sseCalc(tempHC, yHCcal);
sseHNcal = sseCalc(tempHN, yHNcal);
sseCCcal = sseCalc(tempCC, yCCcal);
sseCNcal = sseCalc(tempCN, yCNcal);

%[Algorithm 1 Data Set]
sseHC1 = sseCalc(tempHC, yHC1);
sseHN1 = sseCalc(tempHN, yHN1);
sseCC1 = sseCalc(tempCC, yCC1);
sseCN1 = sseCalc(tempCN, yCN1);

%[Algorithm 2 Data Set]
sseHC2 = sseCalc(tempHC, yHC2);
sseHN2 = sseCalc(tempHN, yHN2);
sseCC2 = sseCalc(tempCC, yCC2);
sseCN2 = sseCalc(tempCN, yCN2);


%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS

%ALGORITHM 1

figure(1) % Heating plots

subplot(2,1,1) % [Upper] Clean Heating

grid on
hold on
plot(tHC, tempHC, 'r-'); % Plots Raw Data
plot(tHC, yHC1, 'b-'); % Plots Piecewise Data
title('Clean Heating Algorithm 1 Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempHC), max(tempHC)]);
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')

subplot(2,1,2) % [Lower] Noisy Heating

grid on
hold on
plot(tHN, tempHN, 'r-'); % Plots Calibration data
plot(tHN, yHN1, 'b-'); % Plots algorithm data
title('Noisy Heating Algorithm 1 Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempHN), max(tempHN)]);
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')


figure(2) % Cooling plots

subplot(2,1,1) % [Upper] Clean Cooling

grid on
hold on
plot(tCC, tempCC, 'r-'); % Plots Calibration data
plot(tCC, yCC1, 'b-'); % Plots algorithm data
title('Clean Cooling Algorithm 1 Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempCC), max(tempCC)]);
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')

subplot(2,1,2) % [Upper] Noisy Cooling

grid on
hold on
plot(tCN, tempCN, 'r-'); % Plots Calibration data
plot(tCN, yCN1, 'b-'); % Plots algorithm data
title('Noisy Cooling Algorithm 1 Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempCN), max(tempCN)]);
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')

%ALGORITHM 2

figure(3) % Heating plots

subplot(2,1,1) % [Upper] Clean Heating

grid on
hold on
plot(tHC, tempHC, 'r-'); % Plots Raw Data
plot(tHC, yHC2, 'b-'); % Plots Piecewise Data
title('Clean Heating Algorithm 2 Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempHC), max(tempHC)]);
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')

subplot(2,1,2) % [Lower] Noisy Heating

grid on
hold on
plot(tHN, tempHN, 'r-'); % Plots Calibration data
plot(tHN, yHN2, 'b-'); % Plots algorithm data
title('Noisy Heating Algorithm 2 Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempHN), max(tempHN)]);
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')


figure(4) % Cooling plots

subplot(2,1,1) % [Upper] Clean Cooling

grid on
hold on
plot(tCC, tempCC, 'r-'); % Plots Calibration data
plot(tCC, yCC2, 'b-'); % Plots algorithm data
title('Clean Cooling Algorithm 2 Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempCC), max(tempCC)]);
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')

subplot(2,1,2) % [Upper] Noisy Cooling

grid on
hold on
plot(tCN, tempCN, 'r-'); % Plots Calibration data
plot(tCN, yCN2, 'b-'); % Plots algorithm data
title('Noisy Cooling Algorithm 2 Data Comparison')
xlabel('Time Elapsed (sec)')
ylabel('Temperature (°C)')
ylim([min(tempCN), max(tempCN)]);
legend('Raw Data Set', 'Piecewise Approximation', 'Location', 'southeast')

%% ____________________
%% COMMAND WINDOW OUTPUT

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.

