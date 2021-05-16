(import ./geo3x3)

(print (geo3x3/encode 35.65858 139.745433 14))

(def pos (geo3x3/decode "E9139659937288"))
(print (0 pos) " " (1 pos) " " (2 pos) " " (3 pos))
(def pos2 (geo3x3/decode "W9"))
(print (0 pos2) " " (1 pos2) " " (2 pos2) " " (3 pos2))
