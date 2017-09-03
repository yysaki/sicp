(load "./3.5")

(define (interleave s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

(define (triples s t u)
  (cons-stream
    (list (stream-car s) (stream-car t) (stream-car u))
    (interleave
      (stream-cdr
        (stream-map (lambda (x) (cons (stream-car s) x))
                    (pairs t u)))
      (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))

(define pythagoras
  (stream-filter
    (lambda (triple)
      (let ((i (car triple))
            (j (cadr triple))
            (k (caddr triple)))
        (= (+ (* i i) (* j j)) (* k k))))
    (triples integers integers integers)))

(display-stream (stream-take pythagoras 3))
