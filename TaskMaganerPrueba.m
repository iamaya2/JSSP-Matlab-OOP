% Parameter initialization
nbJobsV = [3 10] 
nbMachinesV = [4 10]
population = [10 30 50]
selfconf = [0.5 1 1.5 2 2.5]
globalconf = [0.5 1 1.5 2 2.5]
unifyfactor = [0.1 0.2 0.5 0.8 0.9]
%Small Instance/Large Instance 
for s=1:2
    directory2=["C:\Users\nufo\Documents\MATLAB\JSSP-Matlab-OOP-master\"];    
    oldfolder=cd(directory2)
 
nbJobs = nbJobsV(s); % Number of jobs desired in the instance
nbMachines =nbMachinesV(s); % Number of machines desired in the instance
if s==1 
timeRanges = [0 10]; % Min,Max processing times for the instance
else 
timeRanges = [0 100]; % Min,Max processing times for the instance
end
fh = @(x)EvaluateUPSOtoJSSP(x, nbJobs); % Objective function for UPSO
flim = [repmat(timeRanges,nbJobs*nbMachines,1); repmat([0.01 nbMachines],nbJobs*nbMachines,1)]; % First processing times, then machine IDs
    if s==1 
        newdir = ["SPTvsLPT_Small"]
    else 
        newdir = ["SPTvsLPT_Large"]
    end 
status=mkdir('GeneratedInstances', newdir)
% UPSO properties definition

    for p=1:3
        oldfolder=cd('GeneratedInstances'); 
        oldfolder=cd(newdir);
        newdirpop = [newdir + "_pop"+ num2str(population(p))];
        status=mkdir(newdirpop);
        
        properties = struct('populationSize', population(p));  
        
        
        for sc=1:5
         
             oldfolder=cd(directory2)
             oldfolder=cd('GeneratedInstances'); 
             oldfolder=cd(newdir);
             oldfolder=cd(newdirpop);
             newdirSC =  [newdirpop + "_SC" + num2str(selfconf(sc))]
             status   = mkdir(newdirSC)
             
             properties = struct('selfConf', selfconf(sc))
             
             
            
                 for gc=1:5
         
             oldfolder=cd(directory2)
             oldfolder=cd('GeneratedInstances'); 
             oldfolder=cd(newdir);
             oldfolder=cd(newdirpop);
             oldfolder=cd(newdirSC);
             newdirGC =  [newdirSC + "_GC" + num2str(globalconf(gc))]
             status   = mkdir(newdirGC)
             
             properties = struct('globalConf', globalconf(gc))
             
             
             properties = struct('visualMode', false, 'verboseMode', true, ...
                'maxIter', 100, 'maxStagIter', 100, ...
             'unifyFactor', 0.5);
                    for uf=1:5
         
             oldfolder=cd(directory2)
             oldfolder=cd('GeneratedInstances'); 
             oldfolder=cd(newdir);
             oldfolder=cd(newdirpop);
             oldfolder=cd(newdirSC);
             oldfolder=cd(newdirGC);
             newdirUF =  [newdirGC + "_UF" + num2str(unifyfactor(uf))]
             status   = mkdir(newdirUF)
             
             properties = struct('unifyFactor', unifyfactor(uf))
             
             
             properties = struct('visualMode', false, 'verboseMode', true, ...
                'maxIter', 100, 'maxStagIter', 100);


% Call to the optimizer
for idx=1:30
directory2=["C:\Users\nufo\Documents\MATLAB\JSSP-Matlab-OOP-master\"];    
 oldfolder=cd(directory2)
[position,fitness,details] = UPSO2(fh, flim, properties);
generatedInstance = UPSOtoJSSP(position,nbJobs);
performanceData = EvaluateUPSOtoJSSP(position,nbJobs)
%directory=["C:\Users\nufo\Documents\MATLAB\JSSP-Matlab-OOP-master\GeneratedInstances\SPTvsLPT"];    
cell={generatedInstance, performanceData}; 
oldfolder=cd('GeneratedInstances'); 
oldfolder=cd(newdir);
oldfolder=cd(newdirpop);
oldfolder=cd(newdirSC);
oldfolder=cd(newdirGC);
oldfolder=cd(newdirUF);
filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1))+"T2"+num2str(timeRanges(2))+"Rep"+num2str(idx)+"LPTvsSPT";
save(filename2,'cell')
directory2=["C:\Users\nufo\Documents\MATLAB\JSSP-Matlab-OOP-master\"];    
 oldfolder=cd(directory2);
                    end
                end
            end
        end
    end
end
