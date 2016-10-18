function [chi,eta]=mapear_quad_2D(punto,X) % punto=vector columna de 2x1 - X=matriz de 4x2 con las coordenadas de los nodos del triangulo

M=[ones(4,1), X(:,1), X(:,2), X(:,1).*X(:,2)];
chi=0;
eta=0;
chi_eta=[-1 -1; 1 -1; 1 1; -1 1];

alpha_beta=M\chi_eta;
aux=[1,punto',punto(1,1)*punto(2,1)]*alpha_beta;
chi=aux(1);
eta=aux(2);

endfunction
