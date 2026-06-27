CLASS zcl_priviledge_access_c431 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_priviledge_access_c431 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    AUTHORITY-CHECK OBJECT 'Z_CUST_BU'
*     ID 'ACTVT'  FIELD '03'
*     ID 'BUKRS'  FIELD '1000'.
*
*    IF sy-subrc <> 0.
*      MESSAGE 'You are not authorized to view data for company code 1000.' TYPE 'E'.
*      EXIT.
*
*    ELSE.

      SELECT FROM zcds_12_log_c431 WITH PRIVILEGED ACCESS
      FIELDS *
      INTO TABLE @DATA(lt_results)
      UP TO 50 ROWS.

      IF sy-subrc = 0.
        out->write( lt_results ).
      ENDIF.

*    ENDIF.

  ENDMETHOD.

ENDCLASS.
