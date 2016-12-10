% La matriz state_conocido, es de Nx(m+1), donde N es la cantidad de nodos en la interfaz de estados conocidos
% y m es la dimension del vector que representado el estado conocido. El primer elemento de dicha matriz,
% es siempre el numero del nodo al que se le asocia el estado de dimension 1xm

function coeficientes=calcular_coeficientes(xnode_conocido,state_conocido,varianza)

%% Cantidad de puntos en la interfaz conocida).
N=length(xnode_conocido(:,1));

%% Dimension de los estados conocidos sobre cada nodo).
m=length(state_conocido(1,2:end));


G=ones(N,N);
F=zeros(N,m);
for i=1:N
  numero_nodo=state_conocido(i,1);
  
  % estado es un vector de 1xm (fila)
  estado=state_conocido(i,2:end);
  xi=xnode_conocido(numero_nodo,:);
  
  %% Se construye la matriz de NxN gausianas (simetrica, definida positiva) con 1's en la diagonal.
  for j=i+1:N
    numero_nodo=state_conocido(j,1);
    xj=xnode_conocido(numero_nodo,:);
    x=xi-xj;
    aux=exp(-.5*(x*x')/varianza);
    G(i,j)=aux;
    G(j,i)=aux;
  end
  
  %% Se genera la solucion del sistema. Cada fila representa el estado conocido a interpolar.
  %% cuando la dimension m del estado conocido es mayor a 1, f es una matriz de Nxm
  F(i,:)=estado; 
end

%% Se resuelve el sistema G(NxN)*coef(Nxm)=F(Nxm) -> coef(Nxm)=[G(NxN)^-1)]*F(Nxm)

coeficientes=G\F;


%% Cada i-esimo coeficiente, es un vector fila de 1xm. Por lo tanto la interpolacion final, en el posterior paso, sera:
%% estado_desconocido(1xm)=suma(exp(-.5*|x-xi|^2/desv)*coeficientes(i,:))

########################################################################################
%% No es conveniente realizar la resolucion del sistema y la interpolacion en
%% esta misma funcion ya que se estaria resolviendo el sistema por cada vez que se quiere
%% realizar la interpolacion de estados para un nodo de la malla de estados desconocidos.
########################################################################################


end