function [] = JSSPSolveInstance(instance, heurID)
done = false 
counter = 1
% while done == false 
while ~strcmp(instance.status,'Solved')
%     control = input("Enter to schedule next activity")
    JSSPStepInstance(instance, heurID)
end
instance.plot
end
    