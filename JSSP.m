% Class definition for the Job Shop Scheduling Problem
classdef JSSP < handle
    properties        
        instances           = JSSPInstance();
        problemSolvers      = {'1:LPT', '2:SPT','3:MPA','4:LPA'};
        problemType         = 'JSSP';        
    end
    
       properties (Dependent)
%         features
%         fitness
    end
    
    methods
        function obj = JSSP()
            
        end
        
    end
    
    
    methods (Static)
        function newInstance = cloneInstance(JSSPInstance)
            newInstance = createJSSPInstanceFromInstance(JSSPInstance)
        end
        
        function instance = createDummyInstance()
            instance = JSSPInstance();
        end
        
        function allInstances = generateRandomInstances(nbInstances, varargin)
            if length(varargin) >= 1, nbJobs = varargin{1}; else, nbJobs =3; end
            if length(varargin) >= 2, nbMachines = varargin{2}; else, nbMachines =4; end
            if length(varargin) >= 3, timeRanges = varargin{3}; else,  timeRanges=[0 10]; end %must be an array of two elements
            if length(varargin) == 4, toSave = varargin{4}; else, toSave = true; end
            allInstances{nbInstances} = JSSPInstance(); % Dummy instance to allocate memory
            for idx = 1 : nbInstances
                fileName = sprintf('JSSPInstanceJ%dM%dT1%dT2%dRep%dRandom.mat', nbJobs,nbMachines,timeRanges(1),timeRanges(2),idx);
                instanceData = nan(nbJobs, nbMachines, 2);
                instanceData(:,:,1) = rand(nbJobs, nbMachines)*timeRanges(1);
                instanceData(:,:,2) = randi(nbMachines, nbJobs, nbMachines);
                instance = JSSPInstance(instanceData);
                if toSave, save(fileName, 'instance'); end % Saves variable named 'instance', if desired
                allInstances{idx} = instance;
            end
        end
        
        function Parameters=GetParameters(heurID, objective,varargin)
           if ~isempty(varargin) %if delta assignment
                if heurID==1 && objective ==1, [Parameters]=[10,1.5,1.5,0.1];end
                if heurID==1 && objective ==2, [Parameters]=[50,0.5,2.5,0.9];end
                if heurID==2 && objective ==1, [Parameters]=[50,1.5,2.5,0.5];end
                if heurID==2 && objective ==2, [Parameters]=[10,2.5,1.5,0.9];end
                if heurID==3 && objective ==1, [Parameters]=[10,1.5,1.5,0.1];end
                if heurID==3 && objective ==2, [Parameters]=[50,1.5,1.5,0.5];end
                if heurID==4 && objective ==1, [Parameters]=[10,2.5,2.5,0.9];end
                if heurID==4 && objective ==2, [Parameters]=[10,1.5,1.5,0.1];end 
           else    %if no delta assignment
                if heurID==1 && objective ==1, [Parameters]=[10,1.5,1.5,0.1];end
                if heurID==1 && objective ==2, [Parameters]=[50,0.5,2.5,0.9];end
                if heurID==2 && objective ==1, [Parameters]=[50,1.5,2.5,0.5];end
                if heurID==2 && objective ==2, [Parameters]=[10,2.5,1.5,0.9];end
                if heurID==3 && objective ==1, [Parameters]=[10,1.5,1.5,0.1];end
                if heurID==3 && objective ==2, [Parameters]=[50,1.5,1.5,0.5];end
                if heurID==4 && objective ==1, [Parameters]=[50,1.5,1.5,0.5];end
                if heurID==4 && objective ==2, [Parameters]=[50,2.5,1.5,0.5];end
           end
        end
        
       
            
        function vector = getHeurID(heurID)
         vector=[1 2 3 4];
%          index=find(vector==heurID)
         vector([1 heurID])= vector([heurID 1]);
