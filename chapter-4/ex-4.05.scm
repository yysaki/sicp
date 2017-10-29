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
          (let ((predicate (cond-predicate first)))
            (make-if predicate
                     (list (cadr (cond-actions first)) predicate)
                     (expand-clauses rest)))
          (make-if (cond-predicate first)
                   (sequence->exp (cond-actions first))
                   (expand-clauses rest)))))))

(driver-loop)
