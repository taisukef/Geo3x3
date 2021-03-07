VARIABLE LAT
VARIABLE LNG
VARIABLE LEVEL1
VARIABLE UNIT

VARIABLE X
VARIABLE Y
VARIABLE RES
: R CHARS RES + ;

: GEO3X3_ENCODE ( level lat lng -- code_len code_addr )
  LEVEL1 !
  LNG !
  LAT !
\  LAT ? CR
\  LNG ? CR
\  LEVEL1 ? CR

  RES LEVEL1 @ CHARS ALLOT
  RES LEVEL1 @ ERASE
  LNG @ 0< IF
              LNG @ 180000000 + LNG !
              87 0 R C! \ W
           ELSE
              69 0 R C! \ E
           THEN
  LAT @ 90000000 + LAT ! 
  180000000 UNIT ! 

  LEVEL1 @ 1 DO
    UNIT @ 3 / UNIT !
    LNG @ UNIT @ / X !
    LAT @ UNIT @ / Y !
    48 X @ Y @ 3 * + + 1 + I R C!
    LNG @ X @ UNIT @ * - LNG !
    LAT @ Y @ UNIT @ * - LAT !
  LOOP
  RES LEVEL1 @
;


VARIABLE CODE_ADDR
VARIABLE CODE_LEN
: CH CHARS CODE_ADDR @ + ;
VARIABLE INIT
VARIABLE IS_WEST
VARIABLE II
VARIABLE N
VARIABLE C

: GEO3X3_DECODE ( code_len code_addr  -- lat lng level unit  )
  CODE_LEN !
  CODE_ADDR !
\  CODE_ADDR @ CODE_LEN @ TYPE CR
  0 INIT !
  FALSE IS_WEST !
  0 CH C@ C !
  C @ 45 = C @ 87 = OR IF TRUE IS_WEST !
                          1 INIT !
                       THEN
  C @ 43 = C @ 69 = OR IF 1 INIT !
                       THEN
\  C ? CR
\  IS_WEST ? CR
\  INIT ? CR

  180000000 UNIT !
  0 LAT !
  0 LNG !
  1 LEVEL1 !

  INIT @ II ! BEGIN
  II @ CODE_LEN @ < WHILE
    II @ CH C@ 48 - N !
\    N @ . CR
    0 N @ < N @ 9 <= AND IF
                UNIT @ 3 / UNIT !
                N @ 1 - N !
                LNG @ N @ 3 MOD UNIT @ * + LNG !
                LAT @ N @ 3 /   UNIT @ * + LAT !
                LEVEL1 @ 1 + LEVEL1 !
                II @ 1 + II !
             ELSE
                CODE_LEN @ II !
             THEN
  REPEAT

  LAT @ UNIT @ 2 / + LAT !
  LNG @ UNIT @ 2 / + LNG !
  LAT @ 90000000 - LAT !
  IS_WEST @ IF LNG @ 180000000 - LNG ! THEN

\  LAT ? CR
\  LNG ? CR
\  LEVEL1 ? CR
\  UNIT ? CR

  UNIT @
  LEVEL1 @
  LNG @
  LAT @
;
