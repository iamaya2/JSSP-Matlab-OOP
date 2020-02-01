% Parameter initialization
nbJobsV = [3]; %number of jobs desired
nbMachinesV = [4]; %number of machines desired
population = [30];% 30 50] %number of particles for UPSO
selfconf = [0.5 1.5 2.5]; %Self Confidence Factor to evaluate 
globalconf = [0.5 1.5 2.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.1 0.5 0.9]; %Unifying Factor 
nbRep = 30; %Number of instances per combination
heurID = [2 1]; %Number: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
heuristicID = ["SPT" "LPT"]; % 3 Letters code: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
timeRanges = [0 10]; % Min,Max processing times for the instance
TaskManagerPrueba(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf, unifyfactor, nbRep, heurID, heuristicID);