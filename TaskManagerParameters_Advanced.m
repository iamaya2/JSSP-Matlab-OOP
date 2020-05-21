% Parameter initialization
nbJobsV = [3]; %number of jobs desired
nbMachinesV = [4]; %number of machines desired
population = [10];% 30 50] %number of particles for UPSO
selfconf = [1.5]; %Self Confidence Factor to evaluate 
globalconf = [2.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.9]; %Unifying Factor 
nbRep = 50; %Number of instances per combination
heurID = [2 4 3 1]; %Number: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
timeRanges = [0 10]; % Min,Max processing times for the instance
objective = 1; % 1.- Enhance heuristic performance 2.- Diminish heuristic performance
delta = 20; % optional; needs to be added to the parameters (always a positive number)
toPlot = false; %optional; needs to be added to the parameters
folder = "PruebasDelta";
TaskManagerPrueba_Advanced(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbRep, heurID, objective, folder, delta);
% Parameter initialization
nbJobsV = [3]; %number of jobs desired
nbMachinesV = [4]; %number of machines desired
population = [10];% 30 50] %number of particles for UPSO
selfconf = [1.5]; %Self Confidence Factor to evaluate 
globalconf = [2.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.9]; %Unifying Factor 
nbRep = 50; %Number of instances per combination
heurID = [2 4 3 1]; %Number: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
timeRanges = [0 10]; % Min,Max processing times for the instance
objective = 1; % 1.- Enhance heuristic performance 2.- Diminish heuristic performance
delta = 30; % optional; needs to be added to the parameters (always a positive number)
toPlot = false; %optional; needs to be added to the parameters
folder = "PruebasDelta";
TaskManagerPrueba_Advanced(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbRep, heurID, objective, folder, delta);

% Parameter initialization
nbJobsV = [3]; %number of jobs desired
nbMachinesV = [4]; %number of machines desired
population = [10];% 30 50] %number of particles for UPSO
selfconf = [1.5]; %Self Confidence Factor to evaluate 
globalconf = [2.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.9]; %Unifying Factor 
nbRep = 50; %Number of instances per combination
heurID = [2 4 3 1]; %Number: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
timeRanges = [0 10]; % Min,Max processing times for the instance
objective = 1; % 1.- Enhance heuristic performance 2.- Diminish heuristic performance
delta = 40; % optional; needs to be added to the parameters (always a positive number)
toPlot = false; %optional; needs to be added to the parameters
folder = "PruebasDelta";
TaskManagerPrueba_Advanced(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbRep, heurID, objective, folder, delta);

% Parameter initialization
nbJobsV = [3]; %number of jobs desired
nbMachinesV = [4]; %number of machines desired
population = [10];% 30 50] %number of particles for UPSO
selfconf = [1.5]; %Self Confidence Factor to evaluate 
globalconf = [2.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.9]; %Unifying Factor 
nbRep = 50; %Number of instances per combination
heurID = [2 4 3 1]; %Number: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
timeRanges = [0 10]; % Min,Max processing times for the instance
objective = 1; % 1.- Enhance heuristic performance 2.- Diminish heuristic performance
delta = 50; % optional; needs to be added to the parameters (always a positive number)
toPlot = false; %optional; needs to be added to the parameters
folder = "PruebasDelta";
TaskManagerPrueba_Advanced(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbRep, heurID, objective, folder, delta);
                                                