function Project_M4Regression_014_07(tauList)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Preforms function discovery and preforms non linear regression to find a
% curve of best fit for the data 
%
% Function Call
%  Project_M4Regression_014_07(tauList)
%
% Input Arguments
% tauList - Complete list of 100 tau values; 50 Heating + 50 Cooling
% (seconds)
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
FOS1tau = [tauList(1:10,1);tauList(51:60,1)];                               %The taus for the 1st thermocouple (sec)
FOS2tau = [tauList(11:20,1);tauList(61:70,1)];                              %The taus for the 2nd thermocouple(sec)
FOS3tau = [tauList(21:30,1);tauList(71:80,1)];                              %The taus for th3rd thermocouple(sec)
FOS4tau = [tauList(31:40,1);tauList(81:90,1)];                              %The taus for th4th thermocouple(sec)
FOS5tau = [tauList(41:50,1);tauList(91:100,1)];                             %The taus for th5th thermocouple(sec)
tauOrdered = [FOS1tau; FOS2tau; FOS3tau; FOS4tau; FOS5tau];                 %The ordered tau vector (sec)

% Cost per unit (USD) 
FOS1Price = 17.02;                                                          %The price of the first thermocouple (USD)
FOS2Price = 9.16;                                                           %The price of the Second thermocouple(USD)
FOS3Price = 3.77;                                                           %The price of the thrid thermocouple(USD)
FOS4Price = 2.19;                                                           %The price of the fourth thermocouple(USD)
FOS5Price = 0.70;                                                           %The price of the fifth thermocouple(USD)

FOSPriceFull = zeros(length(tauOrdered) ,1);                                %Makes a vector of zeroes
for k = 1:100                                                               %Iterate the loop from 1 to 100
    if (k <= 20)                                                            %If k the loop is less than or equal to 20
        FOSPriceFull(k) = FOS1Price;                                        %FOS1 price is added to the full FOS price vecotr
    elseif (k <= 40)                                                        %If k is less than or equal to 40
        FOSPriceFull(k) = FOS2Price;                                        %FOS2 price is added to the full FOS price vecotr
    elseif (k <= 60)                                                        %If k is less than or equal to 60
        FOSPriceFull(k) = FOS3Price;                                        %FOS3 price is added to the full FOS price vecotr
    elseif (k <= 80)                                                        %If k is less than or equal to 80
        FOSPriceFull(k) = FOS4Price;                                        %FOS4 price is added to the full FOS price vecotr
    elseif (k <= 100)                                                       %If k is less than or equal to 100
        FOSPriceFull(k) = FOS5Price;                                        %FOS5 price is added to the full FOS price vecotr
    end
end
%% ____________________
%% FUNCTION DISCOVERY
figure(1)
subplot(2,2,1)
plot(tauOrdered, FOSPriceFull, 'o')                                         %Plots tauOrdered and FOSPriceFull
title('Thermocouple Cost to Effeciency (LINEAR)', 'FontSize', 10)           %Titles the plot
xlabel('Time Constant (sec)', 'FontSize', 10)                               %Creates the xlabel
ylabel('Cost of Thermocouple Unit (USD)', 'FontSize', 10)                   %Creates the yLabel
subplot(2,2,2)
semilogy(tauOrdered, FOSPriceFull, 'o')                                     %Plots the semilogy of tauOrdered and FOSPriceFUll
title('Thermocouple Cost to Effeciency (SEMILOGY)', 'FontSize', 10)         %titles the semilogy
xlabel('Time Constant (sec)', 'FontSize', 10)                               %creates the xlabel
ylabel('Cost of Thermocouple Unit (USD)', 'FontSize', 10)                   %creates the ylabel
subplot(2,2,3)  
semilogx(tauOrdered, FOSPriceFull, 'o')                                     %plots the semilogx of tauOrdered and FOSPriceFull
title('Thermocouple Cost to Effeciency (SEMILOGX)', 'FontSize', 10)         %Titles the plot
xlabel('Time Constant (sec)', 'FontSize', 10)                               %Creates the xlabel
ylabel('Cost of Thermocouple Unit (USD)', 'FontSize', 10)                   %Creates the ylabel
subplot(2,2,4)                                              
loglog(tauOrdered, FOSPriceFull, 'o')                                       %Plots the loglog of tauOrdered and FOSPriceFUll
title('Thermocouple Cost to Effeciency (LOGLOG)', 'FontSize', 10)           %Titles the plot
xlabel('Time Constant (sec)', 'FontSize', 10)                               %creates the xlabel
ylabel('Cost of Thermocouple Unit (USD)', 'FontSize', 10)                   %Creates the ylabel

%% ____________________
%% REGRESSION
logFOSPriceFull = log10(FOSPriceFull);                                                          %Logs the full price(USD)
regCoefs = polyfit(tauOrdered, logFOSPriceFull, 1);                                             %determines the coefficients
regVals = polyval(regCoefs, tauOrdered);                                                        %determines the values based onthe coefficients
[SSE, SST, coefDetermination] = Project_M4RegressionValues_014_07(tauOrdered, logFOSPriceFull); %Determines the SSE SST and coefficient of determination (degF^2)
%% ____________________
%% FORMATTED DISPLAY
figure(2)
hold on
plot(FOS1tau, FOS1Price, 'o')
plot(FOS2tau, FOS2Price, 'o')
plot(FOS3tau, FOS3Price, 'o')
plot(FOS4tau, FOS4Price, 'o')
plot(FOS5tau, FOS5Price, 'o')
       %plots the orderedtau an FOSPrice

plot(tauOrdered, 10 .^ regVals, 'r-' )                                       %Plots the ordered tau and 10 raised to the regvalues
str = {'Price = 10^{1.341}*10^{-.929*timeConstant}'};
text(.6,10,str, 'fontsize', 18)
title('Thermocouple Cost Compared to Efficiency', 'FontSize', 20)                    %Adds a title
xlabel('Time Constant (sec)', 'FontSize', 20)                               %adds an xlabel
ylabel('Cost of Thermocouple Unit (USD)', 'FontSize', 20)                   %adds a ylabel
legend('FOS1','FOS2','FOS3','FOS4','FOS5', 'Regression Model', 'Location', 'Northeast') 
                                    %adds a legend
%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The project I am submitting
% is my own original work.

