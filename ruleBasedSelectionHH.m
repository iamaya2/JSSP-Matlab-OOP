% Class definition for Rule-based selection hyper-heuristics
classdef ruleBasedSelectionHH < selectionHH
    % ----- ---------------------------------------------------- -----
    %                       Properties
    % ----- ---------------------------------------------------- -----
    properties
    % Most properties are inherited from the selectionHH superclass. Only
    % the following properties are specific to this class:     
    nbRules         = NaN; % Number of rules for the HH
    nbFeatures      = NaN; % Number of features for the HH
    nbSolvers       = NaN;
    featurevalues
    heuristicVector
    HHRules
    instances
    end
    
    properties (Dependent)
        % TO-DO: Put any dependent properties here (calculated on-the-fly)
    end
    
    % ----- ---------------------------------------------------- -----
    %                       Methods
    % ----- ---------------------------------------------------- -----
    methods
        % ----- ---------------------------------------------------- -----
        % Constructor
        % ----- ---------------------------------------------------- -----
        function obj = ruleBasedSelectionHH(Rules, targetProblem)            
            % Function for creating a rule-based selection hyper-heuristic
            obj.hhType = 'Rule-based';
            if nargin >= 1
                obj.nbRules = Rules;
            end
            if nargin ==2
                obj.assignProblem(targetProblem)
%                 obj.nbFeatures = length(obj.availableFeatures);
%                 obj.nbSolvers = length(obj.availableSolvers);
                % Put something here in case a constructor is required...
                obj.initializeModel(Rules,obj.nbFeatures, obj.nbSolvers);
            end
        end              
        

        
        % ----- ---------------------------------------------------- -----
        % Other methods (sort them alphabetically)
        % ----- ---------------------------------------------------- -----

        
        % ----- Instance seeker
        function allinstances = getInstances(obj, instanceType, varargin)
            % GETINSTANCES  Method for extracting one kind of instances from the model (not yet implemented)
            %  instanceType: String containing the kind of instances that
            %  will be extracted. Can be: Training, Testing
             switch  lower(instanceType)
              
                case 'preliminary'
                    addpath(genpath('InstanceRepository/PreliminaryInstances'))
                    if nargin == 3 
                        ChoseInstances=varargin{1};
                    else 
                       warning("Must choose one of three kind of preliminary instances: 1 - LPTvsSPT, 2 - SPTvsLPT, 3 - Random");
                       ChoseInstances=input("Write the kind of preliminary instances to load");
                    end
%                     disp(ChoseInstances) 
                    switch ChoseInstances 
                        case 1
                            for idx=1:30
                                address="JSSPInstanceJ3M4T10T210Rep"+num2str(idx)+"LPTvsSPT.mat";
                                JSSPInstance = {};
                                load(address)
%                                 allinstances{idx}=import(address);
                                allinstances{idx}=JSSPInstance{1};
                            end
                        case 2
                            for idx=1:30
                                address="JSSPInstanceJ3M4T10T210Rep"+num2str(idx)+"SPTvsLPT.mat";
                                JSSPInstance = {};
                                load(address)
%                                 allinstances{idx}=import(address);
                                allinstances{idx}=JSSPInstance{1};
                            end
                        case 3
                            for idx=1:30
                                address=["GeneratedJSSPInstance_2020_May_27_19_04_33_3jobs_4machs_Inst"+num2str(idx)+".mat"];
                                instance = {};
                                load(address)
%                                 allinstances{idx}=import(address);
                                allinstances{idx}=instance;
                            end
                        otherwise
                            warning("Selected preliminary instance kind is not defined, program will load 30 random instances by default")
                            for idx=1:30
                                address="GeneratedJSSPInstance_2020_May_27_19_04_33_3jobs_4machs_Inst"+num2str(idx)+".mat";
                                instance = {};
                                load(address)
