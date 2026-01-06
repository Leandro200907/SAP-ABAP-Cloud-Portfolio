" --- CLASE PADRE (Superclase) ---
CLASS lcl_alojamiento DEFINITION.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING i_nombre TYPE string.

    METHODS get_nombre
      RETURNING VALUE(r_nombre) TYPE string.

  PROTECTED SECTION.
    " PROTECTED permite que los hijos vean estos datos, pero los extraños no
    DATA nombre TYPE string.
ENDCLASS.

CLASS lcl_alojamiento IMPLEMENTATION.
  METHOD constructor.
    me->nombre = i_nombre.
  ENDMETHOD.

  METHOD get_nombre.
    r_nombre = me->nombre.
  ENDMETHOD.
ENDCLASS.
" --- CLASE HIJA (Subclase) ---
CLASS lcl_hotel DEFINITION INHERITING FROM lcl_alojamiento.
  PUBLIC SECTION.
    " Redefinimos el constructor porque el hotel añade 'estrellas'
    METHODS constructor
      IMPORTING
        i_nombre    TYPE string
        i_estrellas TYPE i.

    METHODS get_estrellas
      RETURNING VALUE(r_estrellas) TYPE i.

  PRIVATE SECTION.
    DATA estrellas TYPE i.
ENDCLASS.

CLASS lcl_hotel IMPLEMENTATION.
  METHOD constructor.
    " Llamamos al constructor del PADRE (super) para que guarde el nombre
    super->constructor( i_nombre = i_nombre ).
    me->estrellas = i_estrellas.
  ENDMETHOD.

  METHOD get_estrellas.
    r_estrellas = me->estrellas.
  ENDMETHOD.
ENDCLASS.
CLASS lcl_departamento DEFINITION INHERITING FROM lcl_alojamiento.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        i_nombre    TYPE string
        i_ambientes TYPE i.
    METHODS get_ambientes
      RETURNING VALUE(r_amb) TYPE i.
    " REDEFINITION: Aquí es donde ocurre el polimorfismo
    " Cambiaremos el comportamiento de un método que ya existe
    METHODS get_nombre REDEFINITION.

  PRIVATE SECTION.
    DATA ambientes TYPE i.
ENDCLASS.

CLASS lcl_departamento IMPLEMENTATION.
  METHOD constructor.
    super->constructor( i_nombre = i_nombre ).
    me->ambientes = i_ambientes.
  ENDMETHOD.
  METHOD get_ambientes.
    r_amb = me->ambientes.
  ENDMETHOD.
  METHOD get_nombre.
    " Un departamento muestra su nombre de forma distinta al hotel
    r_nombre = |Depto: { me->nombre } ({ me->ambientes } amb)|.
  ENDMETHOD.
CLASS z_instanceherencia DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_instanceherencia IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.
    " Declaramos la tabla genérica del Padre
    DATA alojamientos TYPE TABLE OF REF TO lcl_alojamiento.

    " --- CREACIÓN DE INSTANCIAS (2 más de cada uno) ---
    " Hoteles existentes y nuevos
    APPEND NEW lcl_hotel( i_nombre = 'Hotel Hilton' i_estrellas = 5 ) TO alojamientos.
    APPEND NEW lcl_hotel( i_nombre = 'Hotel Economy' i_estrellas = 2 ) TO alojamientos. " Nuevo 2*
    APPEND NEW lcl_hotel( i_nombre = 'Hotel Business' i_estrellas = 4 ) TO alojamientos. " Nuevo 4*

    " Departamentos existentes y nuevos
    APPEND NEW lcl_departamento( i_nombre = 'Studio Central' i_ambientes = 2 ) TO alojamientos.
    APPEND NEW lcl_departamento( i_nombre = 'Family Suite' i_ambientes = 3 ) TO alojamientos. " Nuevo 3 amb
    APPEND NEW lcl_departamento( i_nombre = 'Micro Studio' i_ambientes = 1 ) TO alojamientos. " Nuevo 1 amb

    out->write( '--- RESULTADOS FILTRADOS ---' ).

    LOOP AT alojamientos INTO DATA(lo_alojamiento).

      " --- LÓGICA DE FILTRADO CON CONDICIONAL DOBLE ---

      " 1. Filtro para Hoteles de más de 3 estrellas
      IF lo_alojamiento IS INSTANCE OF lcl_hotel.
        DATA(lo_hotel) = CAST lcl_hotel( lo_alojamiento ).

        IF lo_hotel->get_estrellas( ) > 3.
          out->write( |HOTEL TOP: { lo_hotel->get_nombre( ) } - { lo_hotel->get_estrellas( ) } estrellas| ).
        ENDIF.

      " 2. Filtro para Departamentos de más de 1 ambiente
      ELSEIF lo_alojamiento IS INSTANCE OF lcl_departamento.
        DATA(lo_depto) = CAST lcl_departamento( lo_alojamiento ).

        IF lo_depto->get_ambientes( ) > 1.
          out->write( |DEPTO AMPLIO: { lo_depto->get_nombre( ) }| ).
        ENDIF.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
ENDCLASS.
