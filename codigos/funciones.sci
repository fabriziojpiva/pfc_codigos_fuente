clc;
clear all;
close;
//Funcion para pre-plotear las mallas, donde entran las matrices de la malla y salen todas las
//rectas a plotear para visualizar el mallado
function [X,Y] = procesar_malla_2D(xnode, icone)   
    nelementos =  size( icone,1 ) ;
    k = 1; //indice para colocar cada recta en las dos matrices X e Y. La
           //matriz X contiene los puntos de la forma [x1 x2] y la Y los
           //correspondientes [y1 y2], para que luego podamos hacer uso
           //de la funci�n plot( [x1 x2], [y1 y2] ) que dibuja la recta
           //que pasa por los puntos (x1,y1) y (x2,y2).
    for i=1:nelementos
        polpuntos = icone (i,:); //tomamos las conectividades del elemento, sea recta, tri�ngulo o cuadrado
        for j=1:(nvertices-1)
            punto1_idx = polpuntos(1,j); //Agarramos el indice de nodo del primer punto.
            punto2_idx = polpuntos(1,j+1); //Agarramos el indice de nodo del segundo punto.
            punto1 = xnode(punto1_idx,:); //punto en formato (x,y,z)
            punto2 = xnode(punto2_idx,:);
          // Guardamos en las matrices las coordenadas como fueron explicadas mas arriba.
            X(k,1:2) =  [punto1(1,1) punto2(1,1) ] ;
            Y(k,1:2) =  [punto1(1,2) punto2(1,2) ];
            k = k + 1;
            
	end
	//A la salida del for, falta procesar el ultimo segmento de recta, que se hace de la
        //misma manera.
         punto1_idx = polpuntos(1,nvertices); 
         punto2_idx = polpuntos(1,1);
         punto1 = xnode(punto1_idx,:);
         punto2 = xnode(punto2_idx,:);
         
         X(k,1:2) =  [punto1(1,1) punto2(1,1) ] ;
         Y(k,1:2) =  [punto1(1,2) punto2(1,2) ] ;
         k = k + 1;
         
    end
endfunction

function r = cruz (u , v) //Funci�n producto cruz entre vectores.
    r = [ u(1,2)*v(1,3) - u(1,3)*v(1,2) , u(1,3)*v(1,1) - u(1,1)*v(1,3) , u(1,1)*v(1,2) - u(1,2)*v(1,1) ] ;
endfunction

function [chi,eta] = mapear_tri_2D(punto, T) //esta funcion mapea un punto de un triangulo al
                                             //elemento master del tri�ngulo.
//punto es un vector columna, y T es una matriz que en cada fila tiene las coordenadas de los
//nodos que forman el tri�ngulo. Se utiliza la formula, para cada coordenada, de la sumatoria de
//los chi_i*N_i(x,y), donde los chi_i son los v�rtices del tri�ngulo m�ster: (0,0), (0,1), (1,0).					       
    x = punto(1,1);
    y = punto(2,1);
    x1 = T(1,1);
    x2 = T(2,1);
    x3 = T(3,1);
    y1 = T(1,2);
    y2 = T(2,2);
    y3 = T(3,2);
    
    N2_xy = x*(y3-y1) + y*(x1-x3) + y1*x3 - y3*x1 ;
    den = (x2 - x1)*(y3 - y1)+ (y1 - y2)*(x3 - x1);
    N2_xy = N2_xy / den;
    
    N3_xy = x*(y1 - y2)+ y*(x2 - x1)+ y2*x1 - y1*x2;
    N3_xy = N3_xy /den;
    chi = N2_xy;
    eta = N3_xy;
endfunction

