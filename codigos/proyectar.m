
function resultado = proyectar (datos,estados_conocidos,nodos)
  if( datos(1)==1)
            % valores contiene los valores de los estados conocidos
            valores=buscar_estado(nodos,estados_conocidos);
            % se asignan los estados interpolados a los estados desconocidos
            resultado = [(1-datos(2)), datos(2)]*valores;
        endif
        endfunction