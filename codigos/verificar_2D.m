
%Funcion que verifica si el punto pertenece al elemento en cuestión. El elemento puede ser un
%segmento, triangulo o cuadrado. Convención: si pertenece, r = 1, sino r = -1.
function [alpha,r]=verificar_2D(punto, M)
global tol;
    alpha=0;
    n=size(M,1); %extraer cantidad de filas.
    switch(n)
    case (2) 
        [alpha,r]=verificar_seg_2D(punto,M);
    case (3) 
        r=verificar_tri_2D(punto,M);
    
    case (4) 
        r=verificar_cuad_2D(punto,M);
    endswitch
    
endfunction