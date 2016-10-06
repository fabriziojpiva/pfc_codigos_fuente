function elements = buscar_vecinos(indice_nodo, xnode_desconocidos)
  elements(1,:) = xnode_desconocidos(indice_nodo-1,:);
  elements(2,:) = xnode_desconocidos(indice_nodo+1,:);
  endfunction