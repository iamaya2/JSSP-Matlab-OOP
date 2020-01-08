
% Parameter initialization
nbJobs = 10;%3; % Number of jobs desired in the instance
nbMachines = 10;%4; % Number of machines desired in the instance
timeRanges = [0 100]; % Min,Max processing times for the instance
fh = @(x)EvaluateUPSOtoJSSP(x, nbJobs); % Objective function for UPSO
flim = [repmat(timeRanges,nbJobs*nbMachines,1); repmat([0.01 nbMachines],nbJobs*nbMachines,1)]; % First processing times, then machine IDs

% UPSO properties definition
properties = struct('visualMode', false, 'verboseMode', true, ...
                'populationSize', 10, 'maxIter', 100, 'maxStagIter', 100, ...
                'selfConf', 2, 'globalConf', 2.5, 'unifyFactor', 0.5);
            
% Create new folder

% Call to the optimizer
for idx=1:30
directory2=["C:\Users\USER END\Desktop\TEC COURSES\MASTER\TESIS\MATLAB\JSSP-Matlab-OOP\"]    
 oldfolder=cd(directory2)
[position,fitness,details] = UPSO2(fh, flim, properties);
generatedInstance = UPSOtoJSSP(position,nbJobs);
directory=["C:\Users\USER END\Desktop\TEC COURSES\MASTER\TESIS\MATLAB\JSSP-Matlab-OOP\GeneratedInstances\SPTvsLPT"]    
 oldfolder=cd(directory)
filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1))+"T2"+num2str(timeRanges(2))+"Rep"+num2str(idx)+"LPTvsSPT";
save(filename2,'generatedInstance')

end
directory2=["C:\Users\USER END\Desktop\TEC COURSES\MASTER\TESIS\MATLAB\JSSP-Matlab-OOP\"]    
 oldfolder=cd(directory2)
EvaluateUPSOtoJSSP(position,nbJobs, true)