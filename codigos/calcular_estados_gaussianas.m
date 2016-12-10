function estados=calcular_estados_gaussianas(coeficientes,xnode_conocido,state_conocido,xnode_desconocido,state_desconocido,varianza)


%% Cantidad de nodos en la malla conocida.
  N_con=length(xnode_conocido(:,1));
%% Cantidad de nodos en la malla desconocida.
  N_des=length(xnode_desconocido(:,1));

%% Dimension del estado a interpolar.
  m=length(state_conocido(1,2:end));

  gaussianas=zeros(N_des,N_con);

%% Debe tenerse en cuenta, ahora, que para hallar los valores interpolados para los estados desconocidos,
%% puede producirse todo el proceso de una unica pasada. Esto es:

%% 1) calculamos las gaussianas centradas en cada nodo de la malla de estados conocidos, 
%%    evaluadas sobre cada nodo de la malla de estados desconocidos:

  for k=1:N_des
    numero_nodo=state_desconocido(k,1);
    xk_des=xnode_desconocido(numero_nodo,:);
    for i=1:N_con
      numero_nodo=state_conocido(i,1);
      xi_con=xnode_conocido(numero_nodo,:);
      x=xk_des-xi_con;
      gaussianas(k,i)=exp(-.5*x*x'/varianza);
    end
  end

%% Este procedimiento genera una matriz de N_des x N_con.

%% 2) Ahora, cada fila de 'gaussianas', contiene las RBFs centradas en distintos
%%    nodos de la malla de estados conocidos. Por lo tanto, para hallar el k-esimo estado
%%    del nodo k de la malla desconocida, se hace:

%%    estado_desconocido(k,:)[1xm]=gaussianas(k,:)[1xN_con]*coeficientes[N_conxm].

%%    Para todos los k=1, 2, 3, ... , N_des:

  state_desconocido(:,2:end) = gaussianas * coeficientes; 
  estados=state_desconocido;
%%            [ N_des x m] = [N_des x N_con]*[N_con x m].
