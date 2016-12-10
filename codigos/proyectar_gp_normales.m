function [elemento,chi]=proyectar_gp_normales(elemento_de_punto,punto,icone, xnode)
E_c=length(icone(:,1));
verificacion=-1;
X=[];
punto_interseccion=[];
normal_corregida=[];
j=1;
chi=-99;
elemento=-1;
while (j<(E_c+1) && verificacion==-1)
            % nodos contiene los nodos que conforman los vertices del j-esimo elemento
            nodos=icone(j,:);
            X = xnode(nodos',:);
            % verificar controla que el punto pertenezca al j-esimo elemento. Si verificar=1 pertenece, Si verificar=-1 NO pertenece.
            % punto es el nodo de la malla con estados desconocidos.
            % X es el conjunto de coordenadas de los nodos, ya sea de triangulo (matriz de 3x2) o cuadrilatero (matriz de 4x2)
            [verificacion,punto_interseccion,normal_corregida]=proyectar_punto_de_elemento(elemento_de_punto,punto,X);
            j=j+1;
endwhile

if(verificacion==1)
 % se asignan los estados interpolados a los estados desconocidos
  chi=(2*punto_interseccion-X(1,:)-X(2,:))*(X(2,:)-X(1,:))';
  chi=chi/(norm(X(2,:)-X(1,:)))^2;
  elemento=j-1;
endif        
end