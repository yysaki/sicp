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
        (if (eq? (cadr first) '=>)
          (make-if (cond-predicate first)
                   (list (cadr (cond-actions first)) (cond-predicate first))
                   (expand-clauses rest))
          (make-if (cond-predicate first)
                   (sequence->exp (cond-actions first))
                   (expand-clauses rest)))))))

(driver-loop)
