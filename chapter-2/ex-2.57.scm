(load "./ex-2.56")

(define make-sum
  (lambda (a b . c)
    (append (list '+ a) (cons b c))))
(define make-product
  (lambda (a b . c)
    (append (list '* a) (cons b c))))

(define (augend s)
  (if (eq? (cdddr s) '())
    (caddr s)
    (cons '+ (cddr s))))
(define (multiplicand p)
  (if (eq? (cdddr p) '())
    (caddr p)
    (cons '* (cddr p))))
