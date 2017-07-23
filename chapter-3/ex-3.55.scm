(load "./3.5")

(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (stream-cdr s) (partial-sums s))))

(display-stream (stream-take (partial-sums integers) 10))
; 1
; 3
; 6
; 10
; 15
; 21
; 28
; 36
; 45
; 55
