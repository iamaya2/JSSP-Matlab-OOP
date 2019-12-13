classdef JSSPJob < handle
    properties       
        activities
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
                jobObj.activities = JSSPActivity(machIDs,procTimes);
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