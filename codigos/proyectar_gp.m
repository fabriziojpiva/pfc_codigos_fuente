function [elemento,chi]=proyectar_gp(punto,icone_conocido, xnode_conocido)
E_c=length(icone_conocido(:,1));
verificacion=-1;
X=[];
j=1;
chi=-99;
elemento=-1;
while (j<(E_c+1) && verificacion==-1)
            % nodos contiene los nodos que conforman los vertices del j-esimo elemento
            nodos=icone_conocido(j,:);
            X = xnode_conocido(nodos',:);
            % verificar controla que el punto pertenezca al j-esimo elemento. Si verificar=1 pertenece, Si verificar=-1 NO pertenece.
            % punto es el nodo de la malla con estados desconocidos.
            % X es el conjunto de coordenadas de los nodos, ya sea de triangulo (matriz de 3x2) o cuadrilatero (matriz de 4x2)
            [alpha,verificacion]=verificar_2D(punto,X);
            j=j+1;
        endwhile
        if(verificacion==1)
            % se asignan los estados interpolados a los estados desconocidos
            chi=2*alpha-1;
            elemento=j-1;
        endif        
end