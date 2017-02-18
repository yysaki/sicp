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

(define (range max)
  (define (range-iter min max)
    (if (> min max) '()
      (cons min (range-iter (+ min 1) max))))
  (range-iter 1 max))
(define (index-zip ls)
  (map list (range (length ls)) ls))

(define (op-exists? ls op)
  (not (null? (filter (lambda (pair) (eq? op (cadr pair))) (index-zip ls)))))
(define (index ls op)
  (let ((pair (filter (lambda (pair) (eq? op (cadr pair))) (index-zip ls))))
    (car (car pair))))

(define (take ls n)
  (if (or (<= n 0) (null? ls)) ()
    (cons (car ls) (take (cdr ls) (- n 1)))))
(define (drop ls n)
  (if (or (<= n 0) (null? ls)) ls
    (drop (cdr ls) (- n 1))))

(define (sum? x)
  (and (pair? x) (op-exists? x '+)))
(define (product? x)
  (and (pair? x) (not (op-exists? x '+)) (op-exists? x '*)))

(define (addend s)
  (let ((ls (take s (- (index s '+) 1))))
    (if (= (length ls) 1) (car ls) ls)))
(define (augend s)
  (let ((ls (drop s (index s '+))))
    (if (= (length ls) 1) (car ls) ls)))

(define (multiplier p)
  (let ((ls (take p (- (index p '*) 1))))
    (if (= (length ls) 1) (car ls) ls)))
(define (multiplicand p)
  (let ((ls (drop p (index p '*))))
    (if (= (length ls) 1) (car ls) ls)))

; (print (deriv '(x + 3 * (x + y + 2)) 'x))
