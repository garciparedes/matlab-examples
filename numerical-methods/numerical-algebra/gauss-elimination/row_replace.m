function [ X ] = row_replace(X, r1, r2 )
%row_replace Replaces row at r1 between r2 on X
%   Replaces row at r1 between r2 on X
%
%   Author: Sergio García Prado - garciparedes.me

    t = X(r1, :);
    X(r1, :) = X(r2,:);
    X(r2,: ) = t;
end
