function [chi,eta] = mapear_tri_2D(punto, T) %esta funcion mapea un punto de un triangulo al
                                             %elemento master del triángulo.
%punto es un vector columna, y T es una matriz que en cada fila tiene las coordenadas de los
%nodos que forman el triángulo. Se utiliza la formula, para cada coordenada, de la sumatoria de
%los chi_i*N_i(x,y), donde los chi_i son los vértices del triángulo máster: (0,0), (0,1), (1,0).					       
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