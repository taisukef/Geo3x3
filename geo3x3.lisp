(defpackage :geo3x3 (:use :cl))
(in-package :geo3x3)

(defun encode_fn (code level i lat lng unit)
    (if (>= i level)
        code
        (encode_fn
            (concatenate 'string code (write-to-string (+ 1 (floor (/ lng unit)) (* (floor (/ lat unit)) 3))))
            level
            (+ i 1)
            (- lat (* (floor (/ lat unit)) unit))
            (- lng (* (floor (/ lng unit)) unit))
            (/ unit 3.0)
        )
    )
)

(defun encode (lat lng level)
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

(defun is_1to9 (c)
    (and (>= (char-code c) (char-code #\1)) (<= (char-code c) (char-code #\9)))
)

(defun decode_fn (code lat lng level unit)
    (if (or (= (length code) 0) (not (is_1to9 (first code))))
        (list (- (+ lat (/ (* unit 3.0) 2.0)) 90.0) (+ lng (/ (* unit 3.0) 2.0)) level (* unit 3.0))
        (let (n)
            (setq n (- (char-code (first code)) 49))
            (decode_fn
                (rest code)
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
        (list (first pos) (- (second pos) 180.0) (third pos) (fourth pos))
    )
)

(defun decode (scode)
    (let (code)
        (setq code (coerce scode 'list))
        (if (= (length code) 0)
            (list 0.0 0.0 0 180.0) ; err
            (progn
                (case (first code)
                    (#\W (decode_fnw (rest code)))
                    (#\- (decode_fnw (rest code)))
                    (#\E (decode_fne (rest code)))
                    (#\+ (decode_fne (rest code)))
                    (t (decode_fne code))
                )
            )
        )
    )
)
