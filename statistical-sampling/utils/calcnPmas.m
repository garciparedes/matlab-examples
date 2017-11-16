%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Author: Jesús Alberto Tapia García
  Name: calcnPmas

  Función para determinar el tamaño de muestra necesario para estimar una
  proporcion en m.a.s. sin muestra previa

  Inputs:
    N tamaño de la población
    c porcentaje de confianza
    B error de estimacion de una proporcion

  Output:
    n tamaño de la muestra

%}
function n = calcnPmas(N, c, B)
  aux1 = (1 - c) / 2;
  aux2 = 1 - aux1;
  k = norminv(aux2, 0, 1);
  n0 = k ^ 2 * 0.25 * N / (B ^ 2 * (N - 1));
  n = n0 / ((n0 / N) + 1);
  n = ceil(n);
end
