% Regla de Simpson 3/8 compuesta
%
% Autor: Ángel San miguel Blanco
% Autor: Sergio García PRado
%
% Datos
% f_ integrado, escrito como una cadena con "función anónima": '@x f(x)'
% a,b extremos de la integral.
% n número de particiones (debe ser múltiplo de 1 + 3k)
%
% Resultado
% VI valor de la integral de f en [a,b]


function VI = RSimpson38C(f_, a, b, n)
  interval = linspace(a, b, n);
  VI = sum(RSimpson38S(f_, interval(1:3:(n - 3)), interval(2:3:(n - 2)), interval(3:3:(n - 1)), interval(4:3:n)));
