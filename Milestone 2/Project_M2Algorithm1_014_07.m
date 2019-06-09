function [yH,yL,Ts,Tau] = Project_M2Algorithm1_014_07(type)
% This user defined function takes in a type of data that is wanted and
% returns the max y value, minimum y value, time step value, and the tau

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This user defined function takes in a type of data that is wanted and
% returns the max y value (deg C), minimum y value (deg C), time step
% value(seconds), and the tau (seconds)
%
% Function Call
% [yH, yL, Ts, Tau] = Project_M2Algorithm2_014_07(type)
%
% Input Arguments
% type, this is which data is wanted to analyze
% 1: clean heating
% 2: noise heating
% 3. clean cooling
% 4. noise heating
%
% Output Arguments
% yH: the maximum y value (Deg C)
% yL: the minimum y value (Deg C)
% Ts: Time step value (Seconds)
% Tau: Tau value (Seconds)
%
% Assignment Information
%   Assignment:       	M2
%   Author:             Dante Sanaei, dsanaei@purdue,edu
%   Team ID:            0014-07    
%  	Contributor: 		X
%   My contributor(s) helped me:	
%     [ ] understand the assignment expectations without
%         telling me how they will approach it.
%     [ ] understand different ways to think about a solution
%         without helping me plan my solution.
%     [ ] think through the meaning of a specific error or
%         bug present in my code without looking at my code.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (type == 1)                                                      %If the user wants clean heating
    data = csvread('M2_Data_Calibration_HeatingClean.csv');         %reading heating clean data
elseif(type == 2)                                                   %If the user wants noisy heating
    data = csvread('M2_Data_Calibration_HeatingNoisy.csv');         %reading  heating noisy data
elseif(type == 3)                                                   %If the user wants clean cooling
    data = csvread('M2_Data_Calibration_CoolingClean.csv');         %reading clean cooling data
elseif(type == 4)                                                   %If the user wants noisy cooling
    data = csvread('M2_Data_Calibration_CoolingNoisy.csv');         %Reading noisey cooling data
end
xdata = data(:,1);      % cut the x data into its own vector (seconds)
ydata = data(:,2);      % cut the y data into its own vector (deg C)
Differ = 100;           % initalize difference
smooth = ydata;         % initialize the smooth y vector 
maxDifference = 0;      % initialize the max difference


for j = 1:1000          % runs the smoothening for loop 1000 times to maximise smoothness
for i = 2:length(ydata) - 1     %runs through all of the data and averages the data in order to smooth the data
    smooth(i) = (smooth(i-1) + smooth(i) + smooth(i+1)) / 3;
end
end
yH = max(smooth);       %finds the yH by finding max of smooth data (deg C)
yL = min(smooth);       %finds the yL by finding the min of smooth data (deg C)
for m = 1:length(smooth) - 3        %runs through the entire data set
    average = (smooth(m+1) + smooth(m+2) + smooth(m+3)) / 3;        %finds the average of the smooth y values of the next three values
    difference = abs((average - smooth(m)));                        %finds the difference between this average and the current value
    if difference > maxDifference                                   %this finds the max difference in the entire code
        maxDifference = difference;             
        Ts = xdata(m);                                              %Ts is the step time (seconds)
    end
end

if (type == 1)
yT = yL + .632 * (yH - yL);                     %if it is type 1, use this equation
elseif(type == 2)       
yT = yL + .632 * (yH - yL);                     %if it is type 2, use this equation
elseif(type == 3)
yT = yH + .632 * (yL - yH);                     %if it is type 3, use this equation
elseif(type == 4)
yT = yH + .632 * (yL - yH);                     %if it is type 4, use this equation
end


Laun = 1;       %initlaize laun
k = 1;          %initialize k
for k = Laun:length(ydata)-1            %runs through the data 
    Differ1(k) = (smooth(k) - yT);      %makes an array of the all of the differences between the yT value and the y value
    
end
[M,I] = min(abs(Differ1));              %finds the index of the minimum difference 
D = xdata(I);                           %finds the x value (time) for the found index
Tau = D - 1.5;                          %uses the equation to find Tau (seconds)
    





