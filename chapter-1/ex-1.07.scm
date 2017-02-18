(define (power-iter x y base-x)
  (if (<= y 1)
    x
    (power-iter (* x base-x) (- y 1) base-x)))
(define (power x y)
  (power-iter x y x))

(define (good-enough? guess x)
  (< (abs (/ (- guess (improve guess x)) guess))
     (/ 1.0 (power 10 15))))

(define (average x y)
  (/ (+ x y) 2))
(define (improve guess x)
  (average guess (/ x guess)))
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
(define (sqrt x)
  (sqrt-iter 1.0 x))

(print (sqrt 2))
(print (sqrt (power 0.00001 2)))
(print (sqrt (power 123456789 2)))
