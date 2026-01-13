CLASS zcl_vendedorbase DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.

    " Atributos que heredarán todos los hijos
    DATA mv_nombre TYPE string.
    DATA mv_bonus  TYPE p DECIMALS 2.
    DATA mv_waers  TYPE waers VALUE 'USD'.
    " El constructor para asignar el nombre al crear el objeto
    METHODS constructor
      IMPORTING iv_nombre TYPE string.

    " Método abstracto: cada hijo (Senior/Junior) pondrá su propia lógica aquí
    METHODS calcular_bonificacion ABSTRACT.
    METHODS obtener_reporte_bono RETURNING VALUE(rs_reporte) TYPE zst_reporte_bonos.
ENDCLASS.

CLASS zcl_vendedorbase IMPLEMENTATION.

  METHOD constructor.
    me->mv_nombre = iv_nombre.
  ENDMETHOD.
METHOD obtener_reporte_bono.
    rs_reporte-nombre = me->mv_nombre.
    rs_reporte-bonus  = me->mv_bonus.
    rs_reporte-waers  = me->mv_waers.
  ENDMETHOD.

ENDCLASS.

