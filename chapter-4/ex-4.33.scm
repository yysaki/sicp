(load "./4.2")

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp env))
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
         (apply (actual-value (operator exp) env)
                (operands exp)
                env))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (text-of-quotation exp env)
  (define (loop ls)
    (if (null? ls)
      '()
      (list 'cons (list 'quote (car ls)) (loop (cdr ls)))))
  (let ((body (cadr exp)))
    (if (not (pair? body))
      body
      (eval (loop body) env))))

(for-each (lambda (exp) (actual-value exp the-global-environment))
          '((define (cons x y)
              (lambda (m) (m x y)))

            (define (car z)
              (z (lambda (p q) p)))

            (define (cdr z)
              (z (lambda (p q) q)))

            (define (list-ref items n)
              (if (= n 0)
                (car items)
                (list-ref (cdr items) (- n 1))))

            (define (map proc items)
              (if (null? items)
                '()
                (cons (proc (car items))
                      (map proc (cdr items)))))

            (define (scale-list items factor)
              (map (lambda (x) (* x factor))
                   items))

            (define (add-lists list1 list2)
              (cond ((null? list1) list2)
                    ((null? list2) list1)
                    (else (cons (+ (car list1) (car list2))
                                (add-lists (cdr list1) (cdr list2))))))

            (define ones (cons 1 ones))

            (define integers (cons 1 (add-lists ones integers)))

            (define (integral integrand initial-value dt)
              (define int
                (cons initial-value
                      (add-lists (scale-list integrand dt)
                                 int)))
              int)

            (define (solve f y0 dt)
              (define y (integral dy y0 dt))
              (define dy (map f y))
              y)))

(driver-loop)
; (car '(a b c))
