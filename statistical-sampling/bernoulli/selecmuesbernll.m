%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Author: Jesús Alberto Tapia García
  Name: selecmuesbernll

  Función para tomar la muestra en un disño de Bernoulli, es decir, decidr
  los individuos de la poblacion que estan en la muestra.

  Inputs:
    N: tamaño de la población.
    p: probabilidad de seleccion de un individuo en el diseño de Bernoulli.
%}
function muestra = selecmuesbernll(N,p)
  j=0;

  %Procedimiento de Bernoulli
  for i=1:N
      clear e
      e=unifrnd(0,1);
      if e<=p
          j=j+1;
          muestra(j,1)=i;
      end
  end
end
