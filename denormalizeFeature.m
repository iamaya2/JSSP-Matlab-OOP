function [denormalizedFeature]= denormalizeFeature(featureValue, featureID)

    if featureID ==1 
        denormalizedFeature = featureValue*2; 
    elseif featureID ==2 
        denormalizedFeature = featureValue*1.73;
    elseif featureID ==3 
        denormalizedFeature = featureValue*2;    
    elseif featureID ==4 
        denormalizedFeature = featureValue*1.6875;
    elseif featureID ==5 
        denormalizedFeature = featureValue*1.5;
    end
end
