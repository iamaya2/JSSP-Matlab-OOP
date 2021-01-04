                        
                        
%Parameter Initialization
population = [10];% 30 50] %number of particles for UPSO
selfconf = [1.5]; %Self Confidence Factor to evaluate 
globalconf = [1.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.1]; %Unifying Factor 
nbRep = 30; %Number of instances per combination
heurID = [1 2 3 4]; %Number: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
timeRanges = [0 100]; % Min,Max processing times for the instance
objective = 1; % 1.- Enhance heuristic performance 2.- Diminish heuristic performance
delta = nan; % optional; needs to be added to the parameters (always a positive number)
toPlot = false; %optional; needs to be added to the parameters
folder = "ConfirmatoryInstances";
nbJobsV = [10];
nbMachinesV = [10];
TaskManagerPrueba_Advanced(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbRep, heurID, objective, folder); 
                        
                        
                        
%Parameter Initialization
population = [50];% 30 50] %number of particles for UPSO
selfconf = [1.5]; %Self Confidence Factor to evaluate 
globalconf = [2.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.5]; %Unifying Factor 
nbRep = 30; %Number of instances per combination
heurID = [2 1 3 4]; %Number: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
timeRanges = [0 100]; % Min,Max processing times for the instance
objective = 1; % 1.- Enhance heuristic performance 2.- Diminish heuristic performance
delta = nan; % optional; needs to be added to the parameters (always a positive number)
toPlot = false; %optional; needs to be added to the parameters
folder = "ConfirmatoryInstances";
nbJobsV = [10];
nbMachinesV = [10];
TaskManagerPrueba_Advanced(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbRep, heurID, objective, folder);   
                        
                         
                        
%Parameter Initialization
population = [10];% 30 50] %number of particles for UPSO
selfconf = [1.5]; %Self Confidence Factor to evaluate 
globalconf = [1.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.1]; %Unifying Factor 
nbRep = 30; %Number of instances per combination
heurID = [3 2 1 4]; %Number: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
timeRanges = [0 100]; % Min,Max processing times for the instance
objective = 1; % 1.- Enhance heuristic performance 2.- Diminish heuristic performance
delta = nan; % optional; needs to be added to the parameters (always a positive number)
toPlot = false; %optional; needs to be added to the parameters
folder = "ConfirmatoryInstances";
nbJobsV = [10];
nbMachinesV = [10];
TaskManagerPrueba_Advanced(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbRep, heurID, objective, folder);                        

                        
                        
                        
%Parameter Initialization
population = [50];% 30 50] %number of particles for UPSO
selfconf = [1.5]; %Self Confidence Factor to evaluate 
globalconf = [1.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.5]; %Unifying Factor 
nbRep = 30; %Number of instances per combination
heurID = [4 2 3 1]; %Number: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
timeRanges = [0 100]; % Min,Max processing times for the instance
objective = 1; % 1.- Enhance heuristic performance 2.- Diminish heuristic performance
delta = nan; % optional; needs to be added to the parameters (always a positive number)
toPlot = false; %optional; needs to be added to the parameters
folder = "ConfirmatoryInstances";
nbJobsV = [10];
nbMachinesV = [10];
TaskManagerPrueba_Advanced(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbRep, heurID, objective, folder);      
                        
                        
                        