

folder = "HyperMatrix_Pre";
HeurID1 = 1;
HeurID2 = 2; 
Population = 10;

HeuristicID1=heurIDrepository(HeurID1);
HeuristicID2=heurIDrepository(HeurID2);

address = char(HeuristicID1+"vs"+HeuristicID2+"_Small_pop"+num2str(Population)+".mat");
address2 = char(HeuristicID2+"vs"+HeuristicID1+"_Small_pop"+num2str(Population)+".mat");
folder2 = pwd;

oldfolder=cd(folder); 
hypMatrix=importdata(address);
hypMatrix2=importdata(address2);
hypMatrix_T_I=(hypMatrix')*-1;
hypMatrix2_T_I=(hypMatrix2')*-1;
hypMatrix_concatenated(1,:)=hypMatrix_T_I;
hypMatrix_concatenated(2,:)=hypMatrix2_T_I;

% hypMatrix_T_I=sort(hypMatrix_T_I)
% hypMatrix2_T_I=sort(hypMatrix2_T_I)
%a=heatmap(hypMatrix_concatenated)
% 
% plot(hypMatrix_T_I,'--o')
% hold on
% plot(hypMatrix2_T_I, '--o')

figure
subplot(1,2,1)
histogram(hypMatrix_T_I)
subplot(1,2,2)
histogram(hypMatrix2_T_I,'FaceColor','r')