(load "./4.1")

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((unless? exp) (eval (unless->if exp) env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((let? exp) (eval (let->combination exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (unless? exp) (tagged-list? exp 'unless))

(define (unless->if exp)
  (define (condition exp) (cadr exp))
  (define (exceptional-value exp)
    (if (not (null? (cadddr exp)))
      (cadddr exp)
      'false))
  (define (usual-value exp) (caddr exp))
  (let ((condition (cadr exp))
        (exceptional-value (cadddr exp))
        (usual-value (caddr exp)))
    (make-if condition exceptional-value usual-value)))

(driver-loop)

; unlessを(condやletのように)導出された式としてどう実装するかを示し, unlessが特殊形式としてではなく, 手続きとして使えると有用である状況の例を述べよ. 

; 手続きの場合、map等の高階関数に渡せるようになる

