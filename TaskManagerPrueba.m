function []= TaskManagerPrueba(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf, unifyfactor, nbRep, heurID, heuristicID)
% Parameter initialization
%nbJobsV = [3]; %number of jobs desired
%nbMachinesV = [4]; %number of machines desired
%population = [10];% 30 50] %number of particles for UPSO
%selfconf = [0.5 1.5 2.5]; %Self Confidence Factor to evaluate 
%globalconf = [0.5 1.5 2.5]; %Global Confidence Factor to evaluate
%unifyfactor = [0.1 0.5 0.9]; %Unifying Factor 
%nbRep = 30; %Number of instances per combination
%heurID = [2 1]; %Number: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
%heuristicID = ["SPT" "LPT"]; % 3 Letters code: 1.LPT 2.SPT 3.MPA 4.LPA ; first the heuristic to worsen, second the heuristic to improve
%timeRanges = [0 10]; % Min,Max processing times for the instance



%Small Instance/Large Instance
for s=1:length(nbJobsV)
    %     directory2=["C:\Users\nufo\Documents\MATLAB\JSSP-Matlab-OOP-master\"]; % Ruta para funciones
    directory2=pwd; % For same folder...
    oldfolder=cd(directory2)
    
    nbJobs = nbJobsV(s); % Number of jobs desired in the instance
    nbMachines =nbMachinesV(s); % Number of machines desired in the instance

    fh = @(x)EvaluateUPSOtoJSSP(x, nbJobs, heurID); % Objective function for UPSO
    flim = [repmat(timeRanges,nbJobs*nbMachines,1); repmat([0.01 nbMachines],nbJobs*nbMachines,1)]; % First processing times, then machine IDs
   

    newdir = char(heuristicID(1) +"vs"+heuristicID(2)+"_Small");
    status=mkdir('GeneratedInstances', newdir)
    % UPSO properties definition
    
    for p=1:length(population)
        oldfolder=cd('GeneratedInstances');

        oldfolder=cd(newdir);
        newdirpop = char([newdir + "_pop"+ num2str(population(p))]);
        status=mkdir(newdirpop);
        
        properties = struct('populationSize', population(p));
        
        

        for sc=1:length(selfconf)
             oldfolder=cd(directory2)
            oldfolder=cd('GeneratedInstances');

            oldfolder=cd(newdir);
            oldfolder=cd(newdirpop);
            newdirSC =  char([newdirpop + "_SC" + num2str(selfconf(sc))])

            status   = mkdir(newdirSC);
            
            properties = struct('selfConf', selfconf(sc));
            
            
            

            for gc=1:length(globalconf)
                
                oldfolder=cd(directory2)
                oldfolder=cd('GeneratedInstances');
                oldfolder=cd(newdir);
                oldfolder=cd(newdirpop);
                oldfolder=cd(newdirSC);
                newdirGC =  char([newdirSC + "_GC" + num2str(globalconf(gc))]);
                status   = mkdir(newdirGC);
                
                properties = struct('globalConf', globalconf(gc))
                
                
                properties = struct('verboseMode', true, ...
                    'maxIter', 100, 'maxStagIter', 100, ...
                    'unifyFactor', 0.5);

                for uf=1:length(unifyfactor)
                    
                    oldfolder=cd(directory2)
                    oldfolder=cd('GeneratedInstances');
                    oldfolder=cd(newdir);
                    oldfolder=cd(newdirpop);
                    oldfolder=cd(newdirSC);
                    oldfolder=cd(newdirGC);
                    newdirUF =  char([newdirGC + "_UF" + num2str(unifyfactor(uf))]);
                    status   = mkdir(newdirUF);
                    
                    properties = struct('unifyFactor', unifyfactor(uf))
                    
                    
                    properties = struct('verboseMode', true, ...
                        'maxIter', 100, 'maxStagIter', 100);
                    
                    
                    % Call to the optimizer
                    for idx=1:nbRep
%                         directory2=["C:\Users\nufo\Documents\MATLAB\JSSP-Matlab-OOP-master\"];
                        oldfolder=cd(directory2)
                        [position,fitness,details] = UPSO2(fh, flim, properties);
                        generatedInstance = UPSOtoJSSP(position,nbJobs);

                        performanceData = EvaluateUPSOtoJSSP(position,nbJobs,heurID )
                        %directory=["C:\Users\nufo\Documents\MATLAB\JSSP-Matlab-OOP-master\GeneratedInstances\SPTvsLPT"];
                        cell={generatedInstance, performanceData};
                        oldfolder=cd('GeneratedInstances');
                        oldfolder=cd(newdir);
                        oldfolder=cd(newdirpop);
                        oldfolder=cd(newdirSC);
                        oldfolder=cd(newdirGC);
                        oldfolder=cd(newdirUF);

                        filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1))+"T2"+num2str(timeRanges(2))+"Rep"+num2str(idx)+heuristicID(1)+"vs"+heuristicID(2);
                        save(filename2,'cell')
%                         directory2=["C:\Users\nufo\Documents\MATLAB\JSSP-Matlab-OOP-master\"];
                        oldfolder=cd(directory2);
                    end
                end
            end
        end
    end
end

end
