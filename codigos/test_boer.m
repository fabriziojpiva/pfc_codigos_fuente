%clc;
%clear all;
%close all;
load("mallas.mat");

global tol = 1e-6;

[dominio1,imagen1] = procesar_malla_2D(xnode_s , icone_s);
[dominio2,imagen2] = procesar_malla_2D(xnode_f , icone_f);


# axis([0, 5, 0, 5]); 
 title("Interfaz");
 xlabel("x");
 ylabel("y");
 hold on;
for k=1:size(dominio1,1)
    plot( dominio1(k,:) ,imagen1(k,:) , 'r') ;
end

for k=1:size(dominio2,1)
    plot( dominio2(k,:) ,imagen2(k,:) , 'b') ;
end
hold off;

% estados=calcular_estado(icone_f,xnode_f,state_f,xnode_s,state_s);
%estados=calcular_estado_normales(icone_s,xnode_s,state_s,xnode_f,state_f,1);
estados=calcular_estado_normales(icone_f,xnode_f,state_f,xnode_s,state_s,0);
# Calculo de error en test de Boer:

exact = 0.01*cos(2*pi.*xs(1:length(xs)) );
den = exact*exact';
dif = estados(1:length(xs),2)-exact';
num= dif'*dif;
error= sqrt(num/den)

# Calculo de error integral. El valor exacto es 0.
% Estados aroximados:

I=integrar(xnode_s,estados);

%# Grafico de la funcion error:
%
%figure;
%# Errores de proyeccion nuestra
%loglog( 2.^([0 1 2 3 4 5])*5 +1 , [0.16707 0.043912 0.011274 0.0028384 7.1174e-4 1.7818e-4]);
%legend("Proyeccion s/n");
%figure;
%loglog( 2.^([0 1 2 3 4 5])*5 +1 , [0.16949 0.044183 0.011285 0.0028392 7.1179e-4 1.7818e-4]);
%legend("Proyeccion N & P");
%figure;
%loglog( 2.^([0 1 2 3 4 5])*5 +1 , [0.16978 0.044198 0.011286 0.0028393 7.1179e-4 1.7818e-4]);
%legend("Proyeccion P & N");