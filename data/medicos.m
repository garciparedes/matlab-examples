%datos poblacionales

N1=200
id1=[1:1:200]'

h1=round(unifrnd(0,0.6,200,1))
t1=sum(h1)


N2=300
id2=[1:1:300]'
h2=round(unifrnd(0.1,0.7,300,1))
  t2=sum(h2)  
 

NI=50
nI=5
id3=[1:1:50]'
%numero de medicos
medcs=round(unifrnd(8,12,50,1))
N3=sum(medcs)
t=unifrnd(0.6,1,50,1)
cs=round(t.*medcs)
t3=sum(cs)

hosp1=[id1 h1]
hosp2=[id2 h2]
censad=[id3 medcs cs]

p=[t1/N1, t2/N2, t3/N3]

%Tomemos muestras

m1=mas(N1,20)
m2=mas(N2, 30)
m3=mas(NI,5)

%respuestas
rhosp1=hosp1(m1,1:2)
rhosp2=hosp2(m2,1:2)
rcensad=censad(m3,1:3)


save datpob hosp1 hosp2 censad
save datmue rhosp1 rhosp2 rcensad