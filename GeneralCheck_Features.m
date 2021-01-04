function [performanceMatrix] = GeneralCheck_Features(folder,featureID, varargin)

folder2 = pwd;

nbJobs = 3;
nbMachines = 4;
nbRep = 100;
timeRanges = [0 10];

if nargin == 3, targetValue = varargin{1}; end


%Convert numeric featureID to a "MirshXX" Code
featID = featureIDrepository(featureID); 

addressID = "Feature_"+featID; 
    

      
        
            for NB=1:nbRep;
%                 oldfolder= cd(folder2);
%                 oldfolder=cd(folder);
                if nargin == 3
                    PathAddress = char(folder2+"\"+folder+"\"+addressID+"\"+num2str(targetValue)+"\");
                else
                    PathAddress = char(folder2+"\"+folder+"\"+addressID+"\");
                end
               address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
                    +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+"featureID_"+featID+".mat");
               
%            
                JSSPInstance = {};
                addpath(genpath(PathAddress))
%                 oldfolder=cd(PathAddress);
                load(address)
%                 oldfolder= cd(folder2);
           
                
                perfDataMatrix(NB,1) = JSSPInstance{2};
                
             
            
            end
    if nargin == 3
        filename=[addressID+"_"+num2str(targetValue)+".mat"]
    else
        filename=[addressID+".mat"]
    end
     %oldfolder= cd(folder2);
         save(filename, 'perfDataMatrix');
     performanceMatrix = perfDataMatrix;
     rmpath(genpath(PathAddress))
     nan=0;
end
    
        


