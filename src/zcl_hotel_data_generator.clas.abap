CLASS zcl_hotel_data_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hotel_data_generator IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATA lt_hoteles TYPE TABLE OF zhotels_db.

    " 1. Limpiar datos viejos para evitar duplicados
    DELETE FROM zhotels_db.

    " 2. Preparar datos de prueba
    lt_hoteles = VALUE #(
      ( client = sy-mandt hotel_id = 'H001' name = 'Hilton Tokyo' city = 'Tokyo' price = 2000 currency = 'JPY' )
      ( client = sy-mandt hotel_id = 'H002' name = 'Ibis Paris'   city = 'Paris' price = 120  currency = 'EUR' )
      ( client = sy-mandt hotel_id = 'H003' name = 'Sheraton NY'  city = 'New York' price = 350  currency = 'USD' )
      ( client = sy-mandt hotel_id = 'H004' name = 'Hostel Econ'  city = 'Madrid' price = 45   currency = 'EUR' )
    ).

    " 3. Insertar en la base de datos
    INSERT zhotels_db FROM TABLE @lt_hoteles.

    IF sy-subrc = 0.
      out->write( '¡Éxito! Tabla ZHOTELS_DB poblada con 4 hoteles.' ).
    ELSE.
      out->write( 'Hubo un error al insertar los datos.' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
