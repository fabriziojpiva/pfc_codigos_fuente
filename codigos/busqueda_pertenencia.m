
function [datos,nodos] = busqueda_pertenencia(icone_conocido,xnode_conocido,punto,vecinos,modo)
datos=(-1)*ones(1,2);
M=length(icone_conocido(:,1)); % cantidad de elementos que conforman el dominio con estados conocidos
j=1;
        while (j<(M+1) && datos(1)==-1)
            % nodos contiene los nodos que conforman los vertices del j-esimo elemento
            nodos=icone_conocido(j,:);
            X = xnode_conocido(nodos',:);
            % verificar controla que el punto pertenezca al j-esimo elemento. Si verificar=1 pertenece, Si verificar=-1 NO pertenece.
            % punto es el nodo de la malla con estados desconocidos.
            % X es el conjunto de coordenadas de los nodos, ya sea de triangulo (matriz de 3x2) o cuadrilatero (matriz de 4x2)
            datos=verificar_2D_normales(punto,X,vecinos,modo);
            j=j+1;
        endwhile
        endfunction