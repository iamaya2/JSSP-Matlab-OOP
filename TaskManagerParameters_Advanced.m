% Parameter initialization
nbJobsV = [3]; %number of jobs desired
nbMachinesV = [4]; %number of machines desired
population = [50];% 30 50] %number of particles for UPSO
selfconf = [0.5]; %Self Confidence Factor to evaluate 
globalconf = [1.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.1]; %Unifying Factor 
nbRep = 50; %Number of instances per combination
heurID = [4 2 3 1]; %Number: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
timeRanges = [0 10]; % Min,Max processing times for the instance
objective = 2; % 1.- Enhance heuristic performance 2.- Diminish heuristic performance
delta = 20; % optional; needs to be added to the parameters (always a positive number)
toPlot = false; %optional; needs to be added to the parameters
TaskManagerPrueba_Advanced(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbRep, heurID, objective, delta);

