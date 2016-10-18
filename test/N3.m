% X contiene solo las coordenadas (x,y) de los 4 puntos del cuadrilatero. Matriz de 4x2
% punto es el punto en 2D. Vector columna
function z=N3(punto,X) 

%%% Centro todos los puntos en el nodo X3.
%x1=X(1,1)-X(3,1);
%y1=X(1,2)-X(3,2);
%x2=X(2,1)-X(3,1);
%y2=X(2,2)-X(3,2);
%x3=X(3,1)-X(3,1);
%y3=X(3,2)-X(3,2);
%x4=X(4,1)-X(3,1);
%y4=X(4,2)-X(3,2);
%
%x=punto(1,1)-X(3,1);
%y=punto(2,1)-X(3,2);
%
%eta_41=zeros(3,1);
%
%% vector normal al plano NO UNITARIO -> producto cruz = (X1-X4)x[(0,0,1)-X4]
%eta_41=[(y1-y4);-(x1-x4);(y1-y4)*x4-(x1-x4)*y4];
%
%% Lo convierto en vector normal unitario 
%eta_41=eta_41./sqrt(eta_41'*eta_41);
%
%% Ecuacion del plano que se anula en la recta que une los punto 4 y 1, y vale 1 sobre el nodo 3
%z_41=((x4-x)*eta_41(1,1)+(y4-y)*eta_41(2,1))/eta_41(3,1);
%
%%%%%%%%%%%%%%
%
%eta_12=eta_41.*0;
%
%% vector normal al plano NO UNITARIO -> producto cruz = (X2-X1)x[(0,0,1)-X1]
%eta_12=[(y2-y1);-(x2-x1);(y2-y1)*x2-(x2-x1)*y2];
%
%% Lo convierto en vector normal unitario 
%eta_12=eta_12./sqrt(eta_12'*eta_12);
%
%% Ecuacion del plano que se anula en la recta que une los punto 1 y 2
%z_12=((x1-x)*eta_12(1,1)+(y1-y)*eta_12(2,1))/eta_12(3,1);
%
%% Multiplicacion de los planos para generar la funcion de forma del 3er nodo
%z = z_41 * z_12;
%
%% La multiplicacion de los planos (polinomios de grado 1 en R2) genera un polinomio bilineal
%% Este polinomio bilineal vale 1 en el nodo 3, y cero sobre las rectas que pasan por (P4-P1) y (P1-P2)






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
z_41=(x4-x)*(y1-y4)+(y4-y)*(x4-x1);
z_41=z_41/((x1-x4)*(y3-y4)-(y1-y4)*(x3-x4));

%%%%%%%%%%%%%%
%% Ecuacion del plano que se anula en la recta que une los puntos 2 y 3, y vale 1 sobre el nodo 4
z_12=(x1-x)*(y2-y1)+(y1-y)*(x1-x2);
z_12=z_12/((x2-x1)*(y3-y1)-(y2-y1)*(x3-x1));


z = z_41 * z_12;

endfunction