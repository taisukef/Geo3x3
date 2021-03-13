       IDENTIFICATION  DIVISION.
       PROGRAM-ID.     geo3x3_decode.
       DATA            DIVISION.
       WORKING-STORAGE SECTION.
       01  I           PIC  9(03).
       01  FLG         PIC  9(01).
       01  BEGIN       PIC  9(01).
       01  LEN         PIC  9(03).
       01  N           PIC  9(01).
       01  D           PIC S999.
       01  R           PIC S999.
       LINKAGE         SECTION.
       01  COD         PIC  X(31).
       01  COD-TBL     REDEFINES   COD.
         03  COD-X     PIC  X(1)   OCCURS  31.
       01  LAT         PIC S9(03)V9(6).
       01  LNG         PIC S9(03)V9(6).
       01  LEVEL       PIC  9(02).
       01  UNT         PIC S9(03)V9(6).
       PROCEDURE       DIVISION    USING   BY  REFERENCE   COD
                                           BY  REFERENCE   LAT
                                           BY  REFERENCE   LNG
                                           BY  REFERENCE   LEVEL
                                           BY  REFERENCE   UNT.
       MAIN            SECTION.
       MAIN-01.
           MOVE    ZERO        TO  LAT
                                   LNG
                                   LEVEL
                                   UNT.
      *
           IF      COD =   SPACE   THEN
               GO  TO  MAIN-99
           END-IF.
      *
           MOVE    ZERO        TO  FLG.
           MOVE    1           TO  BEGIN.
           EVALUATE    COD(1:1)
               WHEN    "W"
                   MOVE    1       TO  FLG
                   MOVE    2       TO  BEGIN
               WHEN    "E"
                   MOVE    2       TO  BEGIN
               WHEN    OTHER
                   GO  TO  MAIN-99
           END-EVALUATE.
      *
           COMPUTE LEN =   FUNCTION STORED-CHAR-LENGTH(COD)
                           -   BEGIN
           END-COMPUTE.
           IF      COD(BEGIN:LEN)  IS NOT NUMERIC THEN
               GO  TO  MAIN-99
           END-IF.
      *
           MOVE    180         TO  UNT.
           MOVE    ZERO        TO  LAT
                                   LNG.
           MOVE    1           TO  LEVEL.
           PERFORM VARYING I
                   FROM    BEGIN
                   BY      1
                   UNTIL   I   >   31
                       OR  COD(I:1)   =   SPACE
               MOVE    COD(I:1)    TO  N
               COMPUTE UNT =   UNT / 3         END-COMPUTE
               SUBTRACT    1       FROM    N   END-SUBTRACT
               DIVIDE  3   INTO    N
                   GIVING      D
                   REMAINDER   R
               END-DIVIDE
               COMPUTE LNG =   LNG + R * UNT   END-COMPUTE
               COMPUTE LAT =   LAT + D * UNT   END-COMPUTE
               ADD     1           TO  LEVEL   END-ADD
           END-PERFORM.
           COMPUTE LNG =   LNG +   UNT / 2 END-COMPUTE.
           COMPUTE LAT =   LAT +   UNT / 2 END-COMPUTE.
           COMPUTE LAT =   LAT -   90.
           IF      FLG =   1
               COMPUTE LNG =   LNG -   180 END-COMPUTE
           END-IF.
       MAIN-99.
           EXIT PROGRAM.
       END PROGRAM     geo3x3_decode.
