%% Example for using UPSO2 with Jong and Ackley functions
%% Cleanup
clc
clear
close all

%% Basic example with standard test function 
% Parameter initialization
% fh = @(x)Jong(x);
fh = @(x)Ackley(x);
fh([2 3]) % Should yield 13 for Jong!
flim = [-20 10; -2 2; -50 45]; % Different limits to validate scaling
properties = struct('visualMode', true, 'verboseMode', true, ...
                'populationSize', 3, 'maxIter', 1, 'maxStagIter', 2);
% Call to the optimizer           
[position,fitness,details] = UPSO2(fh, flim, properties);

%% Basic example for optimizing instance
% Parameter initialization
nbJobs = 6;%3; % Number of jobs desired in the instance
nbMachines = 6;%4; % Number of machines desired in the instance
timeRanges = [0 10]; % Min,Max processing times for the instance
fh = @(x)EvaluateUPSOtoJSSP(x, nbJobs); % Objective function for UPSO
flim = [repmat(timeRanges,nbJobs*nbMachines,1); repmat([0.01 nbMachines],nbJobs*nbMachines,1)]; % First processing times, then machine IDs
% UPSO properties definition
properties = struct('visualMode', false, 'verboseMode', true, ...
                'populationSize', 15, 'maxIter', 100, 'maxStagIter', 100, ...
                'selfConf', 2, 'globalConf', 2.5, 'unifyFactor', 0.25);
% Call to the optimizer           
[position,fitness,details] = UPSO2(fh, flim, properties);
generatedInstance = UPSOtoJSSP(position,nbJobs);
EvaluateUPSOtoJSSP(position,nbJobs, true)