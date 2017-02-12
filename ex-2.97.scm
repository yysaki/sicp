(load "./tables")

(define (reduce x y) (apply-generic 'reduce x y))

(define (reduce-integers n d)
  (let ((g (gcd n d)))
    (list (/ n g) (/ d g))))

(put 'reduce '(scheme-number scheme-number)
     (lambda (x y) (tag (reduce-integers x y))))

(define (make-rat n d)
  (let ((r (reduce n d)))
    (cons (car r) (cadr r))))

(define (reduce-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (let ((result-terms (reduce-terms (term-list p1)
                                      (term-list p2))))
      (list
        (make-poly (variable p1) (car result-terms))
        (make-poly (variable p1) (cadr result-terms))))
    (error "Polys not in same var -- REDUCE-POLY"
           (list p1 p2))))
(define (reduce-terms n d)
  (let ((g (gcd-terms n d)))
    (list (car (div-terms n g)) (car (div-terms d g)))))

(put 'reduce '(polynomial polynomial)
     (lambda (p1 p2)
       (let ((r (reduce-poly p1 p2)))
         (list (tag (car r)) (tag (cadr r))))))

(install-scheme-number-package)
(install-rational-package)
(install-polynomial-package)

(define p1 (make-polynomial 'x '((1 1)(0 1))))
(define p2 (make-polynomial 'x '((3 1)(0 -1))))
(define p3 (make-polynomial 'x '((1 1))))
(define p4 (make-polynomial 'x '((2 1)(0 -1))))

(define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))

(print (add rf1 rf2))
