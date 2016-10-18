% mapeo de un punto en coordenadas (x,y) al elemento master da coordenadas (chi,eta) donde
% (chi,eta) pertenece a [-1,1]. Se plantea una interpolación bilineal, con parámetros chi y eta,
% quedando una formula bilineal en las variables chi y eta tanto en x como en y. Luego se
% despeja de una el valor de chi, y se reemplaza en la otra, para que queden dos fórmulas
% explícitas para chi y eta. Esta fórmula explícita, tiene forma de ecuación cuadrática (Ax^2 +
% Bx + C), que se resuelve por la fórmula de la resolvente. También recordemos que hay casos
% particulares (donde A=0 por ejemplo) que se consideran para evitar divisiones por cero o un
% discriminante negativo.
% Por convención, un punto que no pertence al cuadrado será mapeado a las coordenadas chi=-99 y
% eta= -99.
function [chi,eta] = mapear_cuad_2D(punto, C) 
    tol=1e-16;
    p1 = [C(1,:) ]';
    p2 = [C(2,:) ]';
    p3 = [C(3,:) ]';
    p4 = [C(4,:) ]';
    %Los siguientes coeficientes son los resultantes de plantear la interpolación bilineal, es
    %decir, la fórmula bilineal tiene la forma: x = a_1 + a_2*chi + a_3*eta + a_4*chi*eta. Lo
    %mismo para y pero usando los coeficientes b_1,b_2,b_3 y b_4. Esta matriz coefs contiene los
    %coeficientes a_i y los b_i. Recordemos que cada punto es una columna.
    coefs = [ (1/4)*(p1 + p2 +p3 + p4) , (1/4)*(p2 - p1 + p3 - p4) , (1/4)*(p3 - p2 + p4 - p1), (1/4)*(p1 - p2 + p3 - p4)] ;
    a = coefs(1,:);    
    b = coefs(2,:);
    %Lo siguientes es para resolver la ecuación cuadrática y todas las particularidades
    %posibles. Para ver la parte teórica, consultar el pdf de bibliografía.
    x0 = a(1) - punto(1);
    y0 = b(1) - punto(2);
    
    if ( abs(a(4))>= tol && abs(a(2)) >=tol )  %preguntando si es distinto de cero
        eta = ( -a(2) )/a(4);
        chi = ( y0*a(4) + a(2)*b(3) ) / (a(4)*b(2) - a(2)*b(4) ) ;
    endif
    if (abs(a(4) )<tol && abs(a(2))<tol)  %preguntando si es igual a cero
        eta = ( x0 )/a(3);
        chi = ( y0*a(3) - x0*b(3) ) / (a(3)*b(2) + x0*b(4) ) ;
    else
        A = a(4)*b(3) - a(3)*b(4);
        B = ( y0*a(4) + a(2)*b(3) ) - ( x0*b(4) + a(3)*b(2) ) ;
        K = y0*a(2) - x0*b(2) ;

        if ( abs(A) >= tol )  %distinto de cero
            disc = B*B - 4*A*K ;
            if (disc<0) 
                eta = -99;
                chi = -99;
            else
                eta = (-B + sqrt(disc) ) / (2*A) ;
                chi = ( -(x0 + a(3)*eta) )/(a(2) + a(4)*eta )  ;
            endif
        else % caso de si A = 0.
            eta = -K/B;
            chi = ( -(x0 + a(3)*eta) )/(a(2) + a(4)*eta )  ;
        endif
    endif
   
endfunction