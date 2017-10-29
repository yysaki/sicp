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
        ((while? exp) (eval (while->let exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (let? exp) (tagged-list? exp 'let))

(define (make-definition variables body)
  (list 'define variables body))

(define (let->combination exp)
  (if (variable? (cadr exp))
    (let ((operator (cadr exp))
          (operands (map car (caddr exp)))
          (inits (map cadr (caddr exp)))
          (body (cdddr exp)))
      (make-begin
        (list (make-definition operator (make-lambda operands body))
              (cons operator inits))))
    (let ((params (map car (cadr exp)))
          (inits (map cadr (cadr exp)))
          (body (cddr exp)))
      (cons (make-lambda params body) inits))))


(define (while? exp) (tagged-list? exp 'while))

(define (make-named-let name pairs body) (list 'let name pairs body))

(define (while-predicate exp) (cadr exp))
(define (while-body exp) (cddr exp))

(define (while->let exp)
  (make-named-let 'my-while
                  '()
                  (make-if (while-predicate exp)
                           (make-begin (list (make-begin (while-body exp))
                                             (list 'my-while)))
                           'true)))

(define while-expression
  '(begin
     (define i 0)
     (while (< i 10) (display i) (set! i (+ i 1)))))

(eval while-expression the-global-environment)