%          vector(index)=[];
%          heurID=[heurID vector]
        end
        
        function allInstances = TailorInstances(nbInstances, InstanceKind, varargin)
            switch InstanceKind
                case 1 %AllvsOne/OnevsAll 
                if length(varargin) <1
                    heurID=input("You neeed to introduce an Heuristic ID (1: LPT, 2: SPT, 3: MPA, 4: LPA")
                else
                    heurID=varargin{1};
                end
                if length(varargin) ==1
                    disp("No objective was introduced (1: Enhance heuristic performance, 2: Hinder heuristic performance), by default the generator will enhance heuristic performance")
                    objective=1;
                elseif length(varargin) >=2
                    objective=varargin{2};
                end
                if length(varargin) >= 3, folder = varargin{3}; else, folder=pwd; end
                if length(varargin) >= 4, nbJobs = varargin{4}; else, nbJobs =3; end
                if length(varargin) >= 5, nbMachines = varargin{5}; else, nbMachines =4; end
                if length(varargin) >= 6, timeRanges = varargin{6}; else,  timeRanges=[0 10]; end %must be an array of two elements
                if length(varargin) >= 7, toSave = varargin{7}; else, toSave = true; end
                if length(varargin) == 8
                    delta = varargin{8};
                    UPSOParameters=JSSP.GetParameters(heurID,objective,1);
                else
                    UPSOParameters=JSSP.GetParameters(heurID,objective);
                end

                population=UPSOParameters(1);
                selfconf=UPSOParameters(2);
                globalconf=UPSOParameters(3);
                unifyfactor=UPSOParameters(4);
                vector=JSSP.getHeurID(heurID);

         
                allInstances = TaskManagerPrueba_Advanced(nbJobs,nbMachines,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbInstances, vector, objective, folder);
            
                case 2 %Feature Oriented
                if length(varargin) <1
                    featID=input("You neeed to introduce an Feature ID (1: Mirsh175, 2: Mirsh15, 3: Mirsh29, 4: Mirsh282, 5: Mirsh95")
                else
                    featID=varargin{1};
                end
                if length(varargin) ==1
                    disp("No target was introduced (target should be a value between 0 and 1), by default the generator will tailor instances with a feature target of 1")
                    target=1;
                elseif length(varargin) >=2
                    target=varargin{2};
                end
                if length(varargin) >= 3, folder = varargin{3}; else, folder=pwd; end
                if length(varargin) >= 4, nbJobs = varargin{4}; else, nbJobs =3; end
                if length(varargin) >= 5, nbMachines = varargin{5}; else, nbMachines =4; end
                if length(varargin) >= 6, timeRanges = varargin{6}; else,  timeRanges=[0 10]; end %must be an array of two elements
                if length(varargin) >= 7, toSave = varargin{7}; else, toSave = true; end
                if length(varargin) >= 8, population=varargin{8}; else, population=50; end
                if length(varargin) >= 9, selfconf=varargin{9}; else, selfconf=1.5; end
                if length(varargin) >= 10, globalconf=varargin{10}; else, globalconf=1.5; end
                if length(varargin) == 11, unifyfactor=varargin{11}; else, unifyfactor=0.5; end
                objective=3; %to find target value


                allInstances= TaskManagerPrueba_Features(nbJobs,nbMachines,timeRanges,population,selfconf, globalconf,...
                                unifyfactor, nbInstances, featID,folder,objective,target);
                for x=1:nbInstances 
                    featValues(x)=normalizeFeature(CalculateFeature(allInstances{x},featID),featID);
                end
                disp("The reached values are:")
                disp(featValues)
              otherwise 
              disp("function has not been implemented yet")
             end
        end
        
        function allInstances = TailorInstancesFeat(nbInstances, featID,objective, target, varargin)
            if length(varargin) >= 1, folder = varargin{1}; else, folder=pwd; end
            if length(varargin) >= 2, nbJobs = varargin{2}; else, nbJobs =3; end
            if length(varargin) >= 3, nbMachines = varargin{3}; else, nbMachines =4; end
            if length(varargin) >= 4, timeRanges = varargin{4}; else,  timeRanges=[0 10]; end %must be an array of two elements
            if length(varargin) >= 5, toSave = varargin{5}; else, toSave = true; end
            if length(varargin) >= 6, population=varargin{6}; else, population=50; end
            if length(varargin) >= 7, selfconf=varargin{7}; else, selfconf=1.5; end
            if length(varargin) >= 8, globalconf=varargin{8}; else, globalconf=1.5; end
            if length(varargin) == 9, unifyfactor=varargin{9}; else, unifyfactor=0.5; end
            objective=3; %to find target value
            
            
            allInstances= TaskManagerPrueba_Features(nbJobs,nbMachines,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbInstances, featID,folder,objective,target);
            for x=1:nbInstances 
                featValues(x)=normalizeFeature(CalculateFeature(allInstances{x},featID),featID);
            end
            disp("The reached values are:")
            disp(featValues)
           
        end
        
        
        function allInstances = TailorInstances_Advanced(nbInstances,  heurID, objective, varargin)
        
         if length(varargin) >= 1, nbJobs = varargin{1}; else, nbJobs =3; end
         if length(varargin) >= 2, nbMachines = varargin{2}; else, nbMachines =4; end
         if length(varargin) >= 3, timeRanges = varargin{3}; else,  timeRanges=[0 10]; end %must be an array of two elements
         if length(varargin) >= 4, toSave = varargin{4}; else, toSave = true; end
          if length(varargin) >= 5, folder = varargin{5}; else, folder=pwd; end
         if length(varargin) == 6
             delta = varargin{6};
             Parameters=JSSP.GetParameters(heurID,objective,1);
         else
             Parameters=JSSP.GetParameters(heurID,objective);
         end
         
         population=Parameters(1);
         selfconf=Parameters(2);
         globalconf=Parameters(3);
         unifyfactor=Parameters(4);
         vector=JSSP.getHeurID(heurID);

         
         allInstances = TaskManagerPrueba_Advanced(nbJobs,nbMachines,timeRanges,population,selfconf, globalconf,...
                            unifyfactor, nbInstances, vector, objective, folder);
         
                      
             for x=1:nbInstances 
                    makespanValues(x)=makespan(allInstances{x},heurID);
             end
            disp("The instances makespan are:")
            disp(makespanValues)               
             %if toSave, save(fileName, 'instance')
         end
        
        
            
        function allInstances = loadSavedInstances(nbInstances,varargin)
            nbElements = varargin{1}; nbBitsPerElement = varargin{2}; baseFileName = varargin{3};
            allInstances{nbInstances} = BPInstance(); 
            for idx = 1 : nbInstances
                fileName = sprintf('GeneratedBPInstance_%s_%dElem_%dBits_Inst%d.mat',baseFileName, nbElements,nbBitsPerElement,idx);
                %instance = BPInstance('l', fileName); 
                instance = load('-mat', fileName);
                allInstances{idx} = instance.instance;
