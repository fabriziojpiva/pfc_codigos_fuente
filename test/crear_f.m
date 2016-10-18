  function f=crear_f(X)
  N=length(X(:,1));
  f=zeros(N,1);
%  for i=1:N
%    f(i,1)=F(X(i,1),X(i,2));
%  end
  for i=1:N
    [f(i,1),~]=mapeo_inverso_bilineal(X(i,:),X);
  end

  endfunction