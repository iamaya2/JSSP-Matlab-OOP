function [allInstances]= TaskManagerPrueba_Features(nbJobsV,nbMachinesV,timeRanges,population,selfconf, globalconf, unifyfactor, nbRep, featureID, folder, objective, varargin)
% heuristicID=heurIDrepository(heurID); %convert the numeric ID into a three letter string ID, ex. 1-> "LPT" 


%Instance Size
for s=1:length(nbJobsV)
    
    directory2=pwd; % Directory where the function is located
    oldfolder=cd(directory2) % Going back to the main directory
    
    nbJobs = nbJobsV(s); % Number of jobs desired in the instance
    nbMachines =nbMachinesV(s); % Number of machines desired in the instance

    delta = nan;
    toPlot = false;
    if nargin == 12, targetValue = varargin{1}; end
    
%     if objective == 1  
%         newdir =heuristicID(1) +"vsAll_"+"J"+num2str(nbJobsV(s))+"xM"+num2str(nbMachinesV(s));
%     elseif objective == 2 
%         newdir ="Allvs"+heuristicID(1)+"_J"+num2str(nbJobsV(s))+"xM"+num2str(nbMachinesV(s));
%     end
    featID=featureIDrepository(featureID);
    newdir="Feature_"+featID;
    status=mkdir(folder,newdir); %Creating a new folder within GeneratedInstances_Advanced

   
    % Number of Particles
    for p=1:length(population)
        oldfolder=cd(folder);

        oldfolder=cd(newdir);
        newdirpop = char([newdir + "_pop"+ num2str(population(p))]);
        
        
        properties = struct('populationSize', population(p));
        
        
        % Self Confidence Parameter
        for sc=1:length(selfconf)


            oldfolder=cd(directory2);
            oldfolder=cd(folder);
            oldfolder=cd(newdir);
           
            newdirSC =  char([newdirpop + "_SC" + num2str(selfconf(sc))]);

            
            
            properties = struct('selfConf', selfconf(sc));
            
            
            
        % Global Confidence Parameter
            for gc=1:length(globalconf)
                
                oldfolder=cd(directory2)
                oldfolder=cd(folder);
                oldfolder=cd(newdir);
              
                newdirGC =  char([newdirSC + "_GC" + num2str(globalconf(gc))]);
             
                
                properties = struct('globalConf', globalconf(gc))
                
                
  

                for uf=1:length(unifyfactor)
                    
                    oldfolder=cd(directory2)
                    oldfolder=cd(folder);
                    oldfolder=cd(newdir);
                 
                    newdirUF =  char([newdirGC + "_UF" + num2str(unifyfactor(uf))]);
                    if  ~isnan(delta), d = -delta; end
                    
                    if  ~isnan(delta), newdirDelta = char(["Delta_"+num2str(d)]); end
                    if  ~isnan(delta), status   = mkdir(newdirDelta); end
                    
                    properties = struct('unifyFactor', unifyfactor(uf))
                    
                   %UPSO Remaining Parameters 
                    properties = struct('verboseMode', true, ...
                        'maxIter', 100, 'maxStagIter', 100);
                    
               
                    % Call to the optimizer
               if nargin == 12     
                 for t=1:length(targetValue)
                     oldfolder=cd(directory2);
                     oldfolder=cd(folder);
                     oldfolder=cd(newdir);
                     newdirFeat=num2str(targetValue(t));
                     status=mkdir(newdirFeat)
                    fh = @(x)EvaluateUPSOtoJSSP_features(x, nbJobs, featureID,objective,targetValue(t)); % Objective function for UPSO      
                    flim = [repmat(timeRanges(s,:),nbJobs*nbMachines,1); repmat([0.01 nbMachines],nbJobs*nbMachines,1)]; % First processing times, then machine IDs
   

                    for idx=1:nbRep

%                         
                        oldfolder=cd(directory2)
                        [position,fitness,details] = UPSO2(fh, flim, properties);
                        generatedInstance = UPSOtoJSSP(position,nbJobs);
                        
                        performanceData = EvaluateUPSOtoJSSP_features(position,nbJobs,featureID,objective,targetValue(t));
                        if objective==1, performanceData=performanceData*-1; end
                        if objective==3
                                if featureID==1 
                                    performanceData=Mirsh175(generatedInstance);
                                elseif featureID==2 
                                     performanceData=Mirsh15( generatedInstance);
                                elseif featureID==3 
                                     performanceData=Mirsh29( generatedInstance);
                                elseif featureID==4 
                                     performanceData=Mirsh282( generatedInstance);
                                elseif featureID==5 
                                     performanceData=Mirsh95( generatedInstance);
                                end
                        end
                        JSSPInstance={generatedInstance, performanceData};
                        allInstances{idx}=generatedInstance;
                        oldfolder=cd(folder);
                        oldfolder=cd(newdir);
                        oldfolder=cd(newdirFeat);
                        
                    
%                      if objective ==1               
%                         filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(s,1))+"T2"+num2str(timeRanges(s,2))+"Rep"+num2str(idx)+heuristicID(1)+"vsAll";
%                      elseif objective ==2 
%                          filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(s,1))+"T2"+num2str(timeRanges(s,2))+"Rep"+num2str(idx)+"Allvs"+heuristicID(1);
%                      end
                        filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(s,1))+"T2"+num2str(timeRanges(s,2))+"Rep"+num2str(idx)+"featureID_"+featID;
                      save(filename2,'JSSPInstance')                        
                      oldfolder=cd(directory2);
                end
              end
            
           else
                   fh = @(x)EvaluateUPSOtoJSSP_features(x, nbJobs, featureID,objective); % Objective function for UPSO      
                   flim = [repmat(timeRanges(s,:),nbJobs*nbMachines,1); repmat([0.01 nbMachines],nbJobs*nbMachines,1)]; % First processing times, then machine IDs
                    for idx=1:nbRep

%                         
                        oldfolder=cd(directory2)
                        [position,fitness,details] = UPSO2(fh, flim, properties);
                        generatedInstance = UPSOtoJSSP(position,nbJobs);
                        
                        performanceData = EvaluateUPSOtoJSSP_features(position,nbJobs,featureID,objective);
                        if objective==1, performanceData=performanceData*-1; end
                        
                        JSSPInstance={generatedInstance, performanceData};
                        oldfolder=cd(folder);
                        oldfolder=cd(newdir);
                      
                        
                    
%                      if objective ==1               
%                         filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(s,1))+"T2"+num2str(timeRanges(s,2))+"Rep"+num2str(idx)+heuristicID(1)+"vsAll";
%                      elseif objective ==2 
%                          filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(s,1))+"T2"+num2str(timeRanges(s,2))+"Rep"+num2str(idx)+"Allvs"+heuristicID(1);
%                      end
                        filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(s,1))+"T2"+num2str(timeRanges(s,2))+"Rep"+num2str(idx)+"featureID_"+featID;
                      save(filename2,'JSSPInstance')                        
                      oldfolder=cd(directory2);
                     end
               end
             end
            end

        end
    end
end
end

