    global hypMatrix_concat
    folder_1 = "AdvancedStage/AdvancedInstances_1/PerformanceData";
    folder_2 = "AdvancedStage/AdvancedInstances_2/PerformanceData";
    HeurID = [1 2 3 4 1 2 3 4];
    objective = [1 1 1 1 2 2 2 2];
    nbJobsV = [3];
    nbMachinesV = [4];
    timeranges=[0 10];
    folder2 = pwd;
    a=size(HeurID,2);
    
    for x=1:size(HeurID,2)
         oldfolder=cd(folder2); 
         heuristicID=heurIDrepository(HeurID(x));
         heurIDV=HeurIDVector(HeurID(x));
        if objective(x) == 1  
             address =heuristicID(1) +"vsAll_"+"J"+num2str(nbJobsV(1))+"xM"+num2str(nbMachinesV(1))+".mat";
        elseif objective(x) == 2 
             address ="Allvs"+heuristicID(1)+"_J"+num2str(nbJobsV(1))+"xM"+num2str(nbMachinesV(1))+".mat";
        end
    
    
    oldfolder=cd(folder_1); 
    matrix_1=importdata(address);
    oldfolder=cd(folder2); 
    oldfolder=cd(folder_2);
    matrix_2=importdata(address);
    
    perfData1(:,x) = matrix_1(:,1).*-1;
    perfData2(:,x) = matrix_2(:,1).*-1;
    
    
    
    end
    
    cd(folder2)
    tt = Graphics('Prueba');

    CATEGORYNAMES = {"LPT vs. All" "SPT vs. All" "MPA vs. All" "LPA vs. All" "All vs. LPT" "All vs. SPT" "All vs. MPA" "All vs. LPA"};
    violinplot(perfData1, CATEGORYNAMES,'ViolinColor',[1,0,0],'width', 0.3, 'violinalpha', 0.3, 'ShowData', false) 
    hold on
    violinplot(perfData2, CATEGORYNAMES,'ViolinColor',[0,0,1],'width', 0.3, 'violinalpha', 0.3, 'ShowData', false) 
    xlabel("Generation Focus")
    ylabel("Makespan Difference")
    setup(tt)
    tt.setfont(15)
%     
%        figure
%     subplot(1,2,1)
%     hist(perfData1(:,1))
%     subplot(1,2,2)
%     hist(perfData2(:,1))
%     
%     
%     m1= median(perfData1)
%     m2= median(perfData2)
%     m1= mean(perfData1)
%     m2= mean(perfData2)
%     m1= min(perfData1)
%     m2= min(perfData2)
%     m1= max(perfData1)
%     m2= max(perfData2)
%     m1= std(perfData1)
%     m2= std(perfData2)
%     m1= iqr(perfData1)
%     m2= iqr(perfData2)
