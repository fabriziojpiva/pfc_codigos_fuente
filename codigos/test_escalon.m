clc;
clear all;
close all;

%% Carga de variables globales: icone_conocido - xnode_conocido - estado_conocido.
%%                              icone_desconocido - xnode_desconocido - estado_desconocido.
load("mallas.mat");
global tol = 1e-6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Plotteado de la interfaz.
[dominio1,imagen1] = procesar_malla_2D(xnode_s , icone_s);
[dominio2,imagen2] = procesar_malla_2D(xnode_f , icone_f);

 figure;
 title("Interfaz");
 xlabel("x");
 ylabel("y");
 hold on;
for k=1:size(dominio1,1)
    plot( dominio1(k,:) ,imagen1(k,:) , ['.' 'r']) ;
    plot( dominio1(k,:) ,imagen1(k,:) , 'r') ;
end

for k=1:size(dominio2,1)
    plot( dominio2(k,:) ,imagen2(k,:) , ['.' 'b']) ;
    plot( dominio2(k,:) ,imagen2(k,:) , 'b') ;
end
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% Proyecciones directas y conservativa %%%%%%%%%%%%%%%%%%%%%%%

%% 3 Tipos de proyecciones directas.
%tic;
% estados=calcular_estado(icone_s,xnode_s,state_s,xnode_f,state_f);
%%estados=calcular_estado_normales(icone_s,xnode_s,state_s,xnode_f,state_f,0);
%%estados=calcular_estado_normales(icone_s,xnode_s,state_s,xnode_f,state_f,1);
%tiempo=toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Proyeccion de datos mediante interpolacion por gaussianas v=alpha_j*exp(-.5*|x-xj|^2/std^2)
%tic;
%varianza=2;
%coeficientes=calcular_coeficientes(xnode_s,state_s,varianza);
%estados=calcular_estados_gaussianas(coeficientes,xnode_s,state_s,xnode_f,state_f,varianza);
%tiempo=toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% Proyeccion conservativa mediante 2 puntos de gauss %%%%%%%%%%%%%
tic;
[M,T,estados]=calcular_estado_conservativo(icone_s,xnode_s,state_s,icone_f,xnode_f,state_f);
tiempo=toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




# Calculo de error en test de funcion escalon:
exact=zeros(1,length(xf));
for i=1:length(xf)
  if(xf(i)<0)
    exact(i)=0;
  else
    exact(i)=1;
  end
end
den = exact*exact';
dif = estados(1:length(xf),2)-exact';
num= dif'*dif;
error= sqrt(num/den)

# Calculo de error integral. El valor exacto es 0.
% Estados aroximados:
I=integrar(icone_f,xnode_f,estados);
disp("Error integral");
abs(I-.5)

curva_error=abs(exact-estados(:,2)');

%%% Graficas comparativas entre la curva de la solucio exacta y la curva generada por la proyeccion
figure;hold on;
plot(estados(:,2),['.','b']);
plot(exact,['.','g']);
plot(estados(:,2),'b');
plot(exact,'g');
legend('Proyeccion','Exacta');


figure;plot(xf,curva_error);































%%# Grafico de la funcion error:
%%
%%figure;
%%# Errores de proyeccion nuestra
%%loglog( 2.^([0 1 2 3 4 5])*5 +1 , [0.16707 0.043912 0.011274 0.0028384 7.1174e-4 1.7818e-4]);
%%legend("Proyeccion s/n");
%%figure;
%%loglog( 2.^([0 1 2 3 4 5])*5 +1 , [0.16949 0.044183 0.011285 0.0028392 7.1179e-4 1.7818e-4]);
%%legend("Proyeccion N & P");
%%figure;
%%loglog( 2.^([0 1 2 3 4 5])*5 +1 , [0.16978 0.044198 0.011286 0.0028393 7.1179e-4 1.7818e-4]);
%%legend("Proyeccion P & N");

%t_simple=[.062389 .062894 .19284 .70557 2.6692 10.55 41.136];
%t_NP=[.050563 .095599 .3233 1.1888 4.5972 18.284 73.481];
%t_PN=[.033583 .089655 .29976 1.1202 4.2866 16.784 66.491];
%k=0:1:6;
%
%figure;hold on;plot(k,t_simple,'g');plot(k,t_NP,'b');plot(k,t_PN,'k');
%legend('Proy. Geo.','PNU','PNNU');
%xlabel('k');
%ylabel('Tiempo ejecucion (seg.)');


