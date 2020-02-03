 function [heuristicID] = heurIDrepository(heurID) 

heuristicID = string(nan(1, length(heurID)));
    for x=1:length(heurID)         
        if heurID(x) == 1
            heuristicID(x) = "LPT";
        elseif heurID(x)== 2 
            heuristicID(x) = "SPT";
        elseif heurID(x) == 3 
            heuristicID(x) = "MPA";
        elseif heurID(x) == 4
            heuristicID(x) = "LPA";
        else
            warning("code is not in database") 
        end
    end
end