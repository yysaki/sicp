(define (ripple-carry-adder as bs ss c)
  (define (iter as bs ss ck-1)
    (if (not (null? as))
      (let ((ak (car as))
            (bk (car bs))
            (sk (car ss))
            (ck (make-wire)))
        (full-adder ak bk ck sk ck-1)
        (iter (cdr as) (cdr bs) (cdr ss) ck))))
  (let ((c-in (make-wire)))
    (full-adder (car as) (car bs) c-in (car ss) c)
    (iter (cdr as) (cdr bs) (cdr ss) c-in)))

; TODO: 遅延時間の計算
