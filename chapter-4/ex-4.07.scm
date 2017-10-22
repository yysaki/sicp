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
        ((let? exp) (eval (let->combination exp) env))
        ((let*? exp) (eval (let*->nested-lets exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (let? exp) (tagged-list? exp 'let))

(define (let->combination exp)
  (let ((params (map car (cadr exp)))
        (inits (map cadr (cadr exp)))
        (body (cddr exp)))
    (cons (make-lambda params body) inits)))

(define (let*? exp) (tagged-list? exp 'let*))

(define (make-let pairs body) (list 'let pairs body))

(define (let*->nested-lets exp)
  (let ((body (caddr exp)))
    (define (make-lets pairs)
      (if (null? pairs)
        body
        (make-let (list (car pairs))
                  (make-lets (cdr pairs)))))
    (make-lets (cadr exp))))

(driver-loop)
; (let ((a 1) (b 2)) (* a b))
; (let* ((x 3) (y (+ x 2)) (z (+ x y 5))) (* x z))
