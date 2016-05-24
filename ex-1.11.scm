(define (f1 n)
  (if (< n 3)
    n
    (+ (f1 (- n 1))
       (* 2 (f1 (- n 2)))
       (* 3 (f1 (- n 3))))))

(define (f2 n)
  (f2-iter 2 1 0 n))

(define (f2-iter a b c n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        ((= n 2) a)
        (else (f2-iter (+ a (* 2 b) (* 3 c))
                       a
                       b
                       (- n 1)))))
