nbFeatures = 9;
nbSolvers=4;
nbRules=4;
FeatureRanges=[0 1];

instances= create_instances("training.txt", "KPInstances/Training_Instances/");
nbInstances =size(instances,2) ;
nbHHs = 1;


for i=1:nbHHs
  
   singleHH=ruleBasedSelectionHH(nbRules,nbFeatures,nbSolvers)
   
fh = @(x)EvaluateUPSOtoHH(x, nbFeatures, nbSolvers, singleHH, instances); % Objective function for UPSO, 
flim = [repmat(FeatureRanges,nbFeatures*nbSolvers,1)]; % 
properties = struct('visualMode',false, 'verboseMode', true, ...
                'populationSize', 3, 'maxIter', 50, 'maxStagIter', 100, ...
                'selfConf', 2.5, 'globalConf', 2.5, 'unifyFactor', 0.5);
    

 [position] = UPSO2(fh, flim, properties);
 [performanceData, HHRules,generatedRules] =EvaluateUPSOtoHH(position,nbFeatures, nbSolvers, singleHH, instances);
 
 
 newHH{i,1} = generatedRules(:,:);
 newHH{i,2} = performanceData;
 
 
 
 
 
end


