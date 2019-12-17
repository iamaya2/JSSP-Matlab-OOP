classdef JSSPJob < handle
    properties       
        activities = JSSPActivity(nan,nan); % The activities to schedule (the order of machines to be scheduled and the processing times of the operations performed by each machine)
        jobID = nan; 
        lastScheduledActivity
        lastScheduledTime = 0;
    end
    
    properties (Dependent)
        nbActivities        
    end
    
    methods
        function jobObj = JSSPJob(machIDs, procTimes, jobID) 
            %This function receives machIDs and procTimes from the class
            %object JSSPActivity
            if nargin > 0        
                nbAct = length(machIDs); 
                jobObj.activities(nbAct) = JSSPActivity(machIDs(end),procTimes(end)); 
                for idx = 1 : nbAct-1
                    %This loop will save in the object Job the activities
                    %to process (the machine to schedule and the time it
                    %will be operating)
                    jobObj.activities(idx) = JSSPActivity(machIDs(idx),procTimes(idx));
%                     jobObj.activities(idx).machineID = machID(idx);
%                     jobObj.activities(idx).processingTime = procTime(idx);                
                end                
%                 jobObj.activities = JSSPActivity(machIDs,procTimes);
                jobObj.jobID = jobID; %The order in which jobs will be scheduled
            end
        end
        
        function poppedActivity = popActivity(obj)
            %This function sets the next activity to be scheduled and
            %eliminates it from the agenda. 
            poppedActivity = obj.activities(1);
            obj.activities = obj.activities(2:end);
        end
        
        function updateLastActivity(obj, activity, timeslot)
            obj.lastScheduledActivity = activity;
            obj.lastScheduledTime = timeslot;
        end
        
        function nbActivities = get.nbActivities(obj)
            %Number of activities to schedule
            nbActivities = length(obj.activities);
        end
        
        
    end
end