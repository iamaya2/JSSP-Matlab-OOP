function [status]= singlecheck_Advanced(Instance,heurID, objective) 

instance1 = createJSSPInstanceFromInstance(Instance{1});
instance2 = createJSSPInstanceFromInstance(Instance{1});
instance3 = createJSSPInstanceFromInstance(Instance{1});
instance4 = createJSSPInstanceFromInstance(Instance{1});

if heurID == 1 
    heurID2 = [2 3 4]; 
elseif heurID == 2 
    heurID2 = [1 3 4];
elseif heurID == 3
    heurID2 = [1 2 4];
elseif heurID == 4
    heurID2 = [1 2 3];
end 

makespan1 = JSSPSolveInstance(instance1, heurID);
makespan2 = JSSPSolveInstance(instance2, heurID2(1));
makespan3 = JSSPSolveInstance(instance3, heurID2(2));
makespan4 = JSSPSolveInstance(instance4, heurID2(3));

if objective==1
perfData = makespan1 - min([makespan2,makespan3,makespan4]);
elseif objective ==2
perfData = max([makespan2,makespan3,makespan4])-makespan1;
end


if perfData == Instance{2} 
    status = true ;
    disp("Value confirmed")
else 
    status = false;
    disp("error") 
    disp(perfData) 
    disp(Instance{2})
end
end