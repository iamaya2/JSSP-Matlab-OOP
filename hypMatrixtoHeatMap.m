function []= hypMatrixtoHeatMap(folder, HeurID1, HeurID2, Population) 

    HeuristicID1=heurIDrepository(HeurID1);
    HeuristicID2=heurIDrepository(HeurID2);
    
    address = char(HeuristicID1+"vs"+HeuristicID2+"_Small_pop"+num2str(Population)+".mat");
    folder2 = pwd;
    
    oldfolder=cd(folder); 
    hypMatrix=importdata(address); 
    hypMatrixCompressed=hypMatrix(:,:);
    hypMatrixInverted=(hypMatrixCompressed.*-1);
    
    counter=1;
    for x=1:9:19 
        hypMatrixInverted2(:,counter)=(hypMatrixInverted(:,x));
        hypMatrixInverted2(:,counter+1)=(hypMatrixInverted(:,x+1));
         hypMatrixInverted2(:,counter+2)=(hypMatrixInverted(:,x+2));
        counter=counter+3; 
    end 
    counter=10;
     for x=4:9:22 
        hypMatrixInverted2(:,counter)=(hypMatrixInverted(:,x));
        hypMatrixInverted2(:,counter+1)=(hypMatrixInverted(:,x+1));
         hypMatrixInverted2(:,counter+2)=(hypMatrixInverted(:,x+2));
        counter=counter+3; 
    end 
       counter=19;
     for x=7:9:25 
        hypMatrixInverted2(:,counter)=(hypMatrixInverted(:,x));
        hypMatrixInverted2(:,counter+1)=(hypMatrixInverted(:,x+1));
         hypMatrixInverted2(:,counter+2)=(hypMatrixInverted(:,x+2));
        counter=counter+3; 
    end 
    
    
    a=heatmap(hypMatrixInverted);
    ylabel("Repetitions")
    xlabel("Configurations")
    title(HeuristicID1+" vs "+HeuristicID2+" Small Population: "+num2str(Population))
      oldfolder=cd(folder2);
end