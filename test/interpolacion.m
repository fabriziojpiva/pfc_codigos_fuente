  function g=interpolacion(x,f,X)
  N=4;
  w=zeros(N,1); % lagrangianos L(x,i) con i=1,2,...,N.
  for k=1:N
        w(k,1)=L(x,k,X);
  end
  w=w./sum(w);
  g=w'*f;
  endfunction