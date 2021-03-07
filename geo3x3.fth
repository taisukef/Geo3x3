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
  LNG f!
  LAT f!
\  LAT f@ f. CR
\  LNG f@ f. CR
\  LEVEL1 ?

  RES LEVEL1 @ CHARS ALLOT
  RES LEVEL1 @ ERASE
  LNG f@ f0< IF
                LNG f@ 180e f+ LNG f!
                87 0 R C! \ W
             ELSE
                69 0 R C! \ E
             THEN
  LAT f@ 90.e f+ LAT f! 
  180.e UNIT f! 

  LEVEL1 @ 1 DO
    UNIT f@ 3e f/ UNIT f!
    LNG f@ UNIT f@ f/ floor f>s X !
    LAT f@ UNIT f@ f/ floor f>s Y !
    48 X @ Y @ 3 * + + 1 + I R C!
    LNG f@ X @ s>f UNIT f@ f* f- LNG f!
    LAT f@ Y @ s>f UNIT f@ f* f- LAT f!
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

  180e UNIT f!
  0e LAT f!
  0e LNG f!
  1 LEVEL1 !

  INIT @ II ! BEGIN
  II @ CODE_LEN @ < WHILE
    II @ CH C@ 48 - N !
\    N @ . CR
    0 N @ < N @ 9 <= AND IF
                            UNIT f@ 3e f/ UNIT f!
                            N @ 1 - N !
                            LNG f@ N @ 3 MOD s>f UNIT f@ f* f+ LNG f!
                            LAT f@ N @ 3 /   s>f UNIT f@ f* f+ LAT f!
                            LEVEL1 @ 1 + LEVEL1 !
                            II @ 1 + II !
                         ELSE
                            CODE_LEN @ II !
                         THEN
  REPEAT

  LAT f@ UNIT f@ 2e f/ f+ LAT f!
  LNG f@ UNIT f@ 2e f/ f+ LNG f!
  LAT f@ 90e f- LAT f!
  IS_WEST @ IF LNG f@ 180e f- LNG f! THEN

\  LAT f@ f. CR
\  LNG f@ f. CR
\  LEVEL1 ? CR
\  UNIT f@ f. CR

  UNIT f@
  LEVEL1 @
  LNG f@
  LAT f@
;
