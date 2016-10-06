function estados=calcular_estado_normales(icone_conocido,xnode_conocido,estados_conocidos,xnode_desconocidos,estados_desconocidos,modo)
    estados=estados_desconocidos;
    N=length(estados(:,1)); % cantidad de nodos sobre los que calcular los estados
    # Trabajo para el primer nodo, ya que este no tiene vecino por izquierda:
    indice_primer_nodo = estados_desconocidos(1,1);
    primer_punto = xnode_desconocidos(indice_primer_nodo,:)';
    punto_siguiente = xnode_desconocidos(indice_primer_nodo+1,:);
    delta = norm( punto_siguiente-primer_punto ,2);
    nodo_ficticio = [primer_punto(1) - delta , primer_punto(2),0];
    vecinos = [nodo_ficticio;punto_siguiente];
    
    [datos,nodos] = busqueda_pertenencia(icone_conocido,xnode_conocido,primer_punto,vecinos,modo);
    estados(1,2:end) = proyectar(datos,estados_conocidos,nodos);
    
    for i=2:(N-1)
% se extrae del arreglo de estados la primer componente que contiene el indice del nodo. Éste nodo, deberá pertenecer a algún elemento de la malla conocida
        indice_nodo=estados(i,1); 
% para el nodo de indice indice_nodo, se buscan sus coordenadas espaciales
        punto=xnode_desconocidos(indice_nodo,:)';
        vecinos = buscar_vecinos(indice_nodo, xnode_desconocidos); %se buscan los elementos vecinos.
% Luego, se comienza el proceso de determinación de pertenencia a algún elemento de la malla conocida.
        [datos,nodos] = busqueda_pertenencia(icone_conocido,xnode_conocido,punto,vecinos,modo);
        % buscar estado en estados_conocidos.
        estados(i,2:end)= proyectar(datos,estados_conocidos,nodos);
    endfor
    
    # Trabajo para el ultimo nodo, ya que este no tiene vecino por izquierda:
    indice_ultimo_nodo = estados_desconocidos(size(estados_desconocidos,1) ,1);
    ultimo_punto = xnode_desconocidos(indice_ultimo_nodo,:)';
    punto_anterior = xnode_desconocidos(indice_ultimo_nodo-1,:);
    delta = norm( ultimo_punto-punto_anterior ,2);
    nodo_ficticio = [ultimo_punto(1) + delta , ultimo_punto(2),0];
    vecinos = [punto_anterior;nodo_ficticio];
    
    [datos,nodos] = busqueda_pertenencia(icone_conocido,xnode_conocido,ultimo_punto,vecinos,modo);
    estados(size(estados,1),2:end) = proyectar(datos,estados_conocidos,nodos);
    
endfunction