#lang racket
 
(define (encode-bytes lat lng level)
  (cond
   [(< level 1) (error "invalid level")]
   [else
    (let (
	  [unit 0]
	  [res (make-bytes 0)]
	  )

      (cond
       [(>= lng 0)
	(set! res (bytes-append res (bytes (char->integer #\E))))
	]
       [else
	(set! res (bytes-append res (bytes (char->integer #\W))))
	(set! lng (+ lng 180))
	]
       )

      (set! lat (- 90 lat))
      (set! unit 180)

      (for-each
       (lambda (_)
	 (set! unit (/ unit 3))
	 (let ([x (exact-floor (/ lng unit))]
	       [y (exact-floor (/ lat unit))])
	   (set! res (bytes-append
		      res
		      (bytes (+ (char->integer #\0) x (* y 3) 1))
		      )
		 )
	   (set! lng (- lng (* x unit)))
	   (set! lat (- lat (* y unit)))
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
      (let ([begin empty]
            [is-west empty])

        (let ([c (integer->char (bytes-ref code 0))])
          (cond
             [(or (eq? c #\-) (eq? c #\W))
              (set! is-west #t)
              (set! begin 1)
             ]
             [(or (eq? c #\+) (eq? c #\E))
	      (set! is-west #f)
              (set! begin 1)
             ]
             [else
              (set! is-west #f)
              (set! begin 0)
             ]
          )
        )

        (let ([unit 180]
              [lat 0]
              [lng 0]
              [level 1])

          (define (loop clen i)
            (when (< i clen)
              (let ([n (- (bytes-ref code i) (char->integer #\0)) ])
                (when (> n 0)
                      (set! unit (/ unit 3))
                      (set! lng (+ lng (* (remainder (- n 1) 3) unit)))
                      (set! lat (+ lat (* (quotient  (- n 1) 3) unit)))
                      (set! level (+ level 1))
                      (loop clen (+ i 1))
                )
              )
;              (lambda (n)
;                (when (> n 0)
;                      (set! unit (/ unit 3))
;                      (set! lng (+ lng (* (remainder (- n 1) 3) unit)))
;                      (set! lat (+ lat (* (quotient  (- n 1) 3) unit)))
;                      (set! level (+ level 1))
;                      (loop clen (+ i 1))
;                )
;              )((- (bytes-ref code i) (char->integer #\0)))

	    )
          )
          (loop (bytes-length code) begin)

          (set! lat (+ lat (/ unit 2)))
          (set! lng (+ lng (/ unit 2)))
          (set! lat (- 90 lat))
          (when is-west (set! lng (- lng 180)))

          (list
            (exact->inexact lat)
            (exact->inexact lng)
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
