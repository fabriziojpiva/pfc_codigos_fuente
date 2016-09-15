

function r = cruz (u , v) %Función producto cruz entre vectores.
    r = [ u(1,2)*v(1,3) - u(1,3)*v(1,2) , u(1,3)*v(1,1) - u(1,1)*v(1,3) , u(1,1)*v(1,2) - u(1,2)*v(1,1) ] ;
endfunction