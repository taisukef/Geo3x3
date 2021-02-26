#lang racket

(define (encode-bytes lat lng level)
   (cond [(< level 1) (error "invalid level")]
         [else
             (let* ([state '()]
                    [res (make-bytes 0)]
                    [display (lambda (c) (set! res (bytes-append res (bytes (char->integer c)))))])
                 ((match-lambda [(cons c lng)
                                 (display c) (set! state (list (- 90 lat) lng 180))])
                     (if (>= lng 0) (cons #\E lng)
                                    (cons #\W (+ lng 180))))
                 (for-each (lambda (_)(
                       (match-lambda [(list lat lng unit)
                                   (let* ([unit (/ unit 3)]
                                          [x (exact-floor (/ lng unit))]
                                          [y (exact-floor (/ lat unit))]
                                          [c (integer->char (+ (char->integer #\0) x (* y 3) 1))]
                                          [lng (- lng (* x unit))]
                                          [lat (- lat (* y unit))])
                                        (display c) (set! state (list lat lng unit)))])
                            state))
                      (range 1 level))
                 res)]))

(define (decode-bytes code)
   (cond [(or (not (bytes? code)) (= (bytes-length code) 0)) (error "trying to decode empty data")]
         [else
            (let-values ([(begin is-west) 
                 (let ([c (integer->char (bytes-ref code 0))])
                     (cond [(or (eq? c #\-) (eq? c #\W)) (values 1 #t)]
                           [(or (eq? c #\+) (eq? c #\E)) (values 1 #f)]
                           [else                         (values 0 #f)]))])
                 (let ([state (list 0 0 1 180)]
                       [clen (bytes-length code)])
                     (let loop ((i begin))
                         (when (< i clen)
                             (let ([n (- (bytes-ref code i) (char->integer #\0))])
                                 (when (> n 0)
                                    (let ([n (- n 1)])
                                       ((match-lambda [(list lat lng level unit)
                                            (let* ([unit  (/ unit 3)]
                                                   [lng   (+ lng (* (remainder n 3) unit))]
                                                   [lat   (+ lat (* (quotient  n 3) unit))]
                                                   [level (+ level 1)])
                                                (set! state (list lat lng level unit))
                                                (loop (+ i 1)))])
                                         state))))))
                     ((match-lambda [(list lat lng level unit)
                             (list (exact->inexact (let ([lat (+ lat (/ unit 2))]) (- 90 lat) ))
                                   (exact->inexact (let ([lng (+ lng (/ unit 2))]) (if is-west (- lng 180) lng) ))
                                   level
                                   (exact->inexact unit))])
                         state)))]))


;(encode 35.65858 139.745433 14)
(define (encode lat lng level)
    (bytes->string/latin-1 (encode-bytes lat lng level)))

;(decode "E3793653391822")
(define (decode code)
    (decode-bytes (string->bytes/latin-1 code)))

(provide encode-bytes)
(provide decode-bytes)
(provide encode)
(provide decode)

