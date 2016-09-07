clc;
clear all;

DIR = get_absolute_file_path("graficar_malla.sci") ;
load( DIR +"mallas.sod");

//getd(DIR);

 mtlb_axis([1, 9.5, 1, 9]); 
 xtitle("Interfaz","x","y");
[dominio1,imagen1] = procesar_malla_2D(xnode4 , icone4);
[dominio2,imagen2] = procesar_malla_2D(xnode5 , icone5);

for k=1:size(dominio1,1)
    plot( dominio1(k,:) ,imagen1(k,:) , 'r') ;
end

for k=1:size(dominio2,1)
    plot( dominio2(k,:) ,imagen2(k,:) , 'b') ;
end
