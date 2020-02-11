function []= hypMatrixtoViolin(folder, HeurID1, HeurID2, Population) 

    HeuristicID1=heurIDrepository(HeurID1);
    HeuristicID2=heurIDrepository(HeurID2);
    
    address = char(HeuristicID1+"vs"+HeuristicID2+"_Small_pop"+num2str(Population)+".mat");
    folder2 = pwd;
    
    oldfolder=cd(folder); 
    hypMatrix=importdata(address); 
    hypMatrixCompressed=hypMatrix(:,:);
    hypMatrixInverted=(hypMatrixCompressed.*-1);
    
    cd(folder2)
    CATEGORYNAMES = {"0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9"};
    violinplot(hypMatrixInverted, CATEGORYNAMES, 'width', 0.3, 'violinalpha', 0.55, 'ShowData', false) 
    xlabel("Unify Factor")
    ylabel("Makespan Delta")
    title(HeuristicID1+" vs "+HeuristicID2+" Small Population: "+num2str(Population))
end