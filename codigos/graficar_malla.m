clc;
clear all;
DIR = make_absolute_filename("graficar_malla.m") ;
pos_ultima_barra=rindex(DIR,"/");
DIR(pos_ultima_barra+1:end)="";
cadena= DIR;
mallas_filename = strcat(cadena,"mallas.mat");
load( mallas_filename ) ;
[dominio1,imagen1] = procesar_malla_2D(xnode1 , icone1);
[dominio2,imagen2] = procesar_malla_2D(xnode2 , icone2);

axis([0, 5, 0, 6]); 
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
