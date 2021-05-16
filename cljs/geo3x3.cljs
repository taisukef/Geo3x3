(ns cljs.geo3x3)

(defn encode_fn [code level i lat lng unit]
    (if (>= i level)
        code
        (encode_fn
            (str code (+ 1 (int (/ lng unit)) (* (int (/ lat unit)) 3)))
            level
            (+ i 1)
            (- lat (* (int (/ lat unit)) unit))
            (- lng (* (int (/ lng unit)) unit))
            (/ unit 3.0)
        )
    )
)

(defn encode [lat lng level]
    (if (< level 1)
        nil
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

(defn is_1to9 [c]
    (>= (.indexOf "123456789" c) 0)
)

(defn decode_fn [code lat lng level unit]
    (if (or (= (count code) 0) (not (is_1to9 (first code))))
        [(- (+ lat (/ (* unit 3.0) 2.0)) 90.0) (+ lng (/ (* unit 3.0) 2.0)) level (* unit 3.0)]
        (let [n (- (int (first code)) 1)]
            (decode_fn
                (rest code)
                (+ lat (* (Math/floor (/ n 3)) unit))
                (+ lng (* (mod n 3) unit))
                (+ level 1)
                (/ unit 3.0)
            )
        )
    )
)

(defn decode_fne [code]
    (decode_fn code 0.0 0.0 1 (/ 180.0 3.0))
)

(defn decode_fnw [code]
    (let [pos (decode_fne code)]
        [(first pos) (- (nth pos 1) 180.0) (nth pos 2) (nth pos 3)]
    )
)

(defn decode [code]
    (if (= (count code) 0)
        [0.0 0.0 0 180.0] ; err
        (case (first code)
            \W (decode_fnw (rest code))
            \- (decode_fnw (rest code))
            \E (decode_fne (rest code))
            \+ (decode_fne (rest code))
            (decode_fne code)
        )
    )
)
