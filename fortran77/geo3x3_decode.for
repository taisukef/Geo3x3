      PROGRAM MAIN
        IMPLICIT NONE
        CHARACTER(50) GEO3X3_DECODE
        PRINT*,GEO3X3_DECODE('E9139659937288')
      END PROGRAM MAIN

C      DECODE FUNCTION
      CHARACTER(50) FUNCTION GEO3X3_DECODE(CODE)
        CHARACTER(LEN=*) CODE
        REAL LAT, LNG, LEVEL, UNIT
        INTEGER F, I, N
        LAT = 0.0
        LNG = 0.0
        LEVEL = 0.0
        UNIT = 180.0

        IF (LEN(CODE) > 0) THEN
          F = 0
          IF (CODE(1:1) .EQ. 'W') THEN
            F = 1
          END IF
          LEVEL = LEVEL + 1
          DO 100 I = 2,LEN(CODE)
            N = INDEX('123456789',CODE(I:I)) -1
            IF (N .GE. 0) THEN
              UNIT = UNIT /3
              LNG = LNG + MOD(N, 3) * UNIT
              LAT = LAT + N / 3 * UNIT
              LEVEL = LEVEL + 1
            END IF
100       CONTINUE
          LAT = LAT + UNIT / 2
          LNG = LNG + UNIT / 2
          LAT = LAT - 90
          IF (F .EQ. 1) THEN
            LNG = LNG - 180.0
          END IF
        END IF
        WRITE(GEO3X3_DECODE,"(3(G0,',')G0)") LAT,LNG,LEVEL,UNIT
        RETURN
      END FUNCTION GEO3X3_DECODE