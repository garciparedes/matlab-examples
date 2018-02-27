function [ X ] = row_constant(X, r, c )
%row_constant Multiplies row at position r of X by c
%   Multiplies row at position r of X by c
%
%   Author: Sergio García Prado - garciparedes.me

    X(r, :) = X(r, :) * c;
end
