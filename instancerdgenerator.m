function [instance] = instancerdgenerator(nbJobs, nbMachines,TimeRanges)
rdP = rand(nbJobs,nbMachines);
%P=rdP.*(TimeRanges(2)-TimeRanges(1))+TimeRanges(1);
P = randi(TimeRanges(2), nbJobs, nbMachines); % for debugging 
M = randi(nbMachines, nbJobs, nbMachines); 
InstanceData(:,:,1)=P;
InstanceData(:,:,2)=M;
instance=JSSPInstance(InstanceData);
end 