// mapeo de un punto en coordenadas (x,y) al elemento master da coordenadas (chi,eta) donde
// (chi,eta) pertenece a [-1,1]. Se plantea una interpolaci�n bilineal, con par�metros chi y eta,
// quedando una formula bilineal en las variables chi y eta tanto en x como en y. Luego se
// despeja de una el valor de chi, y se reemplaza en la otra, para que queden dos f�rmulas
// expl�citas para chi y eta. Esta f�rmula expl�cita, tiene forma de ecuaci�n cuadr�tica (Ax^2 +
// Bx + C), que se resuelve por la f�rmula de la resolvente. Tambi�n recordemos que hay casos
// particulares (donde A=0 por ejemplo) que se consideran para evitar divisiones por cero o un
// discriminante negativo.
// Por convenci�n, un punto que no pertence al cuadrado ser� mapeado a las coordenadas chi=-99 y
// eta= -99.
function [chi,eta] = mapear_cuad_2D(punto, C) 
    p1 = [C(1,:) ]';
    p2 = [C(2,:) ]';
    p3 = [C(3,:) ]';
    p4 = [C(4,:) ]';
    //Los siguientes coeficientes son los resultantes de plantear la interpolaci�n bilineal, es
    //decir, la f�rmula bilineal tiene la forma: x = a_1 + a_2*chi + a_3*eta + a_4*chi*eta. Lo
    //mismo para y pero usando los coeficientes b_1,b_2,b_3 y b_4. Esta matriz coefs contiene los
    //coeficientes a_i y los b_i. Recordemos que cada punto es una columna.
    coefs = [ (1/4)*(p1 + p2 +p3 + p4) , (1/4)*(p2 - p1 + p3 - p4) , (1/4)*(p3 - p2 + p4 - p1), (1/4)*(p1 - p2 + p3 - p4)] ;
    a = coefs(1,:);    
    b = coefs(2,:);
    //Lo siguientes es para resolver la ecuaci�n cuadr�tica y todas las particularidades
    //posibles. Para ver la parte te�rica, consultar el pdf de bibliograf�a.
    x0 = a(1) - punto(1);
    y0 = b(1) - punto(2);
    
    if (a(4) ~=0 & a(2) ~=0) then
        eta = ( -a(2) )/a(4);
        chi = ( y0*a(4) + a(2)*b(3) ) / (a(4)*b(2) - a(2)*b(4) ) ;
    end
    if (a(4) ==0 & a(2) == 0) then
        eta = ( x0 )/a(3);
        chi = ( y0*a(3) - x0*b(3) ) / (a(3)*b(2) + x0*b(4) ) ;
    else
        A = a(4)*b(3) - a(3)*b(4);
        B = ( y0*a(4) + a(2)*b(3) ) - ( x0*b(4) + a(3)*b(2) ) ;
        K = y0*a(2) - x0*b(2) ;

        if (A ~= 0) then
            disc = B*B - 4*A*K ;
            if (disc<0) then
                eta = -99;
                chi = -99;
            else
                eta = (-B + sqrt(disc) ) / (2*A) ;
                chi = ( -(x0 + a(3)*eta) )/(a(2) + a(4)*eta )  ;
            end
        else
            eta = -K/B;
            chi = ( -(x0 + a(3)*eta) )/(a(2) + a(4)*eta )  ;
        end
    end
   
endfunction

// verifica si un punto est� o no dentro del tri�ngulo, utilizando elemento master para abaratar
// el costo computacional. Se mapea el punto al elemento master, y se tienen que cumplir dos
// condiciones: 
// 1. Que el punto est� en el "cuadrado" definido por (0,0) , (0,1) , (1,1) y (1,0)
// 2. Que el punto est� POR DEBAJO de la recta: 1 - chi - eta.
// Si se cumplen las dos condiciones, entonces el punto pertenece al tri�ngulo.
// Convenci�n: si pertenece, r = 1, sino r = -1.
function r = verificar_tri_2D(punto , T) 
    [chi,eta] = mapear_tri_2D(punto , T);
    if (chi<0 | eta<0 | chi>1 | eta>1 )
        r = -1 ;
    elseif((chi==1 & eta==0)|(chi==0 & eta==1))  //VERIFICAR SI EL PUNTO (punto) ES UN NODO (osea, si es una fila de T))
        r=1;
    else
        r = ( 1 - chi - eta) / abs(1 - chi - eta);
    end
endfunction

// verifica si un punto est� o no dentro del cuadrado, utilizando elemento master para abaratar
// el costo computacional. Se mapea el punto al elemento master, y se tienen que cumplir que las
// coordenadas (chi,eta) del punto mapeado est�n dentro del elemento master.
// Convenci�n: si pertenece, r = 1, sino r = -1.
function r=verificar_cuad_2D(punto, C)
    [chi,eta] = mapear_cuad_2D(punto , C);
    r=1;
    if(chi<-1 | eta<-1 | chi>1 | eta>1)
        r=-1;
    end
endfunction

