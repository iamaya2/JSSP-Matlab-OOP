function []= scatterPlot_2Features_Features(folder, featureID1,featureID2, target)
nbJobs = 3;
nbMachines = 4;
timeRanges = [0 10];
nbInstances = 100; %Change when calling the function if needed
% if nargin == 6, nbInstances = varargin{1}; end

% Convert numeric heurID to a three letter heurID
%     if heurID == 1 
%         heuristicID = "LPT"; 
%     elseif heurID == 2 
%         heuristicID = "SPT";
%     elseif heurID == 3
%         heuristicID = "MPA"; 
%     elseif heurID == 4
%         heuristicID = "LPA";
%     end
    
folder2 =pwd; %saving current folder
featID1 = featureIDrepository(featureID1); % getting feature code name with feature number 
featID2 = featureIDrepository(featureID2); 

  for NB=1:nbInstances;

               
               
                  PathAddress = char(folder2+"\"+folder+"\");
              
%                if objective == 1
%                     address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
%                     +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+heuristicID+"vsAll.mat");
%                 elseif objective == 2
%                     address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
%                     +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+"Allvs"+heuristicID +".mat");
%                 end
               address=char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
                    +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+"featureID_"+featID1+".mat");
           
                JSSPInstance = {};
                addpath(genpath(PathAddress))
           
                load(address)
                
                if featureID1 == 1
                    FeatMatrix(NB,1) = normalizeFeature(Mirsh175(JSSPInstance{1}),1);
                elseif featureID1 ==2
                    FeatMatrix(NB,1) = normalizeFeature(Mirsh15(JSSPInstance{1}),2);
                elseif featureID1 ==3
                    FeatMatrix(NB,1) = normalizeFeature(Mirsh29(JSSPInstance{1}),3);
                elseif featureID1 ==4
                    FeatMatrix(NB,1) = normalizeFeature(Mirsh282(JSSPInstance{1}),4);   
                elseif featureID1 ==5
                    FeatMatrix(NB,1) = normalizeFeature(Mirsh95(JSSPInstance{1}),5);
                end
                
                if featureID2 == 1
                    FeatMatrix(NB,2) = normalizeFeature(Mirsh175(JSSPInstance{1}),1);
                elseif featureID2 ==2
                    FeatMatrix(NB,2) = normalizeFeature(Mirsh15(JSSPInstance{1}),2);
                elseif featureID2 ==3
                    FeatMatrix(NB,2) = normalizeFeature(Mirsh29(JSSPInstance{1}),3);
                elseif featureID2 ==4
                    FeatMatrix(NB,2) = normalizeFeature(Mirsh282(JSSPInstance{1}),4);   
                elseif featureID2 ==5
                    FeatMatrix(NB,2) =normalizeFeature(Mirsh95(JSSPInstance{1}),5); 
                end
                FeatMatrix(NB,3)= -JSSPInstance{2};
  end
  
  x= FeatMatrix(:,1);
  y= FeatMatrix(:,2);
%sz = FeatMatrix(:,3);
 sz=300;
  if featureID1==1 
      symbol="^";
  elseif featureID1==2 
      symbol="s";
  elseif featureID1==3
      symbol="o";
  elseif featureID1==4 
      symbol="d"; 
  elseif featureID1==5 
      symbol="p"; 
  end
  
  if target==0 
      color =[0 1 0];
  elseif target==0.25
      color =[0.5 1 0];
  elseif target==0.5
      color =[1 1 0];
  elseif target==0.75
      color =[1 0.5 0];
  elseif target==1
      color = [1 0 0];     
  end   
%   if objective==1 
%       symbol='s';
%   elseif objective ==2 
%       symbol='o';
%   end
%   
%   if heurID==1 
%       color =[1 1 0]; 
%   elseif heurID==2
%       color =[0 1 0]; 
%   elseif heurID==3 
%       color =[1 0 0];
%   elseif heurID==4 
%       color =[0 0 1];
%   end 
  scatter(x,y,sz,symbol,"filled",'MarkerEdgeColor',[0 1 0],'MarkerFaceColor',color,'MarkerFaceAlpha', 0.5)
  %plot(x,y,'bd','Markersize',15); %50,[1,0,0],"filled")
   xlabel(featID1)
   ylabel(featID2)
  
%    figure

  
    rmpath(genpath(PathAddress))
end