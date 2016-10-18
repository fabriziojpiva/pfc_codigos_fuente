clc;
clear all;
close all;

global p=2;
global q=1;


%% Cuadrilatero sobre el que se realizara la prueba
%X=[-2 -4 0;7 -1 0; 5 5 0; -4 5 0];
X=[-1 -1 0;1 -1 0; 5 5 0; -1 1 0];

%% vector que contiene los valores conocidos en los 4 nodos
f=crear_f(X);


%% Cantidad de nodos de la malla discreta para ver la superficie
M=51;

%% Valores minimos y maximos de las coordenadas (x,y) del cuadrilatero
minimo=min(min(X));
maximo=max(max(X));

%% Dominio del problema -> Cuadrado [minimo, maximo]x[minimo, maximo].
tx=ty=linspace(minimo,maximo,M);

%% generacion de la malla 2D
[xx, yy] = meshgrid (tx, ty);

%% tz_L es la superficie generada por la interpolacion por Lagrangianos.
tz_L=zeros(M,M);

%% tz_B es la superficie generada por la aproximacion bilineal.
tz_B=zeros(M,M);

%% funcion es la superficie de a funcion.
funcion=tz_L;

%% contador de puntos interiores.
inside_points=0;

for i=1:M
  for j=1:M
    punto=[tx(i);ty(j);0];
    %% Para todo punto fuera del cuadrilatero se le asigna un valor nulo, para no realizar ninguna aproximacion
    tz_L(j,i)=0;
    tz_b(j,i)=0;
    funcion(j,i)=0;    
    
    if(verificar_cuad_2D(punto',X)==1)
    %% Si el punto se encuentra dentro del cuadrilatero, se realiza lo siguiente:
    
      %% Interpolacion Lagrangiana como lo pense usando norma (L2)^2
      tz_L(j,i)=interpolacion(punto(1:2,1),f,X(:,1:2));
      
      %% Interpolacion bilineal.
      n1=N1(punto,X);
      n2=N2(punto,X);
      n3=N3(punto,X);
      n4=N4(punto,X);
      total=n1+n2+n3+n4;
%      total=1;
      tz_B(j,i)=f'*[n1;n2;n3;n4]./total;
      
      %% Calcular el valor real de la funcion.
%      funcion(j,i)=F(punto(1),punto(2));
      [funcion(j,i),~]=mapeo_inverso_bilineal(punto,X);
      
      inside_points++;
    end
  end
end
%%%%%% Calculo de errores %%%%%%%%%%%%%
ecm_L=sqrt(sum(sum((tz_L-funcion).^2))/sum(sum(funcion.^2)));
disp("Error Lagrangiano");
ecm_L

ecm_B=sqrt(sum(sum((tz_B-funcion).^2))/sum(sum(funcion.^2)));
disp("Error Bilineal");
ecm_B

%%%%%%%%%%%%%%%%%%%
figure;
mesh(xx,yy,tz_L);
legend("Lagrangiano");
colorbar;
%%%%%%%%%%%%%%%%%%%
figure;
mesh(xx,yy,tz_B);
legend("Bilineal");
colorbar;
%%%%%%%%%%%%%%%%%%%
figure;
mesh(xx,yy,funcion);
legend("Funcion");
colorbar;




