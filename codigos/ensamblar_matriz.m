function M=ensamblar_matriz(icone,xnode)
n=length(xnode(:,1));
M=zeros(n,n);
E=length(icone(:,1));

for e=1:E
  fila1=icone(e,1); fila2=icone(e,2);
  columna1=fila1; columna2=fila2;
  L_e=norm(xnode(fila1,:)-xnode(fila2,:));
  
  M(fila1,columna1)=M(fila1,columna1)+(1/3)*L_e;
  M(fila2,columna2)=M(fila2,columna2)+(1/3)*L_e;
  M(fila1,columna2)=M(fila1,columna2)+(1/6)*L_e;
  M(fila2,columna1)=M(fila2,columna1)+(1/6)*L_e;

end


end