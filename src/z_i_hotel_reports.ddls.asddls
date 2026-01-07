@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reporte Maestro con Joins'
@Metadata.ignorePropagatedAnnotations: true

define view entity Z_I_HOTEL_REPORTS
  as select from zhotels_db as Hotel -- Alias para nuestra tabla principal
  
  /* JOIN: Unimos con la tabla de textos de moneda */
  left outer join I_CurrencyText as Text on  Hotel.currency = Text.Currency
                                         and Text.Language  = $session.system_language
{
  key Hotel.hotel_id     as HotelID,
  Hotel.name             as HotelName,
  Hotel.city             as City,
  
  @Semantics.amount.currencyCode: 'Currency'
  Hotel.price            as BasePrice,
  
  Hotel.currency         as Currency,
  
  /* Nuevo campo traído desde el JOIN */
  @EndUserText.label: 'Descripción Moneda'
  Text.CurrencyName      as CurrencyDescription,

  /* Tu lógica de CASE que ya funciona */
  @Semantics.amount.currencyCode: 'Currency'
  case Hotel.city
    when 'Tokyo' then cast( cast( Hotel.price * 120 as abap.dec(15,2) ) / 100 as abap.curr(15,2) )
    when 'Paris' then cast( cast( Hotel.price * 115 as abap.dec(15,2) ) / 100 as abap.curr(15,2) )
    else              cast( cast( Hotel.price * 110 as abap.dec(15,2) ) / 100 as abap.curr(15,2) )
  end                    as FinalPrice
}
