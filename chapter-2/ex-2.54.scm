(define (equal? lhs rhs)
  (cond
    ((and (eq? lhs ()) (eq? rhs ())) #t)
    ((and (symbol? lhs) (symbol? rhs))(eq? lhs rhs))
    ((not (and (pair? lhs) (pair? rhs))) #f)
    (else (and (equal? (car lhs) (car rhs))
               (equal? (cdr lhs) (cdr rhs))))))

(print (equal? '(this is a list) '(this is a list)))
(print (equal? '(this is a list) '(this (is a) list)))
(print (equal? '(a . b) '(a . b)))
