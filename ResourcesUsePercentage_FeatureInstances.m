folder="ConfirmatoryStage/PruebasFeatures/NormalizedFeatures/";
nbMachines=4;
nbJobs=3;
nbRep=100;
timeRanges=[0 10];
objective=[0 0.25 0.5 0.75 1]; 
FeatID=5;
featureID=featureIDrepository(FeatID);
addressID = "Feature_"+featureID;
for o=1:length(objective)
    
 
 InstanceFolder=folder+addressID+"/"+num2str(objective(o));
 addpath(genpath(InstanceFolder)) 
 
    for NB=1:nbRep
 
        
                    address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
                    +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+"featureID_"+featureID+".mat");
              
 
          JSSPInstance={};
          load(address)
          MachineMat=JSSPInstance{1}.rawInstanceData(:,:,2);
          iCount=0;
        for n=1:nbMachines 
            iNum=0;
            for j=1:nbJobs
                for m=1:nbMachines
                    if MachineMat(j,m)==n
                        iNum=1;
                        break
                    end 
                end
                if MachineMat(j,m)==n
                        iNum=1;
                        break
                end
            end
            if iNum>0 
                iCount=iCount+1;
            end
        end
 percentageVector(NB)=iCount/nbMachines;
end
 objective2=["0" "025" "050" "075" "1"];
filename=addressID+"_"+objective2(o);
 save(filename, 'percentageVector');
 rmpath(genpath(InstanceFolder))

end
      