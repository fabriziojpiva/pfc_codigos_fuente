% X contiene solo las coordenadas (x,y) de los 4 puntos del cuadrilatero. Matriz de 4x2
% punto es el punto en 2D. Vector columna
function z=N4(punto,X) 
%% Centro todos los puntos en el nodo X4.
%
%x1=X(1,1)-X(4,1);
%y1=X(1,2)-X(4,2);
%x2=X(2,1)-X(4,1);
%y2=X(2,2)-X(4,2);
%x3=X(3,1)-X(4,1);
%y3=X(3,2)-X(4,2);
%
%x=punto(1,1)-X(4,1);
%y=punto(2,1)-X(4,2);
%
%eta_12=zeros(3,1);
%
%% vector normal al plano NO UNITARIO -> producto cruz = (X2-X1)x[(0,0,1)-X1]
%eta_12=[(y2-y1);-(x2-x1);(y2-y1)*x1-(x2-x1)*y1];
%
%% Lo convierto en vector normal unitario 
%eta_12=eta_12./sqrt(eta_12'*eta_12);
%
%% Ecuacion del plano que se anula en la recta que une los puntos 1 y 2, y vale 1 sobre el nodo 4
%z_12=((x1-x)*eta_12(1,1)+(y1-y)*eta_12(2,1))/eta_12(3,1);
%
%%%%%%%%%%%%%%
%
%eta_23=eta_12.*0;
%
%% vector normal al plano NO UNITARIO -> producto cruz = (X2-X1)x[(0,0,1)-X1]
%eta_23=[(y3-y2);-(x3-x2);(y3-y2)*x2-(x3-x2)*y2];
%
%% Lo convierto en vector normal unitario 
%eta_23=eta_23./sqrt(eta_23'*eta_23);
%
%% Ecuacion del plano que se anula en la recta que une los puntos 2 y 3, y vale 1 sobre el nodo 4
%z_23=((x2-x)*eta_23(1,1)+(y2-y)*eta_23(2,1))/eta_23(3,1);
%
%% Multiplicacion de los planos para generar la funcion de forma del 4to nodo
%z = z_12 * z_23;
%
%% La multiplicacion de los planos (polinomios de grado 1 en R2) genera un polinomio bilineal
%% Este polinomio bilineal vale 1 en el nodo 4, y cero sobre las rectas que pasan por (P1-P2) y (P2-P3)




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
z_12=(x1-x)*(y2-y1)+(y1-y)*(x1-x2);
z_12=z_12/((x2-x1)*(y4-y1)-(y2-y1)*(x4-x1));

%%%%%%%%%%%%%%
%% Ecuacion del plano que se anula en la recta que une los puntos 2 y 3, y vale 1 sobre el nodo 4
z_23=(x2-x)*(y3-y2)+(y2-y)*(x2-x3);
z_23=z_23/((x3-x2)*(y4-y2)-(y3-y2)*(x4-x2));


z = z_12 * z_23;

endfunction