(load "./3.5")

; a

(define (integrate-series power-series)
  (stream-map / power-series integers))

; b

(define cosine-series
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

(display-stream (stream-take cosine-series 5))
(display-stream (stream-take sine-series 6))
