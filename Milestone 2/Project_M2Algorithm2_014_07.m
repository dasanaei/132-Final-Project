function [yH, yL, Ts, Tau] = Project_M2Algorithm2_014_07(type)
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
xdata = data(:,1);      %Cutting the x values (seconds)
ydata = data(:,2);      %Cutting the Y values (deg C)
smooth = ydata;         %Initalize Y Values
maxSlope = 0;           %Initalize max slope
endLoop = 1;            %Initalize end loop
add = 1;                %Initalize add variabel

for j = 1:1000      %run smooth function 1000 times for maximum smoothening
for i = 2:length(ydata) - 1     %Runs through the y values and smooths them out with averages
    smooth(i) = (smooth(i-1) + smooth(i) + smooth(i+1)) / 3;
end
end

for m = 1:length(smooth) - 10       %runs through all the values minus 10
    slope = abs((smooth(m+10) - smooth(m)) / (xdata(m+10) - xdata(m)));         %finds the slope of the index value and the value 10 spaces ahead.
    if slope > maxSlope             %This part finds the maximum slope through the entire data set
        maxSlope = slope;           %This is the max slope of the entire data set
        t = m;                      %This is the index of the maximum slope
    end
end



if (type == 1)      %If the user wants clean heating
    Ts = xdata(t);  %This is teh Ts Value
    FlatLine = ydata(1:t);  %This is the values of the flat line in the beggining of the data
    yL = mean(FlatLine);    %This is the average of these values, setting it equal to yL (deg C)
    yH = mean(ydata(length(ydata) - 10:end));       %This mean of the last 10 values is the yH. (deg C)
    yT = yL + .632 * (yH - yL);                     %This equation finds yT (deg C)
    while (endLoop == 1)                            %This while loop will continue to run until there is one index that falls in the interval that corresponds to the calculated yT value. 
        index = find(ydata >= yT - add & ydata <= yT + add);
        if (length(index) == 1)  %Ends loop if there is 1 index
            endLoop = 0;
        elseif(isempty(index))  %If the index is empty then add 1 to the interval window.
            add = add + 1;
        else
            add = add - .01;    %if there are more than one index then subtract .01 from the window
        end
    end
   xTau = xdata(index);     %find the xTau with the found index (seconds)
   Tau = xTau - Ts;         %calculate tau with this equation (seconds)
elseif(type == 2)           %If the user wants noise heating
    Ts = xdata(t);  %This is teh Ts Value
    FlatLine = ydata(1:t);  %This is the values of the flat line in the beggining of the data
    yL = mean(FlatLine);    %This is the average of these values, setting it equal to yL (deg C)
    yH = mean(ydata(length(ydata) - 10:end));       %This mean of the last 10 values is the yH. (deg C)
    yT = yL + .632 * (yH - yL);                     %This equation finds yT (deg C)
    while (endLoop == 1)                            %This while loop will continue to run until there is one index that falls in the interval that corresponds to the calculated yT value. 
        index = find(ydata >= yT - add & ydata <= yT + add);
        if (length(index) < 2)  %Ends loop if there is 1 index
            endLoop = 0;
        elseif(isempty(index))  %If the index is empty then add 1 to the interval window.
            add = add + 1;
        else
            add = add - .01;    %if there are more than one index then subtract .01 from the window
        end
    end
   xTau = xdata(index);%find the xTau with the found index (seconds)
   Tau = xTau - Ts;          %calculate tau with this equation  (seconds)  
elseif(type == 3)       %If the user wants clean cooling
    Ts = xdata(t);  %This is teh Ts Value
    FlatLine = ydata(1:t);  %This is the values of the flat line in the beggining of the data
    yH = mean(FlatLine);    %This is the average of these values, setting it equal to yL (deg C)
    yL = mean(ydata(length(ydata) - 10:end));       %This mean of the last 10 values is the yH. (deg C)
    yT = yH + .632 * (yL - yH);                     %This equation finds yT (deg C)
    while (endLoop == 1)                            %This while loop will continue to run until there is one index that falls in the interval that corresponds to the calculated yT value. 
        index = find(ydata >= yT - add & ydata <= yT + add);
        if (length(index) < 2)  %Ends loop if there is 1 index 
            endLoop = 0;
        elseif(isempty(index))  %If the index is empty then add 1 to the interval window.
            add = add + 1;
        else
            add = add - .01;    %if there are more than one index then subtract .01 from the window
        end
    end
   xTau = xdata(index);%find the xTau with the found index (seconds)
   Tau = xTau - Ts;           %calculate tau with this equation   (seconds)
elseif(type == 4)            %If the user wants noisy cooling
    Ts = xdata(t);      %This is teh Ts Value
    FlatLine = ydata(1:t);  %This is the values of the flat line in the beggining of the data
    yH = mean(FlatLine);    %This is the average of these values, setting it equal to yL (deg C)
    yL = mean(ydata(length(ydata) - 10:end));       %This mean of the last 10 values is the yH. (deg C)
    yT = yH + .632 * (yL - yH);                     %This equation finds yT (deg C)
    while (endLoop == 1)                            %This while loop will continue to run until there is one index that falls in the interval that corresponds to the calculated yT value. 
        index = find(ydata >= yT - add & ydata <= yT + add);
        if (length(index) < 2)  %Ends loop if there is 1 index
            endLoop = 0;
        elseif(isempty(index))  %If the index is empty then add 1 to the interval window.
            add = add + 1;
        else
            add = add - .01;    %if there are more than one index then subtract .01 from the window
        end
    end
   xTau = xdata(index);%find the xTau with the found index (seconds)
   Tau = xTau - Ts;          %calculate tau with this equation (seconds)
end

