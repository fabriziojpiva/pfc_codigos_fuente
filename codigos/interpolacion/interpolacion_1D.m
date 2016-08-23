
function r = chi ( x0 , x1 , x)
	
	r = (2*x - x0 - x1)./(x1 - x0);
	
endfunction				
		
	
function producto = Nk ( chis , k, chi)
	
	n = length( chis )  -1  ; // n es el grado del polinomio
	producto = 1;
	for i = 1: k-1
		producto = producto* ( ( chi - chis(i) ) / (chis(k) - chis(i) ) );
	end	
	for i = (k+1) : (n+1)
		producto = producto*  ( ( chi - chis(i) ) / (chis(k) - chis(i) ) );
	end
							
endfunction
funcprot(0);

//Ejemplo: sen(x) entre 0 y pi
npuntos = 5;
a = 0;
b= %pi;

x = a: (b - a)/(npuntos - 1) : b ;
phis = sin(deltax);

chis  = chi( a , b, deltax);

dominio  = a : 0.01 : b;
chis_d = chi( a , b, dominio);

imagen = sin(dominio);
imagen_aprox = zeros(1,length(dominio));

for i=1:length(dominio)
    for j=1:npuntos
        imagen_aprox(i) = imagen_aprox(i) + phis(j)*Nk(chis , j , chis_d(i) ) ;
    end
end
   plot( dominio , imagen_aprox);

plot ( dominio , imagen ,'r' );

//display( resultado);


//function r = interp_linear( x0 , x1 , alpha )
		
	
	
	
	
//endfunction
