%% P2
% Comentar clase ac�
classdef JSSPSchedule < handle  % Only one schedule should be around
    properties               
        nbMachines % number of machines
        schedule = JSSPMachine(); %itinerary matrix of activities. Rows: Machines. Columns: Scheduled activities
        nbMaxJobs = nan;
        schColorMap
    end        
    
    properties (Dependent)
        makespan % The time taken to complete all jobs
    end
    
    methods
        % ----- ---------------------------------------------------- -----
        % Constructor
        % ----- ---------------------------------------------------- -----
        function jobObj = JSSPSchedule(nbMachines, nbMaxJobs)
            %Creating an empty schedule
            %This function assign to the object job the number of machines
            %avaiable and creates an empty schedule of size equal to the
            %number of machines
            if nargin > 0                
                jobObj.nbMachines = nbMachines;
                jobObj.nbMaxJobs = nbMaxJobs;
                jobObj.schedule(nbMachines,1) = JSSPMachine; % Empty column of actitivities
                for idx = 1 : nbMachines - 1
                    jobObj.schedule(idx,1) = JSSPMachine; % Empty column of actitivities
                end
%                 jobObj.schColorMap = [.92 .97 .97; parula(nbMaxJobs)];
                jobObj.schColorMap = [parula(nbMaxJobs)];
            end
        end
        
        % ----- ---------------------------------------------------- -----
        % General methods
        % ----- ---------------------------------------------------- -----
        %function timeIndex = getTimeslot(obj, machineID, activityLength)            
        function timeIndex = getTimeslot(obj, targetJob)            
            if isempty([targetJob.activities.machineID])
                error('Error! Job has been completely scheduled... Aborting!')                
            end
            machineID = targetJob.activities(1).machineID;
            activityLength = targetJob.activities(1).processingTime;
            selectedMachine = obj.schedule(machineID); % Machine object
            currMakespan = obj.makespan;
            if isnan(currMakespan) % Fix for when the schedule is too young
%                 if selectedMachine == 0, timeIndex = targetJob.lastScheduledTime;
%                 else, timeIndex = 2; 
%                 end
                timeIndex = 0;
                return
            elseif targetJob.lastScheduledTime > currMakespan % Expansion required
                timeIndex = targetJob.lastScheduledTime;
                return
            else                
                fixedStart = targetJob.lastScheduledTime; % Search starting point                               
                emptyRanges =  selectedMachine.emptyRangeInMachine;
                validColumns = emptyRanges(1,:) >= fixedStart;
                availableGaps = diff(emptyRanges(:,validColumns));
                validGaps = find(availableGaps >= activityLength, 1);
                if isempty(validGaps)
                    timeIndex = max(emptyRanges(1,end),fixedStart); % Pending update. This should consider the empty gap at the end, if it exists
                else
                    validTimes = emptyRanges(1,validColumns);                    
                    timeIndex = validTimes(validGaps); % This should be the location...
                end                                               
            end
%             if obj.makespan == 1 % Fix for when the schedule is too young
%                 if selectedMachine == 0, timeIndex = targetJob.lastScheduledTime;
%                 else, timeIndex = 2; 
%                 end
%                 return
%             elseif targetJob.lastScheduledTime > obj.makespan
%                 timeIndex = targetJob.lastScheduledTime;
%                 return
%             else                
%                 fixedStart = targetJob.lastScheduledTime;
%                 zerosIdx = selectedMachine(fixedStart:end) == 0; % Normalize scheduleIdentify empty spaces
%                 diffIdx = diff(zerosIdx);
%                 startIdx = find(diffIdx==1); % Identify start of zero regions
%                 endIdx = find(diffIdx==-1); % Identify end of zero regions
%                 if isempty(startIdx) && isempty(endIdx) % All full or all empty
% %                     if selectedMachine(1) == 0, timeIndex = 1; % Empty,                         
%                     if selectedMachine(fixedStart) == 0, timeIndex = fixedStart; % Empty,
%                     else, timeIndex = obj.makespan + 1; % Full
%                     end
%                     return
%                 elseif isempty(startIdx), startIdx = 0; 
%                 elseif isempty(endIdx), timeIndex = startIdx(1)+fixedStart; return
%                 end
%                 if endIdx(1) < startIdx(1), startIdx = [0 startIdx]; end % Correct zero start
%                 if endIdx(end) < startIdx(end), endIdx = [endIdx startIdx(end)+activityLength]; end % Correct zero end
%                 for idx = 1:length(startIdx)      % This needs completion...
%                     if endIdx(idx)-startIdx(idx) >= activityLength % Enough space?
%                         timeIndex = startIdx(idx)+fixedStart; % +1 because of diff offset
%                         return
%                     end
%                 end
%                 timeIndex = obj.makespan+1; % If full, set at end of schedule
%             end
        end
        
        
        function scheduleJob(obj, targetJob, timeslot)
            % Schedule next Job in agenda       
            selAct = targetJob.popActivity();
            machineID = selAct.machineID;
            thisMachine = obj.schedule(machineID);            
            selAct.startTime = timeslot;
            if isempty(thisMachine.makespan) || isnan(thisMachine.makespan)
                thisMachine.activities = selAct; % First activity
                thisMachine.jobList = targetJob.jobID;
            else
                thisMachine.activities = [thisMachine.activities selAct]; % Others
                thisMachine.jobList = [thisMachine.jobList targetJob.jobID];
            end
            selAct.isScheduled = true;
            targetJob.updateLastActivity(selAct, selAct.endTime);
        end
        
        % ----- ---------------------------------------------------- -----
        % Methods for overloading functionality
        % ----- ---------------------------------------------------- -----
        function plot(obj, varargin)
            %plotting the schedule representation
%             disp('Not yet implemented...')
%             heatmap(obj.schedule); % temp... change this to make similar effect with decimal values            
            figure, colormap(obj.schColorMap)
            axis([-0.1 obj.makespan+0.1 -obj.nbMachines-0.1 0.1])
            set(gca,'CLim',[1 obj.nbMaxJobs]);            
            colorbar('Ticks', 1:obj.nbMaxJobs) % Create colorbar
            box on
            hold on            
            for idM = 1 : length(obj.schedule)
                eachMachine = obj.schedule(idM);
                if ~isempty(eachMachine.makespan)
                    for idx = 1 : length([eachMachine.activities])
                        eachActivity = eachMachine.activities(idx);
                        boxwidth = eachActivity.processingTime;
                        rectangle('Position', [eachActivity.startTime -eachActivity.machineID boxwidth 1], ...
                            'FaceColor', obj.schColorMap(eachMachine.jobList(idx),:))
                    end
                end
            end
%             boxwidth = 1;
%             for idx = 1 : obj.makespan
%                 for idy = 1 : obj.nbMachines
%                     rectangle('Position', [idx-1 -idy boxwidth boxwidth], 'FaceColor', obj.schColorMap(1+obj.schedule(idy,idx),:))
%                 end
%             end
        end
        
        % ----- ---------------------------------------------------- -----
        % Methods for dependent properties
        % ----- ---------------------------------------------------- -----
        function makespan = get.makespan(obj)
            %Counting the number of columns to obtain the makespan
%             makespan = size(obj.schedule,2);
            

%             tempVals = zeros(obj.nbMachines,1);
%             for idx = 1:obj.nbMachines
%                 thisObj = obj.schedule(idx,:);
%                 tempVals(idx) = thisObj(end).endTime;
%             end
%             makespan = max(tempVals);
                makespan = max([obj.schedule(:).makespan]);
        end               
        
    end
end