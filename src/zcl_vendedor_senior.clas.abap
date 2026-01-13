CLASS zcl_vendedor_senior DEFINITION
  PUBLIC
  INHERITING FROM zcl_vendedorbase
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA mv_ventas TYPE i.
    METHODS constructor IMPORTING iv_nombre TYPE string iv_ventas TYPE i.
    METHODS calcular_bonificacion REDEFINITION.
ENDCLASS.

CLASS zcl_vendedor_senior IMPLEMENTATION.
  METHOD constructor.
    super->constructor( iv_nombre = iv_nombre ).
    me->mv_ventas = iv_ventas.
  ENDMETHOD.

  METHOD calcular_bonificacion.
    me->mv_bonus = me->mv_ventas * '0.10'.
  ENDMETHOD.
ENDCLASS.
