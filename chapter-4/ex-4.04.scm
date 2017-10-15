(load "./4.1")

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((and? exp) (eval-and exp env))
        ((or? exp) (eval-or exp env))
        ; ((and? exp) (eval (and->if exp) env))
        ; ((or? exp) (eval (or->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (and? exp) (tagged-list? exp 'and))
(define (and-clauses exp) (cdr exp))

(define (or-clauses exp) (cdr exp))
(define (or? exp) (tagged-list? exp 'or))

; 適切な構文手続きと評価手続きeval-andとeval-orを作り, andとorを評価器の新しい特殊形式として組み込め.

(define (eval-and exp env)
  (define (iter clauses)
    (if (null? clauses)
      false
      (let ((first (eval (car clauses) env))
            (rest (cdr clauses)))
        (if (null? rest)
          (if (true? first) first false)
          (if (true? first) (iter rest) false)))))
  (iter (and-clauses exp)))

(define (eval-or exp env)
  (define (iter clauses)
    (if (null? clauses)
      false
      (let ((first (eval (car clauses) env))
            (rest (cdr clauses)))
        (if (true? first) first (iter rest)))))
  (iter (or-clauses exp)))

; またandとorを導出された式として評価する方法を示せ.

(define (and->if exp)
  (expand-and-clauses (and-clauses exp)))
(define (expand-and-clauses clauses)
  (if (null? clauses)
    'false
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (null? rest)
        (make-if first first 'false)
        (make-if first (expand-and-clauses rest) 'false)))))

(define (or->if exp)
  (expand-or-clauses (or-clauses exp)))
(define (expand-or-clauses clauses)
  (if (null? clauses)
    'false
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (make-if first first (expand-or-clauses rest)))))

(driver-loop)
