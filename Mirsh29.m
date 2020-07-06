function[FeatureValue] = Mirsh29(JSSPInstance)
 InstanceData=JSSPInstance.rawInstanceData;

 for a=1:JSSPInstance.nbMachines
     subMPT=0;
     for c=1:JSSPInstance.nbJobs
                     for d=1:JSSPInstance.nbMachines
                            if InstanceData(c,d,2)==a 
                                subMPT=subMPT+ InstanceData(c,d,1);
                            end    
                     end
  
     end
     MPT(a)=subMPT;
 end
          FeatureValue=(std(MPT)/mean(MPT));  

end