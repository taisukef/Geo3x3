(setq load-path nil)
(load "geo3x3")

(message (geo3x3_encode 35.65858 139.745433 14))

(setq pos (geo3x3_decode "E9139659937288"))
(message (number-to-string (nth 0 pos)))
(message (number-to-string (nth 1 pos)))
(message (number-to-string (nth 2 pos)))
(message (number-to-string (nth 3 pos)))
