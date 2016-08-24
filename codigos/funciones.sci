clc;
clear all;
close;
//Funcion para pre-plotear las mallas, donde entran las matrices de la malla y salen todas las rectas a plotear para visualizar el mallado
function [X,Y] = procesar_malla_2D(xnode, icone)   
    nelementos =  size( icone,1 ) ;
    k = 1;
    for i=1:nelementos
        polpuntos = icone (i,:);
        nvertices = size(polpuntos , 2);
        for j=1:(nvertices-1)
            punto1_idx = polpuntos(1,j);
            punto2_idx = polpuntos(1,j+1);
            punto1 = xnode(punto1_idx,:); //punto en formato (x,y,z)
            punto2 = xnode(punto2_idx,:);
          
            X(k,1:2) =  [punto1(1,1) punto2(1,1) ] ;
            Y(k,1:2) =  [punto1(1,2) punto2(1,2) ];
            k = k + 1;
            
         end
         punto1_idx = polpuntos(1,nvertices);
         punto2_idx = polpuntos(1,1);
         punto1 = xnode(punto1_idx,:);
         punto2 = xnode(punto2_idx,:);
         
         X(k,1:2) =  [punto1(1,1) punto2(1,1) ] ;
         Y(k,1:2) =  [punto1(1,2) punto2(1,2) ] ;
         k = k + 1;
         
    end
endfunction

//function r = cruz (u , v)
//    r = [ u(1,2)*v(1,3) - u(1,3)*v(1,2) , u(1,3)*v(1,1) - u(1,1)*v(1,3) , u(1,1)*v(1,2) - u(1,2)*v(1,1) ] ;
//endfunction

function [chi,eta] = mapear_tri_2D(punto, T) //esta funcion mapea un punto de un triangulo al elemento master del triángulo.
    x = punto(1,1);
    y = punto(2,1);
    x1 = T(1,1);
    x2 = T(2,1);
    x3 = T(3,1);
    y1 = T(1,2);
    y2 = T(2,2);
    y3 = T(3,2);
    
    N2_xy = x*(y3-y1) + y*(x1-x3) + y1*x3 - y3*x1 ;
    den = (x2 - x1)*(y3 - y1)+ (y1 - y2)*(x3 - x1);
    N2_xy = N2_xy / den;
    
    N3_xy = x*(y1 - y2)+ y*(x2 - x1)+ y2*x1 - y1*x2;
    N3_xy = N3_xy /den;
    chi = N2_xy;
    eta = N3_xy;
endfunction

// mapeo de un punto en coordenadas (x,y) al elemento master da coordenadas (chi,eta) donde (chi,eta) pertenece a [-1,1]
function [chi,eta] = mapear_cuad_2D(punto, C) 
    p1 = [C(1,:) ]';
    p2 = [C(2,:) ]';
    p3 = [C(3,:) ]';
    p4 = [C(4,:) ]';
    
    coefs = [ (1/4)*(p1 + p2 +p3 + p4) , (1/4)*(p2 - p1 + p3 - p4) , (1/4)*(p3 - p2 + p4 - p1), (1/4)*(p1 - p2 + p3 - p4)] ;
    a = coefs(1,:);    
    b = coefs(2,:);
    x0 = a(1) - punto(1);
    y0 = b(1) - punto(2);
    
    if (a(4) ~=0 & a(2) ~=0) then
        eta = ( -a(2) )/a(4);
        chi = ( y0*a(4) + a(2)*b(3) ) / (a(4)*b(2) - a(2)*b(4) ) ;
    end
    if (a(4) ==0 & a(2) == 0) then
        eta = ( x0 )/a(3);
        chi = ( y0*a(3) - x0*b(3) ) / (a(3)*b(2) + x0*b(4) ) ;
    else
        A = a(4)*b(3) - a(3)*b(4);
        B = ( y0*a(4) + a(2)*b(3) ) - ( x0*b(4) + a(3)*b(2) ) ;
        K = y0*a(2) - x0*b(2) ;
        
        disc = B*B - 4*A*K ;
        if (disc<0) then
            eta = -99;
            chi = -99;
        else
            eta = (-B + sqrt(disc) ) / (2*A) ;
            chi = ( -(x0 + a(3)*eta) )/(a(2) + a(4)*eta )  ;
        end
    end
   
endfunction

// verifica si un punto está o no dentro del triángulo, utilizando elemento master para abaratar el costo computacional
// si 'punto' no pertenece al Triangulo T
function r = verificar_tri_2D(punto , T) 
    ////////////////////////////////////////////////////////////////// CAMBIOS!
    [chi,eta] = mapear_tri_2D(punto , T);
    if (chi<0 | eta<0 | chi>1 | eta>1 )
        r = -1 ;
    elseif((chi==1 & eta==0)|(chi==0 & eta==1))  //VERIFICAR SI EL PUNTO (punto) ES UN NODO (osea, si es una fila de T))
        r=1;
    else
        disp("chi="+string(chi));
        disp("eta="+string(eta));
        r = ( 1 - chi - eta) / abs(1 - chi - eta);
    end
endfunction

function r=verificar_cuad_2D(punto, C)
    [chi,eta] = mapear_cuad_2D(punto , C);
    r=1;
    if(chi<-1 | eta<-1 | chi>1 | eta>1)
        r=-1;
    end
endfunction


//Funcion que verifica si el punto pertenece al elemento de nodos-coordenados como M=[x1 y1; x2 y2; x3 y3] si el elemento_es_un_triangulo.
function r=verificar_2D(punto, M)
    n=size(M,1); //extraer cantidad de filas.
    if(n==3)
        r=verificar_tri_2D(punto,M);
    end
    
    if(n==4)
        r=verificar_cuad_2D(punto,M);
    end
endfunction

function valor=interpolar(punto, M, valores)
    n=length(M(:,1));
    // En caso de ser un triangulo, se interpolan los estados utilizando las correspondientes funciones de forma del traingulo master= N1;N2;N3.
    valor=[];
    if(n==3)
        [chi,eta]=mapear_tri_2D(punto,M);
        valor=[1-chi-eta, eta, chi]*valores;
    end
    // En caso de ser un cuadrilatero, se interpolan los estados utilizando las funciones de forma del cuadrilatero master= N1;N2;N3;N4.
    if(n==4)
        [chi,eta]=mapear_cuad_2D(punto,M);
        valor=.25*[(1-eta)*(1-chi), (1-eta)*(1+chi), (1+eta)*(1-chi), (1+eta)*(1+chi)]*valores;
    end
endfunction


// indices_nodos=indices de los nodos que conforman un elemento dado. Vector fila.
// estados_conocidos=base de datos donde se almacenan los estados conocidos (primer columna contiene el indice del nodo al cual se le asignan los estados)
// v=matriz donde cada fila es un estado-vector
function v=buscar_estado(indices_nodos,estados_conocidos)
    n=length(estados_conocidos(:,1));
    m=length(indices_nodos(1,:));
    v=[];
    for i=1:m
        for j=1:n
            if(estados_conocidos(j,1)==indices_nodos(1,i))
                v=[v;estados_conocidos(j,2:$)'];
            end
        end
    end
endfunction



