clc;
clear all;
close all;

% 


%% Con un cuadrilatero como este se demuestran las falencias de trabajar con funciones de forma Ni(x,y)-> no funcionan bien con ejes alineados
% X=[-1 -1; 1 -1; 1 1; -1 1];

%% Este cuadrilatero muestra las falencias de invertir una matriz con rombos centrados 
% modificar (este valor) para observar como se distorsiona la exactitud de aproximacion. Cuanto mas grande (o menor) sea, peor el resultado
%                \/
X=[0 -1;0 -5; 5 0; 0 5];  % Diamante parado
%X=[-5 0;50        0; 0 1; -1 0];% Rombo alargado en +x
%X=[0 0;5 0;5 5;0 5]; %Cuadrado perfecto
%X=[0 0;5 0;2 2;0 2]; %Rectangulo perfecto
%X=[10 50;20 50; 40 70; 10 70]; %Una punta estirada en direccion +x

% X=[0 0;10 2; 9 5; 2 4];


%% Parametro de la ecuacion parametrica de la recta que pasa por los nodos Pi y Pj
t=[0:0.01:1];
i=1;j=3;

%% Puntos de la recta (x,y)=(xi,yi)+t*[(xj,yj)-(xi,yi)] que une los puntos Pi y Pj
punto_x=X(i,1)+t.*(X(j,1)-X(i,1));
punto_y=X(i,2)+t.*(X(j,2)-X(i,2));
%[chi_inv,eta_inv]=mapear_quad_2D(punto,X);

chi_inv=zeros(length(t),1);
eta_inv=zeros(length(t),1);
chi_dir=zeros(length(t),1);
eta_dir=zeros(length(t),1);
chi=zeros(length(t),1);
eta=zeros(length(t),1);

for i=1:length(t)

%% punto sobre el que se llevara a cabo la inversion (x,y)->(chi,eta).
punto=[punto_x(1,i);punto_y(1,i)];

%% aproximacion de chi y eta invirtiendo la matriz de 4x4
[chi_inv(i),eta_inv(i)]=mapear_quad_2D(punto,X);

%% Valores reales de chi y eta utilizando la resolvente de la inversion directa
%[chi(i),eta(i)]=mapear_cuad_2D(punto,X);
[chi(i),eta(i)]=mapeo_inverso_bilineal([punto;0]',[X,zeros(4,1)]);

%% aproximacion de chi y eta mediante las funciones de forma Nk(x,y)
n1=N1(punto,X);
n2=N2(punto,X);
n3=N3(punto,X);
n4=N4(punto,X);
total=n1+n2+n3+n4;
%total=1;
chi_dir(i)=(n2-n1+n3-n4)/total;
eta_dir(i)=(n4-n1+n3-n2)/total;
end


%% Graficas de comparacion entre cada caso
hold on; 
plot(chi_inv);
plot(chi_dir,'k');
plot(chi,'g');
legend('Chi sistema','Chi planos','Chi Buss');

figure;
hold on; plot(eta_inv);plot(eta_dir,'k');plot(eta,'g');
legend("eta");

%% Error cuadratico debido al mapeo por inversion de matriz de 4x4.
disp("Error cuadratico debido al mapeo por inversion de matriz de 4x4.");
ec_inversion_chi=sqrt(sum((chi_inv-chi).^2)/sum(chi.^2))
ec_inversion_eta=sqrt(sum((eta_inv-eta).^2)/sum(eta.^2))

%% Errores debido al mapeo por planos cuadraticos, con suma 1.
disp("Errores debido al mapeo por planos cuadraticos, con suma 1.");
ec_planos_chi=sqrt(sum((chi_dir-chi).^2)/sum(chi.^2))
ec_planos_eta=sqrt(sum((eta_dir-eta).^2)/sum(eta.^2))



