CLASS zcl_testbono DEFINITION  " <--- Asegúrate que coincida con el nombre del archivo
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_testbono IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.
    DATA lt_vendedores TYPE TABLE OF REF TO zcl_vendedorbase.
    " Esta tabla acumulará todos los resultados para el reporte final
    DATA lt_reporte_final TYPE TABLE OF zst_reporte_bonos.

    " 1. Instanciamos los objetos globales
    APPEND NEW zcl_vendedor_senior( iv_nombre = 'Ana Senior' iv_ventas = 50000 ) TO lt_vendedores.
    APPEND NEW zcl_vendedor_junior( iv_nombre = 'Pedro Junior' iv_contratos = 12 ) TO lt_vendedores.

    " 2. Procesamos la lógica de negocio
    LOOP AT lt_vendedores INTO DATA(lo_vendedor).
      lo_vendedor->calcular_bonificacion( ).

      " Acumulamos el resultado en nuestra tabla de reporte
      APPEND lo_vendedor->obtener_reporte_bono( ) TO lt_reporte_final.
    ENDLOOP.

    " 3. Salida limpia (Encabezado -> Datos -> Pie)
    out->write( '--- REPORTE CONSOLIDADO DE BONIFICACIONES ---' ).

    " Al pasar la tabla completa, SAP imprime los títulos una sola vez
    out->write( lt_reporte_final ).

    out->write( '--- FIN DEL PROCESO ---' ).
  ENDMETHOD.
  ENDCLASS.
