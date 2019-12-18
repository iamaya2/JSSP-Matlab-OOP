%% Code for translating UPSO values into JSSP instance
% UPSO works with a column array. The first n elements are processing time
% values, while the next n values are machine orderings
function JSSPInstanceData = UPSOtoJSSP(UPSOArray, nbJobs)
JSSPdata = reshape(UPSOArray, nbJobs,[],2);
JSSPdata(:,:,2) = ceil(JSSPdata(:,:,2)); % Avoids floating-value machine IDs
JSSPInstanceData = JSSPInstance(JSSPdata);
end