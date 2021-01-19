nbJobs=3;
nbMachines=4;
timeRanges=[0 10];
folder='RandomInstances';
folder2=pwd;
status=mkdir(folder2, folder);

for idx=1:45
    olderfolder=cd(folder2);
    generatedInstance=instancerdgenerator(nbJobs,nbMachines,timeRanges); 
    filename2 = "JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1))+"T2"+num2str(timeRanges(2))+"Rep"+num2str(idx)+"Random";
    oldfolder=cd(folder);
    save(filename2,'generatedInstance')
end
    