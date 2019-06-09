function [yH, yL, Ts, Tau] = Project_M4Alogrithm_014_07(xdata, ydata)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This user defined function takes in a type of data that is wanted and
% returns the max y value (deg F), minimum y value (deg F), time step
% value(seconds), and the tau (seconds)
%
% Function Call
% [yH, yL, Ts, Tau] = Project_M4Algorithm2_014_07(xdata,ydata)
%
% Input Arguments
% The x and y data that will be inputted into the script. Xdata in seconds
% and ydata in degrees fahrenheit
% In the context of our project, the xdata will be time and the ydata will
% be temperature in defrees fahrenheit
%
% Output Arguments
% yH: the maximum y value (Deg F)
% yL: the minimum y value (Deg F)
% Ts: Time step value (Seconds)
% Tau: Tau value (Seconds)
%
% Assignment Information
%   Assignment:       	M4
%   Author:             Dante Sanaei, Cody Martin, Evan Kelch, Jeff Nickels ,dsanaei@purdue.edu,mart1390@purdue.edu, ekelch@purdue.edu, jnickels@purdue.edu
%   Team ID:            0014-07
%   Contributors: N/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ____________________
%% INITIALIZATION
smooth = ydata;                                                             %Initalize Y Values degrees Fahrenheit (deg F)
maxSlope = 0;                                                               %Initalize max slope
endLoop = 1;                                                                %Initalize end loop
%add = 10;                                                                   %Initalize add variable
add = 2;        %CATEGORY 2: Add is the variable that determines the range of the interval that is used to find the tau value. By reducing this value to 2 from 10 we can make the while loop iterate significantly less than before. This will make the code more efficient and faster.

%% ____________________
%% Calculations
%for j = 1:1000                                                             %run smooth function 1000 times for maximum smoothening
for j = 1:150              %CATEGORY 1 and 2: Reduce the amount of iterations in order to reduce the smoothing from skewing the data and making the Ts less accurate. ALSO, reducing the amount of iterations will make the code more efficient and fast as it no longer has to loop nearly 10 million times. 
for i = 1:length(ydata)-1                                                 %Runs through the y values (deg F) and smooths them out with averages 
    if i == 1                                                               %If the count is at 1
        smooth(i) = (smooth(i) + smooth(i) + smooth(i+1)) / 3;              %Averages it with the next value and the first value (deg F)
    elseif i == length(ydata) - 1 
        smooth(i) = (smooth(i-1) + smooth(i-2) + smooth(i)) / 3;            %Averages it with the previous two values (deg F)
    else
        smooth(i) = (smooth(i-1) + smooth(i) + smooth(i+1))  /3;         %Averages it with the next value and the previous value (deg F)
    end
end
end
for m = 1:length(smooth) - 200                                              %runs through all the values minus 10
    %slope = abs((smooth(m+10) - smooth(m)) / (xdata(m+10) - xdata(m)));     %finds the slope of the index value and the value 10 spaces ahead.
    slope = abs((smooth(m+200) - smooth(m)) / (xdata(m+200) - xdata(m)));  %CATEGORY 1: In order to decrease the amount of iterations for the smoothing, we needed to increase the interval between points that we use to calculate the slope. Using farther points will allow us to get slopes that are less effected by the noise. 

    if slope > maxSlope                                                     %This part finds the maximum slope through the entire data set
        maxSlope = slope;                                                   %This is the max slope of the entire data set
       % ydata(m);      %CATEGORY 2: Non-vital statement is removed      
        t = m;                                                              %This is the index of the maximum slope
    end
end

    indexP = 0;                                                             %Initializes the index
    Ts = xdata(t);                                                          %This is teh Ts Value
    FlatLine = ydata(1:200); %CATEGORY 1: Instead of finding the average from 1 to the time step, we instead find the average from 1 to the 200th data point.                                               
    firstY = mean(FlatLine);                                                %This is the average of these values, setting it equal to yL (deg F)
    lastY = mean(ydata(length(ydata) - 200:end));    %CATEGORY 1: Instead of finding the average from the the tenth to last value to the end, we instead find the average from 200th to last point to the end.                             %This mean of the last 10 values is the yH. (deg F)
    if (firstY > lastY)                                                     %Cooling
        yH = firstY;                                                        %Initializes the high Y as the first Y
        yL = lastY;                                                         %Initializes the low Y as the last L
        yT = yL + .368 * (yH - yL);                                         %This equation finds yT (deg F)
    end
    if (firstY < lastY)                                                     % heating     
        yL = firstY;                                                        %Initializes the low Y as the first Y
        yH = lastY;                                                         %Initializes the high Y as the last Y
        yT = yL + .632 * (yH - yL);                                         %This equation finds yT (deg F)
    end
    while (endLoop == 1)                                                    %This while loop will continue to run until there is one index that falls in the interval that corresponds to the calculated yT value. 
        index = find(ydata >= yT - add & ydata <= yT + add);                %Determines the index based on the yT value.
        if(isempty(index))                                                  %If the index is empty then add 1 to the interval window.
            index = indexP(1);                                              %Sets the index to the IndexP of 1
            endLoop = 0;                                                    %Sets the end loop criteria
        elseif (length(index) < 2)                                          %Ends loop if there is 1 index
            endLoop = 0;                                                    %Ends the loop if the length is less than 2        
        else
            add = add - .01;                                                %if there are more than one index then subtract .01 from the window
        end
        indexP = index;                                                     %Sets indexP to the current value of Index
    end
   xTau = xdata(index);                                                     %find the xTau with the found index (seconds)
   Tau = xTau - Ts;                                                         %calculate tau with this equation (seconds)

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.

