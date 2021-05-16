(defn- encode_fn [code level i lat lng unit]
  (if (>= i level)
    code
    (encode_fn
      (string code (+ 1 (math/floor (/ lng unit)) (* (math/floor (/ lat unit)) 3)))
      level
      (+ i 1)
      (- lat (* (math/floor (/ lat unit)) unit))
      (- lng (* (math/floor (/ lng unit)) unit))
      (/ unit 3.0)
    )
  )
)

(defn encode [lat lng level]
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

(defn is_1to9 (c)
    (and (>= c 49) (<= c 57))
)

(defn- decode_fn [code lat lng level unit]
  (if (or (= (length code) 0) (not (is_1to9 (first code))))
    (tuple (- (+ lat (/ (* unit 3.0) 2.0)) 90.0) (+ lng (/ (* unit 3.0) 2.0)) level (* unit 3.0))
    (do
      (def n (- (first code) 49))
      (decode_fn
        (slice code 1)
        (+ lat (* (math/floor (/ n 3)) unit))
        (+ lng (* (math/floor (% n 3)) unit))
        (+ level 1)
        (/ unit 3.0)
      )
    )
  )
)

(defn- decode_fne [code]
  (decode_fn code 0.0 0.0 1 (/ 180.0 3.0))
)

(defn- decode_fnw [code]
  (def pos (decode_fne code))
  (tuple (first pos) (- (first (slice pos 1)) 180) (first (slice pos 2)) (first (slice pos 3)))
)

(defn decode [scode]
  (def code (string/bytes scode))
  (if (> (length code) 0)
    (do
      (case (first code)
        87 (decode_fnw (slice code 1)) # W=87
        69 (decode_fne (slice code 1)) # E=69
        '(0.0 0.0 0 180.0)
      )
    )
    '(0.0 0.0 0 180.0)
  )
)
