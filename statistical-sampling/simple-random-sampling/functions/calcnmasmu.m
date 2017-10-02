%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Author: Jesús Alberto Tapia García
  Name: calcnmasmu

  Funcion para calcular el tamaño de muestra para estimar la media
  poblacional en m.a.s

  Inputs:
    B: error de estimación
    conf: confianza que deseamos de 0 a 1
    N: Tamaño de la poblacion
    cv: cuasivarianza poblacional (estimada)

%}
function n = calcnmasmu(N, cv, B, conf)
  k = norminv(1 - ((1 - conf) / 2));
  n0 = k ^ 2 * cv / (B ^ 2);
  n = n0 / ((n0 / N) + 1);
  n = ceil(n);
end
