classdef JSSPMachine < handle
    properties
        activities = JSSPActivity;
        jobList
    end
    
    properties (Dependent)
        emptyRangeInMachine
        makespan
    end
    
    methods
        function obj = JSSPMachine()
            % Empty on purpose
            % Machine initializes to default values
        end
        
        function ranges = get.emptyRangeInMachine(obj)
            ranges = [0 sort([obj.activities(:).endTime]); sort([obj.activities(:).startTime]) obj.makespan];
        end
        
        function makespan = get.makespan(obj)
            makespan = max([obj.activities.endTime]);
        end
    end
end