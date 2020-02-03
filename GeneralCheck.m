function [performanceMatrix] = GeneralCheck(folder,heurID1, heurID2, population)

nbJobsV = [3]; %number of jobs desired
nbMachinesV = [4]; %number of machines desired
selfconf = [2.5]; %Self Confidence Factor to evaluate 
globalconf = [2.5]; %Global Confidence Factor to evaluate
unifyfactor = [0.5]; %Unifying Factor 
nbRep = 30; %Number of instances per combination
timeRanges = [0 10];
folder2 = pwd;

%Convert numeric heurID to a three letter heurID
    if heurID1 == 1 
        heuristicID1 = "LPT"; 
    elseif heurID1 == 2 
        heuristicID1 = "SPT";
    elseif heurID1 == 3
        heuristicID1 = "MPA"; 
    elseif heurID1 == 4
        heuristicID1 = "LPA";
    end
    
    if heurID2 == 1 
        heuristicID2 = "LPT"; 
    elseif heurID2 == 2 
        heuristicID2 = "SPT";
    elseif heurID2 == 3
        heuristicID2 = "MPA"; 
    elseif heurID2 == 4
        heuristicID2 = "LPA";
    end

addressSize = heuristicID1+"vs"+heuristicID2+"_Small";
addressPop = addressSize+"_pop"+num2str(population);
for sc=1:length(selfconf)
    addressSC = addressPop+"_SC"+num2str(selfconf(sc));
    
    for gc=1:length(globalconf);
        addressGC = addressSC+"_GC"+num2str(globalconf(gc));
        
        for uf=1:length(unifyfactor);
            addressUF = addressGC+"_UF"+num2str(unifyfactor(uf));
            for NB=1:nbRep;
                oldfolder= cd(folder2);
               PathAddress = char(folder+"\"+addressSize+"\"+addressPop+"\"+addressSC+"\"+addressGC+"\"+addressUF+"\");
%                "\JSSPInstanceJ"+num2str(nbJobsV(1))+"M"+num2str(nbMachinesV(1))+"T1"+num2str(timeRanges(1)) ...
%                 +"T2"+num2str(timeRanges(2))+"Rep"+num2str(nb)+heuristicID1+"vs"+heuristicID2+".mat");
             address= char("JSSPInstanceJ"+num2str(nbJobsV(1))+"M"+num2str(nbMachinesV(1))+"T1"+num2str(timeRanges(1)) ...
                 +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+heuristicID1+"vs"+heuristicID2+".mat");
%              oldfolder = cd('GeneratedInstances');
%              oldfolder = cd(addressSize);
%              oldfolder = cd(addressPop);
%              oldfolder = cd(addressSC);
%              oldfolder = cd(addressGC);
%              oldfolder = cd(addressUF);
             cell = {};
%               addpath(genpath('GeneratedInstances\' addressSize '\' addressPop '\'));
                addpath(genpath(PathAddress));
              load(address)
              a=nan; 
               %oldfolder= cd(folder2);
              status = singlecheck(cell, heurID1, heurID2);
              if status == true 
                  hypMatrix(NB, uf, gc, sc) = cell{2};
              else 
                 disp(addressPop);
                 disp(addressSC);
                 disp(addressGC);
                 disp(addressUF); 
                 disp(NB); 
                 hypMatrix(NB, uf, gc, sc) = nan;
                 error("Dismatched Performance Value") 
              end
              
             %disp(address)
             %a=cell{2};
             %disp(a)
             
            end
        end
    end
end
     oldfolder= cd(folder2);
     save(addressPop, 'hypMatrix')
     performanceMatrix = hypMatrix;
end
    
        


%load('C:\Users\nufo\Documents\GitHub\JSSP-Matlab-OOP\GeneratedInstances\LPAvsMPA_Small\LPAvsMPA_Small_pop10\LPAvsMPA_Small_pop10_SC0.5\LPAvsMPA_Small_pop10_SC0.5_GC0.5\LPAvsMPA_Small_pop10_SC0.5_GC0.5_UF0.1\JSSPInstanceJ3M4T7T210Rep1LPAvsMPA.mat')