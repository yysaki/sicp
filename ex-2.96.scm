(load "./tables")

(define (gcd-terms a b)
  (if (empty-termlist? b)
    (let ((gcd-coeff (apply gcd (map coeff a))))
      (mul-term-by-all-terms (make-term 0 (/ 1 gcd-coeff)) a))
    (gcd-terms b (pseudoremainder-terms a b))))
(define (pseudoremainder-terms a b)
  (let ((ta (first-term a))
        (tb (first-term b)))
    (let ((integerizing-factor
            (expt (coeff tb) (+ 1 (order ta) (- (order tb))))))
      (caaadr
        (div-terms
          (mul-term-by-all-terms (make-term 0 integerizing-factor) a)
          b)))))

(install-scheme-number-package)
(install-rational-package)
(install-polynomial-package)

(define p1 (make-polynomial 'x '((2 1) (1 -2) (0 1))))
(define p2 (make-polynomial 'x '((2 11) (0 7))))
(define p3 (make-polynomial 'x '((1 13) (0 5))))
(define q1 (mul p1 p2))
(define q2 (mul p1 p3))
(print (greatest-common-divisor q1 q2))

