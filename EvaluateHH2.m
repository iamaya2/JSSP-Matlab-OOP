function [performanceData,HH2Rules] = EvaluateHH2(nbFeatures, nbSolvers, HH2, instances, HHs,AllRulesHHs,HH2Rules)
profit=0;
for x=1:size(instances,2)

    
    Heuristic_selector = [1 2 3 4 5 6 7 8 9 10];
    HH2Rules_All= [HH2Rules Heuristic_selector'];
    instances(x) = instances(x).reset();
    HH2.solveInstance(instances(x),HH2Rules, HH2Rules_All, AllRulesHHs, HHs);

    profit(x)= instances(x).fprofit;
end
    performanceData = profit;
end 

