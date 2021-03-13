       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     geo3x3_test.
       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  WK-AREA.
         03  LAT       PIC S9(03)V9(6).
         03  LNG       PIC S9(03)V9(6).
         03  UNT       PIC S9(03)V9(6).
         03  LEVEL     PIC  9(02).
       01  RES         PIC  X(31).
       01  COD         PIC  X(31).
       PROCEDURE       DIVISION.
       MAIN-01.
           MOVE   14           TO  LEVEL.
           MOVE   35.65858     TO  LAT.
           MOVE  139.745433    TO  LNG.
           MOVE    SPACE       TO  RES.
           DISPLAY "LAT  = " LAT.
           DISPLAY "LNG  = " LNG.
           DISPLAY "LEVEL= " LEVEL.
           CALL    "geo3x3_encode" USING   BY  REFERENCE   LAT
                                           BY  REFERENCE   LNG
                                           BY  REFERENCE   LEVEL
                                           BY  REFERENCE   RES
           END-CALL.
           DISPLAY "RES = " RES.
      *
           MOVE    RES         TO  COD.
           INITIALIZE              WK-AREA.
           CALL    "geo3x3_decode" USING   BY  REFERENCE   COD
                                           BY  REFERENCE   LAT
                                           BY  REFERENCE   LNG
                                           BY  REFERENCE   LEVEL
                                           BY  REFERENCE   UNT
           END-CALL.
           DISPLAY "LAT  = " LAT.
           DISPLAY "LNG  = " LNG.
           DISPLAY "LEVEL= " LEVEL.
           DISPLAY "UNIT = " UNT.
      *
           MOVE    SPACE       TO  RES.
           CALL    "geo3x3_encode" USING   BY  REFERENCE   LAT
                                           BY  REFERENCE   LNG
                                           BY  REFERENCE   LEVEL
                                           BY  REFERENCE   RES
           END-CALL.
           DISPLAY "RES = " RES.
       MAIN-99.
           STOP RUN.
       END PROGRAM     geo3x3_test.
