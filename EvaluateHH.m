function [performanceData] = EvaluateHH(generatedRules,HH, instances)
profit = 0;
for x=1:size(instances,2)

   

    Heuristic_selector = ["MaxProfit" "MinWeight" "ProfitWeightRatio" "Markovitz"];
    HHRules= [generatedRules Heuristic_selector'];
    instances(x) = instances(x).reset();
    HH.solveInstance(instances(x), generatedRules,HHRules);

    profit= profit + instances(x).fprofit;
end
    performanceData = profit;
end 
