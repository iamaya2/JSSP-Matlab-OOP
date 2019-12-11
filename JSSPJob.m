classdef JSSPJob
    properties       
        activities
    end
    
    properties (Dependent)
        nbActivities        
    end
    
    methods
        function jobObj = JSSPJob(machIDs, procTimes)
            if nargin > 0                
                jobObj.activities = JSSPActivity(machIDs,procTimes);
            end
        end
        
        function nbActivities = get.nbActivities(obj)
            nbActivities = length(obj.activities);
        end
        
        
    end
end