folder="ConfirmatoryStage/ConfirmatoryInstances/UsodeRecursos";
addpath(genpath(folder))
nbMachines=10;
nbJobs=10;
heurID=[1 2 3 4 1 2 3 4];
objectiveV=[1 1 1 1 2 2 2 2];

for x=1:length(heurID)
    
    heuristicID=heurIDrepository(heurID(x));
    objective=objectiveV(x);
 if objective == 1 
        addressID = heuristicID + "vsAll_J" + num2str(nbJobs) + "xM" + num2str(nbMachines)+".mat";
    elseif objective == 2 
        addressID =  "Allvs" + heuristicID + "_J" + num2str(nbJobs) + "xM" + num2str(nbMachines)+".mat";
 end
    
 load(addressID)
percentageVectorT=percentageVector';
percentageMat(:,x)=percentageVectorT;
 
end

CATEGORYNAMES = {"LPTvsAll" "SPTvsAll" "MPAvsAll" "LPAvsAll" "AllvsLPT" "AllvsSPT" "AllvsMPA" "AllvsLPA"};
    violinplot(percentageMat, CATEGORYNAMES,'ViolinColor',[1,0,0],'width', 0.3, 'violinalpha', 0.8, 'ShowData', false) 
     xlabel("Generation Focus")
     ylabel("Resources Usage Percentage")