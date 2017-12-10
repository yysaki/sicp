(load "./4.2")

; ('procudure parameters body env modifiers)

(define (make-procedure parameters body env)
  (define (actual-parameter x)
    (if (symbol? x) x (car x)))
  (define (modifier x)
    (if (symbol? x) '() (cadr x)))
  (let ((p (map actual-parameter parameters))
        (m (map modifier parameters)))
    (list 'procedure p body env m)))

(define (procedure-modifiers p) (car (cddddr p)))

(define (apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
           procedure
           (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (procedure-parameters procedure)
             (list-of-delayed-args arguments
                                   (procedure-modifiers procedure)
                                   env)
             (procedure-environment procedure))))
        (else
          (error
            "Unknown procedure type -- APPLY" procedure))))

(define (list-of-delayed-args exps modifiers env)
  (define (evaluator m)
    (cond ((eq? m 'lazy) delay-it)
          ((eq? m 'lazy-memo) delay-memo-it)
          (else actual-value)))
  (if (no-operands? exps)
    '()
    (let ((modifier (first-operand modifiers)))
      (cons ((evaluator modifier) (first-operand exps) env)
            (list-of-delayed-args (rest-operands exps)
                                  (rest-operands modifiers)
                                  env)))))

(define (delay-memo-it exp env)
  (list 'thunk-memo exp env))

(define (thunk-memo? obj)
  (tagged-list? obj 'thunk-memo))

(define (force-it obj)
  (cond ((thunk-memo? obj)
         (let ((result (actual-value
                         (thunk-exp obj)
                         (thunk-env obj))))
           (set-car! obj 'evaluated-thunk)
           (set-car! (cdr obj) result)
           (set-cdr! (cdr obj) '())
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        ((thunk? obj)
         (actual-value (thunk-exp obj) (thunk-env obj)))
        (else obj)))

(driver-loop)
(define (f a (b lazy) c (d lazy-memo))
  (+ a b c d))
(f 1 2 3 4)
