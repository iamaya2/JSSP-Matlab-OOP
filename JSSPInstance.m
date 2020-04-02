% Class definition for creating instances of the JSSP
classdef JSSPInstance < handle
    % ----- ---------------------------------------------------- -----
    %                       Properties
    % ----- ---------------------------------------------------- -----
    properties
        nbJobs
        nbMachines
        status = 'Undefined'; % Instance status. Can be: Undefined (empty), Pending, Solved
        solution % JSSPSchedule object with the current solution
        instanceData = JSSPJob(); % JSSPJob array with the original instance
        pendingData = JSSPJob(); % JSSPJob array with what remains of the instance
        features = 'Not yet implemented. Should be updated with empty feature vector';        
        rawInstanceData
    end
    
    properties (Dependent)
        upcomingActivities % JSSPActivity array with the first activity from each job
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
                [instance.nbJobs, ~] = size(instanceData(:,:,1));
                instance.nbMachines = max(max(instanceData(:,:,2)));
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
                instance.solution = JSSPSchedule(instance.nbMachines, instance.nbJobs);                
                instance.rawInstanceData = instanceData;
            end
        end
        
        % ----- ---------------------------------------------------- -----
        % Job scheduler
        % ----- ---------------------------------------------------- -----
        function scheduleJob(obj, jobID)
            jts = obj.pendingData(jobID); % Job to schedule
            ts = obj.solution.getTimeslot(jts); % Timeslot
            obj.solution.scheduleJob(jts, ts);
            for idx = 1 : length(obj.pendingData)
                if ~isempty(obj.pendingData(idx).activities)
                    return
                end
            end
            obj.status = 'Solved';
            %obj.solution.schedule, [jts.activities.machineID; jts.activities.processingTime], obj.solution.plot();
        end
        
        % ----- ---------------------------------------------------- -----
        % Instance reset
        % ----- ---------------------------------------------------- -----
        function reset(obj)
%             [~, rawInstanceData] = createJSSPInstanceFromInstance(obj);
            for idx = 1 : obj.nbJobs                
                obj.pendingData(idx) = ...
                    JSSPJob(obj.rawInstanceData(idx,:,2),obj.rawInstanceData(idx,:,1),idx);
            end
            obj.status = 'Pending';
            obj.solution = JSSPSchedule(obj.nbMachines, obj.nbJobs);
        end
        
        % ----- ---------------------------------------------------- -----
        % Methods for overloading functionality
        % ----- ---------------------------------------------------- -----
        function plot(obj, varargin)
            disp('Not yet fully implemented...')
            obj.solution.plot()
        end
        
        function disp(obj, varargin)
%             pTimes = nan(obj.nbJobs,obj.nbMachines);
%             mOrder = pTimes;
%             for idx = 1 : obj.nbJobs
%                 pTimes(idx,:) = [obj.instanceData(idx).activities.processingTime];
%                 mOrder(idx,:) = [obj.instanceData(idx).activities.machineID];
%             end
            fprintf('Processing times (P):\n')
            disp(obj.rawInstanceData(:,:,1))
            fprintf('Machine orderings (M):\n')
            disp(obj.rawInstanceData(:,:,2))
        end

        % ----- ---------------------------------------------------- -----
        % Methods for dependent properties
        % ----- ---------------------------------------------------- -----
        function activities = get.upcomingActivities(obj)
            if isempty(obj.pendingData(end).activities)
                activities(obj.nbJobs) = JSSPActivity;
            else
                activities(obj.nbJobs) = obj.pendingData(end).activities(1);
            end
            for idx = 1 : obj.nbJobs-1
                if isempty(obj.pendingData(idx).activities)
                    activities(idx) = JSSPActivity;
                else
                    activities(idx) = obj.pendingData(idx).activities(1);
                end                
            end
        end
    end
end