 address1= "AdvancedStage/AdvancedInstances_1/PerformanceData/AllvsSPT_J3xM4.mat";
 address2= "AdvancedStage/AdvancedInstances_2/PerformanceData/AllvsSPT_J3xM4.mat";
        hypMatrix1=importdata(address1); 
        hypMatrix2=importdata(address2); 
        hypMatrix3=hypMatrix1(:,2:5);
        hypMatrix4=hypMatrix2(:,2:5);
       
for x=1:4
    a=hypMatrix3(:,x)';
    b=hypMatrix4(:,x)';
    [Rsum(x),h(x)]=ranksum(a,b);
end 
disp(Rsum)
disp(h)