
function estados=calcular_estado(icone_conocido,xnode_conocido,estados_conocidos,xnode_desconocidos,estados_desconocidos)
    estados=estados_desconocidos;
    N=length(estados(:,1)); % cantidad de nodos sobre los que calcular los estados
    M=length(icone_conocido(:,1)); % cantidad de elementos que conforman el dominio con estados conocidos
    for i=1:N
% se extrae del arreglo de estados la primer componente que contiene el indice del nodo. Éste nodo, deberá pertenecer a algún elemento de la malla conocida
        indice_nodo=estados(i,1); 
% para el nodo de indice indice_nodo, se buscan sus coordenadas espaciales
        punto=xnode_desconocidos(indice_nodo,:)'; 
% Luego, se comienza el proceso de determinación de pertenencia a algún elemento de la malla conocida.
        j=1;
        verificacion=-1;
        while (j<(M+1) && verificacion==-1)
            % nodos contiene los nodos que conforman los vertices del j-esimo elemento
            nodos=icone_conocido(j,:);
            X = xnode_conocido(nodos',:);
            % verificar controla que el punto pertenezca al j-esimo elemento. Si verificar=1 pertenece, Si verificar=-1 NO pertenece.
            % punto es el nodo de la malla con estados desconocidos.
            % X es el conjunto de coordenadas de los nodos, ya sea de triangulo (matriz de 3x2) o cuadrilatero (matriz de 4x2)
            verificacion=verificar_2D(punto,X);
            j=j+1;
        endwhile
        % buscar estado en estados_conocidos.
        if(verificacion==1)
            % valores contiene los valores de los estados conocidos
            valores=buscar_estado(nodos,estados_conocidos);
            % se asignan los estados interpolados a los estados desconocidos
            estados(i,2:end)=interpolar(punto,X,valores);
        endif
    endfor
endfunction

