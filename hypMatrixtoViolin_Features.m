function []= hypMatrixtoViolin_Features(folder, featureID, targetValues, varargin) 
    global hypMatrix_concat
    timeRanges=[0 10];
    nbJobsV = [3];
    nbMachinesV = [4];
    featID = featureIDrepository(featureID); 
    addressID = "Feature_"+featID; 
    if nargin ==4,  NormValue=varargin{1}; end
 
    
    folder2 = pwd;
    oldfolder=cd(folder); 
    %oldfolder=cd(addressID);
   
    for x=1:length(targetValues)
        
        address= addressID+"_"+num2str(targetValues(x))+".mat";
        hypMatrix=importdata(address); 
        Matrix2= hypMatrix./NormValue;
        Matrix=((hypMatrix./NormValue)-targetValues(x)).^2; 
       
   
        hypMatrix_concat(:,x)= Matrix(:,1);
        hypMatrix_concat2(:,x)=Matrix2(:,1);
    end
    disp("Mean")
    hypMatrix_mean= mean(hypMatrix_concat)
      disp("Median")
    hypMatrix_median=median(hypMatrix_concat)
    
    cd(folder2)
    CATEGORYNAMES = {num2str(targetValues(1)) num2str(targetValues(2)) num2str(targetValues(3)) num2str(targetValues(4)) num2str(targetValues(5))};
    violinplot(hypMatrix_concat, CATEGORYNAMES,'width', 0.3, 'violinalpha', 0.8, 'ShowData', false) 
    

     %boxplot(hypMatrix_concat) 
   xlabel("Target Values")
    ylabel("Squared error between Target Value and Obtained Value")
    
    
    figure
    CATEGORYNAMES = {num2str(targetValues(1)) num2str(targetValues(2)) num2str(targetValues(3)) num2str(targetValues(4)) num2str(targetValues(5))};
    violinplot(hypMatrix_concat2, CATEGORYNAMES,'width', 0.3, 'violinalpha', 0.8, 'ShowData', false) 
    

     %boxplot(hypMatrix_concat) 
   xlabel("Target Values")
    ylabel("Normalized Feature Value")
    oldfolder=cd(folder2); 
end




