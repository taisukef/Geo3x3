; encode
(defun encode_fn (code level i lat lng unit)
    (if (>= i level)
        code
        (encode_fn
            (concat code (int-to-string(+ 1 (floor (/ lng unit)) (* (floor (/ lat unit)) 3))))
            level
            (+ i 1)
            (- lat (* (floor (/ lat unit)) unit))
            (- lng (* (floor (/ lng unit)) unit))
            (/ unit 3.0)
        )
    )
)

(defun geo3x3_encode (lat lng level)
    (if (< level 1)
        ""
        (encode_fn
            (if (>= lng 0.0) "E" "W")
            level
            1
            (+ lat 90.0)
            (if (>= lng 0.0) lng (+ lng 180.0))
            (/ 180.0 3.0)
        )
    )
)

; decode
(defun is_1to9 (c)
    (string-match c "123456789")
)

(defun decode_fn (code lat lng level unit)
    (if (or (= (length code) 0) (not (is_1to9 (car code))))
        (list (- (+ lat (/ (* unit 3.0) 2.0)) 90.0) (+ lng (/ (* unit 3.0) 2.0)) level (* unit 3.0))
        (let (n)
            (setq n (- (string-to-number (car code)) 1))
            (decode_fn
                (cdr code)
                (+ lat (* (floor (/ n 3)) unit))
                (+ lng (* (floor (mod n 3)) unit))
                (+ level 1)
                (/ unit 3.0)
            )
        )
    )
)

(defun decode_fne (code)
    (decode_fn code 0.0 0.0 1 (/ 180.0 3.0))
)

(defun decode_fnw (code)
    (let (pos)
        (setq pos (decode_fne code))
        (list (nth 0 pos) (- (nth 1 pos) 180.0) (nth 2 pos) (nth 3 pos))
    )
)

(defun geo3x3_decode (scode)
    (let (code)
        (setq code (reverse (cdr (reverse (cdr (split-string scode ""))))))
        (if (= (length code) 0)
            (list 0.0 0.0 0 180.0) ; err
            (progn
                (if (string= (car code) "W")
                    (decode_fnw (cdr code))
                    (decode_fne (cdr code))
                )
            )
        )
    )
)
