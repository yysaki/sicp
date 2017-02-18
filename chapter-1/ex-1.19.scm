; T_(p, q)({a, b}) = {a', b'}
; a' = bq + a(p+q)
; b' = aq + bp
; T_(p, q)^2(a, b) = (a'', b'')
; b'' = a'q + b'p
;     = (bq + a(p+q))q + (aq + bp)p
;     = (bqq + apq + aqq) + (apq + bpp)
;     = 2apq + aqq + bpp + bqq
;     = a(2pq + qq) + b(pp + qq)
; これより p'= pp + qq, q' = 2pq + qqと置くと、
; a'' = b'q + a'q + a'p
;     = (aq + bp)q + (bq + aq + ap)q + (bq + aq + ap)p
;     = 2apq + 2bpq + app + 2aqq + bqq
;     = a(2pq + pp + 2qq) + b(2pq + qq)
;     = b(2pq + qq) + a(2pq + qq) + a(pp + qq)
;     = bq' + aq' + ap'
; すなわち,
; T_(p, q)^2(a, b) = T_(p', q')(a, b) : p'= pp + qq, q'= 2pq + qq
; である。

(define (fib n)
 (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))
                   (+ (* 2 p q) (* q q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

(define (range max)
  (define (range-iter min max)
    (if (> min max)
      '()
      (cons min (range-iter (+ min 1) max))))
  (range-iter 1 max))

(map (lambda (x) (print (fib x))) (range 10))
