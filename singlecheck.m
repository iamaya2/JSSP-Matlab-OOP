function [status]= singlecheck(cell,heurID1, heurID2) 
instance1 = createJSSPInstanceFromInstance(cell{1});
instance2 = createJSSPInstanceFromInstance(cell{1});
makespan1 = JSSPSolveInstance(instance1, heurID1);
makespan2 = JSSPSolveInstance(instance2, heurID2);
perfData = makespan2 - makespan1;
if perfData == cell{2} 
    status = true ;
    disp("Value confirmed")
else 
    status = false;
    disp("error") 
    disp(perfData) 
    disp(makespan1)
    disp(makespan2)
    disp(cell{2})
end
end