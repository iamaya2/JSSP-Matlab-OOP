nbFeatures = 9;
nbSolvers=10;
nbRules=10;
FeatureRanges=[0 1];
AllRulesHHs =AllRules;
HHs=HHs;
instances= create_instances("training.txt", "KPInstances/Training_Instances/");
nbInstances =size(instances,2) ;
nbHH2s = 1;
%instances=instances(1)
%%
for i=1:nbHH2s
  
   singleHH2=ruleBasedSelectionHH2(nbRules,nbFeatures,nbSolvers)
   
fh = @(x)EvaluateUPSOtoHH2(x, nbFeatures, nbSolvers, singleHH2, instances,HHs,AllRulesHHs); % Objective function for UPSO, 
flim = [repmat(FeatureRanges,nbFeatures*nbSolvers,1)]; % 
properties = struct('visualMode',false, 'verboseMode', true, ...
                'populationSize', 15, 'maxIter', 10, 'maxStagIter', 100, ...
                'selfConf', 2.5, 'globalConf', 0.1, 'unifyFactor', 0.5);
    

 [position] = UPSO2(fh, flim, properties);
 [performanceData, HH2Rules] =EvaluateUPSOtoHH2(position,nbFeatures, nbSolvers, singleHH2, instances, HHs, AllRules);
 
 
 newHH2{i,1} = HH2Rules(:,:);
 newHH2{i,2} = -performanceData;
 
 
 
 
 
end


