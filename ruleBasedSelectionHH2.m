classdef ruleBasedSelectionHH2 < ruleBasedSelectionHH
    % ----- ---------------------------------------------------- -----
    %                       Properties
    % ----- ---------------------------------------------------- -----
    properties
    % Most properties are inherited from the ruleBasedSelectionHH superclass. Only
    % the following properties are specific to this class:
    availableHH = [];
    nbHH
    selectedSolvers

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
        function obj = ruleBasedSelectionHH2(Rules, targetProblem)            
            % Function for creating a rule-based selection hyper-heuristic
            %obj.availableSolvers = ['HH1' 'HH2'];
            obj.hhType = 'Rule-based';
            %obj.nbSolvers = length(obj.availableSolvers);
            obj.nbHH = length(obj.availableHH);
            obj.selectedSolvers=obj.availableHH;
            if nargin >= 1
                obj.nbRules = Rules;
            end
            if nargin ==2
                obj.assignProblem(targetProblem)
%               obj.initializeModel(Rules,obj.nbFeatures, obj.nbSolvers);  
                %obj.initializeModel(Rules,obj.nbFeatures, obj.nbHH);
            end
        end              
        

        
        % ----- ---------------------------------------------------- -----
        % Other methods (sort them alphabetically)
        % ----- ---------------------------------------------------- -----

        
     
        
        
        % ----- Rule selector for the model
%         function closestRule = getClosestRule(obj, instance)
%             % INITIALIZEMODEL  Method for generating a random solution for
%             % the current hh model
%             
%             %allDistances = dist2(obj.value(:,1:end-1),repmat(instance.features,obj.nbRules,1));
%              switch obj.problemType
%                 case 'JSSP'  
%                     for f=1:obj.nbFeatures
%                         featureValues(f)=CalculateFeature(instance, f);
%                     end
%                     instance.features=featureValues;
%              end          
%             %allDistances = dist2(obj.value(:,1:end-1),repmat(instance.features,obj.nbRules,1));
%             for i = 1:size(obj.value,1)
%       
%                   dist(i)  = sqrt(sum((obj.value(i,1:end-1) - instance.features) .^ 2));
%             end 
%             [~, closestRule] = min(dist);              
%         end
        
        % Tests a given hh model (candidate) to see if it is good. Requires
        % that the new model preserves the number of rules and features
%         function fitness = evaluateCandidateSolution(obj, solution, instances)
%             switch obj.problemType
%                 case 'JSSP'
%                     
%                     currentModel = reshape(solution, obj.nbRules, obj.nbFeatures+1);
%                     currentModel(:,end) = round(currentModel(:,end)); % Translates to action IDs 
%                     obj.setModel(currentModel)
%                   
%                     SolvedInstances=obj.solveInstanceSet(instances);
%                     fitness=0;
%                     %fitness = sum([obj.instances.solution.makespan]);
%                      for i=1:length(instances)
%                          fitness=fitness + SolvedInstances{i}.solution.makespan;
%                          %instances{i}.reset
%                      end
%                 otherwise
%                     error('target problem has not been assigned')
%             end
%         end
        
        % ----- Model initializer
        function initializeModel(obj, nbRules, nbFeatures, nbHH)
            % INITIALIZEMODEL  Method for generating a random solution for
            % the current hh model
            obj.value = [rand(nbRules, nbFeatures) randi(nbHH,[nbRules, 1])];
            %obj.nbRules = nbRules; 
            %obj.nbFeatures = nbFeatures;
            %obj.nbSolvers = nbSolvers;
        end 
        
%         function initializeModel_one_to_one(obj, nbRules, nbFeatures, nbSolvers)
%             % INITIALIZEMODEL  Method for generating a random solution for
%             % the current hh model
%              
%             Heuristic_selector = [1 2 3 4 5 6 7 8 9 10];
%             obj.featurevalues = rand(nbRules, nbFeatures);
%             obj.value = [obj.featurevalues Heuristic_selector'];
%             obj.nbRules = nbRules; 
%             obj.nbFeatures = nbFeatures;
%             obj.nbSolvers = nbSolvers;
%         end 
        
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
            %obj.nbSolvers = max(model(:,end)); % At least the max action
        end 
                
        % ----- Hyper-heuristic solver
                 
        
        
        function [instance] = solveInstance(obj, instance)
            % SOLVEINSTANCE  Method for solving a single instance with the current version of the HH (not yet implemented)            
            counter = 1;
            
            
            heuristicVector3=[]; % se necesita modificar para tener el historial de todas las heuristicas sobre todas las instancias
            while ~strcmp(instance.status, 'Solved')
                activeRule = obj.getClosestRule(instance);
                solverID = obj.value(activeRule,end);
                heuristicVector3(counter) = solverID;
                counter = counter +1;
                obj.stepInstance(instance, solverID);
                %instance.stepInstance(heuristicID);
            end     
            %disp(heuristicVector)
            obj.heuristicVector=heuristicVector2;
            SolvedInstance = instance;
            end     
            
        
       
        
        function [Instance] = stepInstance(obj,instance, solverID)
            Instance=availableHH(solverID).step(instance);                             
        end
               
        function addHH(obj,solver)
            availableHH = [obj.availableHH solver];
            obj.availableHH = availableHH;
            obj.nbHH=length(availableHH);
        end
        
        function remHH(obj,solverID) 
            obj.availableHH(solverID)=[];
            
            obj.nbHH=length(obj.availableHH)      
        end
       
        function selectedSolvers = selHH(obj,solvers) 
            for i=1:length(solvers)
                selectedSolvers(i)=obj.availableHH(solvers(i));
            end
            obj.selectedSolvers=selectedSolvers;
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
                     if length(varargin) >= 2, populationSize = varargin{2}; else, populationSize =15; end
                     if length(varargin) >= 3, selfConf = varargin{3}; else,  selfConf=2; end %must be an array of two elements
                     if length(varargin) >= 4, globalConf = varargin{4}; else, globalConf=2.5; end
                     if length(varargin) >= 5, unifyFactor = varargin{5}; else, unifyFactor=0.25; end
                     if length(varargin) == 6, visualMode = varargin{6}; else,visualMode=false; end
                    % Test run using UPSO
                    nbSearchDimensionsFeatures  = obj.nbRules*obj.nbFeatures;
                    nbSearchDimensionsActions   = obj.nbRules;
                    fh = @(x)obj.evaluateCandidateSolution(x,obj.instances); % Evaluates a given solution
                    flimFeatures = repmat([0 1], nbSearchDimensionsFeatures, 1 ); % First features, then actions
                    flimActions  = repmat([1 obj.nbHH], nbSearchDimensionsActions, 1);
                    flim = [flimFeatures; flimActions];

                    % UPSO properties definition
                    properties = struct('visualMode', visualMode, 'verboseMode', true, ...
                        'populationSize', populationSize, 'maxIter', maxIter, 'maxStagIter', 30, ...
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