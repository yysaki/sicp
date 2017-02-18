(define (double a)
  (+ a a))
(define (halve a)
  (/ a 2))

(define (fast-* a b)
  (fast-*-iter a b 0))

(define (fast-*-iter a b product)
  (cond ((= b 0) product)
        ((even? b) (fast-*-iter (double a) (halve b) product))
        (else (fast-*-iter a (- b 1) (+ product a)))))

(print (fast-* 10 12)) ;120

