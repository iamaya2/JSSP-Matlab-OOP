folder="ConfirmatoryStage/PruebasFeatures/NormalizedFeatures/UsodeRecursos";
addpath(genpath(folder))
featID=5;
objectiveV=["0" "025" "050" "075" "1"];

for x=1:length(objectiveV)
    
    featureID=featureIDrepository(featID);
    objective=objectiveV(x);
 addressID="Feature_"+featureID+"_"+objectiveV(x);
    
 load(addressID)
percentageVectorT=percentageVector';
percentageMat(:,x)=percentageVectorT;
 
end

CATEGORYNAMES = {"0" "0.25" "0.50" "0.75" "1"};
    violinplot(percentageMat, CATEGORYNAMES,'ViolinColor',[1,0,0],'width', 0.3, 'violinalpha', 0.8, 'ShowData', false) 
     xlabel("Generation Focus")
     ylabel("Resources Usage Percentage")