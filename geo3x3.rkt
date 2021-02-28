#lang racket

(require rnrs/bytevectors-6)
(require rnrs/io/ports-6)

(define (encode-bytes lat lng level)
   (cond [(< level 1) (error "invalid level")]
         [else
           (call-with-bytevector-output-port (lambda (res)
             (let-values ([(lat lng unit) (values lat lng 0)])
                 (let-values([(c lng1) (if (>= lng 0) (values #\E lng)
                                                      (values #\W (+ lng 180)))])
                              (put-u8 res (char->integer c))
		              (set!-values (lat lng unit) (values (+ lat 90) lng1 180)))
                 (for-each (lambda (_)
                          (let*-values ([(unit1) (/ unit 3)]
                                        [(x y) (values (exact-floor (/ lng unit1))
                                                       (exact-floor (/ lat unit1)))]
                                        [(c lng1 lat1) (values (+ (char->integer #\0) x (* y 3) 1)
                                                               (- lng (* x unit1))
                                                               (- lat (* y unit1)))])
;                             (printf "lng:~a lat:~a unit:~a unit1:~a x:~a y:~a\n" lng lat unit unit1 x y)
;                             (printf "c:~a lng1:~a lat1:~a\n" c lng1 lat1)
                              (put-u8 res c)
                              (set!-values (lat lng unit) (values lat1 lng1 unit1))))
                      (range 1 level)))))]))

(define (decode-bytes code)
   (cond [(or (not (bytevector? code)) (= (bytevector-length code) 0)) (error "trying to decode empty data")]
         [else
            (let-values ([(begin is-west) 
                 (let ([c (integer->char (bytevector-u8-ref code 0))])
                     (cond [(or (eq? c #\-) (eq? c #\W)) (values 1 #t)]
                           [(or (eq? c #\+) (eq? c #\E)) (values 1 #f)]
                           [else                         (values 0 #f)]))])
                 (let-values ([(lat lng level unit) (values 0 0 1 180)]
                              [(clen) (bytevector-length code)])
                     (let loop ((i begin))
                         (when (< i clen)
                             (let ([n (- (bytevector-u8-ref code i) (char->integer #\0))])
                                 (when (and (<= 1 n) (<= n 9))
                                      (let*-values ([(unit1) (/ unit 3)]
                                                    [(lng1 lat1) (let ([n (- n 1)])
                                                           (values (+ lng (* (remainder n 3) unit1))
                                                                   (+ lat (* (quotient  n 3) unit1))))]
                                                    [(level1) (+ level 1)])
                                          (set!-values (lat lng level unit) (values lat1 lng1 level1 unit1))
                                          (loop (+ i 1)))))))
                     (list (exact->inexact (let ([lat (+ lat (/ unit 2))]) (- lat 90) ))
                           (exact->inexact (let ([lng (+ lng (/ unit 2))]) (if is-west (- lng 180) lng) ))
                           level
                           (exact->inexact unit))))]))


;(encode 35.65858 139.745433 14)
(define (encode lat lng level)
    (utf8->string (encode-bytes lat lng level)))

;(decode "E3793653391822")
(define (decode code)
    (decode-bytes (string->utf8 code)))

(provide encode-bytes)
(provide decode-bytes)
(provide encode)
(provide decode)

