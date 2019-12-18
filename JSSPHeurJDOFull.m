% Jobs in Descending Order Heuristic (JSSP)
function [fitness] = JSSPHeurJDOFull (JSSPInstanceData)
nbJobs = JSSPInstanceData.nbJobs;
for idx = nbJobs : -1 : 1 % Schedules from last to first
    for idy = 1 : length(JSSPInstanceData.instanceData(idx).activities)
        JSSPInstanceData.scheduleJob(idx); % Replace with real heuristic
    end
end
fitness = JSSPInstanceData.solution.makespan;
end