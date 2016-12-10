
function [M,T,estados]=calcular_estado_conservativo(icone_conocido,xnode_conocido,estados_conocidos,icone_desconocidos,xnode_desconocidos,estados_desconocidos)
    estados=estados_desconocidos;
    n=length(xnode_desconocidos(:,1));
    m=length(xnode_conocido(:,1));
    M=zeros(n,n);
    E_d=length(icone_desconocidos(:,1));
    E_c=length(icone_conocido(:,1));
    N_gp=2;
    w=1;
    chi_gp=[-1/sqrt(3), 1/sqrt(3)];
    T=zeros(n,m);
    X=[];
    
    for e=1:E_d
      fila1=icone_desconocidos(e,1); fila2=icone_desconocidos(e,2);
      columna1=fila1; columna2=fila2;
      L_e=norm(xnode_desconocidos(fila1,:)-xnode_desconocidos(fila2,:));
      
      M(fila1,columna1)=M(fila1,columna1)+(1/3)*L_e;
      M(fila1,columna2)=M(fila1,columna2)+(1/6)*L_e;
      M(fila2,columna2)=M(fila2,columna2)+(1/3)*L_e;
      M(fila2,columna1)=M(fila2,columna1)+(1/6)*L_e;
      
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
      
        idx_nodo1_d=icone_desconocidos(e,1);
        idx_nodo2_d=icone_desconocidos(e,2);
        X=[xnode_desconocidos(idx_nodo1_d,:); xnode_desconocidos(idx_nodo2_d,:)];
        L_e=norm(xnode_desconocidos(idx_nodo1_d,:)-xnode_desconocidos(idx_nodo2_d,:));
        %% Proyeccion del punto de Gauss a coordenadas globales.
        x1=.5*(1-chi_gp(1))*xnode_desconocidos(idx_nodo1_d,:)+.5*(1+chi_gp(1))*xnode_desconocidos(idx_nodo2_d,:);
        x2=.5*(1-chi_gp(2))*xnode_desconocidos(idx_nodo1_d,:)+.5*(1+chi_gp(2))*xnode_desconocidos(idx_nodo2_d,:);
        %% ______________________________________________________________________________________________________________%%
        
        %% Por cada punto de Gauss hay que realizar el siguiente bloque de codigo %%
%        [elemento1,chi1]=proyectar_gp(x1',icone_conocido,xnode_conocido);
        [elemento1,chi1]=proyectar_gp_normales(X,x1',icone_conocido,xnode_conocido);
        if(elemento1>0)
          idx_nodos1_c=icone_conocido(elemento1,:);
          T(idx_nodo1_d,idx_nodos1_c(1))=T(idx_nodo1_d,idx_nodos1_c(1))+ (L_e/8)*(1-chi_gp(1))*(1-chi1);
          T(idx_nodo1_d,idx_nodos1_c(2))=T(idx_nodo1_d,idx_nodos1_c(2))+ (L_e/8)*(1-chi_gp(1))*(1+chi1);
          T(idx_nodo2_d,idx_nodos1_c(1))=T(idx_nodo2_d,idx_nodos1_c(1))+ (L_e/8)*(1+chi_gp(1))*(1-chi1);
          T(idx_nodo2_d,idx_nodos1_c(2))=T(idx_nodo2_d,idx_nodos1_c(2))+ (L_e/8)*(1+chi_gp(1))*(1+chi1);
        end
        %______________________________________________________________________%
%        [elemento2,chi2]=proyectar_gp(x2',icone_conocido,xnode_conocido);
        [elemento2,chi2]=proyectar_gp_normales(X,x2',icone_conocido,xnode_conocido);
        if(elemento2>0)
          idx_nodos2_c=icone_conocido(elemento2,:);
          T(idx_nodo1_d,idx_nodos2_c(1))=T(idx_nodo1_d,idx_nodos2_c(1))+ (L_e/8)*(1-chi_gp(2))*(1-chi2);
          T(idx_nodo1_d,idx_nodos2_c(2))=T(idx_nodo1_d,idx_nodos2_c(2))+ (L_e/8)*(1-chi_gp(2))*(1+chi2);
          T(idx_nodo2_d,idx_nodos2_c(1))=T(idx_nodo2_d,idx_nodos2_c(1))+ (L_e/8)*(1+chi_gp(2))*(1-chi2);
          T(idx_nodo2_d,idx_nodos2_c(2))=T(idx_nodo2_d,idx_nodos2_c(2))+ (L_e/8)*(1+chi_gp(2))*(1+chi2);
        end
      end
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %% Ya se que no hay que invertir a M pero bueno...era para obtener aresultados...
      estados=M\T*estados_conocidos;
      
      
     %% Esto es lo que habiamos hecho
%      for e=1:E_d
%        idx_nodo1_d=icone_desconocidos(e,1);
%        idx_nodo2_d=icone_desconocidos(e,2);
%        L_e=norm(xnode_desconocidos(idx_nodo1_d,:)-xnode_desconocidos(idx_nodo2_d,:));
%        %% Proyeccion del punto de Gauss a coordenadas globales.
%        x1=.5*(1-x_gp(1))*xnode_desconocidos(idx_nodo1_d,:)+.5*(1+x_gp(1))*xnode_desconocidos(idx_nodo2_d,:);
%        x2=.5*(1-x_gp(2))*xnode_desconocidos(idx_nodo1_d,:)+.5*(1+x_gp(2))*xnode_desconocidos(idx_nodo2_d,:);
%        %% ______________________________________________________________________________________________________________%%
%        [elemento1,chi1]=proyectar_gp(x1',icone_conocido,xnode_conocido);
%        if(elemento1>0)
%          idx_nodos1_c=icone_conocido(elemento1,:);
%          T(idx_nodo1_d,idx_nodos1_c(1))=T(idx_nodo1_d,idx_nodos1_c(1))+ (L_e/8)*(1-x_gp(1))*(1-chi1);
%          T(idx_nodo1_d,idx_nodos1_c(2))=T(idx_nodo1_d,idx_nodos1_c(2))+ (L_e/8)*(1-x_gp(1))*(1+chi1);
%          T(idx_nodo2_d,idx_nodos1_c(1))=T(idx_nodo2_d,idx_nodos1_c(1))+ (L_e/8)*(1+x_gp(1))*(1-chi1);
%          T(idx_nodo2_d,idx_nodos1_c(2))=T(idx_nodo2_d,idx_nodos1_c(2))+ (L_e/8)*(1+x_gp(1))*(1+chi1);
%        end
%        
%        [elemento2,chi2]=proyectar_gp(x2',icone_conocido,xnode_conocido);
%        if(elemento2>0)
%          idx_nodos2_c=icone_conocido(elemento2,:);
%          T(idx_nodo1_d,idx_nodos2_c(1))=T(idx_nodo1_d,idx_nodos2_c(1))+ (L_e/8)*(1-x_gp(2))*(1-chi2);
%          T(idx_nodo1_d,idx_nodos2_c(2))=T(idx_nodo1_d,idx_nodos2_c(2))+ (L_e/8)*(1-x_gp(2))*(1+chi2);
%          T(idx_nodo2_d,idx_nodos2_c(1))=T(idx_nodo2_d,idx_nodos2_c(1))+ (L_e/8)*(1+x_gp(2))*(1-chi2);
%          T(idx_nodo2_d,idx_nodos2_c(2))=T(idx_nodo2_d,idx_nodos2_c(2))+ (L_e/8)*(1+x_gp(2))*(1+chi2);
%        end
%        
%      end


endfunction