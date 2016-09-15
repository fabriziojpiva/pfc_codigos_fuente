%Función para interpolar, genérica, actúa como wrapper para llamar a la función de interpolación
%segun sea el caso: triángulo, cuadrado o segmento. Interpola los valores (temperatura, campo de
%velocidad, desplazamiento,etc.) que tiene cada nodo según la posición del punto en cuestión. 
function valor=interpolar(punto, M, valores)
    n=length(M(:,1));
    % En caso de ser un triangulo, se interpolan los estados utilizando las correspondientes
    % funciones de forma del traingulo master= N1;N2;N3.
    valor=[];
    switch(n)
    case (2) 
        % se realiza la interpolacion en 1D dentro del segmento: (1-alpha)*valor1 + alpha*valor2.
        v=punto'-M(1,:); % v es vector fila. Es el vector que va desde P1 hasta el punto en cuestion.
        dif=M(2,:)-M(1,:);
        L_seg=norm(dif,2);
        u=dif./L_seg;
        alpha=(v*u')/L_seg;
        valor=[(1-alpha), alpha]*valores;
     case(3) 
      % se realiza la interpolación 2D, mapeando el punto en cuestión al elemento master para
      % luego interpolar en él, ya que las funciones de forma allí son sustancialmente mas sencillas.
        [chi,eta]=mapear_tri_2D(punto,M);
        valor=[1-chi-eta, chi, eta]*valores;
     case(4)
      % se realiza la interpolación 2D, mapeando el punto en cuestión al elemento master para
      % luego interpolar en él, ya que las funciones de forma allí son sustancialmente mas
      % sencillas.  En caso de ser un cuadrilatero, se interpolan los estados utilizando las
      % funciones de forma del cuadrilatero master= N1;N2;N3;N4.
        [chi,eta]=mapear_cuad_2D(punto,M);
        valor=.25*[(1-eta)*(1-chi), (1-eta)*(1+chi), (1+eta)*(1+chi),(1+eta)*(1-chi) ]*valores;
    endswitch
endfunction
