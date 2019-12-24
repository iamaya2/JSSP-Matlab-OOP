function [fitness_makespan] = JSSPSolveInstance(instance, heurID, varargin)
toPlot = false;
if nargin == 3, toPlot = varargin{1}; end
while ~strcmp(instance.status,'Solved')
%     control = input("Enter to schedule next activity")
    JSSPStepInstance(instance, heurID)
end
fitness_makespan = instance.solution.makespan;
if toPlot==true 
instance.plot
end
end
    