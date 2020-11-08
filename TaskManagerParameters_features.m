
                        
                        
                        
                        %Parameter Initialization
population = [50];% 30 50] %number of particles for UPSO
selfconf = [1.5]; %Self Confidence Factor to evaluate 
globalconf = [1.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.5]; %Unifying Factor 
nbRep = 100; %Number of instances per combination
featureID = [4]; %Number: 1.Mirsh175 2.Mirsh15 3.Mirsh29 4.Mirsh282 5.Mirsh95 ; 
timeRanges = [0 10]; % Min,Max processing times for the instance
objective = 3; % 1.- Maximize Feature Value 2.- Minimize Feature Value 3.- TargetValue
folder = "NormalizedFeatures";
nbJobsV = [3];
nbMachinesV = [4];
targetValue =[0 0.25 0.5 0.75 1];
TaskManagerPrueba_Features(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbRep, featureID,folder,objective,targetValue);
                        
                        
                        