// Verifica si un punto pertenece a un segmento. Para ello, se arma el vector diferencia de los
// dos puntos del segmento, y se arma el vector que llamamos "v", que es la diferencia entre el
// punto en cuesti�n y el primer punto del segmento. Si la proyecci�n de v en la direcci�n del
// vector diferencia es menor al m�dulo de ese vector diferencia, entonces se lo considera
// adentro. Convenci�n: si pertenece, r = 1, sino r = -1.

function r=verificar_seg_2D(punto,M)
    r=-1;
    v=punto'-M(1,:); // v es vector fila. Es el vector que va desde P1 hasta el punto en cuestion.
    dif=M(2,:)-M(1,:);
    u=dif./norm(dif,2);
    alpha=v*u';
    if(alpha<norm(dif,2) & alpha>=0) 
        r=1;
    end
endfunction



//Funcion que verifica si el punto pertenece al elemento en cuesti�n. El elemento puede ser un
//segmento, triangulo o cuadrado. Convenci�n: si pertenece, r = 1, sino r = -1.
function r=verificar_2D(punto, M)
    n=size(M,1); //extraer cantidad de filas.
    select(n)
    case (2) then
        r=verificar_seg_2D(punto,M);
    case (3) then
        r=verificar_tri_2D(punto,M);
    
    case (4) then
        r=verificar_cuad_2D(punto,M);
    end
    
endfunction

//Funci�n para interpolar, gen�rica, act�a como wrapper para llamar a la funci�n de interpolaci�n
//segun sea el caso: tri�ngulo, cuadrado o segmento. Interpola los valores (temperatura, campo de
//velocidad, desplazamiento,etc.) que tiene cada nodo seg�n la posici�n del punto en cuesti�n. 
function valor=interpolar(punto, M, valores)
    n=length(M(:,1));
    // En caso de ser un triangulo, se interpolan los estados utilizando las correspondientes
    // funciones de forma del traingulo master= N1;N2;N3.
    valor=[];
    select(n)
    case (2) then
        // se realiza la interpolacion en 1D dentro del segmento: (1-alpha)*valor1 + alpha*valor2.
        v=punto'-M(1,:); // v es vector fila. Es el vector que va desde P1 hasta el punto en cuestion.
        dif=M(2,:)-M(1,:);
        L_seg=norm(dif,2);
        u=dif./L_seg;
        alpha=(v*u')/L_seg;
        valor=[(1-alpha), alpha]*valores;
     case(3) then
      // se realiza la interpolaci�n 2D, mapeando el punto en cuesti�n al elemento master para
      // luego interpolar en �l, ya que las funciones de forma all� son sustancialmente mas sencillas.
        [chi,eta]=mapear_tri_2D(punto,M);
        valor=[1-chi-eta, chi, eta]*valores;
     case(4)
      // se realiza la interpolaci�n 2D, mapeando el punto en cuesti�n al elemento master para
      // luego interpolar en �l, ya que las funciones de forma all� son sustancialmente mas
      // sencillas.  En caso de ser un cuadrilatero, se interpolan los estados utilizando las
      // funciones de forma del cuadrilatero master= N1;N2;N3;N4.
        [chi,eta]=mapear_cuad_2D(punto,M);
        valor=.25*[(1-eta)*(1-chi), (1-eta)*(1+chi), (1+eta)*(1+chi),(1+eta)*(1-chi) ]*valores;
    end
endfunction


// indices_nodos=indices de los nodos que conforman un elemento dado. Vector fila.
// estados_conocidos=base de datos donde se almacenan los estados conocidos (primer columna
// contiene el indice del nodo al cual se le asignan los estados)
// v=matriz donde cada fila es un estado-vector
// Esta funci�n tiene por objetivo buscar en la matriz de estados de toda la malla, cuales son
// los estados correspondientes a un elemento dado de esa malla. Por ejemplo, para saber cuales
// son las temperaturas que tiene el tri�ngulo n�mero 20 en una malla de 300 elementos triangulares.
function v=buscar_estado(indices_nodos,estados_conocidos)
    n=length(estados_conocidos(:,1));
    m=length(indices_nodos(1,:));
    v=[];
    for i=1:m
        for j=1:n
            if(estados_conocidos(j,1)==indices_nodos(1,i))
                v=[v;estados_conocidos(j,2:$)']; //Aqui se hace una copia desde la columna 2 en
                                                 //adelante porque se considera que la primer
                                                 //columna es para decir que nodo es, y las columnas
                                                 //restantes el dato del estado (sea vector u
                                                 //escalar.
            end
        end
    end
endfunction



