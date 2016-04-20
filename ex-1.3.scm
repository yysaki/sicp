(define (square x)
  (* x x))

(define (mymin x y z)
  (cond ((and (< x y) (< x z)) x)
        ((< y z) y)
        (else z)))

(define (ans x y z)
  (- (+ (square x)
        (square y)
        (square z))
     (square (mymin x y z))))

(print (ans 1 2 3)) ; 13
(print (ans 4 1 2)) ; 20
(print (ans 2 5 1)) ; 29
(print (ans 3 3 3)) ; 18
