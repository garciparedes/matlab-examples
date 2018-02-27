function [ Ab ] = naive_gauss(Ab)
%naive_gauss Applies the gauss algorithm
%   Applies the gauss algorithm
%
%   abuthor: Sergio García Prado - garciparedes.me

    [n_rows, n_columns] = size(Ab);

    for i = 1:n_rows;
      for j = i+1:n_rows;
        Ab = row_combine(Ab, j, i, - Ab(j,i) / Ab(i,i));
      end
    end

    for i = n_rows:-1:1;
      Ab = row_constant(Ab, i, 1 / Ab(i,i));
      for j = i-1:-1:1;
        Ab = row_combine(Ab, j, i, - Ab(j,i) / Ab(i,i));
      end
    end

end
