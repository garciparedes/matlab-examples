%Solucion ejercicio 1 d practicas
clear
load comunida

%Tamaños de los estratos
N1=15000;
N2=90000
basloc1=normrnd(100,20,N1,1);
basviv1=normrnd(50,10,N2,1);
for i=1:N1
    if basloc1(i,1)<0     
    basloc1(i,1)=0;
    end
end
for i=1:N2
    if basviv1(i,1)<0
            basviv1(i,1)=0;
    end
end

for i=1:N1
    clear u
    u=unifrnd(0,1);
    if u<0.25  
    basloc2(i,1)=1;
    else
     basloc2(i,1)=0;   
    end
end

for i=1:N2
    clear u
    u=unifrnd(0,1);
    if u<0.1  
    basviv2(i,1)=1;
    else
            basviv2(i,1)=0;
    end
end
 
save basuras2013 basviv1 basviv2 basloc1 basloc2