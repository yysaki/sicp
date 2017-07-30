(load "./3.5")

; a

(define (integrate-series power-series)
  (stream-map / power-series integers))

; b

(define minus-stream
  (cons-stream -1 minus-stream))

(define cosine-series
  (cons-stream 1 
               (mul-streams minus-stream
               (integrate-series sine-series))))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

(display-stream (stream-take cosine-series 5))
(display-stream (stream-take sine-series 6))
