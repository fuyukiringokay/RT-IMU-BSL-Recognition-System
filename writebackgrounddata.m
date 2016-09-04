% Copyright (c) 2015, Engineering Team
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
% 
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution
%     * Neither the name of the Shimmer nor the names
%       of its contributors may be used to endorse or promote products derived
%       from this software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.


function [gyro1, gyro2, gyro3] = writebackgrounddata(comPort, captureDuration)

%PLOTANDWRITEXAMPLE - Demonstrate basic features of ShimmerHandleClass
%
%  PLOTANDWRITEEXAMPLE(COMPORT, CAPTUREDURATION, FILENAME) plots 3 
%  accelerometer signals, 3 gyroscope signals and 3 magnetometer signals,
%  from the Shimmer paired with COMPORT. The function 
%  will stream data for a fixed duration of time defined by the constant 
%  CAPTUREDURATION. The function also writes the data in a tab ddelimited 
%  format to the file defined in FILENAME.
%  NOTE: This example uses the method 'getdata' which is a more advanced 
%  alternative to the 'getuncalibrateddata' method in the beta release. 
%  The user is advised to use the updated method 'getdata'.  
%
%  SYNOPSIS: plotandwriteexample(comPort, captureDuration, fileName)
%
%  INPUT: comPort - String value defining the COM port number for Shimmer
%  INPUT: captureDuration - Numerical value defining the period of time 
%                           (in seconds) for which the function will stream 
%                           data from  the Shimmers.
%  INPUT : fileName - String value defining the name of the file that data 
%                     is written to in a comma delimited format.
%  OUTPUT: none
%
%  EXAMPLE: plotandwriteexample('7', 30, 'testdata.dat')
%
%  See also twoshimmerexample ShimmerHandleClass 


%% definitions

shimmer = ShimmerHandleClass(comPort);                                     % Define shimmer as a ShimmerHandle Class instance with comPort1
SensorMacros = SetEnabledSensorsMacrosClass;                               % assign user friendly macros for setenabledsensors

firsttime = true;
gyro1 = 0;
gyro2 = 0;
gyro3 = 0;
% Note: these constants are only relevant to this examplescript and are not used
% by the ShimmerHandle Class
NO_SAMPLES_IN_PLOT = 500;                                                  % Number of samples that will be displayed in the plot at any one time
DELAY_PERIOD = 0.2;                                                        % A delay period of time in seconds between data read operations
numSamples = 0;
fid=fopen('traindata.txt','wt'); 

%%

if (shimmer.connect)                                                       % TRUE if the shimmer connects
    
    % Define settings for shimmer
    shimmer.setsamplingrate(51.2);                                         % Set the shimmer sampling rate to 51.2Hz
    shimmer.setinternalboard('9DOF');                                      % Set the shimmer internal daughter board to '9DOF'
    shimmer.disableallsensors;                                             % disable all sensors
    shimmer.setenabledsensors(SensorMacros.ACCEL,1,SensorMacros.MAG,1,...  % Enable the shimmer accelerometer, magnetometer, gyroscope and battery voltage monitor
        SensorMacros.GYRO,1,SensorMacros.BATT,1);    
    shimmer.setaccelrange(0);                                              % Set the accelerometer range to 0 (+/- 1.5g) for Shimmer2r
    shimmer.setbattlimitwarning(3.4);                                      % This will cause the Shimmer LED to turn yellow when the battery voltage drops below 3.4, note that it is only triggered when the battery voltage is being monitored, and after the getdata command is executed to retrieve the battery data 
         
    if (shimmer.start)                                                     % TRUE if the shimmer starts streaming
        
        elapsedTime = 0;                                                   % Reset to 0    
        tic;                                                               % Start timer
        f = figure('Position',[500 500 500 500]);
        u1 = uicontrol('Parent',f,...
                'Style', 'text',...
               'String', '3',... 
               'Units','pixels',...
               'position',[200 200 100 100],...
               'fontsize',40);
         pause(1);
         u1 = uicontrol('Parent',f,...
                'Style', 'text',...
               'String', '2',... 
               'Units','pixels',...
               'position',[200 200 100 100],...
               'fontsize',40);
         pause(1);
         u1 = uicontrol('Parent',f,...
                'Style', 'text',...
               'String', '1',... 
               'Units','pixels',...
               'position',[200 200 100 100],...
               'fontsize',40);
            pause(1)
            
        u1 = uicontrol('Parent',f,...
                'Style', 'text',...
                'String', 'Analysing... For best result, please do not move.',... 
                'Units','pixels',...
                'position',[200 200 100 100],...
                'fontsize',12);
        while (elapsedTime < captureDuration)            
            pause(DELAY_PERIOD);                                           % Pause for this period of time on each iteration to allow data to arrive in the buffer        
            [newData,signalNameArray,signalFormatArray,signalUnitArray] = shimmer.getdata('c');   % Read the latest data from shimmer data buffer, signalFormatArray defines the format of the data and signalUnitArray the unit
            
            if ~isempty(newData)                                           % TRUE if new data has arrived    
                    dlmwrite('traindata.txt', newData(:,[2:4,6:11]), '-append','precision',16,'newline', 'pc');
                    
             end
            
            elapsedTime = elapsedTime + toc;                               % Stop timer and add to elapsed time
            tic;                                                           % Start timer           
            
        end  
        
        elapsedTime = elapsedTime + toc;                                   % Stop timer
        shimmer.stop;                                                      % Stop data streaming                                                    
    end 
        DATA = dlmread('traindata.txt');
        gyro1 = sum(abs(DATA(:,6)));  
        gyro2 = sum(abs(DATA(:,7))); 
        gyro3 = sum(abs(DATA(:,8)));
        
        u1 = uicontrol('Parent',f,...
           'Style', 'text',...
           'String', 'Analysing END',... 
           'Units','pixels',...
           'position',[200 200 100 100],...
           'fontsize',15);
        close;
                
    shimmer.disconnect;                                                    % Disconnect from shimmer
        
end