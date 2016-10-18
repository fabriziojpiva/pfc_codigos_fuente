% X contiene solo las coordenadas (x,y) de los 4 puntos del cuadrilatero. Matriz de 4x2
% punto es el punto en 2D. Vector columna
function z=N1(punto,X) 

%%% Centro todos los puntos en el nodo X1.
%x1=X(1,1)-X(1,1);
%y1=X(1,2)-X(1,2);
%x2=X(2,1)-X(1,1);
%y2=X(2,2)-X(1,2);
%x3=X(3,1)-X(1,1);
%y3=X(3,2)-X(1,2);
%x4=X(4,1)-X(1,1);
%y4=X(4,2)-X(1,2);
%
%x=punto(1,1)-X(1,1);
%y=punto(2,1)-X(1,2);
%eta_23=zeros(3,1);
%% vector normal al plano NO UNITARIO -> producto cruz = (X3-X2)x[(0,0,1)-X2]
%eta_23=[(y3-y2);-(x3-x2);(y3-y2)*x2-(x3-x2)*y2];
%% Lo convierto en vector normal unitario 
%eta_23=eta_23./sqrt(eta_23'*eta_23);
%
%% Ecuacion del plano que se anula en la recta que une los punto 2 y 3, y vale 1 sobre el nodo 1
%z_23=((x2-x)*eta_23(1,1)+(y2-y)*eta_23(2,1))/eta_23(3,1);
%
%%%%%%%%%%%%%%
%eta_34=eta_23.*0;
%% vector normal al plano NO UNITARIO -> producto cruz = (X4-X3)x[(0,0,1)-X3]
%eta_34=[(y4-y3);-(x4-x3);(y4-y3)*x3-(x4-x3)*y3];
%% Lo convierto en vector normal unitario 
%eta_34=eta_34./sqrt(eta_34'*eta_34);
%
%% Ecuacion del plano que se anula en la recta que une los punto 3 y 4, y vale 1 sobre el punto 1
%z_34=((x3-x)*eta_34(1,1)+(y3-y)*eta_34(2,1))/eta_34(3,1);
%
%% Multiplicacion de los planos para generar la funcion de forma del 1er nodo
%z = z_23 * z_34;
%
%% La multiplicacion de los planos (polinomios de grado 1 en R2) genera un polinomio bilineal
%% Este polinomio bilineal vale 1 en el nodo 1, y cero sobre las rectas que pasan por (P2-P3) y (P3-P4)



x1=X(1,1);
y1=X(1,2);
x2=X(2,1);
y2=X(2,2);
x3=X(3,1);
y3=X(3,2);
x4=X(4,1);
y4=X(4,2);

x=punto(1);
y=punto(2);


%% Ecuacion del plano que se anula en la recta que une los puntos 1 y 2, y vale 1 sobre el nodo 4
z_23=(x2-x)*(y3-y2)+(y2-y)*(x2-x3);
z_23=z_23/((x3-x2)*(y1-y2)-(y3-y2)*(x1-x2));

%%%%%%%%%%%%%%
%% Ecuacion del plano que se anula en la recta que une los puntos 2 y 3, y vale 1 sobre el nodo 4
z_34=(x3-x)*(y4-y3)+(y3-y)*(x3-x4);
z_34=z_34/((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3));


z = z_23 * z_34;
endfunction