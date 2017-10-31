; > この問題は完全な仕様にはなっていない. 例えば環境の最初のフレームからだけ結合を除去するのか. 仕様を完成し, 自分の選択を正当化せよ. 
; 最初のフレームからだけ結合を除去する.
; そうしないと呼び出し元の手続き以外の手続き中のスコープから束縛を除去してしまうため.

(load "./4.1")

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((unbind? exp) (eval-unbind! exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((while? exp) (eval (while->let exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (unbind? exp)
  (tagged-list? exp 'unbind!))

(define (eval-unbind! exp env)
  (unbind-variable! (cadr exp)
                   env)
  'ok)

(define (unbind-variable! var env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (error "Unbound variable -- UNBIND!" var))
            ((eq? var (car vars))
             (set-car! vars (cadr vars))
             (set-cdr! vars (cddr vars))
             (set-car! vals (cadr vals))
             (set-cdr! vals (cddr vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame)
          (frame-values frame))))

(driver-loop)

