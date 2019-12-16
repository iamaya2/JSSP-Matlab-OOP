function [mP,mM] = InstanceLoader (delimiterIn,headerlinesIn,nbjobs,nbmachines,nbinstances) 
delimiterIn = ' ' 
headerlinesIn = 3
nbjobs=15;
nbmachines=15;
nbinstances=10;
for idx=1:nbinstances
    mP(idx) = {importdata("tai15_15.txt",delimiterIn,headerlinesIn)};
    mM(idx)= {importdata("tai15_15.txt",delimiterIn,headerlinesIn+nbjobs+1)};
    headerlinesIn = idx*(headerlinesIn + nbjobs + nbmachines + 1);
end

end
%%
function [P, M] = instancerdgenerator(nbJobs, nbMachines,maxPT)
P = randi(maxPT,nbJobs,nbMachines);
M = randi(nbMachines, nbJobs, nbMachines); 
end 

