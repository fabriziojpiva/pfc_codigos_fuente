% verifica si un punto está o no dentro del cuadrado, mediante la técnica de los productos cruces:
%se hace el producto cruz entre cada arista del polígono con el vector formado por la diferencia
%entre el punto en cuestión y el primer vértice de la arista.
%el punto es un vector fila y cada fila de la matriz C tiene las coordenadas de cada vértice del
%cuadrado.
function r=verificar_cuad_2D(punto, C)
    C(5,:) = C(1,:);
    r=1;
    i=1;
    while(r~=(-1) && i<=4)
        k = cruz( C(i+1,:) - C(i,:) , punto - C(i,:) );
        if (k(3) < 0) 
            r=-1;
        endif
        i = i + 1;
        endwhile 
endfunction