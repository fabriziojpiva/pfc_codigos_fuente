
%Funcion para pre-plotear las mallas, donde entran las matrices de la malla y salen todas las
%rectas a plotear para visualizar el mallado
function [X,Y] = procesar_malla_2D(xnode, icone)   
	tol = 1e-6;
    nelementos =  size( icone,1 ) ;
    k = 1; %%indice para colocar cada recta en las dos matrices X e Y. La
           %%matriz X contiene los puntos de la forma [x1 x2] y la Y los
           %%correspondientes [y1 y2], para que luego podamos hacer uso
           %%de la función plot( [x1 x2], [y1 y2] ) que dibuja la recta
           %%que pasa por los puntos (x1,y1) y (x2,y2).
    for i=1:nelementos
        polpuntos = icone (i,:);%tomamos las conectividades del elemento, sea recta, triángulo o cuadrado
        nvertices = size(polpuntos,2);
        for j=1:(nvertices-1)
            punto1_idx = polpuntos(1,j); %Agarramos el indice de nodo del primer punto.
            punto2_idx = polpuntos(1,j+1); %Agarramos el indice de nodo del segundo punto.
            punto1 = xnode(punto1_idx,:); %punto en formato (x,y,z)
            punto2 = xnode(punto2_idx,:);
          % Guardamos en las matrices las coordenadas como fueron explicadas mas arriba.
            X(k,1:2) =  [punto1(1,1) punto2(1,1) ] ;
            Y(k,1:2) =  [punto1(1,2) punto2(1,2) ];
            k = k + 1;
            
	end
	%A la salida del for, falta procesar el ultimo segmento de recta, que se hace de la
        %misma manera.
         punto1_idx = polpuntos(1,nvertices); 
         punto2_idx = polpuntos(1,1);
         punto1 = xnode(punto1_idx,:);
         punto2 = xnode(punto2_idx,:);
         
         X(k,1:2) =  [punto1(1,1) punto2(1,1) ] ;
         Y(k,1:2) =  [punto1(1,2) punto2(1,2) ] ;
         k = k + 1;
         
    end
endfunction