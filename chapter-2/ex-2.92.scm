(load "./tables")

(define (is-ascendant v1 v2)
  (string>? (symbol->string 'v) (symbol->string 'v)))

; *** ERROR: No method for these types (add (x scheme-number))
(define (normalize-poly v p)
  (make-poly v
             (adjoin-term (make-term 0 p)
                          the-empty-termlist)))

(define (add-poly p1 p2)
  (let ((v1 (variable p1)) (v2 (variable p2)))
    (if (same-variable? v1 v2)
      (make-poly (variable p1)
                 (add-terms (term-list p1)
                            (term-list p2)))
      (if (is-ascendant v1 v2)
        (add-poly p1 (normalize-poly v1 p2))
        (add-poly (normalize-poly v2 p1) p2)))))

(define (mul-poly p1 p2)
  (let ((v1 (variable p1)) (v2 (variable p2)))
    (if (same-variable? v1 v2)
      (make-poly (variable p1)
                 (add-terms (term-list p1)
                            (term-list p2)))
      (if (is-ascendant v1 v2)
        (mul-poly p1 (normalize-poly v1 p2))
        (mul-poly (normalize-poly v2 p1) p2)))))

(define (main args)
  (install-scheme-number-package)
  (install-polynomial-package)
  (let ((p1 (make-polynomial 'x '((5 1) (0 -1))))
        (p2 (make-polynomial 'y '((2 1) (0 -1)))))
    (print (add p1 p2))))

