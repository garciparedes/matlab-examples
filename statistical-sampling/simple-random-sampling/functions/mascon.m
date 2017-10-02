%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Author: Jesús Alberto Tapia García
  Name: mascon

  Obtención de una m.a.s. con de una población

  Input:
    N: Tamaño de la población
    n: Tamaño de la muestra
%}
function muestra=mascon(N,n)
  un=fix(unifrnd(1,N+1));
  j=1;
  muestra(1,1)=un;
  while (j<n)
  	un=fix(unifrnd(1,N+1));
  	j=j+1;
  	muestra(j,1)=un;
  end
end
