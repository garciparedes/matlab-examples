%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Author: Jesús Alberto Tapia García
  Name: estPmascon

  Función para estimar con m.as. con reemplazamiento una proporción y el error
  de estimacion de la confianza que fijemos

  Inputs:
    y: la muestra tomada para estimar el parámetro en columna
    a: la confianza valor de 0 a 1

  Output:
    estP: la estimación de la proporción
    BP: el error de estimacion fijada la confianza según el valor `a`

%}
function [estP, BP] = estPmascon(y, a)
  [n, nn] = size(y);
  % Valor de la normal (0,1) para la confianza dada
  a2 = 1 - ((1 - a) / 2);
  k = norminv(a2, 0, 1);
  % Estimador (33)/N
  estP = mean(y);
  % Estimemos el ECM (41)
  ecmP = estP * (1 - estP) / (n - 1);
  BP = k * sqrt(ecmP);
end
