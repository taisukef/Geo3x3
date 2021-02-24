#lang racket


(define (encode-bytes lat lng level)
  (cond
    [(< level 1) (error "invalid level")]
    [else
       (let ([unit null]
             [res (make-bytes 0)])

           (define (update lat0 lng0 unit0 c0)
                   (set! lat lat0)
                   (set! lng lng0)
                   (set! unit unit0)
                   (set! res (bytes-append res (bytes (char->integer c0))))
           )

           (
             (lambda (clng)
               (match clng
                 [(list c lng) (update (- 90 lat) lng 180 c)]
               )
             )
             (if (>= lng 0) (list #\E lng) (list #\W (+ lng 180)))
           )

           (for-each
             (lambda (_)
               (apply update (let* ([unit (/ unit 3)]
                                    [x (exact-floor (/ lng unit))]
                                    [y (exact-floor (/ lat unit))]
                                    [c (integer->char (+ (char->integer #\0) x (* y 3) 1))]
                                    [lng (- lng (* x unit))]
                                    [lat (- lat (* y unit))])
                                   (list lat lng unit c)
                             )
               )
             )
             (range 1 level)
           ) 
           res
       )
    ]
  )
)


(define (decode-bytes code)
  (cond
    [(or (not (bytes? code)) (= (bytes-length code) 0)) (error "trying to decode empty data")]
    [else
      (let ([begin null]
            [is-west null])
        (
	  (lambda (c)
            (cond
               [(or (eq? c #\-) (eq? c #\W))
                (set! begin 1)
                (set! is-west #t)]
               [(or (eq? c #\+) (eq? c #\E))
                (set! begin 1)
	        (set! is-west #f)]
               [else
                (set! begin 0)
	        (set! is-west #f)]
            )
          ) (integer->char (bytes-ref code 0))
        )

        (let ([lat 0]
              [lng 0]
              [level 1]
              [unit 180])
          (define (loop clen i)
            (when (< i clen)
              (
                (lambda (n)
                  (when (> n 0)
                        (set! unit (/ unit 3))
                        (set! lng (+ lng (* (remainder (- n 1) 3) unit)))
                        (set! lat (+ lat (* (quotient  (- n 1) 3) unit)))
                        (set! level (+ level 1))
                        (loop clen (+ i 1))
                  )
                ) (- (bytes-ref code i) (char->integer #\0))
              )
	    )
          )
          (loop (bytes-length code) begin)

          (list
            (exact->inexact ( (lambda (lat) (- 90 lat))
                                      (+ lat (/ unit 2))
                            ))
            (exact->inexact ( (lambda (lng) (if is-west (- lng 180) lng))
                                      (+ lng (/ unit 2))
                            ))
            level
            (exact->inexact unit)
          )
        )

      )
    ]
  )
)


;(encode 35.65858 139.745433 14)
(define (encode lat lng level)
  (bytes->string/utf-8 (encode-bytes lat lng level))
)


;(decode "E3793653391822")
(define (decode code)
  (decode-bytes (string->bytes/utf-8 code))
)


(provide encode-bytes)
(provide decode-bytes)
(provide encode)
(provide decode)

