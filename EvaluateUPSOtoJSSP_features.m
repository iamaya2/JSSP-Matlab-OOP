%% Code for assessing fitness of UPSO values as a JSSP instance for feature values
% UPSO works with a column array. The first n elements are processing time
% values, while the next n values are machine orderings
function performanceData = EvaluateUPSOtoJSSP_features(UPSOArray, nbJobs, FeatureID, objective, varargin)
toPlot = false;
if nargin == 5, targetValue = varargin{1}; end
JSSPInstanceData = UPSOtoJSSP(UPSOArray, nbJobs); % Translate
%JSSPInstanceData2 = UPSOtoJSSP(UPSOArray, nbJobs); % Temp... just for testing

% Evaluate performance

% IMPORTANT: THIS FUNCTION REQUIRES THE ADDITION OF THE DELTA LEVEL TO
% GENERATE INSTANCES WITH SPECIFIC FEATURE VALUES
if objective==1 

    if FeatureID==1 
        performanceData=-normalizeFeature(Mirsh175(JSSPInstanceData),FeatureID);
    elseif FeatureID==2 
         performanceData=-normalizeFeature(Mirsh15(JSSPInstanceData),FeatureID);
    elseif FeatureID==3 
         performanceData=-normalizeFeature(Mirsh29(JSSPInstanceData),FeatureID);
    elseif FeatureID==4 
         performanceData=-normalizeFeature(Mirsh282(JSSPInstanceData),FeatureID);
    elseif FeatureID==5 
         performanceData=-normalizeFeature(Mirsh95(JSSPInstanceData),FeatureID);
    end
elseif objective==2 
    if FeatureID==1 
        performanceData=normalizeFeature(Mirsh175(JSSPInstanceData),FeatureID);
    elseif FeatureID==2 
         performanceData=normalizeFeature(Mirsh15(JSSPInstanceData),FeatureID);
    elseif FeatureID==3 
         performanceData=normalizeFeature(Mirsh29(JSSPInstanceData),FeatureID);
    elseif FeatureID==4 
         performanceData=normalizeFeature(Mirsh282(JSSPInstanceData),FeatureID);
    elseif FeatureID==5 
         performanceData=normalizeFeature(Mirsh95(JSSPInstanceData),FeatureID);
    end
elseif objective==3
    if FeatureID==1 
        performanceData=(normalizeFeature(Mirsh175(JSSPInstanceData),FeatureID)-targetValue)^2;
    elseif FeatureID==2 
         performanceData=(normalizeFeature(Mirsh15(JSSPInstanceData),FeatureID)-targetValue)^2;
    elseif FeatureID==3 
         performanceData=(normalizeFeature(Mirsh29(JSSPInstanceData),FeatureID)-targetValue)^2;
    elseif FeatureID==4 
         performanceData=(normalizeFeature(Mirsh282(JSSPInstanceData),FeatureID)-targetValue)^2;
    elseif FeatureID==5 
         performanceData=(normalizeFeature(Mirsh95(JSSPInstanceData),FeatureID)-targetValue)^2;
    end
end    

% Plot if requested
if toPlot
    JSSPInstanceData.plot
    JSSPInstanceData2.plot
end
    
end