function []= AverageMeanValues(folder, HeurID1, HeurID2, Population) 
    
    HeuristicID1=heurIDrepository(HeurID1);
    HeuristicID2=heurIDrepository(HeurID2);
    
    folder3="InitialInstances/"; 
    addpath(genpath(folder3))
    
    address = char(HeuristicID1+"vs"+HeuristicID2+"_Small_pop"+num2str(Population)+".mat");
    folder2 = pwd;

    oldfolder=cd(folder);
    hypMatrix=importdata(address); 
    hypMatrixCompressed=hypMatrix(:,:); %This arranges the 4-D matrix in a 2-D matrix, 
    hypMatrixInverted=(hypMatrixCompressed.*-1);
    hypMatrixInverted_mean = mean(hypMatrixInverted); % obtaining the mean of the 30 repetitions
   
    
    % this loop is to obtain the sum of the values corresponding to
    % each UF configuration
    
     UF_0_1 = 0;
     UF_0_5 = 0;
     UF_0_9 = 0;
     
     for x=1:3:25
        UF_0_1=  UF_0_1 + (hypMatrixInverted_mean(x));
        UF_0_5=  UF_0_5 + (hypMatrixInverted_mean(x+1));
        UF_0_9=  UF_0_9 + (hypMatrixInverted_mean(x+2));
     end 

    
    
    % this loop is to obtain the sum of the values corresponding to
    % each GC configuration
    
     GC_0_5 = 0;
     GC_1_5 = 0;
     GC_2_5 = 0;
     
    for x=1:9:19 
        GC_0_5 = GC_0_5 + (hypMatrixInverted_mean(x)) + (hypMatrixInverted_mean(x+1)) + (hypMatrixInverted_mean(x+2)) ;
        GC_1_5 = GC_1_5 + (hypMatrixInverted_mean(x+3)) + (hypMatrixInverted_mean(x+4)) + (hypMatrixInverted_mean(x+5)) ;
        GC_2_5 = GC_2_5 + (hypMatrixInverted_mean(x+6)) + (hypMatrixInverted_mean(x+7)) + (hypMatrixInverted_mean(x+8)) ;
    end 
    

      
    % this loop is to obtain the sum of the values corresponding to
    % each SC configuration
    
     SC_0_5 = 0;
     SC_1_5 = 0;
     SC_2_5 = 0;
    
    for x=1:9 
       SC_0_5= SC_0_5 + (hypMatrixInverted_mean(x));
       SC_1_5= SC_1_5 + (hypMatrixInverted_mean(x+9));
       SC_2_5= SC_2_5 + (hypMatrixInverted_mean(x+18));
    end 
     
    
    %Calculating the mean of all parameters 
    overall_mean = mean(hypMatrixInverted_mean) %the mean of the 27 mean values
    meanUF_0_1 = UF_0_1/9; %the mean of this parameter
    meanUF_0_5 = UF_0_5/9;
    meanUF_0_9 = UF_0_9/9;
    meanGC_0_5 = GC_0_5/9;
    meanGC_1_5 = GC_1_5/9;
    meanGC_2_5 = GC_2_5/9; 
    meanSC_0_5 = SC_0_5/9; 
    meanSC_1_5 = SC_1_5/9; 
    meanSC_2_5 = SC_2_5/9; 
    
    %DISPLAY all values for easy capture
    disp(meanUF_0_1)
    disp(meanUF_0_5)
    disp(meanUF_0_9)
    disp(meanGC_0_5)
    disp(meanGC_1_5)
    disp(meanGC_2_5)
    disp(meanSC_0_5)
    disp(meanSC_1_5)
    disp(meanSC_2_5)
end
    
    
