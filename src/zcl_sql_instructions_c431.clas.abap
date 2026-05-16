CLASS zcl_sql_instructions_c431 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_instructions_c431 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*   Inline declaration
*    SELECT * FROM /dmo/customer
*     INTO TABLE @DATA(lt_results)
*     UP TO 10 ROWS.
*
*    IF sy-subrc = 0.
*      out->write( lt_results ).
*    ENDIF.

* Column specification
*    SELECT customer_id
*           FIRST_name
*           last_name
*           title
*           street
*     FROM /dmo/customer
*     INTO TABLE lt_result2
*     WHERE customer_id > 000002.

*    SELECT FROM /dmo/customer
*    FIELDS "*
*           customer_id,
*           first_name,
*           last_name,
*           postal_code
*      INTO TABLE @DATA(lt_result)
*      UP TO 10 ROWS.
*
*    IF sy-subrc = 0.
*      out->write( lt_result ).
*    ENDIF.

* Host Variables

*    CONSTANTS: lc_inmediately TYPE c LENGTH 1 VALUE 'I'.
*
*    DATA: lv_airline_id TYPE c LENGTH 3 VALUE 'LH'.
*
*    TYPES: BEGIN OF ty_result,
*             AirlineId    TYPE c LENGTH 3,
*             ConecctionId TYPE c LENGTH 4,
*             Availability TYPE c LENGTH 1,
*           END OF ty_result.
*
*    DATA: ls_result TYPE ty_result.
*
*
*    SELECT SINGLE FROM /DMO/I_Flight
*    FIELDS AirlineID,
*           ConnectionID,
*           @lc_inmediately AS Availability
*     WHERE AirlineID = @lv_airline_id
*      INTO @ls_result.
*
*    IF sy-subrc = 0.
*      out->write( ls_result ).
*    ENDIF.


* Clause Secuence

*    CONSTANTS lc_availability_seats TYPE int4 VALUE 30.
*
*    SELECT FROM /DMO/I_Flight
*    FIELDS AirlineID,
*           ConnectionID,
*           ( MaximumSeats - OccupiedSeats ) AS AvailableSeats
*    WHERE ( MaximumSeats - OccupiedSeats ) GE @lc_availability_seats
*    GROUP BY AirlineID, ConnectionID, MaximumSeats, OccupiedSeats
*    ORDER BY AirlineID DESCENDING
*    INTO TABLE @DATA(lt_results)
*    UP TO 30 ROWS.
*
*    IF sy-subrc = 0.
*      out->write( lt_results ).
*    ENDIF.


* Case

*    DATA: lv_date TYPE d VALUE '20300101'.
*
*    DATA(lv_current_date) = cl_abap_context_info=>get_system_date( ).
*
*    SELECT FROM /dmo/customer
*    FIELDS customer_id,
*           country_code,
*
*      CASE country_code
*         WHEN 'US' THEN concat( 'United States -', concat_with_space( first_name, last_name, 2 ) )
*         WHEN 'DE' THEN concat( 'Germany - ', last_name )
*         WHEN 'ES' THEN concat( 'Spain -', last_name )
*         ELSE 'Another Country Code'
*      END AS ColumnCase1,
*
*      CASE
*          WHEN country_code = 'US' OR country_code = 'ES' THEN CASE title
*                                                                  WHEN 'Mr.' THEN 'US/ES - Mr.'
*                                                                  WHEN 'Mrs.' THEN  'US/ES - Mrs.'
*                                                                  ELSE 'US/ES - Different Title'
*                                                                END
*          WHEN title = 'Mr.' THEN last_name
*          WHEN @lv_date < dats_add_days( @lv_current_date, -30 ) THEN 'Lower Date'
*          ELSE 'No condittion applied'
*      END AS ColumnCase2
*
*      INTO TABLE @DATA(lt_results).
*
*
*    IF sy-subrc = 0.
*      out->write( lt_results ).
*    ENDIF.

* UNION

*    CONSTANTS lc_blank_date TYPE d VALUE '00000000'.
*
*    SELECT FROM /DMO/I_Flight
*    FIELDS AirlineID AS id,
*           ConnectionID,
*           FlightDate
*
*    UNION DISTINCT "ALL   "DISTINCT
*
*    SELECT FROM /DMO/I_Connection
*    FIELDS AirlineID AS id,
*           ConnectionID,
*           @lc_blank_date AS FlightDate
*
*     ORDER BY id ASCENDING
*     INTO TABLE @DATA(lt_results).
*
*    IF sy-subrc = 0.
*      out->write( lt_results ).
*    ENDIF.

* Global temporary table
    DATA: lt_employee TYPE STANDARD TABLE OF zemployee_c431.

    lt_employee = VALUE #( ( emp_id = 1
                             emp_name = 'Enrique'
                             emp_last_name  = 'Perez'
                             emp_age        = '36'
                             emp_sex       = 'M' )
                           ( emp_id = 2
                             emp_name = 'Laura'
                             emp_last_name  = 'Perez'
                             emp_age        = '36'
                             emp_sex       = 'F' )  ).

    MODIFY zemployee_c431 FROM TABLE @lt_employee.

    IF sy-subrc = 0.

      SELECT * FROM zemployee_c431 INTO TABLE @DATA(lt_results).

      out->write( lt_results ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
