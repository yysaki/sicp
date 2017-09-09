(load "./3.5")

(define sense-data
 (make-stream '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4)))

(define (avarage lhs rhs) (/ (+ lhs rhs) 2))
(define (sign-change-detector input-value last-value)
  (cond ((and (>= input-value 0) (< last-value 0)) 1)
        ((and (< input-value 0) (>= last-value 0)) -1)
        (else 0)))

(define (smooth s)
  (stream-map avarage s (cons-stream 0 s)))

(define smoothed
  (smooth sense-data))
(define zero-crossings
  (stream-map sign-change-detector smoothed (cons-stream 0 smoothed)))

(display-stream (stream-take smoothed 12))
