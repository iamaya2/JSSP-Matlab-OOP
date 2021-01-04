

 address= "AdvancedStage/AdvancedInstances_2/PerformanceData/MPAvsAll_J3xM4.mat";
        hypMatrix=importdata(address); 

        hypMatrix2=hypMatrix(:,2:5);
        minMatrix=min(hypMatrix2');
        avg=mean(hypMatrix2)
        LPT=0;
        SPT=0;
        MPA=0;
        LPA=0;
for x=1:30 
    if hypMatrix2(x,1)==minMatrix(x)
        LPT=LPT+1;
    end
    if hypMatrix2(x,2)==minMatrix(x)
        SPT=SPT+1;
    end
    if hypMatrix2(x,3)==minMatrix(x)
        MPA=MPA+1;
    end 
    if hypMatrix2(x,4)==minMatrix(x)
        LPA=LPA+1;
    end 
end 
Porcentaje(1)=LPT/30;
Porcentaje(2)=SPT/30;
Porcentaje(3)=MPA/30;
Porcentaje(4)=LPA/30;
CATEGORYNAMES = {"LPT" "SPT" "MPA" "LPA"};
    violinplot(hypMatrix2, CATEGORYNAMES,'ViolinColor',[1,0,0],'width', 0.3, 'violinalpha', 0.8, 'ShowData', false) 
     xlabel("Heuristics")
     ylabel("Makespan")