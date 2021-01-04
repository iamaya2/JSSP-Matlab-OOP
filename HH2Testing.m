nbFeatures = 9;
nbSolvers=10;
nbRules=10;
AllRulesHHs =AllRules;
HHs=HHs;
instances= create_instances("test_B.txt", "KPInstances/Test_Instances_B/");
nbInstances =size(instances,2) ;
HH2Rules = newHH2{1};
singleHH2=ruleBasedSelectionHH2(nbRules,nbFeatures,nbSolvers)
%%
[performanceData, HH2Rules] =EvaluateHH2(nbFeatures, nbSolvers, singleHH2, instances, HHs, AllRules,HH2Rules);
