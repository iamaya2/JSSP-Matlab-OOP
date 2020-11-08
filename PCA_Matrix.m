nbJobs = 10;
nbMachines = 10;
timeRanges = [0 100];
nbInstances = 30;
count=1;
heurID=[1 2 3 4 1 2 3 4];
objective=[1 1 1 1 2 2 2 2];

folder2=pwd; 
folder1="ConfirmatoryStage/ConfirmatoryInstances";
for x=1:length(heurID)
    
 heuristicID=heurIDrepository(heurID(x));
 
 if objective(x)==1 
     PathAddress = char(folder2+"\"+folder1+"\"+heuristicID+"vsAll_J10xM10");
 elseif objective(x)==2
     PathAddress = char(folder2+"\"+folder1+"\"+"Allvs"+heuristicID+"_J10xM10");
 end
     addpath(genpath(PathAddress))
     
    for NB=1:nbInstances
        
                if objective(x) == 1
                    address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
                    +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+heuristicID+"vsAll.mat");
                elseif objective(x) == 2
                    address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
                    +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+"Allvs"+heuristicID +".mat");
                end
        
                
                JSSPInstance = {};
                load(address)
                PCAMatrix(count,1)= Mirsh175(JSSPInstance{1});
                PCAMatrix(count,2)= Mirsh15(JSSPInstance{1});
                PCAMatrix(count,3)= Mirsh29(JSSPInstance{1});
                PCAMatrix(count,4)= Mirsh282(JSSPInstance{1});
                PCAMatrix(count,5)= Mirsh95(JSSPInstance{1});
                
                count=count+1;
    end
    rmpath(genpath(PathAddress))
    
end
                