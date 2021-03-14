       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     geo3x3_encode.
       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  IX          PIC  9(03).
       01  I           PIC  9(03).
       01  X           PIC S999.
       01  Y           PIC S999.
       01  UNT         PIC S9(03)V9(6).
       01  R           PIC  9(01).
       LINKAGE         SECTION.
       01  LAT         PIC S9(03)V9(6).
       01  LNG         PIC S9(03)V9(6).
       01  LEVEL       PIC  9(02).
       01  RES         PIC  X(31).
       01  RES-TBL     REDEFINES   RES.
         03  RES-X     PIC  X(1)   OCCURS  31.
       PROCEDURE       DIVISION    USING   BY  REFERENCE   LAT
                                           BY  REFERENCE   LNG
                                           BY  REFERENCE   LEVEL
                                           BY  REFERENCE   RES.
       MAIN            SECTION.
       MAIN-01.
           MOVE    SPACE       TO  RES.
           IF      LEVEL   <   1
               OR  LEVEL   >   30  THEN
               GO  TO  MAIN-99
           END-IF.
      *
           MOVE    1           TO  IX.
           MOVE    "E"         TO  RES-X(IX).
           IF      LNG  <  ZERO    THEN
               MOVE    "W"         TO  RES-X(IX)
               COMPUTE LNG =   LNG +   180
           END-IF.
           COMPUTE LAT =   90  +   LAT.
           MOVE    180         TO  UNT.
           MOVE    ZERO        TO  R.
           PERFORM VARYING I
                   FROM    1
                   BY      1
                   UNTIL   I   >=  LEVEL
               COMPUTE UNT =   UNT / 3         END-COMPUTE
               COMPUTE X   =   FUNCTION INTEGER(LNG / UNT) END-COMPUTE
               COMPUTE Y   =   FUNCTION INTEGER(LAT / UNT) END-COMPUTE
               COMPUTE R   =   X   + Y * 3 + 1 END-COMPUTE
               COMPUTE LNG =   LNG - X * UNT   END-COMPUTE
               COMPUTE LAT =   LAT - Y * UNT   END-COMPUTE
               ADD     1           TO  IX
               MOVE    R           TO  RES-X(IX)
           END-PERFORM.
       MAIN-99.
           EXIT PROGRAM.
       END PROGRAM     geo3x3_encode.
