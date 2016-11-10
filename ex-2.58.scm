(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        (else
          (error "unknown expression type -- DERIV" exp))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; a

(define (make-sum a1 a2) (list a1 '+ a2))
(define (addend s) (car s))
(define (augend s) (caddr s))
(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define (make-product m1 m2)
  (list m1 '* m2))
(define (multiplier p) (car p))
(define (multiplicand p) (caddr p))
(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))

; (deriv '(x + (3 * (x + (y + 2)))) 'x)
