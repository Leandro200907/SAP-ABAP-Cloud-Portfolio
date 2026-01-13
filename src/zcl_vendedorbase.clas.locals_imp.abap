CLASS lcl_vendedor_senior DEFINITION INHERITING FROM zcl_vendedorbase.
  PUBLIC SECTION.
    DATA mv_ventas TYPE i.
    METHODS constructor IMPORTING iv_nombre TYPE string iv_ventas TYPE i.
    METHODS calcular_bonificacion REDEFINITION.
ENDCLASS.

CLASS lcl_vendedor_senior IMPLEMENTATION.
  METHOD constructor.
    super->constructor( iv_nombre = iv_nombre ).
    me->mv_ventas = iv_ventas.
  ENDMETHOD.
  METHOD calcular_bonificacion.
    me->mv_bonus = me->mv_ventas * '0.10'.
  ENDMETHOD.
ENDCLASS.

" --- CLASE HIJA JUNIOR (Local) ---
CLASS lcl_vendedor_junior DEFINITION
  INHERITING FROM zcl_vendedorbase.

  PUBLIC SECTION.
    DATA mv_contratos TYPE i.

    " Constructor: pide el nombre (para el padre) y los contratos (para él)
    METHODS constructor
      IMPORTING iv_nombre    TYPE string
                iv_contratos TYPE i.

    " Redefinimos el cálculo: 500 por cada contrato conseguido
    METHODS calcular_bonificacion REDEFINITION.

ENDCLASS.

CLASS lcl_vendedor_junior IMPLEMENTATION.

  METHOD constructor.
    " Enviamos el nombre a la clase padre
    super->constructor( iv_nombre = iv_nombre ).
    me->mv_contratos = iv_contratos.
  ENDMETHOD.

  METHOD calcular_bonificacion.
    " Lógica específica para Juniors
    me->mv_bonus = me->mv_contratos * 500.
  ENDMETHOD.

ENDCLASS.
CLASS lcl_proceso_bonos DEFINITION.
  PUBLIC SECTION.
    METHODS ejecutar IMPORTING out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.

CLASS lcl_proceso_bonos IMPLEMENTATION.
  METHOD ejecutar.
    DATA lt_vendedores TYPE TABLE OF REF TO zcl_vendedorbase.
    DATA lt_reporte TYPE TABLE OF zst_reporte_bonos.

    APPEND NEW lcl_vendedor_senior( iv_nombre = 'Senior 1' iv_ventas = 10000 ) TO lt_vendedores.
    APPEND NEW lcl_vendedor_junior( iv_nombre = 'Junior 1' iv_contratos = 5 ) TO lt_vendedores.

    LOOP AT lt_vendedores INTO DATA(lo_vend).
      lo_vend->calcular_bonificacion( ).
      APPEND VALUE #( nombre = lo_vend->mv_nombre
                      bonus  = lo_vend->mv_bonus
                      waers  = 'USD' ) TO lt_reporte.
    ENDLOOP.

    out->write( lt_reporte ).
  ENDMETHOD.
ENDCLASS.
