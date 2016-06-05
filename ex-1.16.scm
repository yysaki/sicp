(define (fast-expt-old b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (fast-expt b n)
  (fast-expt-iter b n 1))

(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
        ((even? n) (fast-expt-iter (square b) (/ n 2) a))
        (else (fast-expt-iter b (- n 1) (* a b)))))

(print (fast-expt 5 1)) ;5
(print (fast-expt 5 2)) ;25
(print (fast-expt 5 3)) ;125
(print (fast-expt 5 4)) ;625
(print (fast-expt 5 5)) ;3125
