function [fitness_makespan] = JSSPSolveInstance(instance, heurID)

% while done == false 
while ~strcmp(instance.status,'Solved')
%     control = input("Enter to schedule next activity")
    JSSPStepInstance(instance, heurID)
end
fitness_makespan = instance.solution.makespan;
%instance.plot
end
    