%                 load('-mat', fileName);
%                 allInstances{idx} = instance;
            end
        end
        
      function heurLPA(instance,objective, varargin) %objective (1: step, 2: solve)
         toPlot = false;
         if nargin == 3, toPlot = varargin{1}; end
            
            switch objective
                case 1
                    JSSPStepInstance(instance, 4, toPlot)
                case 2 
                    JSSPSolveInstance(instance, 4, toPlot)
                otherwise
                    disp("objective must be either 1 or 2")
            end             
       end
        
      
        
       function heurMPA(instance,objective, varargin) %objective (1: step, 2: solve)
         toPlot = false;
         if nargin == 3, toPlot = varargin{1}; end
            
            switch objective
                case 1
                    JSSPStepInstance(instance, 3, toPlot)
                case 2 
                    JSSPSolveInstance(instance, 3, toPlot)
                otherwise
                    disp("objective must be either 1 or 2")
            end             
       end
       
        function heurSPT(instance,objective, varargin) %objective (1: step, 2: solve)
         toPlot = false;
         if nargin == 3, toPlot = varargin{1}; end
            
            switch objective
                case 1
                    JSSPStepInstance(instance, 2, toPlot)
                case 2 
                    JSSPSolveInstance(instance, 2, toPlot)
                otherwise
                    disp("objective must be either 1 or 2")
            end             
        end
       
         function heurLPT(instance,objective, varargin) %objective (1: step, 2: solve)
         toPlot = false;
         if nargin == 3, toPlot = varargin{1}; end
            
            switch objective
                case 1
                    JSSPStepInstance(instance, 1, toPlot)
                case 2 
                    JSSPSolveInstance(instance, 1, toPlot)
                otherwise
                    disp("objective must be either 1 or 2")
            end             
         end
       
         
      
        
        function s = disp()
            s = sprintf('Job Shop Scheduling Problem');
        end
    
    end        
end