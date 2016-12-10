function I=integrar(icone,xnode,estados)
E=length(icone(:,1)); %% cantidad de elementos.
%y=estados(1:N,2); %% extraccion de valores de estados.
%x=xnode(:,1); %% coordenadas en x.
I=0;
for e=1:E
%  y_minimo = min([y(i) y(i+1)]);
%  y_maximo = max([y(i) y(i+1)]);
%  delta_x = x(i+1)-x(i);
%  delta_y = y_maximo - y_minimo;
%  I = I +  delta_x * (y_minimo + .5*delta_y);
idx1=icone(e,1);
idx2=icone(e,2);
punto1=xnode(idx1);
punto2=xnode(idx2);
L_e=norm(punto1-punto2);

estado1=estados(idx1,2);
estado2=estados(idx2,2);

I=I+L_e*.5*(estado1+estado2);

end

end