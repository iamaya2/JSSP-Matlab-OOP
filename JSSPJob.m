classdef JSSPJob < handle
    properties       
        activities = JSSPActivity(nan,nan);
        jobID = nan;
        lastScheduledActivity
        lastScheduledTime = 1;
    end
    
    properties (Dependent)
        nbActivities        
    end
    
    methods
        function jobObj = JSSPJob(machIDs, procTimes, jobID)
            if nargin > 0        
                nbAct = length(machIDs);
                jobObj.activities(nbAct) = JSSPActivity(machIDs(end),procTimes(end));
                for idx = 1 : nbAct-1
                    jobObj.activities(idx) = JSSPActivity(machIDs(idx),procTimes(idx));
%                     jobObj.activities(idx).machineID = machID(idx);
%                     jobObj.activities(idx).processingTime = procTime(idx);                
                end                
%                 jobObj.activities = JSSPActivity(machIDs,procTimes);
                jobObj.jobID = jobID;
            end
        end
        
        function poppedActivity = popActivity(obj)
            poppedActivity = obj.activities(1);
            obj.activities = obj.activities(2:end);
        end
        
        function updateLastActivity(obj, activity, timeslot)
            obj.lastScheduledActivity = activity;
            obj.lastScheduledTime = timeslot;
        end
        
        function nbActivities = get.nbActivities(obj)
            nbActivities = length(obj.activities);
        end
        
        
    end
end