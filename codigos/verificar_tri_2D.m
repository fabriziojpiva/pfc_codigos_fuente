% verifica si un punto está o no dentro del triángulo, utilizando elemento master para abaratar
% el costo computacional. Se mapea el punto al elemento master, y se tienen que cumplir dos
% condiciones: 
% 1. Que el punto esté en el "cuadrado" definido por (0,0) , (0,1) , (1,1) y (1,0)
% 2. Que el punto esté POR DEBAJO de la recta: 1 - chi - eta.
% Si se cumplen las dos condiciones, entonces el punto pertenece al triángulo.
% Convención: si pertenece, r = 1, sino r = -1.
function r = verificar_tri_2D(punto , T) 
	global tol;
    [chi,eta] = mapear_tri_2D(punto , T);
    if (chi<0 || eta<0 || chi>1 || eta>1 )
        r = -1 ;
    elseif(( abs(chi-1)<tol && abs(eta)<tol )||( abs(chi)<tol && abs(eta-1)<tol ))  %VERIFICAR SI EL PUNTO (punto) ES UN NODO (osea, si es una fila de T))
        r=1;
    else
        r = ( 1 - chi - eta) / abs(1 - chi - eta);
    endif
endfunction