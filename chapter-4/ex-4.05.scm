(load "./4.1")

(define (expand-clauses clauses)
  (if (null? clauses)
    'false                          ; else節なし
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (cond-else-clause? first)
        (if (null? rest)
          (sequence->exp (cond-actions first))
          (error "ELSE clause isn't last -- COND->IF"
                 clauses))
        (make-if (cond-predicate first)
                 (let ((action (cond-actions first)))
                   (if (eq? (car action) '=>)
                     (list (cadr action) (cond-predicate first))
                     (sequence->exp action))
                   (expand-clauses rest)))))))

(driver-loop)
