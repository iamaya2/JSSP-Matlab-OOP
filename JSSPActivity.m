 %%This class creates activity objects
 % These objects created have to vectors of the same lenght, one with the schedule in terms of
 %machines (machine ID) and other with the processing times of the
 %operations to be processed in those machines (processingTime).
classdef JSSPActivity < handle
    properties
        machineID %This property contains a vector with the order in which machines will be scheduled
        processingTime %This property contains a vector with the processing times of the operations within every job
    end
    
    methods
        function activityObj = JSSPActivity(machID, procTime)
            %This function inherit the machID from heuristics methods and
            %the processing time from the instance.
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