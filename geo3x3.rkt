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
   [(or (not (bytes? code)) (= (bytes-length code) 0 )) (error "trying to decode empty data")]
   [else
    (let ([lat 0]
	  [lng 0]
	  [level 0]
	  [unit 0]
	  [begin 0]
          [flg #f]
	  [c (bytes-ref code 0)]
          [clen (bytes-length code)]
	  )
      (cond
       [(or (= c (char->integer #\-)) (= c (char->integer #\W)))
	(set! flg #t)
	(set! begin 1)
	]
       [(or (= c (char->integer #\+)) (= c (char->integer #\E)))
	(set! begin 1)
	]
       )
      (set! unit 180)
      (set! lat 0)
      (set! lng 0)
      (set! level 1)

      (define (loop i)
	(cond [(< i clen)
	       (let ([n (- (bytes-ref code i) (char->integer #\0)) ]
		     )
		 (cond [(> n 0)
			(set! unit (/ unit 3))
			(set! n (- n 1))
			(set! lng (+ lng (* (remainder n 3) unit)))
			(set! lat (+ lat (* (quotient n 3) unit)))
			(set! level (+ level 1))
			(loop (+ i 1))
			])
		 )
	       ]
	      )
	)
      (loop begin)

      (set! lat (+ lat (/ unit 2)))
      (set! lng (+ lng (/ unit 2)))
      (set! lat (- 90 lat))
      (cond [flg (set! lng (- lng 180))])

      (list
       (exact->inexact lat)
       (exact->inexact lng)
       level
       (exact->inexact unit)
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
