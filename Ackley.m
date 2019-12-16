function Y = Ackley(X)
% Objective function definition
[nbRows, nbCols] = size(X);
if nbRows > 1 && nbCols > 1 % Matrix evaluation
    Nd = nbCols;
    sum1 = sum(X.^2,2);
    sum2 = sum(cos(2*pi*X),2);
else
    Nd = length(X);
    sum1 = sum(X.^2);
    sum2 = sum(cos(2*pi*X));
end
f_x = 20 + exp(1);
f_x = f_x -20 * exp(-0.2*sqrt(sum1/Nd))  -  exp( sum2/Nd );

Y = f_x;

end