(load "./4.2")

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
        ((application? exp)
         ; (apply (eval (operator exp) env)
         ;        (operands exp)
         ;        env))
         (apply (actual-value (operator exp) env)
                (operands exp)
                env))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(driver-loop)

; evalはapplyに渡す前に演算子を評価するのに, 演算子の値を強制するため, evalでなくactual-valueを使う. この強制の必要性を示す例をあげよ.

; ダメな例.
; (define (foo proc) (proc 10))
; (foo (lambda (x) (+ x x)))
