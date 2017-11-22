% Regla de Simpson Simple
%
% Autor: Ángel San miguel Blanco
% Autor: Sergio García PRado
%
% Datos
% f_ integrado, escrito como una cadena con "función anónima": '@x f(x)'
% a,b extremos de la integral.
%
% Resultado
% VI valor de la integral de f en [a,b]


function VI = RSimpsonS(f_, a, b)
  f = str2func(f_);
  VI = 1/6 * (b - a) * f(a) + 4 / 6 *(b - a) * f(1 / 2 * (a + b)) + 1 / 6 * (b - a) * f(b);
