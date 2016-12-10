%% Se proyecta desde el elemento A hacia el B
%elemento_A=[xa1 ya1 za1;
%            xa2 ya2 za2]

%elemento_B=[xb1 yb1 zb1;
%            xb2 yb2 zb2]

function [r,punto_interseccion,normal_corregida]=proyectar_punto_de_elemento(elemento_A,punto,elemento_B)
pa1=elemento_A(1,:);
pa2=elemento_A(2,:);
pb1=elemento_B(1,:);
pb2=elemento_B(2,:);

na=(pa2-pa1)./norm(pa2-pa1);
na=[na(2), -na(1), na(3)];

diferencia_b=(pb2-pb1);

A = [na(1) -diferencia_b(1) ; na(2) -diferencia_b(2)];

b = [pb1(1) - punto(1); pb1(2) - punto(2)];

coefs = A\b;
alpha= coefs(1,1);
beta = coefs(2,1);

normal_corregida=na;
punto_interseccion=[-99, -99, -99];

if ( beta < 0 || beta > 1 )
  r = -1 ; % afuera.
 else
  r = 1; %adentro.
  if(alpha<0)
    normal_corregida=-1.*na;
   end
  punto_interseccion=pb1+beta.*diferencia_b;
endif

endfunction