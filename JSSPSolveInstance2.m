function [] = JSSPSolveInstance2(instance, heurID)

    for x=1:5
           JSSPStepInstance(instance, heurID)
    end 
    
instance.plot
end