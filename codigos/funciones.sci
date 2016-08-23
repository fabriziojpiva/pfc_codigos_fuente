
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

function r = cruz (u , v)
    r = [ u(1,2)*v(1,3) - u(1,3)*v(1,2) , u(1,3)*v(1,1) - u(1,1)*v(1,3) , u(1,1)*v(1,2) - u(1,2)*v(1,1) ] ;
endfunction

function [chi,eta] = mapear_triangulo_2D(punto, T) //esta funcion mapea un punto de un triangulo al elemento master del triángulo.
    x = punto(1,1);
    y = punto(1,2);
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

function [chi,eta] = mapear_cuadrado_2D(punto, C) //esta funcion mapea un punto de un triangulo al elemento master del triángulo.
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

function r = verificar_triangulo_2D(punto , T) // verifica si un punto está o no dentro del triángulo, utilizando elemento master para abaratar el costo computacional
    
    [chi,eta] = mapear_triangulo_2D(punto , T);
    if chi<0 | eta<0 | chi>1 | eta>1 then
        r = -1 ;
    else
        r = ( 1 - chi - eta) / abs(1 - chi - eta);
    end
endfunction
