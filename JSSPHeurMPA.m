function [NextActivity] = JSSPHeurMPA (instance)
for x=1:size(instance.pendingData,2)
    remainingAct(x) = size(instance.pendingData(x).activities,2);
end
[~,NextActivity]=max(remainingAct);
end 