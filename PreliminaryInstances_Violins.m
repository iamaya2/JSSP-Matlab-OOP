addpath(genpath('..\'))

%% Common parameters 
addpath(genpath('..\'))

maxProcessingTime           = 10; 
minProcessingTime           = 0; 
maxMachineID                = 4; 
minMachineID                = 1;

nbJobsPerInstance           = 3;
nbActivititiesPerInstance   = 4;

processingTimeDelta = maxProcessingTime - minProcessingTime;
machineIDDelta = maxMachineID - minMachineID;
% %% Generate and store instances
% nbInstancesToGenerate = 30;
% baseStr = sprintf('GeneratedJSSPInstance_%s_%djobs_%dmachs',getTimeStringForFileStorage,nbJobsPerInstance, nbActivititiesPerInstance);
% for instanceID = 1 : nbInstancesToGenerate
%     fileName = sprintf('%s_Inst%d.mat', baseStr, instanceID);
%     instanceData = nan(nbJobsPerInstance, nbActivititiesPerInstance, 2);
%     instanceData(:,:,1) = rand(nbJobsPerInstance, nbActivititiesPerInstance)*processingTimeDelta + minProcessingTime;
%     instanceData(:,:,2) = randi(maxMachineID, nbJobsPerInstance, nbActivititiesPerInstance) - 1 + minMachineID;
%     instance = JSSPInstance(instanceData);
%     allInstances{instanceID} = instance;
%     save(fileName, 'instance', 'maxProcessingTime', 'minProcessingTime', 'maxMachineID', 'minMachineID', 'instanceData');
%     fprintf('Instance %d / %d successfully generated!\n', instanceID, nbInstancesToGenerate)
% end
%%
nbInstancesToLoad = 30;
% oldTimeString = '2020_May_27_17_00_16';
oldTimeString = '2020_May_27_19_04_33';
baseStr = sprintf('GeneratedJSSPInstance_%s_%djobs_%dmachs',oldTimeString,nbJobsPerInstance, nbActivititiesPerInstance);
for instanceID = 1 : nbInstancesToLoad
    fileName = sprintf('%s_Inst%d.mat', baseStr, instanceID);
    load(fileName)
    allInstances{instanceID} = instance;    
    fprintf('Instance %d / %d successfully loaded!\n', instanceID, nbInstancesToLoad)
end

%% Solve each instance with all heuristics
allHeuristicIDs = 1:2;

nbInstances = length(allInstances);
nbSolvers = length(allHeuristicIDs);
heuristicMakespans = zeros(nbInstances, nbSolvers);

for heuristicID = allHeuristicIDs
    for instanceID = 1 : nbInstances
        thisInstance = allInstances{instanceID};
        heuristicMakespans(instanceID, heuristicID) = JSSPSolveInstance(thisInstance, heuristicID);
        thisInstance.reset();
    end
end

violindata = heuristicMakespans(:,2)-heuristicMakespans(:,1);
%%

folder=pwd;
folder1="PreliminaryStage";
folder2="PreliminaryInstances";
LPTFolder="LPTvsSPT_Small";
SPTFolder="SPTvsLPT_Small";
nbJobs = [3]; %number of jobs desired
nbMachines = [4]; %number of machines desired
nbRep = 30; %Number of instances per combination
timeRanges = [0 10];



oldfolder= cd(folder1);
oldfolder= cd(folder2);

oldfolder= cd(LPTFolder);

for NB=1:nbRep


address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
                    +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+"LPTvsSPT.mat");
               
               
                load(address)
                a=nan;
                oldfolder=cd(folder)
                makespan1= makespan(JSSPInstance{1}, 1);
                makespan2= makespan(JSSPInstance{1}, 2);
                delta= makespan2-makespan1;
                
                Violin_1(NB,1)=delta;
                oldfolder= cd(folder1);
                oldfolder= cd(folder2);

                oldfolder= cd(LPTFolder);
end

oldfolder= cd(folder)
oldfolder= cd(folder1)
oldfolder= cd(folder2)

oldfolder= cd(SPTFolder)

for NB=1:nbRep

address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
                    +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+"SPTvsLPT.mat");
               
                
                load(address)
                a=nan;
                oldfolder= cd(folder);
                makespan1= makespan(JSSPInstance{1}, 1);
                makespan2= makespan(JSSPInstance{1}, 2);
                delta= makespan2-makespan1;
                
                Violin_2(NB,1)=delta;
                oldfolder= cd(folder1);
                oldfolder= cd(folder2);

                oldfolder= cd(SPTFolder);
end
oldfolder= cd(folder);
PreliminaryViolin(:,1)=violindata(:,1);
PreliminaryViolin(:,2)=Violin_1(:,1);
PreliminaryViolin(:,3)=Violin_2(:,1);
%%
CATEGORYNAMES = {"Random" "LPT" "SPT"};
    violinplot(PreliminaryViolin, CATEGORYNAMES, 'width', 0.3, 'violinalpha', 0.55, 'ShowData', false) 
    ylabel("Performance Gap (SPT-LPT)")
        title("PreliminaryInstances")
ylim([-70 80])