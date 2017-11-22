% Regla del Trapecio Simple
%
% Autor: Ángel San miguel Blanco
%
% Datos
% f_ integrado, escrito como una cadena con "función anónima": '@x f(x)'
% a,b extremos de la integral.
%
% Resultado
% VI valor de la integral de f en [a,b]


function VI = RTrapecioS(f_, a, b)
  f = str2func(f_);
  VI = 0.5 .* (b .- a) .* (f(a) + f(b));
