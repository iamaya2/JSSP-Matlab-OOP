function [makespan] = makespan(instance, heurID)

instance1 = createJSSPInstanceFromInstance(instance);

makespan = JSSPSolveInstance(instance1, heurID);

end