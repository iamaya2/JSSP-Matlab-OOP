function [] = JSSPSolveInstance(instance, heurID)
done = false 
counter = 1
while done == false 
    control = input("Enter to schedule next activity")
    counter = counter +1
    JSSPStepInstance(instance, heurID)
    done==true
    for x=1:size(instance.pendingData,2)
        remainingPT(x)=isempty([instance.pendingData(x).activities.processingTime])
        if remainingPT(x)== false 
           done==false
        end    
    end 
    if counter == 100 
        break
    end 
    
end
end
    