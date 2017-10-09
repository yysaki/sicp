(load "./4.1")
(load "../chapter-2/table")

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        (else
          (if (get 'eval (operator exp))
            ((get 'eval (operator exp)) exp env) (apply (eval (operator exp) env)
                   (list-of-values (operands exp) env))))))

(define (install-eval-package)
  (put 'eval 'quote text-of-quotation)
  (put 'eval 'set eval-assignment)
  (put 'eval 'define eval-definition)
  (put 'eval 'if eval-if)
  (put 'eval 'lambda
       (lambda (exp env)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env)))
  (put 'eval 'begin
       (lambda (exp env)
         (eval-sequence (begin-actions exp) env)))
  (put 'eval 'cond
       (lambda (exp env)
         (eval (cond->if exp) env)))
  'done)

(install-eval-package)
