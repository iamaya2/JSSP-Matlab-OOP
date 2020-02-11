hypMatrixreduced=hypMatrix(:,:);
ihypMatrixreduced=hypMatrixreduced.*-1;
Vpromedio=mean(ihypMatrixreduced);
Gaverage=mean(Vpromedio);
sumaUF1=0;
sumaUF2=0;
sumaUF3=0;
aboveAve = 0;
for x=1:length(Vpromedio)
    if Vpromedio(x)>Gaverage 
        aboveAve = aboveAve +1;
    end 
end
for x=1:3:25 
    sumaUF1=sumaUF1+(Vpromedio(x));
    sumaUF2=sumaUF2+(Vpromedio(x+1));
    sumaUF3=sumaUF3+(Vpromedio(x+2));
end 
aveSumaUF1= sumaUF1/9;
aveSumaUF2= sumaUF2/9;
aveSumaUF3= sumaUF3/9;

sumaGC1=0;
sumaGC2=0;
sumaGC3=0;

for x=1:9:19
    sumaGC1 = sumaGC1 + (Vpromedio(x))+(Vpromedio(x+1))+(Vpromedio(x+2));
    sumaGC2 = sumaGC2 + (Vpromedio(x+3))+(Vpromedio(x+1+3))+(Vpromedio(x+2+3));
     sumaGC3 = sumaGC3 + (Vpromedio(x+6))+(Vpromedio(x+1+6))+(Vpromedio(x+2+6));
end
    
aveSumaGC1= sumaGC1/9;
aveSumaGC2= sumaGC2/9;
aveSumaGC3= sumaGC3/9;

sumaSC1=0;
sumaSC2=0;
sumaSC3=0;
for x=1:9 
    sumaSC1= sumaSC1 + Vpromedio(x); 
     sumaSC2= sumaSC2 + Vpromedio(x+9); 
      sumaSC3= sumaSC3 + Vpromedio(x+18);
end
aveSumaSC1= sumaSC1/9;
aveSumaSC2= sumaSC2/9;
aveSumaSC3= sumaSC3/9;

disp(Gaverage)
disp(aboveAve)
disp(aveSumaUF1)
disp(aveSumaUF2)
disp(aveSumaUF3)
disp(aveSumaGC1)
disp(aveSumaGC2)
disp(aveSumaGC3)
disp(aveSumaSC1)
disp(aveSumaSC2)
disp(aveSumaSC3)

