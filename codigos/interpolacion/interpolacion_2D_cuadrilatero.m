//Para cuadrilátero:

function [A,b,coef] = calcular_coeficientes (puntos)
    A = zeros (8,8);
    A(1,1:4) = [1, puntos(1,:) puntos(1,1)*puntos(1,2) ];
    A(2,1:4) = [1, puntos(2,:) puntos(2,1)*puntos(2,2)] ;
    A(3,1:4) = [1, puntos(3,:) puntos(3,1)*puntos(3,2)] ;
    A(4,1:4) = [1, puntos(4,:) puntos(4,1)*puntos(4,2)] ;
    
    A(5,5:8) = [1, puntos(1,:) puntos(1,1)*puntos(1,2) ];
    A(6,5:8) = [1, puntos(2,:) puntos(2,1)*puntos(2,2)];
    A(7,5:8) = [1, puntos(3,:) puntos(3,1)*puntos(3,2)] ;
    A(8,5:8) = [1, puntos(4,:) puntos(4,1)*puntos(4,2)];
    
    b = [-1 1 1 -1 -1 -1 1 1]';
    coef = A\b ;
    
endfunction
funcprot(0);

function r = chi (coef , punto)
    r = sum (coef(1:4,1)'.*[1,punto punto(1)*punto(2) ] ) ;
  endfunction

function r = eta (coef , punto)
    r = sum (coef(5:8,1)'.*[1,punto punto(1)*punto(2) ] ) ;
  endfunction
function r = Nk ( point_t , k)
    select (k)
    case 1 then r = (1/4)*(1 - point_t(1) )*(1 - point_t(2) );
    case 2 then r = (1/4)*(1 + point_t(1) )*(1 - point_t(2) );
    case 3 then r = (1/4)*(1 + point_t(1) )*(1 + point_t(2) );
    case 4 then r = (1/4)*(1 - point_t(1) )*(1 + point_t(2) ); 
    end
  endfunction


test = [ 1 0; 5 0 ; 6 3; 2 3];

[K,f,c]=calcular_coeficientes(test);
disp(K);
disp(f);
disp(c);

disp(chi( c , [5 0]) );
disp(eta( c , [5 0]) );
//
//temps(1) = exp( test(1,1)*test(1,2) );
//temps(2) = exp( test(2,1)*test(2,2) );
//temps(3) = exp( test(3,1)*test(3,2) );
//
//point = [2 1];
//temp_exacta = exp( point(1)*point(2) );
//point_chi = chi (c , point);
//point_eta = eta (c , point);
//point_t = [point_chi point_eta];
//
//N = [ Nk(point_t,1) Nk(point_t,2) Nk(point_t,3)] ;
//temp_aprox = sum( temps'.*N ) ;
//
//disp("Temperatura exacta: ");
//disp(temp_exacta);
//disp("Temperatura aproximada: ");
//disp(temp_aprox);
