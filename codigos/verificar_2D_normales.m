function datos=verificar_2D_normales(punto,X,vecinos,modo)

  switch(modo)
  case (0)
    datos=verificar_seg_NP(punto,vecinos,elemento);
  case (1)
    datos=verificar_seg_PN(punto,vecinos,elemento);
endswitch



endfunction