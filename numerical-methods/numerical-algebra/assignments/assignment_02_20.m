A = [1, 2, 3;
     4, 5, 6;
     7, 8, 9];
 
b = [1;
     1;
     1];
 
matrix_row_vec(A, b)
matrix_col_vec(A, b)

row_reduce(A, 1, 2) % A con las filas 1 y 2 intercambiadas
row_constant(A, 1, 2) % A con la fila 1 multiplicada por 2
row_linear_combination(A, 1, 2, -1) % con la fila 1 modificada habiendosela restado la fila 2