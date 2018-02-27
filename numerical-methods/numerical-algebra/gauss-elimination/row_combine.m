function [ X ] = row_combine(X, r1, r2, c )
%row_linear_combination Replaces row in position r1 of X between the linear
%combination of row r1 plus row r2 dot c
%   Replaces row in position r1 of X between the linear combination of row
%   r1 plus row r2 dot c
%
%   Author: Sergio García Prado - garciparedes.me
    X(r1, :) = X(r1, :) + X(r2, :) * c;
end
