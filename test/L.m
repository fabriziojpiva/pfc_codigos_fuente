function w=L(x,i,X)
  global p;
  global q;
  N=length(X(:,1));
  
  w=1;
  xi=X(i,:)';
  for k=1:i-1
    xk=X(k,:)';
%    w=w*((x-xk)'*C*(x-xk))/((xi-xk)'*C*(xi-xk));
    w=w*sum((x-xk).^p)/sum((xi-xk).^p);
  %  w=w*(norm(x-X(:,k),p))/(norm(X(:,i)-X(:,k),p));
  end

  for k=i+1:N
    xk=X(k,:)';
%    w=w*((x-xk)'*C*(x-xk))/((xi-xk)'*C*(xi-xk));
    w=w*sum((x-xk).^p)/sum((xi-xk).^p);
  %w=w*(norm(x-X(:,k),p))/(norm(X(:,i)-X(:,k),p));
  end
  w=w^q;
%  w=exp(-(1/(N^4))*norm(x-xi,2)^2)*w^q;
%  w=sinc(norm(x-xi,2)^2)*w^q;
 endfunction