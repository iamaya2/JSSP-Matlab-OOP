function [featID] = featureIDrepository(featureID) 

featID = string(nan(1, length(featureID)));
    for x=1:length(featureID)         
        if featureID(x) == 1
            featID(x) = "Mirsh175";
        elseif featureID(x)== 2 
            featID(x) = "Mirsh15";
        elseif featureID(x) == 3 
            featID(x) = "Mirsh29";
        elseif featureID(x) == 4
            featID(x) = "Mirsh282";
        elseif featureID(x) == 5
            featID(x) = "Mirsh95";    
        else
            warning("code is not in database") 
        end
    end
end