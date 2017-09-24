%{

  University: Universidad de Valladolid
  Degree: Grado en Estadística
  Subject: Muestreo Estadístico 1
  Year: 2017/18
  Teacher: Jesús Alberto Tapia García
  Author: Sergio García Prado (garciparedes.me)
  Name: bernoulli-02.m

%}


%Resolver el ejercico presentado en teoría
%Tenemos 600 alumnos
N=600;
%Tomemos una muestra de Bernoulli con probabilidad de seleccion 1/6

%Simulemos los datos poblacionales para poder tomar la muestra
datpob=unifrnd(0,10,N,1);

%Generara datos poblacionales para saber si el individuo aprueba 5 o no
%aprueba
Y=zeros(N,1);
for i=1:N
    if datpob(i,1)>=5
        Y(i,1)=1;
    else
        Y(i,1)=0;
    end
end

%Considermeos el parametro
P=sum(Y)/N;
%P=mean(Y)
%este paramtro es proporcion de aprobados

%Ejercio estimar P utilzando metodologia de Bernoulli con probabilidad de
%seleccion de cada individuo de la poblacion pib=0.3 y las dos opciones de
%estimadores
