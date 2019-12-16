%% Example for using UPSO2 with Jong and Ackley functions
%% Cleanup
clc
clear
close all

%% Parameter initialization
% fh = @(x)Jong(x);
fh = @(x)Ackley(x);
fh([2 3]) % Should yield 13 for Jong!
flim = [-20 10; -2 2; -50 45]; % Different limits to validate scaling
properties = struct('visualMode', true, 'verboseMode', true, ...
                'populationSize', 3, 'maxIter', 1, 'maxStagIter', 2);
[position,fitness,details] = UPSO2(fh, flim, properties);