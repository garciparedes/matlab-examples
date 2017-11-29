% Regla de Simpson 3/8 Simple
%
% Autor: Ángel San miguel Blanco
% Autor: Sergio García PRado
%
% Datos
% f_ integrado, escrito como una cadena con "función anónima": '@x f(x)'
% a,b,c,d extremos de la integral.
%
% Resultado
% VI valor de la integral de f en [a, d]


function VI = RSimpson38S(f_, a, b, c, d)
  f = str2func(f_);
  VI = (3 ./ 8) .* (b - a) .* (f(a) +  3 .* f(b) + 3 .* f(c) + f(d));
