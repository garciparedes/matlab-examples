% Regla de Simpson compuesta
%
% Autor: Ángel San miguel Blanco
%
% Datos
% f_ integrado, escrito como una cadena con "función anónima": '@x f(x)'
% a,b extremos de la integral.
% n número de particiones
%
% Resultado
% VI valor de la integral de f en [a,b]


function VI = RSimpsonC(f_, a, b, n)
  interval = linspace(a, b, n);
  VI = sum(RSimpsonS(f_, interval(1:(n - 1)), interval(2:n)));
