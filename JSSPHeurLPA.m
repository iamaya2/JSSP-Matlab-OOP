function [NextActivity] = JSSPHeurLPA (instance)
for x=1:size(instance.pendingData,2)
    remainingAct(x) = size(instance.pendingData(x).activities,2);
end
[~,NextActivity]=min(remainingAct);
end