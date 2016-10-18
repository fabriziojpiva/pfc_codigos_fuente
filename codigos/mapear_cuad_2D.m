%% punto = punto sobre el que se quiere realizar la inversion (es un vector fila de 1x2).
%% X es una matriz de 4x2 que contiene las coordenadas de los nodos (X(i,:)=(xi,yi)).
function [chi,eta]=mapeo_inverso_bilineal(punto,X)
p1=X(1,:);
p2=X(2,:);
p3=X(3,:);
p4=X(4,:);

%% calculo de chi mediante la resolucion de la ecuacion cuadratica

C_chi=cruz2D(punto,p4+p3-p1-p2)+.5*cruz2D(p4+p3,p1+p2);
B_chi=cruz2D(punto,(p3-p4-p2+p1))+cruz2D(p3,p2)+cruz2D(p1,p4);
A_chi=.5*cruz2D(p3-p4,p2-p1);

if(B_chi>0)
    chi=(-B_chi+sqrt(B_chi*B_chi-4*A_chi*C_chi))/(2*A_chi);
else
    chi=2*C_chi/(-B_chi+sqrt(B_chi*B_chi-4*A_chi*C_chi));
end

%% Calculo de eta resolviendo lo siguiente: (todos los vectores son columna)
%% U = .5*(1-eta)*p12+.5*(1+eta)*p43.
%%   = .5*(p43+p12)+.5*(p43-p12)*eta.

%% Y hacemos el producto escalar miembro a miembro con delta=(p43-p12) para despejar eta.

p43=.5*(p4+p3+(p3-p4)*chi)';
p12=.5*(p2+p1+(p2-p1)*chi)';
delta=(p43-p12);
eta=(((2*punto)-(p43+p12)')*delta)/(delta'*delta);

endfunction