@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root entity - Proyection'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zcds_06_log_c431
  provider contract transactional_query
  as projection on zcds_04_log_c431
{
  key TravelId,
      AgencyId,
      CustomerId,
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      CurrencyCode,
      Description,
      Status,
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      /* Associations */
      _Agency,
      _Booking: redirected to composition child zcds_07_log_c431,
      _Customer
}
