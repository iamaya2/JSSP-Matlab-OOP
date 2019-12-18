% Jobs in Ascending Order Heuristic (JSSP)
function [fitness] = JSSPHeurJAOFull (JSSPInstanceData)
nbJobs = JSSPInstanceData.nbJobs;
for idx = 1 : nbJobs % Schedules from first to last
    for idy = 1 : length(JSSPInstanceData.instanceData(idx).activities)
        JSSPInstanceData.scheduleJob(idx); % Replace with real heuristic
    end
end
fitness = JSSPInstanceData.solution.makespan;
end