function []= hypMatrixtoViolin_Advanced(folder, HeurID, objective) 
    global hypMatrix_concat

    nbJobsV = [3];
    nbMachinesV = [4];
    heuristicID=heurIDrepository(HeurID);
    heurIDV=HeurIDVector(HeurID);
    
    if objective == 1  
        address =heuristicID(1) +"vsAll_"+"J"+num2str(nbJobsV(1))+"xM"+num2str(nbMachinesV(1));
    elseif objective == 2 
        address ="Allvs"+heuristicID(1)+"_J"+num2str(nbJobsV(1))+"xM"+num2str(nbMachinesV(1));
    end
    
    folder2 = pwd;
    oldfolder=cd(folder); 
    oldfolder=cd(address);
   
    for x=10:10:50
        delta_code = "_Delta_"+num2str(x);
        address2= address+delta_code+".mat";
        hypMatrix=importdata(address2); 
        HeurID_makespan_matrix = hypMatrix(:,HeurID+2);
        if objective == 1 
            for r=1:50
                RemVector_makespan_matrix(r,1) = min([hypMatrix(r,heurIDV(1)+2) hypMatrix(r,heurIDV(2)+2) hypMatrix(r,heurIDV(3)+2)]);
            end
            Matrix1 = HeurID_makespan_matrix./RemVector_makespan_matrix;
            Matrix2 = (RemVector_makespan_matrix-HeurID_makespan_matrix)/x; 
        elseif objective == 2 
              for r=1:50
                RemVector_makespan_matrix(r,1) = max([hypMatrix(r,heurIDV(1)+2) hypMatrix(r,heurIDV(2)+2) hypMatrix(r,heurIDV(3)+2)]);
              end
           Matrix1 =RemVector_makespan_matrix./HeurID_makespan_matrix;
           Matrix2 = (HeurID_makespan_matrix-RemVector_makespan_matrix)/x; 
        end
      
     
        y=x/10;
        hypMatrix_concat(:,y)= Matrix2(:,1);
    end
    disp("Mean")
    hypMatrix_mean= mean(hypMatrix_concat)
      disp("Median")
    hypMatrix_median=median(hypMatrix_concat)
    
    cd(folder2)
    CATEGORYNAMES = {"10" "20" "30" "40" "50"};
     violinplot(hypMatrix_concat, CATEGORYNAMES,'ViolinColor',[0,0,1],'width', 0.3, 'violinalpha', 0.3, 'ShowData', false) 
    

     %boxplot(hypMatrix_concat) 
   xlabel("Target Delta")
    ylabel("Quotient between obtained delta and target delta")
    
end




