var1 = [1 2 3; 4 5 6] ;
var2 = [var1 var1];
n1 = pi^2;
n2 = pi*pi;
op1 = 1/(n1-n2);
op2 = (n2-pi^2)/(n1-n2)
a1=12:2:20;
a2= 13:2:21;
a3 = a1 + a2;
a4 = a1.*a2
%%
struct1.escalar = input("introduzca un numero")
struct1.arreglo = 0:100:1000
%%
struct1.suma = struct1.escalar + struct1.arreglo
%%
save("estructura2",'struct1')
%%
newpath= genpath('estructuraytotal')
%%
addpath(newpath)
%%
load("Estructura")
%%
load("Total")
%%
load("estructura2")
%%
disp(struct1)
%%
formatSpec = '%4.4f'
fprintf(formatSpec,struct1.escalar)
%%
A1 = [9.9, 9900];
A2 = [8.8,  7.7 ; ...
      8800, 7700];
formatSpec = 'X is %4.2f meters or %8.3f mm\n';
fprintf(formatSpec,A2)
%%
arreglo = 5:3:15;
arreglo(10) = -2
%%
Arr1 = 10:10:60
Arr2 = (1:6)'
Oper1 =Arr1 +Arr2 
%%
Oper2 =Arr1 *Arr2
%%
Oper3 =Arr1.*Arr2
%%
array = 10:20 
%%
orden =randperm(length(array))
%% 
randomarray=array(orden)
%%
[maxnum, maxpos] = max(array)
%%
[ordered_array, unsortedpos] = sort(randomarray)
%%
[ordered_array, unsortedpos] = sort(randomarray,'descend')