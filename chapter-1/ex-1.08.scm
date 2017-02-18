(define (cube x)
  (* x x x))

(define (good-enough? guess x)
  (< (abs (- (cube guess)
             x))
     0.001))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess))
     3))

(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)))

(define (cube-root x)
  (cube-root-iter 1.0 x))

(print (cube-root 1))  ; 1.00...
(print (cube-root 8))  ; 2.00...
(print (cube-root 27)) ; 3.00...
