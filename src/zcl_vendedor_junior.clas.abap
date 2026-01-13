CLASS zcl_vendedor_junior DEFINITION
  PUBLIC
  INHERITING FROM zcl_vendedorbase
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    " Atributo específico: los Juniors se miden por contratos cerrados
    DATA mv_contratos TYPE i.

    " Constructor: Pide nombre (para el padre) y contratos (para su propia lógica)
    METHODS constructor
      IMPORTING iv_nombre    TYPE string
                iv_contratos TYPE i.

    " Redefinición obligatoria del método abstracto del padre
    METHODS calcular_bonificacion REDEFINITION.

ENDCLASS.

CLASS zcl_vendedor_junior IMPLEMENTATION.

  METHOD constructor.
    " Invocamos al constructor de la superclase global ZCL_VENDEDORBASE
    super->constructor( iv_nombre = iv_nombre ).
    me->mv_contratos = iv_contratos.
  ENDMETHOD.

  METHOD calcular_bonificacion.
    " Lógica de negocio real para nivel Junior:
    " Se paga un bono fijo de 500 USD por cada contrato conseguido.
    me->mv_bonus = me->mv_contratos * 500.
  ENDMETHOD.

ENDCLASS.
