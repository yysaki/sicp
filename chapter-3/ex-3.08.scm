(define x 1)
(define (f n)
  (set! x (* x n))
  x)

(print (+ (f 0) (f 1)))
; 0

; (print (f 0)) => 0
; (print (f 1)) => 0

; (print (f 1)) => 1
; (print (f 0)) => 0
