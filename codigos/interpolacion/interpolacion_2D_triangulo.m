

function [A,b,coef] = calcular_coeficientes (puntos)
    A = zeros (6,6);
    A(1,1:3) = [1, puntos(1,:)];
    A(2,1:3) = [1, puntos(2,:)];
    A(3,1:3) = [1, puntos(3,:)];
    
    A(4,4:6) = [1, puntos(1,:)];
    A(5,4:6) = [1, puntos(2,:)];
    A(6,4:6) = [1, puntos(3,:)];
    
    b = [0 1 0 0 0 1]';
    coef = A\b ;
    
endfunction
funcprot(0);

function r = chi (coef , punto)
    r = sum (coef(1:3,1)'.*[1,punto] ) ;
  endfunction

function r = eta (coef , punto)
    r = sum (coef(4:6,1)'.*[1,punto] );
  endfunction
function r = Nk ( point_t , k)
    select (k)
    case 1 then r = 1 - point_t(1) - point_t(2);
    case 2 then r = point_t(1);
    case 3 then r = point_t(2); 
    end
  endfunction


test = [ 1 0; 3 0 ; 2 1.5];

[_,_,c]=calcular_coeficientes(test);
//disp(K);
//disp(f);
disp(c);

temps(1) = exp( test(1,1)*test(1,2) );
temps(2) = exp( test(2,1)*test(2,2) );
temps(3) = exp( test(3,1)*test(3,2) );

point = [2 1];
temp_exacta = exp( point(1)*point(2) );
point_chi = chi (c , point);
point_eta = eta (c , point);
point_t = [point_chi point_eta];

N = [ Nk(point_t,1) Nk(point_t,2) Nk(point_t,3)] ;
temp_aprox = sum( temps'.*N ) ;

disp("Temperatura exacta: ");
disp(temp_exacta);
disp("Temperatura aproximada: ");
disp(temp_aprox);


