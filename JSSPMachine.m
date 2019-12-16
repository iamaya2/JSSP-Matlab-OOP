classdef JSSPMachine < handle
    properties
        activities = JSSPActivity;
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
            ranges = [0 obj.activities(:).endTime; obj.activities(:).startTime obj.makespan];
        end
        
        function makespan = get.makespan(obj)
            makespan = obj.activities(end).endTime;
        end
    end
end