

% Verifica si un punto pertenece a un segmento. Para ello, se arma el vector diferencia de los
% dos puntos del segmento, y se arma el vector que llamamos "v", que es la diferencia entre el
% punto en cuestión y el primer punto del segmento. Si la proyección de v en la dirección del
% vector diferencia es menor al módulo de ese vector diferencia, entonces se lo considera
% adentro. Convención: si pertenece, r = 1, sino r = -1.

function [alpha,r]=verificar_seg_2D(punto,M)
global tol;
    r=-1;
    v=punto'-M(1,:); % v es vector fila. Es el vector que va desde P1 hasta el punto en cuestion.
    dif=M(2,:)-M(1,:);
    u=dif./norm(dif,2);
    alpha=v*u';
    if(alpha<=norm(dif,2)+tol && alpha>=0) 
        r=1;
    end
endfunction