%                                 allinstances{idx}=import(address);
                                allinstances{idx}=instance;
                            end    
                    end        
                otherwise
                    warning("defined instance Types: {'preliminary'}")
                    
             end 
             obj.instances=allinstances;
        end 
        
        
        % ----- Rule selector for the model
        function closestRule = getClosestRule(obj, instance)
            % INITIALIZEMODEL  Method for generating a random solution for
            % the current hh model
          switch obj.problemType
                case 'JSSP'  
                    for f=1:obj.nbFeatures
                        featureValues(f)=CalculateFeature(instance, f);
                    end
                    instance.features=featureValues;
          end          
            %allDistances = dist2(obj.value(:,1:end-1),repmat(instance.features,obj.nbRules,1));
            for i = 1:size(obj.value,1)
      
                  dist(i)  = sqrt(sum((obj.value(i,1:end-1) - instance.features) .^ 2));
            end 
            [~, closestRule] = min(dist);            
        end
        
        % Tests a given hh model (candidate) to see if it is good. Requires
        % that the new model preserves the number of rules and features
        function fitness = evaluateCandidateSolution(obj, solution, instances)
            switch obj.problemType
                case 'JSSP'
                    
                    currentModel = reshape(solution, obj.nbRules, obj.nbFeatures+1);
                    currentModel(:,end) = round(currentModel(:,end)); % Translates to action IDs 
                    obj.setModel(currentModel)
                  
                    SolvedInstances=obj.solveInstanceSet(instances);
                    fitness=0;
                    %fitness = sum([obj.instances.solution.makespan]);
                     for i=1:length(instances)
                         fitness=fitness + SolvedInstances{i}.solution.makespan;
                         %instances{i}.reset
                     end
                      
                    
                otherwise     
                    
                    currentModel = reshape(solution, obj.nbRules, obj.nbFeatures+1);
                    currentModel(:,end) = round(currentModel(:,end)); % Translates to action IDs 
                    obj.setModel(currentModel)
                    disp(obj.value)
                    solvedInstances = obj.solveInstanceSet(obj.trainingInstances);
                    allInstances  = [solvedInstances{:}];
                    fitness = sum([allInstances.fitness]);
            end    
        end
        
        % ----- Model initializer
        function initializeModel(obj, nbRules, nbFeatures, nbSolvers)
            % INITIALIZEMODEL  Method for generating a random solution for
            % the current hh model
            obj.value = [rand(nbRules, nbFeatures) randi(nbSolvers,[nbRules, 1])];
            obj.nbRules = nbRules; 
            obj.nbFeatures = nbFeatures;
            obj.nbSolvers = nbSolvers;
        end 
        
