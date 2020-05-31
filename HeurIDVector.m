function[heurID2]=HeurIDVector(heurID) 

    if heurID == 1 
        heurID2 = [2 3 4]; 
    elseif heurID == 2 
        heurID2 = [1 3 4];
    elseif heurID == 3
        heurID2 = [1 2 4];
    elseif heurID == 4
        heurID2 = [1 2 3];
    end 
end