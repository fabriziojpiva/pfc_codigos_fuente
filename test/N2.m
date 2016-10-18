% X contiene solo las coordenadas (x,y) de los 4 puntos del cuadrilatero. Matriz de 4x2
% punto es el punto en 2D. Vector columna
function z=N2(punto,X) 

%%% Centro todos los puntos en el nodo X2.
%x1=X(1,1)-X(2,1);
%y1=X(1,2)-X(2,2);
%x2=X(2,1)-X(2,1);
%y2=X(2,2)-X(2,2);
%x3=X(3,1)-X(2,1);
%y3=X(3,2)-X(2,2);
%x4=X(4,1)-X(2,1);
%y4=X(4,2)-X(2,2);
%
%x=punto(1,1)-X(2,1);
%y=punto(2,1)-X(2,2);
%
%eta_34=zeros(3,1);
%% vector normal al plano NO UNITARIO -> producto cruz = (X4-X3)x[(0,0,1)-X3]
%eta_34=[(y4-y3);-(x4-x3);(y4-y3)*x3-(x4-x3)*y3];
%% Lo convierto en vector normal unitario 
%eta_34=eta_34./sqrt(eta_34'*eta_34);
%
%% Ecuacion del plano que se anula en la recta que une los punto 3 y 4, y vale 1 sobre el nodo 2
%z_34=((x3-x)*eta_34(1,1)+(y3-y)*eta_34(2,1))/eta_34(3,1);
%
%%%%%%%%%%%%%%
%eta_41=eta_34.*0;
%% vector normal al plano NO UNITARIO -> producto cruz = (X1-X4)x[(0,0,1)-X4]
%eta_41=[(y1-y4);-(x1-x4);(y1-y4)*x4-(x1-x4)*y4];
%% Lo convierto en vector normal unitario 
%eta_41=eta_41./sqrt(eta_41'*eta_41);
%
%% Ecuacion del plano que se anula en la recta que une los punto 4 y 1, y vale 1 sobre el nodo 2
%z_41=((x4-x)*eta_41(1,1)+(y4-y)*eta_41(2,1))/eta_41(3,1);
%
%% Multiplicacion de los planos para generar la funcion de forma del 2do nodo
%z = z_34 * z_41;
%% La multiplicacion de los planos (polinomios de grado 1 en R2) genera un polinomio bilineal
%% Este polinomio bilineal vale 1 en el nodo 2, y cero sobre las rectas que pasan por (P3-P4) y (P4-P1)




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
z_34=(x3-x)*(y4-y3)+(y3-y)*(x3-x4);
z_34=z_34/((x4-x3)*(y2-y3)-(y4-y3)*(x2-x3));

%%%%%%%%%%%%%
% Ecuacion del plano que se anula en la recta que une los puntos 2 y 3, y vale 1 sobre el nodo 4
z_41=(x4-x)*(y1-y4)+(y4-y)*(x4-x1);
z_41=z_41/((x1-x4)*(y2-y4)-(y1-y4)*(x2-x4));


z = z_34 * z_41;



endfunction