function [Instance] = InstanceLoader (directory,filename,nbinstances) 
newpath= genpath(directory)
addpath(newpath)
taillard=importdata(filename);
delimiterIn = ' ' 
headerlinesIn = 3
nbjobs=taillard.data(1);
nbmachines=taillard.data(2);

for idx=1:nbinstances
   Instance(:,:,idx,1) = {importdata(filename,delimiterIn,headerlinesIn)};
   Instance(:,:,idx,2) = {importdata(filename,delimiterIn,headerlinesIn+nbjobs+1)};
    headerlinesIn = idx*(headerlinesIn + nbjobs + nbmachines + 1);
end


end
%%