%         function initializeModel_one_to_one(obj, nbRules, nbFeatures, nbSolvers)
%             % INITIALIZEMODEL  Method for generating a random solution for
%             % the current hh model
%              
%             Heuristic_selector = ["MaxProfit" "MinWeight" "ProfitWeightRatio" "Markovitz"];
%             obj.featurevalues = rand(nbRules, nbFeatures);
%             obj.value = [obj.featurevalues Heuristic_selector'];
%             obj.nbRules = nbRules; 
%             obj.nbFeatures = nbFeatures;
%             obj.nbSolvers = nbSolvers;
%         end 
        
        % ----- Print overloader for disp()
%         function printExtraData(obj)            
%             fprintf('\tCurrent model:       \n\t')
%             modelString = repmat('\t%.4f', 1, obj.nbFeatures+1);
%             modelString = [modelString '\n\t'];
%             fprintf(modelString, obj.value')
%             fprintf('\n');
%         end
        
        % ----- Model setter
        function setModel(obj, model)
            % SETMODEL  Method for setting the hh model to a fixed matrix
            obj.value = model;
            [obj.nbRules, obj.nbFeatures] = size(model); 
            obj.nbFeatures = obj.nbFeatures -1; % Fix for the action column
            %obj.nbSolvers = max(model(:,end)); % At least the max action
        end 
                
        % ----- Hyper-heuristic solver
        function SolvedInstance = solveInstance(obj, instance)
            % SOLVEINSTANCE  Method for solving a single instance with the current version of the HH (not yet implemented)            
            counter = 1;
            
            
            heuristicVector2=[]; % se necesita modificar para tener el historial de todas las heuristicas sobre todas las instancias
            while ~strcmp(instance.status, 'Solved')
                activeRule = obj.getClosestRule(instance);
                heuristicID = obj.value(activeRule,end);
                heuristicVector2(counter) = heuristicID;
                counter = counter +1;
                obj.targetProblem.stepHeuristic(instance, heuristicID);
                %instance.stepInstance(heuristicID);
            end     
            %disp(heuristicVector)
            obj.heuristicVector=heuristicVector2;
            SolvedInstance = instance;
        end 
        
        function solveInstanceSet_noCloning(obj,instances)
            for i=1:length(instances)
                obj.solveInstance(instances{i})
            end
        end
                
        
               
        
        % ----- Instance asigner
        function setInstances(obj, instanceType, instances)
            % SETINSTANCES  Method for assigning one kind of instances to the model (not yet implemented)
            %  instanceType: String containing the kind of instances that
            %                will be extracted. Can be: Training, Testing
            %  instances:    Cell array with the instances that will be
            %                assigned
            
        end 
                

        
        % ----- Instance splitter
        function splitInstances(obj, trainRatio)
            % SPLITINSTANCES  Method for separating loaded instances into
            % training and testing subsets (not yet implemented)
            %  trainRatio:  Percentage of instances that will be used for
            %  the training set
            %
            % NOTE: When giving the percentage, bear in mind that the
            % number of instances will be rounded to the closest integer.
            % For example, using trainRatio = 0.25 when the number of total
            % instances is 51 will deliver 13 training instances. Instead, if the
            % number of total instances is 49, then 12 training instances
            % will be provided.
            
        end 
        
        % ----- Hyper-heuristic tester
        function test(obj)
            % TEST  Method for running the HH on the testing instances (not yet implemented)
            
        end
        
        % ----- Hyper-heuristic trainer        
        function [position,fitness,details] = train(obj, criterion, varargin)
            % TRAIN  Method for training the HH (not yet implemented)
            %   criterion: Type of criterion that will be used for stopping training (e.g. iteration or stagnation)
            %   parameters: Parameters associated to the stopping criterion (e.g. nbIter or the deltas and such)
            %
            %   See also DISP (ignore that).
            switch criterion 
                case 1
                     if length(varargin) >= 1, maxIter = varargin{1}; else, maxIter =100; end
                     if length(varargin) >= 2, populationSize = varargin{2}; else, populationSize =30; end
                     if length(varargin) >= 3, selfConf = varargin{3}; else,  selfConf=1.5; end %must be an array of two elements
                     if length(varargin) >= 4, globalConf = varargin{4}; else, globalConf=1.5; end
                     if length(varargin) >= 5, unifyFactor = varargin{5}; else, unifyFactor=0.5; end
                     if length(varargin) == 6, visualMode = varargin{6}; else,visualMode=false; end
                    % Test run using UPSO
                    nbSearchDimensionsFeatures  = obj.nbRules*obj.nbFeatures;
                    nbSearchDimensionsActions   = obj.nbRules;
                    fh = @(x)obj.evaluateCandidateSolution(x,obj.instances); % Evaluates a given solution
                    flimFeatures = repmat([0 1], nbSearchDimensionsFeatures, 1 ); % First features, then actions
                    flimActions  = repmat([1 obj.nbSolvers], nbSearchDimensionsActions, 1);
                    flim = [flimFeatures; flimActions];

                    % UPSO properties definition
                    properties = struct('visualMode', visualMode, 'verboseMode', true, ...
                        'populationSize', populationSize, 'maxIter', maxIter, 'maxStagIter', 20, ...
                        'selfConf', selfConf, 'globalConf', globalConf, 'unifyFactor', unifyFactor);
                    % Call to the optimizer
                    [position,fitness,details] = UPSO2(fh, flim, properties);
                    obj.evaluateCandidateSolution(position,obj.instances);
                otherwise
                    error("a criterion must be set: 1.-number of iterations")
            end
        end        
        

        
        % ----- ---------------------------------------------------- -----
        % Methods for overloading functionality
        % ----- ---------------------------------------------------- -----
%         function plot(obj, varargin)
%             disp('Not yet fully implemented...')
%             obj.solution.plot()
%         end
%         

        % ----- ---------------------------------------------------- -----
        % Methods for dependent properties
        % ----- ---------------------------------------------------- -----
%         function resultingData = get.propertyName(obj)
%             % Define here dependent properties
%         end
    end
end