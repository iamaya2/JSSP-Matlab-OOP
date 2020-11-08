function [Min,Max] = featureRanges(folder, featureID)
    nbRep=30;
    nbJobs = 10; % Number of jobs desired in the instance
    nbMachines =10; % Number of machines desired in the instance
    timeRanges = [0 10]; % Min,Max processing times for the instance
    featID=featureIDrepository(featureID);
    folder2=folder+"/Feature_"+featID;
    addpath(genpath(folder2))
    
    for idx=1:nbRep
        address="JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1))+"T2"+num2str(timeRanges(2))+"Rep"+num2str(idx)+"featureID_"+featID;
        load(address)
        featurevalues(idx)=JSSPInstance{2};
    end 
    Min=min(featurevalues)
    Max=max(featurevalues)
    rmpath(folder2)
end