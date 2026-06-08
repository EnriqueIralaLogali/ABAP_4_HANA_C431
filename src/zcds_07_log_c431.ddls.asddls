@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Child Entity - Projection'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_07_log_c431
  as projection on zcds_05_log_c431
{
  key TravelId,
  key BookingId,
      BookingDate,
      CustomerId,
      CarrierId,
      ConnectionId,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      /* Associations */
      _Customer,
      _Travel: redirected to parent zcds_06_log_c431
}
