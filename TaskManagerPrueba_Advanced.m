%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ___________________________________________________________________   %           
%  |  TaskManagerPrueba_Advanced is a function to either maximize or   |  %           
%  | minimize the performance  of a single heuristic on a JSSPInstance |  %           
%  |___________________________________________________________________|  %           
%                                                                         %            
% The function uses the Unify Particle Swarm Optimization method to       %           
% either maximize of minimize the performance of the selected heuristic.  %
%                                                                         %
% It receives a total of 10 inputs which are described as follows:        %
% nbJobsV:     a vector containing the number of Jobs desired for the     %
%              instance to contain, it can contain multiple values, the   %
%              function will create instances for each configuration of   % 
%              jobs.                                                      %
% nbMachinesV: similar to nbJobsV, nbMachines is a vector containing the  %
%              number of Jobs desired for the instance to contain, it also% 
%              can  contain multiple values. Notwithstanding, nbJobsV and %
%              nbMachinesV must be the same length.                       %
%                                                                         %
% timeRanges:  timeRanges is a matrix of two columns and as many rows as  %
%              operation time range configurations desired. It is very    %        
%              important that the number of rows matches the lenght of the% 
%              previous inputs.                                           %
% population:  it is a vector containing the number of particles desired  %
%              for the metaheuristic, if multiple values the code will    %
%              create a folder, containing the created instances, for each%
%              configuration.                                             %
% selfconf:    it is a vector containing the value for the parameter      %
%              "self confidence" of the metaheuristic method. If multiple %
%              values the code will create a folder, within the population%
%              folder, containing the created instances, for each         %
%              configuration.                                             %
% globalconf:  it is a vector containing the value for the parameter      %
%              "global confidence" of the metaheuristic method. If        %
%              multiple values the code will create a folder, within the  %
%               "selfconf" folder, containing the created instances, for  %
%              each configuration.                                        %
% unifyfactor: it is a vector containing the value for the parameter      %
%              "unify factor" of the metaheuristic method. If multiple    %
%              values the code will create a folder, within the           % 
%              "globalconf" folder, containing the created instances, for %
%              each configuration.                                        %
% nbRep:       this parameter gives the number of instances desired for   %
%              each configuration.                                        %
% heurID:      it is a vector with the number code of the heuristics to   %
%              use. 1.- LPT 2.- SPT 3.- MPA 4.- LPA                       %
%              So far it is important to use four heuristics, the order   %
%              doesn't matter except for the first position, it must be   %
%              the one to enhance or diminish.                            %
% objective:   this last parameter represent if the heuristic on the first%
%              position of the heurID is going to be enhanced or diminish %
%              on its performance over a JSSPInstance.                    %
%              1.- Enhance  2.- Diminish                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function []= TaskManagerPrueba_Advanced(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf, unifyfactor, nbRep, heurID, objective)
heuristicID=heurIDrepository(heurID); %convert the numeric ID into a three letter string ID, ex. 1-> "LPT" 

%Instance Size
for s=1:length(nbJobsV)
    
    directory2=pwd; % Directory where the function is located
    oldfolder=cd(directory2) % Going back to the main directory
    
    nbJobs = nbJobsV(s); % Number of jobs desired in the instance
    nbMachines =nbMachinesV(s); % Number of machines desired in the instance

    fh = @(x)EvaluateUPSOtoJSSP_Advanced(x, nbJobs, heurID, objective); % Objective function for UPSO
    flim = [repmat(timeRanges(s,:),nbJobs*nbMachines,1); repmat([0.01 nbMachines],nbJobs*nbMachines,1)]; % First processing times, then machine IDs
   
    if objective == 1  
        newdir =(heuristicID(1) +"vsAll"+"J"+num2str(nbJobsV(s))+"xM"+num2str(nbMachinesV(s)));
    elseif objective == 2 
        newdir =( "Allvs"+heuristicID(1)+"J"+num2str(nbJobsV(s))+"xM"+num2str(nbMachinesV(s)));
    end
    
    status=mkdir('GeneratedInstances_Advanced', newdir); %Creating a new folder within GeneratedInstances_Advanced

   
    % Number of Particles
    for p=1:length(population)
        oldfolder=cd('GeneratedInstances');

        oldfolder=cd(newdir);
        newdirpop = char([newdir + "_pop"+ num2str(population(p))]);
        status=mkdir(newdirpop);
        
        properties = struct('populationSize', population(p));
        
        
        % Self Confidence Parameter
        for sc=1:length(selfconf)


            oldfolder=cd(directory2);
            oldfolder=cd('GeneratedInstances_Advanced');
            oldfolder=cd(newdir);
            oldfolder=cd(newdirpop);
            newdirSC =  char([newdirpop + "_SC" + num2str(selfconf(sc))]);

            status   = mkdir(newdirSC);
            
            properties = struct('selfConf', selfconf(sc));
            
            
            
        % Global Confidence Parameter
            for gc=1:length(globalconf)
                
                oldfolder=cd(directory2)
                oldfolder=cd('GeneratedInstances_Advanced');
                oldfolder=cd(newdir);
                oldfolder=cd(newdirpop);
                oldfolder=cd(newdirSC);
                newdirGC =  char([newdirSC + "_GC" + num2str(globalconf(gc))]);
                status   = mkdir(newdirGC);
                
                properties = struct('globalConf', globalconf(gc))
                
                
  

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
                    
                   %UPSO Remaining Parameters 
                    properties = struct('verboseMode', true, ...
                        'maxIter', 100, 'maxStagIter', 100);
                    
                    
                    % Call to the optimizer
                    for idx=1:nbRep
%                         
                        oldfolder=cd(directory2)
                        [position,fitness,details] = UPSO2(fh, flim, properties);
                        generatedInstance = UPSOtoJSSP(position,nbJobs);

                        performanceData = EvaluateUPSOtoJSSP_Advanced(position,nbJobs,heurID,objective);
                        cell={generatedInstance, performanceData};
                        oldfolder=cd('GeneratedInstances_Advanced');
                        oldfolder=cd(newdir);
                        oldfolder=cd(newdirpop);
                        oldfolder=cd(newdirSC);
                        oldfolder=cd(newdirGC);
                        oldfolder=cd(newdirUF);
                     if objective ==1               
                        filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1))+"T2"+num2str(timeRanges(s,:))+"Rep"+num2str(idx)+heuristicID(1)+"vsAll");
                     elseif objective ==2 
                         filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1))+"T2"+num2str(timeRanges(s,:))+"Rep"+num2str(idx)+"Allvs"+heuristicID(1));
                        save(filename2,'JSSPInstance')                        
                        oldfolder=cd(directory2);
                    end
                end
            end
        end
    end
end

end
