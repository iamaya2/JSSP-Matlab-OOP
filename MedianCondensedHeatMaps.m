    
HeurID1=[1 1 1 2 2 2 3 3 3 4 4 4];
HeurID2=[2 2 2 1 1 1 4 4 4 3 3 3];
Population= [10 30 50 10 30 50 10 30 50 10 30 50];
folder="HyperMatrix";
  folder2 = pwd;
for x=1:12

oldfolder=cd(folder2);
HeuristicID1=heurIDrepository(HeurID1(x));
 HeuristicID2=heurIDrepository(HeurID2(x));
    
    address = char(HeuristicID1+"vs"+HeuristicID2+"_Small_pop"+num2str(Population(x))+".mat");
  
    
    oldfolder=cd(folder); 
    hypMatrix=importdata(address); 
    hypMatrixCompressed=hypMatrix(:,:);
    hypMatrixInverted=sort(hypMatrixCompressed.*-1);
    hypMatrixInverted2=median(hypMatrixInverted);
    hypMatrixInverted3(x,:)=hypMatrixInverted2(1,:);
    
end
for y=1:12
    vector=hypMatrixInverted3(y,:);
    hypMatrixInverted4(y,:)=tiedrank(vector);
end

    hypMatrixInverted5(1,:)= tiedrank(cat(2,hypMatrixInverted3(1,:),hypMatrixInverted3(2,:),hypMatrixInverted3(3,:)));
    hypMatrixInverted5(2,:)= tiedrank(cat(2,hypMatrixInverted3(4,:),hypMatrixInverted3(5,:),hypMatrixInverted3(6,:)));
    hypMatrixInverted5(3,:)= tiedrank(cat(2,hypMatrixInverted3(7,:),hypMatrixInverted3(8,:),hypMatrixInverted3(9,:)));
    hypMatrixInverted5(4,:)= tiedrank(cat(2,hypMatrixInverted3(10,:),hypMatrixInverted3(11,:),hypMatrixInverted3(12,:)));
    
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
    

    
    hypMatrixInverted5 = (hypMatrixInverted5 - 82)*-1;
    hypMatrixInverted6= (hypMatrixInverted6 - 28)*-1;
    hypMatrixInverted4= (hypMatrixInverted4 - 28)*-1;
    
    a=heatmap(hypMatrixInverted5);
    ylabel("Heuristics")
    xlabel("Configurations")
   
     cd(folder2)
    %CATEGORYNAMES = {"0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" "0.1" "0.5" "0.9" };
   %violinplot(hypMatrixInverted4, CATEGORYNAMES, 'width', 0.1, 'violinalpha', 0.8, 'ShowData', false) 
   %boxplot(hypMatrix_concat) 
   %xlabel("Target Delta")
    %ylabel("Quotient between obtained delta and target delta")
  
 
