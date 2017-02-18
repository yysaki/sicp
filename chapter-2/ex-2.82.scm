(use srfi-1)
(load "./table")
(load "./ex-2.81")

(define (get-coerced-args args target-type)
  (if (null? args)
    '()
    (let ((coercion (get-coercion (type-tag (car args)) target-type)))
      (if coercion
        (cons (coercion (car args)) (get-coerced-args (cdr args) target-type))
        (cons (car args) (get-coerced-args (cdr args) target-type))))))

(define (apply-generic-iter args indexes)
  (if (null? indexes)
    '()
    (let ((coerced-args (get-coerced-args args (type-tag (car indexes)))))
      (if (= (length (delete-duplicates (map type-tag coerced-args))) 1)
        coerced-args
        (apply-generic-iter args (cdr indexes))))))

(define (apply-generic op . args)
  (let ((orig-type-tags (map type-tag args))
        (coerced-args (apply-generic-iter args args)))
    (let ((proc (get op (map type-tag coerced-args))))
      (if proc
        (apply proc (map contents coerced-args))
        (error "No method for these types"
               (list op orig-type-tags))))))

(define (main args)
  (install-polar-package)
  (install-rectangular-package)
  (install-scheme-number-package)
  (install-rational-package)
  (install-complex-package)
  (let ((z (make-complex-from-real-imag 3 4))
        (n (make-scheme-number 2)))
    (print (add n n))
    (print (add n z))
    (print (add z n))
    (print (add z z))))
