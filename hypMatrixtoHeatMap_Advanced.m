heuristicID=["LPT" "LPT" "SPT" "SPT" "MPA" "MPA" "LPA" "LPA"];
Objective=[1 2 1 2 1 2 1 2];
nbJobsV=[3];
nbMachinesV=[4];
folder="HyperMatrix_Advanced";
folder2 = pwd;
oldfolder=cd(folder);    
for x=1:length(heuristicID) 
   
     if Objective(x) == 1  
        address =heuristicID(x) +"vsAll_"+"J"+num2str(nbJobsV(1))+"xM"+num2str(nbMachinesV(1)+".mat");
    elseif Objective(x) == 2 
        address ="Allvs"+heuristicID(x)+"_J"+num2str(nbJobsV(1))+"xM"+num2str(nbMachinesV(1)+".mat");
     end
    
      hypMatrix=importdata(address);
      hypMatrix_Inv=(hypMatrix*-1)';
      hypMatrix_concat(:,x)=hypMatrix_Inv(:);
end
oldfolder=cd(folder2);    
%a=heatmap(hypMatrix_concat) 
 CATEGORYNAMES = {"1" "2" "3" "4" "5" "6" "7" "8"};
     violinplot(hypMatrix_concat,CATEGORYNAMES,'ViolinColor',[1,0,0],'width', 0.3, 'violinalpha', 0.3, 'ShowData', false) 
  hold on
     
 heuristicID=["LPT" "LPT" "SPT" "SPT" "MPA" "MPA" "LPA" "LPA"];
Objective=[1 2 1 2 1 2 1 2];
nbJobsV=[3];
nbMachinesV=[4];
folder="HyperMatrix_Advanced2";
oldfolder=cd(folder2);
oldfolder=cd(folder);    
for x=1:length(heuristicID) 
   
     if Objective(x) == 1  
        address =heuristicID(x) +"vsAll_"+"J"+num2str(nbJobsV(1))+"xM"+num2str(nbMachinesV(1)+".mat");
    elseif Objective(x) == 2 
        address ="Allvs"+heuristicID(x)+"_J"+num2str(nbJobsV(1))+"xM"+num2str(nbMachinesV(1)+".mat");
     end
    
      hypMatrix=importdata(address);
      hypMatrix_Inv=(hypMatrix*-1)';
      hypMatrix_concat2(:,x)=hypMatrix_Inv(:);
end
oldfolder=cd(folder2);    
%a=heatmap(hypMatrix_concat) 
 CATEGORYNAMES = {"1" "2" "3" "4" "5" "6" "7" "8"};
     violinplot(hypMatrix_concat2, CATEGORYNAMES, 'ViolinColor',[0,0,1],'width', 0.3, 'violinalpha', 0.3, 'ShowData', false)     
% hist(hypMatrix_concat(1,:))