

% indices_nodos=indices de los nodos que conforman un elemento dado. Vector fila.
% estados_conocidos=base de datos donde se almacenan los estados conocidos (primer columna
% contiene el indice del nodo al cual se le asignan los estados)
% v=matriz donde cada fila es un estado-vector
% Esta función tiene por objetivo buscar en la matriz de estados de toda la malla, cuales son
% los estados correspondientes a un elemento dado de esa malla. Por ejemplo, para saber cuales
% son las temperaturas que tiene el triángulo número 20 en una malla de 300 elementos triangulares.
function v=buscar_estado(indices_nodos,estados_conocidos)
    n=length(estados_conocidos(:,1));
    m=length(indices_nodos(1,:));
    v=[];
    for i=1:m
        for j=1:n
            if(estados_conocidos(j,1)==indices_nodos(1,i))
                v=[v;estados_conocidos(j,2:end)]; %Aqui se hace una copia desde la columna 2 en
                                                 %adelante porque se considera que la primer
                                                 %columna es para decir que nodo es, y las columnas
                                                 %restantes el dato del estado (sea vector u
                                                 %escalar.
            endif
        end
    end
endfunction



