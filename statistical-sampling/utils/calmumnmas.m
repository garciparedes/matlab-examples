%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Author: Jesús Alberto Tapia García
  Name: calmumnmas

  Obtención del tamaño de muestra para el parametro media poblacional en m.a.s.
  fijado un error de estimacion y una confianza formulas 55 y 57

  Inputs:
    N tamaño de la poblacion
    B error de estimacion
    menalf confianza 1-alpha
    s2 estimacion de la cuasivarianza poblacional

%}
function n = calmumnmas(N, B, menalf, s2)
  a=(1-menalf)/2;
  k=norminv(1-a,0,1);
  n0=k*k*s2/(B*B);
  n=n0/((n0/N)+1);
  n=ceil(n);
end
