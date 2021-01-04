function []= hypMatrixtoViolin_AllFeatures(folder) 
    global hypMatrix_concat
    timeRanges=[0 10];
    nbJobsV = [3];
    nbMachinesV = [4];
    featureID=[1 2 3 4 5];
    
    
    for x=1:length(featureID)
    
    
        featID = featureIDrepository(featureID(x)); 
        addressID = "Feature_"+featID; 
        
        addpath(genpath(folder))
 
        address= addressID+".mat";
        hypMatrix=importdata(address); 
            
   
        hypMatrix_concat(:,x)= hypMatrix(:,1);
    end
    disp("Mean")
    hypMatrix_mean= mean(hypMatrix_concat)
      disp("Median")
    hypMatrix_median=median(hypMatrix_concat)
    
  
    CATEGORYNAMES = {"Mirsh175" "Mirsh15" "Mirsh29" "Mirsh289" "Mirsh95"};
%     violinplot(hypMatrix_concat, CATEGORYNAMES,'ViolinColor',[1,0,0],'width', 0.3, 'violinalpha', 0.3, 'ShowData', false) 
    

     boxplot(hypMatrix_concat) 
   xlabel("Features")
   ylabel("Obtained Value")
   
end




