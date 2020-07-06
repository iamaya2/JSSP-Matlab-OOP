function[FeatureValue] = Mirsh15(JSSPInstance)
 InstanceData=JSSPInstance.rawInstanceData;
 for c=1:JSSPInstance.nbJobs
     subJPT=0;
            for d=1:JSSPInstance.nbMachines
                subJPT=subJPT+InstanceData(c,d,1);
            end
     JPT(c)=subJPT;
 end
      FeatureValue=(std(JPT)/mean(JPT));  

end