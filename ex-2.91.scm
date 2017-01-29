(load "./tables")

(define (div-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
    (let ((result-terms (div-terms (term-list p1)
                                   (term-list p2))))
      (list
        (make-poly (variable p1) (car result-terms))
        (make-poly (variable p1) (cdr result-terms))))
    (error "Polys not in same var -- DIV-POLY"
           (list p1 p2))))
(define (div-terms L1 L2)
  (if (empty-termlist? L1)
    (list (the-empty-termlist) (the-empty-termlist))
    (let ((t1 (first-term L1))
          (t2 (first-term L2)))
      (if (> (order t2) (order t1))
        (list (the-empty-termlist) L1)
        (let ((new-c (div (coeff t1) (coeff t2)))
              (new-o (- (order t1) (order t2))))
          (let ((rest-of-result
                  (div-terms
                    (add-terms L1
                               (minus-terms
                                 (mul-term-by-all-terms
                                   (make-term new-o new-c)
                                   L2)))
                    L2)))
            (list (adjoin-term
                    (make-term new-o new-c)
                    (car rest-of-result))
                  (cdr rest-of-result))))))))

(put 'div '(polynomial polynomial)
     (lambda (p1 p2) (tag (div-poly p1 p2))))

(define (main args)
  (install-scheme-number-package)
  (install-polynomial-package)
  (let ((p1 (make-polynomial 'x '((5 1) (0 -1))))
        (p2 (make-polynomial 'x '((2 1) (0 -1)))))
    (print (div p1 p2))))
