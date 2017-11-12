(load "./4.1")

; a

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (if (eq? (car vals) '*unassigned*)
               (error "Unassigned variable" var)
               (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))

; ; b

(define (scan-out-defines body)
  (define (unassigned-variables definitions)
    (map (lambda (x) (list (definition-variable x) ''*unassigned*)) definitions))
  (define (set-values definitions)
    (map (lambda (x) (list 'set! (definition-variable x) (definition-value x))) definitions))
  (let ((definitions (filter definition? body))
        (rest-body (filter (lambda (x) (not (definition? x))) body)))
    (if (null? definitions)
      body
      (list
        (append
          (list 'let (unassigned-variables definitions))
          (set-values definitions)
          rest-body)))))

; c
(define (make-procedure parameters body env)
  (list 'procedure parameters (scan-out-defines body) env))

; procedure-body は二回呼び出されるが, make-procedure  は1度しか呼ばれないで済む.

(driver-loop)
; 
; ((lambda (x) (define u 1) (define v 2) (+ x u v)) 3)
