folder="ConfirmatoryStage/PruebasFeatures/NormalizedFeatures/PerformanceData/";
featID=[1 2 3 4 5]; 
featureID=featureIDrepository(featID); 
objective=["0" "0.25" "0.5" "0.75" "1"];
objective2=[0 0.25 0.5 0.75 1];
epsilon=0.0001;
for f=1:length(featID) 
   featureID=featureIDrepository(featID(f)); 
   
   for o=1:length(objective) 
       address=folder+"Feature_"+featureID+"_"+objective(o)+".mat";
       load(address)
       matrix=importdata(address);
       isum=0;
       target=denormalizeFeature(objective2(o),featID(f)); 
       for x=1:100      
          isum = isum + (target-matrix(x))^2;
       end
       successMatrix(f,o)=isum; 
   end
end
disp(successMatrix)