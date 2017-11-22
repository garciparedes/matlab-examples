% Regla del Punto Medio Simple
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


function VI = RPuntoMedioS(f_, a, b)
  f = str2func(f_);
  VI = (b - a) * f(0.5 *  (a + b));
