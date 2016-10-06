function datos=verificar_seg_NP(punto,vecinos,elemento)

pleft = vecinos(1,:);
pright = vecinos(2,:);

nleft= punto' - pleft;
nleft = [ nleft(2) , -nleft(1) ];

nright = pright - punto';
nright = [ nright(2) , -nright(1) ];

nleft = nleft / norm(nleft,2);
nright = nright / norm(nright,2);

np = 0.5*(nleft + nright);
np = np/norm(np,2);

A = [np(1) (elemento(1,1) - elemento(2,1) ); np(2) (elemento(1,2) - elemento(2,2))];

b = [elemento(1,1) - punto(1,1); elemento(1,2) - punto(2,1)];

coefs = A\b;
alpha= coefs(1,1);
beta = coefs(2,1);


if ( beta < 0 || beta > 1 )
  datos(1) = -1 ; % afuera.
  else
  datos(1) = 1; %adentro.
  endif
  datos(2) = beta;

%  plot([0 5 8],[2 1 3]);
%  hold on;
%  plot([0 8],[0 -1]);
%  quiver(5,1 , nleft(1),nleft(2));
%  quiver(5,1 , nright(1),nright(2));
%  quiver(5,1 , np(1),np(2));
  
%  disp(nleft);
%  disp(nright);
  
endfunction