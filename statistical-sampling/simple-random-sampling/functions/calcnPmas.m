%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Author: Jesús Alberto Tapia García
  Name: calcnPmas

  Función para determinar el calculo de muestra necesario para estimar una
  proporcion en m.a.s. sin muestra previa

  Inputs:
    N tamaño de la poblacion
    c porcentaje de confianza
    B error de estimacion de una proporcion

%}
function n = calcnPmas(N, c, B)
  aux1 = (1 - c) / 2;
  aux2 = 1 - aux1;
  k = norminv(aux2, 0, 1);
  n0 = k * k * 0.25 * N / (B * B * (N - 1));
  n = n0 / ((n0 / N) + 1);
  n = ceil(n);
end
