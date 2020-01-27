function [Instance] = InstanceLoader (directory,filename,nbinstances) 
newpath= genpath(directory)
addpath(newpath)
taillard=importdata(filename);
delimiterIn = ' ' ;
headerlinesIn = 3;
nbjobs=taillard.data(1);
nbmachines=taillard.data(2);
newdir = ["J"+num2str(nbjobs)+"M"+num2str(nbmachines)]
status=mkdir('TaillardInstances', newdir)
directory2=["C:\Users\USER END\Desktop\TEC COURSES\MASTER\TESIS\MATLAB\JSSP-Matlab-OOP\"+directory]
for idx=1:nbinstances
   oldfolder=cd(directory2)
   Instance(:,:,idx,1) = {importdata(filename,delimiterIn,headerlinesIn)};
   Instance(:,:,idx,2) = {importdata(filename,delimiterIn,headerlinesIn+nbjobs+1)};
    headerlinesIn = idx*(2*nbjobs + 4)+3;
    I=Instance(:,:,idx,:);
    filename2 = "JSSPInstanceJ"+num2str(nbjobs)+"M"+num2str(nbmachines)+"T11T299Rep"+num2str(idx);
    oldfolder=cd(newdir)
    save(filename2,'I')
end




end
%%


