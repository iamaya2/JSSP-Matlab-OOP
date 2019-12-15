function Y = Jong(X)
[nbRows, nbCols] = size(X);
if nbRows > 1 && nbCols > 1 % Matrix evaluation
    Y = sum(X.^2 , 2); % Sweeps columns and sum
else
%     Y = sum(X.^2); % Sweeps columns and sum
Y = norm(X)^2;
end
end