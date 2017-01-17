(load "./table")
(load "./ex-2.83")

(define (can-raise-to from to-tag)
  (let ((from-tag (type-tag from)))
    (cond
      ((eq? from-tag to-tag) #t)
      ((get 'raise (list from-tag))
       (can-raise-to ((get 'raise (list from-tag)) (contents from)) to-tag))
      (else #f))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (apply proc (map contents args))
        (if (= (length args) 2)
          (let ((a1 (car args))
                (a2 (cadr args)))
            (cond ((can-raise-to a1 (type-tag a2)) (apply-generic op (raise a1) a2))
                  ((can-raise-to a2 (type-tag a1)) (apply-generic op a1 (raise a2)))
                  (else
                    (error "No method for these types"
                           (list op type-tags)))))
          (error "No method for these types"
                 (list op type-tags)))))))

(define (main args)
  (install-polar-package)
  (install-rectangular-package)
  (install-scheme-number-package)
  (install-rational-package)
  (install-real-package)
  (install-complex-package)
  (let ((n (make-scheme-number 3))
        (q (make-rational 2 3))
        (r (make-real 0.3333))
        (c (make-complex-from-real-imag 1 2)))
    ; (print (add q n))
    ; (print (add r n))
    ; (print (add c n))
    ; (print (add q r))
    ; (print (add q c))
    ; (print (add r c))
  ))

