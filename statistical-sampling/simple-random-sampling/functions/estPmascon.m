%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Author: Jesús Alberto Tapia García
  Name: estPmascon

  Funcion para estimar con m.as. con reemplaziento una proporción y el error
  de estimacion de la confianza que fijemos

  Inputs:
    a la confianza valor de 0 a 1
    y la muestra tomada para estimar el parámetro en columna

  Output:
    estP la estimación de la propporción
    BP el error de estimacion fijada la confianza a

%}
function [estP, BP]=estPmascon(y, a)

  [n, nn]=size(y);
  %valor de la normal (0,1) para la confianza dada
  a2=1-((1-a)/2);
  k=norminv(a2,0,1);
  %Estimador (33)/N
  estP=mean(y);
  %Estimemso el ECM (41)
  ecmP=estP*(1-estP)/(n-1);
  BP=k*sqrt(ecmP);
end
