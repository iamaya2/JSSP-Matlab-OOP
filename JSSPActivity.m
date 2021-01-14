classdef JSSPActivity < handle
    % JSSPActivity   Class for creating activity objects
    %  Each object of this class represents a component (task) that must be
    %  carried out in order to complete a job of the JSSP instance. So, it
    %  contains information about the activity itself and about the machine
    %  where it must be scheduled.
    %
    %  JSSPActivity Properties:
    %   machineID - Information about the machine (its ID) where the
    %   activity must be scheduled.
    %   processingTime - 
    %
    %  JSSPActivity Methods:
    %
    %  These objects created have to vectors of the same lenght, one with the schedule in terms of
    %  machines (machine ID) and other with the processing times of the
    %  operations to be processed in those machines (processingTime).
    %  See also: JSSPJOB, JSSPMACHINE
    properties
        machineID %This property contains a vector with the order in which machines will be scheduled
        processingTime = nan;%This property contains a vector with the processing times of the operations within every job
        isScheduled = false;
        startTime = nan;
    end
    
    properties (Dependent)
        endTime;
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
        
        function endTime = get.endTime(obj)
            endTime = obj.startTime + obj.processingTime;
        end
    end
end