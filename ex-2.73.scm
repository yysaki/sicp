; a
; '+ や '* といったユーザ定義された演算をget、putで扱える書式に落とし込む。
; numvwe?は数値であり、variable? はシンボルに対応する。リスト形式でなく「型タグ」をもった形にならないため、吸収できない。

; b

(load "./table")

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (install-deriv-sum-package)
  (define (=number? exp num)
    (and (number? exp) (= exp num)))

  (define (addend s) (car s))
  (define (augend s)
    (if (eq? (cddr s) '())
      (cadr s)
      (cons '+ (cdr s))))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))
  (put 'deriv '+ deriv-sum)
  'done)

(define (install-deriv-product-package)
  (define (=number? exp num)
    (and (number? exp) (= exp num)))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))

  (define (multiplier p) (car p))
  (define (multiplicand p) (cadr p))
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
  (define (deriv-product exp var)
    (make-sum
      (make-product (multiplier exp)
                    (deriv (multiplicand exp) var))
      (make-product (deriv (multiplier exp) var)
                    (multiplicand exp))))
  (put 'deriv '* deriv-product)
  'done)

; (install-deriv-sum-package)
; (install-deriv-product-package)
; 
; (print (deriv '(* (+ x y) x) 'x))

; c

(define (install-deriv-exponentiation-package)
  (define (=number? exp num)
    (and (number? exp) (= exp num)))
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))

  (define (base e) (car e))
  (define (exponent e) (cadr e))
  (define (make-exponentiation u n)
    (cond
      ((=number? n 0) 1)
      ((=number? n 1) u)
      (else (list '** u n))))
  (define (deriv-exponentiation exp var)
    (cond ((=number? (exponent exp) 0) 1)
          ((=number? (exponent exp) 1) (base exp))
          (else
            (make-product
              (make-product (exponent exp)
                            (make-exponentiation (base exp) (- (exponent exp) 1)))
              (deriv (base exp) var)))))
  (put 'deriv '** deriv-exponentiation)
  'done)

; (install-deriv-sum-package)
; (install-deriv-product-package)
; (install-deriv-exponentiation-package)
; 
; (print (deriv '(** (+ x 1) 2) 'x))

; d
; put の ⟨op⟩ と ⟨type⟩ の順番を逆転させるだけでよい. 
