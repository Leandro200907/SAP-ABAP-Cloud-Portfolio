*"--- CLASE MADRE: Activo Fijo ---
CLASS lcl_activo_fijo DEFINITION.
  PUBLIC SECTION.
    " Atributos que todos los activos tienen
    DATA: mv_nombre        TYPE string,
          mv_valor_inicial TYPE p DECIMALS 2,
          mv_vida_util     TYPE i,
          mv_anio_compra   TYPE i.

    " Constructor: Para asignar valores al crear el objeto
    METHODS constructor
      IMPORTING
        i_nombre TYPE string
        i_valor  TYPE i
        i_vida   TYPE i
        i_anio   TYPE i.

    " Método que será redefinido por las hijas
    METHODS calcular_valor_residual
      RETURNING VALUE(rv_valor) type i.

ENDCLASS.
CLASS lcl_activo_fijo IMPLEMENTATION.

  METHOD constructor.
    mv_nombre        = i_nombre.
    mv_valor_inicial = i_valor.
    mv_vida_util     = i_vida.
    mv_anio_compra   = i_anio.
  ENDMETHOD.

  METHOD calcular_valor_residual.
    " Por defecto, devolvemos el valor inicial si no hay lógica específica
    rv_valor = mv_valor_inicial.
  ENDMETHOD.

ENDCLASS.
*"--- CLASE HIJA 1: Maquinaria ---
CLASS lcl_maquinaria DEFINITION INHERITING FROM lcl_activo_fijo.
  PUBLIC SECTION.
    " Agregamos el constructor aquí también
    METHODS constructor
      IMPORTING i_nombre TYPE string
                i_valor  TYPE i
                i_vida   TYPE i
                i_anio   TYPE i.

    METHODS calcular_valor_residual REDEFINITION.
ENDCLASS.

CLASS lcl_maquinaria IMPLEMENTATION.
  METHOD constructor.
    " Pasamos los datos a la madre
    super->constructor( i_nombre = i_nombre
                        i_valor  = i_valor
                        i_vida   = i_vida
                        i_anio   = i_anio ).
  ENDMETHOD.

  METHOD calcular_valor_residual.
    DATA(lv_anio_actual) = 2026.
    DATA(lv_transcurridos) = lv_anio_actual - mv_anio_compra.

    IF mv_vida_util > 0.
      DATA(lv_cuota_anual) = mv_valor_inicial / mv_vida_util.
      DATA(lv_amort_acumulada) = lv_cuota_anual * lv_transcurridos.

      rv_valor = mv_valor_inicial - lv_amort_acumulada.

      IF rv_valor < 0.
        rv_valor = 0.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
*"--- CLASE HIJA 2: Rodados ---
CLASS lcl_rodados DEFINITION INHERITING FROM lcl_activo_fijo.
  PUBLIC SECTION.
    DATA mv_kms_recorridos TYPE i.

    METHODS constructor
      IMPORTING i_nombre TYPE string
                i_valor  TYPE i
                i_vida   TYPE i
                i_anio   TYPE i
                i_kms    TYPE i.

    METHODS calcular_valor_residual REDEFINITION.
ENDCLASS.

CLASS lcl_rodados IMPLEMENTATION.
  METHOD constructor.
    " Llamamos al constructor de la madre para los datos básicos
    super->constructor( i_nombre = i_nombre i_valor = i_valor i_vida = i_vida i_anio  = i_anio ).
    mv_kms_recorridos = i_kms.
  ENDMETHOD.

 METHOD calcular_valor_residual.
    DATA(lv_anio_actual) = 2026. " Estamos en enero de 2026
    DATA(lv_transcurridos) = lv_anio_actual - mv_anio_compra.

    " Lógica: (Amortización lineal por años) + (Desgaste extra por KMS)
    IF mv_vida_util > 0.
      DATA(lv_cuota_anual) = mv_valor_inicial / mv_vida_util.
      DATA(lv_desgaste_kms) = mv_kms_recorridos / 100.

      " Valor Residual = Valor Inicial - (Amortización Acumulada + Desgaste KMS)
      rv_valor = mv_valor_inicial - ( lv_cuota_anual * lv_transcurridos ) - lv_desgaste_kms.

      " Control: Un activo no puede valer menos que cero
      IF rv_valor < 0.
        rv_valor = 0.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
CLASS zcl_contable_amortizacion DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_contable_amortizacion IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA lt_activos TYPE TABLE OF REF TO lcl_activo_fijo.

    " 1. Maquinaria
    APPEND NEW lcl_maquinaria(
        i_nombre = 'Torno Industrial'
        i_valor  = 10000
        i_vida   = 10
        i_anio   = 2020
    ) TO lt_activos.

    " 2. Rodado
    APPEND NEW lcl_rodados(
        i_nombre = 'Camioneta Reparto'
        i_valor  = 20000
        i_vida   = 5
        i_anio   = 2019
        i_kms    = 50000
    ) TO lt_activos.

    out->write( '--- REPORTE DE VALOR RESIDUAL AL 2026 ---' ).

    LOOP AT lt_activos INTO DATA(lo_activo).
      DATA(lv_valor_res) = lo_activo->calcular_valor_residual( ).
      out->write( |Activo: { lo_activo->mv_nombre } | ).
      out->write( |Valor Residual: { lv_valor_res } | ).
      out->write( '---------------------------------------' ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.


