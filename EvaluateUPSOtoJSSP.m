%% Code for assessing fitness of UPSO values as a JSSP instance
% UPSO works with a column array. The first n elements are processing time
% values, while the next n values are machine orderings
function performanceData = EvaluateUPSOtoJSSP(UPSOArray, nbJobs)
JSSPInstanceData = UPSOtoJSSP(UPSOArray, nbJobs); % Translate
JSSPInstanceData2 = UPSOtoJSSP(UPSOArray, nbJobs); % Temp... just for testing
% Solve
for idx = 1 : nbJobs % Schedules from first to last
    for idy = 1 : length(JSSPInstanceData.instanceData(idx).activities)
        JSSPInstanceData.scheduleJob(idx); % Replace with real heuristic
    end
end

for idx = nbJobs : -1 : 1 % Schedules from last to first
    for idy = 1 : length(JSSPInstanceData.instanceData(idx).activities)
        JSSPInstanceData2.scheduleJob(idx); % Replace with real heuristic
    end
end

% Evaluate performance
performanceData = JSSPInstanceData.solution.makespan - JSSPInstanceData2.solution.makespan;

% For debugging
JSSPInstanceData.plot
JSSPInstanceData2.plot
end