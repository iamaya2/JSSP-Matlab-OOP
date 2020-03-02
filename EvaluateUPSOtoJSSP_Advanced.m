%% Code for assessing fitness of UPSO values as a JSSP instance
% UPSO works with a column array. The first n elements are processing time
% values, while the next n values are machine orderings
function performanceData = EvaluateUPSOtoJSSP(UPSOArray, nbJobs, heurID, objective, varargin)
toPlot = false;
if nargin == 5, toPlot = varargin{1}; end
JSSPInstanceData = UPSOtoJSSP(UPSOArray, nbJobs); % Translate
JSSPInstanceData2 = UPSOtoJSSP(UPSOArray, nbJobs); % Temp... just for testing
JSSPInstanceData3 = UPSOtoJSSP(UPSOArray, nbJobs);
JSSPInstanceData4 = UPSOtoJSSP(UPSOArray, nbJobs);

%Solving Instances with each heuristic
performanceHeur1 = JSSPSolveInstance(JSSPInstanceData,heurID(1));
performanceHeur2 = JSSPSolveInstance(JSSPInstanceData2,heurID(2));
performanceHeur3 = JSSPSolveInstance(JSSPInstanceData3,heurID(3));
performanceHeur4 = JSSPSolveInstance(JSSPInstanceData4,heurID(4));



%Getting the Makespan Delta
if objective==1
performanceData = performanceHeur1 - min([performanceHeur2,performanceHeur3,performanceHeur4]);
elseif objective ==2
performanceData = max([performanceHeur2,performanceHeur3,performanceHeur4])-performanceHeur1;
end
% Plot if requested
if toPlot
    JSSPInstanceData.plot
    JSSPInstanceData2.plot
     JSSPInstanceData3.plot
    JSSPInstanceData24.plot
end
end