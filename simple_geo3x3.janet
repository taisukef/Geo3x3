(import ./geo3x3)
(print (geo3x3/encode 35.65858 139.745433 14))

(def pos (geo3x3/decode "E9139659937288"))
(print (first pos) " " (first (slice pos 1)) " " (first (slice pos 2)) " " (first (slice pos 3)) " " (first (slice pos 4)))
