classdef JSSPInstance < handle
    % ----- ---------------------------------------------------- -----
    %                       Properties
    % ----- ---------------------------------------------------- -----
    properties
        nbJobs
        nbMachines
        status = 'Undefined';
        solution
        instanceData = JSSPJob();
        pendingData = JSSPJob();
        features = 'Not yet implemented. Should be updated with empty feature vector';        
    end
    
    properties (Dependent)
        upcomingActivities
    end
    
    % ----- ---------------------------------------------------- -----
    %                       Methods
    % ----- ---------------------------------------------------- -----
    methods
        % ----- ---------------------------------------------------- -----
        % Constructor
        % ----- ---------------------------------------------------- -----
        function instance = JSSPInstance(instanceData)
            % Function for creating the instance object
            % instanceData: nbJobs*nbMachines*2 array. First layer:
            % Processing times. Second layer: Machine sequence
            if nargin > 0
                [instance.nbJobs, instance.nbMachines] = size(instanceData(:,:,1));
                instance.instanceData(instance.nbJobs) = ...
                    JSSPJob(instanceData(end,:,2),instanceData(end,:,1),instance.nbJobs);
                instance.pendingData(instance.nbJobs) = ...
                    JSSPJob(instanceData(end,:,2),instanceData(end,:,1),instance.nbJobs);
                for idx = 1 : instance.nbJobs-1
                    instance.instanceData(idx) = ...
                        JSSPJob(instanceData(idx,:,2),instanceData(idx,:,1),idx);
                    instance.pendingData(idx) = ...
                        JSSPJob(instanceData(idx,:,2),instanceData(idx,:,1),idx);
                end
                instance.status = 'Pending';
                instance.solution = JSSPSchedule(instance.nbMachines);                
            end
        end
        
        % ----- ---------------------------------------------------- -----
        % Job scheduler
        % ----- ---------------------------------------------------- -----
        function scheduleJob(obj, jobID)
        end
        
        % ----- ---------------------------------------------------- -----
        % Methods for overloading functionality
        % ----- ---------------------------------------------------- -----
        function plot(obj, varargin)
            disp('Not yet implemented...')
        end
        
%         function disp(obj, varargin)
%             disp('Not yet implemented...')
%         end

        % ----- ---------------------------------------------------- -----
        % Methods for dependent properties
        % ----- ---------------------------------------------------- -----
        function activities = get.upcomingActivities(obj)
            activities(obj.nbJobs) = obj.pendingData(end).activities(1);
            for idx = 1 : obj.nbJobs-1
                activities(idx) = obj.pendingData(idx).activities(1);
            end
        end
    end
end