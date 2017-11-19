(load "./4.1")

; a

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
        ((letrec? exp) (print (letrec->let exp)) (eval (letrec->let exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (letrec? exp) (tagged-list? exp 'letrec))

(define (letrec->let exp)
  (define (unassigned-variables pairs)
    (map (lambda (p) (list (car p) ''*unassigned*)) pairs))
  (define (set-values pairs)
    (map (lambda (p) (list 'set! (car p) (cadr p))) pairs))
  (let ((pairs (cadr exp))
        (rest-body (cddr exp)))
    (append (list 'let (unassigned-variables pairs))
            (set-values pairs)
            rest-body)))

(driver-loop)

; (letrec ((even? (lambda (n) (if (= n 0) true (odd? (- n 1))))) (odd? (lambda (n) (if (= n 0) false (even? (- n 1)))))) (even? 9))

; b

; Louis Reasonerは内部定義の騒ぎで混乱した. 彼の考えは, 手続きの内側でdefineが使いたくなければ, letを使うことが出来る. 彼の考えで抜けていることを, fがこの問題で定義されているものとし, 式(f 5)の評価の最中で⟨f⟩の本体の残りが評価される環境を示す環境ダイアグラムを描いて示せ. 同じ評価でfの定義のletrec がletになった場合の環境ダイアグラムを描け.

; let式ではそこで束縛した他の変数を使えないため、再帰や相互再帰が書けない.
