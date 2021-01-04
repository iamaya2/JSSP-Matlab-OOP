folder="ConfirmatoryStage/ConfirmatoryInstances";
nbMachines=10;
nbJobs=10;
nbRep=30;
timeRanges=[0 100];
objective=2;
HeurID=1;
heuristicID=heurIDrepository(HeurID);

 if objective == 1 
        addressID = heuristicID + "vsAll_J" + num2str(nbJobs) + "xM" + num2str(nbMachines);
 elseif objective == 2 
        addressID =  "Allvs" + heuristicID + "_J" + num2str(nbJobs) + "xM" + num2str(nbMachines);
 end
 
 InstanceFolder=folder+"/"+addressID;
 addpath(genpath(InstanceFolder)) 
 
for NB=1:nbRep
 
                if objective == 1
                    address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
                    +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+heuristicID+"vsAll.mat");
                elseif objective == 2
                    address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
                    +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+"Allvs"+heuristicID +".mat");
                end
 
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
 

 save(addressID, 'percentageVector');
 rmpath(genpath(InstanceFolder))
 
      