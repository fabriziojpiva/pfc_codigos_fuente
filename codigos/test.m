
load("mallas.mat");

global tol = 1e-6;

[dominio1,imagen1] = procesar_malla_2D(xnode1 , icone1);
[dominio2,imagen2] = procesar_malla_2D(xnode2 , icone2);


 axis([0, 5, 0, 5]); 
 title("Interfaz");
 xlabel("x");
 ylabel("y");
 hold on;
for k=1:size(dominio1,1)
    plot( dominio1(k,:) ,imagen1(k,:) , 'r') ;
end

for k=1:size(dominio2,1)
    plot( dominio2(k,:) ,imagen2(k,:) , 'b') ;
end
hold off;

estados=calcular_estado(icone1,xnode1,estados1,xnode2,estados2);
%p1=[0;3];
%p2=[2;3];
%p3=[4;3];
%
%M=[1 1; 3 2];
%
%r1=verificar_seg_2D(p1,M);
%r2=verificar_seg_2D(p2,M);
%r3=verificar_seg_2D(p3,M);