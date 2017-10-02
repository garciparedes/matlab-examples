%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Author: Jesús Alberto Tapia García
  Name: estvmascon

  Función dada una m.a.s. con reemplazamiento estimamos el parametro y el ecm

  Inputs:
    N: tamaño de la poblacion
    y: la muestra observada en columna

%}
function [estau, estv] = estvmascon(N, y)
  [n, nn] = size(y);
  %Programo expresions (33) y (39) de teor�a
  pk = (1 / N);
  estau = (1 / n) * sum(y) / pk;
  estv = N * N * var(y) / n;
end
