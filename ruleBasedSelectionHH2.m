classdef ruleBasedSelectionHH2 < ruleBasedSelectionHH
    % ----- ---------------------------------------------------- -----
    %                       Properties
    % ----- ---------------------------------------------------- -----
    properties
    % Most properties are inherited from the selectionHH superclass. Only
    % the following properties are specific to this class:     

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
        function obj = ruleBasedSelectionHH2(Rules, Features, Solvers)            
            % Function for creating a rule-based selection hyper-heuristic
            obj.hhType = 'Rule-based';
            if nargin > 0
                obj.nbRules = Rules;
                obj.nbFeatures = Features;
                obj.nbSolvers = Solvers;
                % Put something here in case a constructor is required...
            end
        end              
        

        
        % ----- ---------------------------------------------------- -----
        % Other methods (sort them alphabetically)
        % ----- ---------------------------------------------------- -----

        
        % ----- Instance seeker
        function getInstances(obj, instanceType)
            % GETINSTANCES  Method for extracting one kind of instances from the model (not yet implemented)
            %  instanceType: String containing the kind of instances that
            %  will be extracted. Can be: Training, Testing
            
        end 
        
        
        % ----- Rule selector for the model
        function closestRule = getClosestRule(obj, instance)
            % INITIALIZEMODEL  Method for generating a random solution for
            % the current hh model
            
            %allDistances = dist2(obj.value(:,1:end-1),repmat(instance.features,obj.nbRules,1));
            for i = 1:size(obj.nbSolvers,1)
      
                  dist(i)  = sqrt(sum((obj.featurevalues(i,:) - instance.features) .^ 2));
            end 
            [~, closestRule] = min(dist);            
        end
        
        % Tests a given hh model (candidate) to see if it is good. Requires
        % that the new model preserves the number of rules and features
        function fitness = evaluateCandidateSolution(obj, solution)
            currentModel = reshape(solution, obj.nbRules, obj.nbFeatures+1);
            currentModel(:,end) = round(currentModel(:,end)); % Translates to action IDs 
            obj.setModel(currentModel)
            solvedInstances = obj.solveInstanceSet(obj.trainingInstances);
            allInstances  = [solvedInstances{:}];
            fitness = sum([allInstances.fitness]);
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
        
        function initializeModel_one_to_one(obj, nbRules, nbFeatures, nbSolvers)
            % INITIALIZEMODEL  Method for generating a random solution for
            % the current hh model
             
            Heuristic_selector = [1 2 3 4 5 6 7 8 9 10];
            obj.featurevalues = rand(nbRules, nbFeatures);
            obj.value = [obj.featurevalues Heuristic_selector'];
            obj.nbRules = nbRules; 
            obj.nbFeatures = nbFeatures;
            obj.nbSolvers = nbSolvers;
        end 
        
        % ----- Print overloader for disp()
        function printExtraData(obj)            
            fprintf('\tCurrent model:       \n\t')
            modelString = repmat('\t%.4f', 1, obj.nbFeatures+1);
            modelString = [modelString '\n\t'];
            fprintf(modelString, obj.value')
            fprintf('\n');
        end
        
        % ----- Model setter
        function setModel(obj, model)
            % SETMODEL  Method for setting the hh model to a fixed matrix
            obj.value = model;
            [obj.nbRules, obj.nbFeatures] = size(model); 
            obj.nbFeatures = obj.nbFeatures -1; % Fix for the action column
            obj.nbSolvers = max(model(:,end)); % At least the max action
        end 
                
        % ----- Hyper-heuristic solver
                 
        
        
        function [instance] = solveInstance(obj, instance, RuleMatrix,HHRules, AllRules, HHs)
            % SOLVEINSTANCE  Method for solving a single instance with the current version of the HH (not yet implemented)            
            counter = 1;
           
            obj.featurevalues=RuleMatrix;
            obj.value=HHRules;
            heuristicVector2=[""];
            while ~strcmp(instance.status, 'Solved')
                activeRule = obj.getClosestRule(instance);
                singleHHRules=AllRules{activeRule};
                HH=HHs(activeRule);
                HH=HH{1};
                Heuristic_selector = ["MaxProfit" "MinWeight" "ProfitWeightRatio" "Markovitz"];
                HHMatrix= [singleHHRules Heuristic_selector'];
                HH.featurevalues = singleHHRules;
                
                activeRule2 = HH.getClosestRule(instance);
                
                %obj.targetProblem.stepHeuristic(instance, heuristicID);
                instance.stepInstance(Heuristic_selector(activeRule2));
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
        function [position,fitness,details] = train(obj, criterion, parameters)
            % TRAIN  Method for training the HH (not yet implemented)
            %   criterion: Type of criterion that will be used for stopping training (e.g. iteration or stagnation)
            %   parameters: Parameters associated to the stopping criterion (e.g. nbIter or the deltas and such)
            %
            %   See also DISP (ignore that).
            
            % Test run using UPSO
            nbSearchDimensionsFeatures  = obj.nbRules*obj.nbFeatures;
            nbSearchDimensionsActions   = obj.nbRules;
            fh = @(x)obj.evaluateCandidateSolution(x); % Evaluates a given solution
            flimFeatures = repmat([0 1], nbSearchDimensionsFeatures, 1 ); % First features, then actions
            flimActions  = repmat([1 obj.nbSolvers], nbSearchDimensionsActions, 1);
            flim = [flimFeatures; flimActions];
            
            % UPSO properties definition
            properties = struct('visualMode', true, 'verboseMode', true, ...
                'populationSize', 15, 'maxIter', 50, 'maxStagIter', 100, ...
                'selfConf', 2, 'globalConf', 2.5, 'unifyFactor', 0.25);
            % Call to the optimizer
            [position,fitness,details] = UPSO2(fh, flim, properties);
            obj.evaluateCandidateSolution(position);
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