(load "./3.5")

(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)

(define (RC R C dt)
  (define (rc i v0)
    (add-streams
      (integral (scale-stream i (/ 1 C)) v0 dt)
      (scale-stream i R)))
  rc)

(define RC1 (RC 5 1 0.5))

(display-stream-10 (RC1 integers 1))
