classdef JSSPActivity < handle
    properties
        machineID
        processingTime
    end
    
    methods
        function activityObj = JSSPActivity(machID, procTime)
            if nargin > 0
                nbAct = length(machID);
                activityObj(nbAct) = activityObj;
                for idx = 1 : nbAct
                    activityObj(idx) = activityObj;
                    activityObj(idx).machineID = machID(idx);
                    activityObj(idx).processingTime = procTime(idx);                
                end                
            end
        end
    end
end