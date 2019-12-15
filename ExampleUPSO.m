%% Example for using UPSO2 with Jong and Ackley functions
%% Cleanup
clc
clear
close all

%% Parameter initialization
fh = @(x) norm(x)^2;
% fh = @(x)Jong(x);
fh([2 3]) % Should yield 13!
flim = [-10 10; -2 2]; % Different limits to validate scaling
properties = struct('visualMode', true, 'verboseMode', true, ...
                'populationSize', 10, 'maxIter', 5);

[position,fitness,details] = UPSO2(fh, flim, properties);