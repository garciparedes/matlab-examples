%
% Título:
% Ejemplo de eliminación gaussiana sobre sistema lineal compatible determinado
% con soluciones no cercanas a cero
%
% Autor:
% Sergio García Prado - garciparedes.me
%
% Fecha:
% 27 de Febrero
%

A = [2, 3, 4, 5;
     6, 15, 19, 23;
     8, 42, 60, 70;
     12, 60, 1, 17];

b = [5;
     30;
     98;
     144];


Ab = [A,b];

naive_gauss(Ab)
