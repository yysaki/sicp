(load "./3.5")

(define (mul-series s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-streams
      (scale-stream (stream-cdr s2) (stream-car s1))
      (mul-series (stream-cdr s1) s2))))

; for testing...

(define (integrate-series power-series)
  (stream-map / power-series integers))

(define cosine-series
  (cons-stream 1 (integrate-series (scale-stream sine-series -1))))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

(display-stream
  (stream-take (add-streams
                 (mul-series cosine-series cosine-series)
                 (mul-series sine-series sine-series))
               10))
