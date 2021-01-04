    
HeurID1=[1 1 1 2 2 2 3 3 3 4 4 4];
HeurID2=[2 2 2 1 1 1 4 4 4 3 3 3];
Population= [10 30 50 10 30 50 10 30 50 10 30 50];
folder="InitialInstances/PerformanceData/";
  folder2 = pwd;
for x=1:12 %this loop condenses every configuration of every heuristic into a 12x27 matrix with median values. 

oldfolder=cd(folder2);
HeuristicID1=heurIDrepository(HeurID1(x));
 HeuristicID2=heurIDrepository(HeurID2(x));
    
    address = char(HeuristicID1+"vs"+HeuristicID2+"_Small_pop"+num2str(Population(x))+".mat");
  
    
    oldfolder=cd(folder); 
    hypMatrix=importdata(address); 
    hypMatrixCompressed=hypMatrix(:,:);
    hypMatrixInverted=sort(hypMatrixCompressed.*-1); %to make the performance possitive
    hypMatrixInverted2=median(hypMatrixInverted); % obtaining the median values of the 30 repetitions
    hypMatrixInverted3(x,:)=hypMatrixInverted2(1,:);
    
end
for y=1:12 %gets the tiedrank of the previous matrix
    vector=hypMatrixInverted3(y,:);
    hypMatrixInverted4(y,:)=tiedrank(vector);
end

%The next four lines make a 4x81 ranked matrix (it concatenates the
%populations of every heuristic)
    hypMatrixInverted5(1,:)= tiedrank(cat(2,hypMatrixInverted3(1,:),hypMatrixInverted3(2,:),hypMatrixInverted3(3,:)));
    hypMatrixInverted5(2,:)= tiedrank(cat(2,hypMatrixInverted3(4,:),hypMatrixInverted3(5,:),hypMatrixInverted3(6,:)));
    hypMatrixInverted5(3,:)= tiedrank(cat(2,hypMatrixInverted3(7,:),hypMatrixInverted3(8,:),hypMatrixInverted3(9,:)));
    hypMatrixInverted5(4,:)= tiedrank(cat(2,hypMatrixInverted3(10,:),hypMatrixInverted3(11,:),hypMatrixInverted3(12,:)));
  
    
    %the next 3 loops groups the results by the GC values (instead of the
    %SC values)
       counter=1;
   for x=1:9:19 
       hypMatrixInverted6(:,counter)=(hypMatrixInverted4(:,x));
       hypMatrixInverted6(:,counter+1)=(hypMatrixInverted4(:,x+1));
        hypMatrixInverted6(:,counter+2)=(hypMatrixInverted4(:,x+2));
       counter=counter+3; 
   end 
   counter=10;
    for x=4:9:22 
       hypMatrixInverted6(:,counter)=(hypMatrixInverted4(:,x));
       hypMatrixInverted6(:,counter+1)=(hypMatrixInverted4(:,x+1));
        hypMatrixInverted6(:,counter+2)=(hypMatrixInverted4(:,x+2));
       counter=counter+3; 
    end 
      counter=19;
     for x=7:9:25 
       hypMatrixInverted6(:,counter)=(hypMatrixInverted4(:,x));
       hypMatrixInverted6(:,counter+1)=(hypMatrixInverted4(:,x+1));
        hypMatrixInverted6(:,counter+2)=(hypMatrixInverted4(:,x+2));
        counter=counter+3; 
     end
    

    %the next lines obtatin the inverted ranks from their respective
    %matrices. The tied rank function ranks 1 the lowest value.
    hypMatrixInverted5 = (hypMatrixInverted5 - 82)*-1;%to obtain the inverse rankings; tiedrank function ranks 1 the lowest value
    hypMatrixInverted6= (hypMatrixInverted6 - 28)*-1;
    hypMatrixInverted4= (hypMatrixInverted4 - 28)*-1;
    
    a=heatmap(hypMatrixInverted5); %plot the chosen matrix
    ylabel("Heuristics")
    xlabel("Configurations")
   
     cd(folder2)
    %CATEGORYNAMES = {"0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" };
   %violinplot(hypMatrixInverted4, CATEGORYNAMES, 'width', 0.1, 'violinalpha', 0.8, 'ShowData', false) 
   %boxplot(hypMatrix_concat) 
   %xlabel("Target Delta")
    %ylabel("Quotient between obtained delta and target delta")
  
 
