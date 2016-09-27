
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

estados=calcular_estado(icone_s,xnode_s,state_s,xnode_f,state_f);

# Calculo de error en test de Boer:

exact = 0.01*cos(2*pi.*xf(1:length(xf)-1) );
den = exact*exact';
dif = estados(1:length(xf)-1,2)-exact';
num= dif'*dif;
error= sqrt(num/den);

