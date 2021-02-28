#!r6rs
(import (rnrs)
        (geo3x3))

(write (encode 35.65858 139.745433 14))
(newline)

(let-values ((result (decode "E9139659937288")))
  (write result))
(newline)

