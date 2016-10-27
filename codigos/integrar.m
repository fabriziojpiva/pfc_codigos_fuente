function I=integrar(xnode,estados)
N=length(xnode(:,1)); %% cantidad de puntos.
y=estados(1:N,2); %% extraccion de valores de estados.
x=xnode(:,1); %% coordenadas en x.
I=0;
for i=1:(N-1)
  y_minimo = min([y(i) y(i+1)]);
  y_maximo = max([y(i) y(i+1)]);
  delta_x = x(i+1)-x(i);
  delta_y = y_maximo - y_minimo;
  I = I +  delta_x * (y_minimo + .5*delta_y);
end

end