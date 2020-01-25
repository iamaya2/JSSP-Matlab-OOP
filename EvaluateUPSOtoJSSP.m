%% Code for assessing fitness of UPSO values as a JSSP instance
% UPSO works with a column array. The first n elements are processing time
% values, while the next n values are machine orderings
function performanceData = EvaluateUPSOtoJSSP(UPSOArray, nbJobs, varargin)
toPlot = false;
if nargin == 3, toPlot = varargin{1}; end
JSSPInstanceData = UPSOtoJSSP(UPSOArray, nbJobs); % Translate
JSSPInstanceData2 = UPSOtoJSSP(UPSOArray, nbJobs); % Temp... just for testing

% Solve
% performanceJAO = JSSPHeurJAOFull(JSSPInstanceData);
% performanceJDO = JSSPHeurJDOFull(JSSPInstanceData2);
% performanceLPT = JSSPSolveInstance(JSSPInstanceData,1);
% performanceSPT = JSSPSolveInstance(JSSPInstanceData2,2);
performanceMPA = JSSPSolveInstance(JSSPInstanceData2,3);
performanceLPA = JSSPSolveInstance(JSSPInstanceData,4);
% Evaluate performance

% IMPORTANT: THIS FUNCTION REQUIRES THE ADDITION OF THE DELTA LEVEL TO
% GENERATE INSTANCES WITH SPECIFIC LEVELS OF DIFFICULTY

% performanceData = performanceJAO - performanceJDO; % Favors JAO
% performanceData = performanceJDO - performanceJAO; % Favors JDO
% performanceData = performanceSPT - performanceLPT;
% performanceData = performanceLPT - performanceSPT;
performanceData = performanceLPA - performanceMPA;
% Plot if requested
if toPlot
    JSSPInstanceData.plot
    JSSPInstanceData2.plot
end
end